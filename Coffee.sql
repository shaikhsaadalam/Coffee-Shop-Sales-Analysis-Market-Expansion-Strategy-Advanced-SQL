SELECT * FROM city;
SELECT * FROM products;
SELECT * FROM customers;
SELECT * FROM sales;

-- Reports & Data Analysis

-- 1. Coffee Consumers Count
SELECT city_name, 
       population, 
	   ROUND((population * 0.25) /1000000, 2) AS coffee_consumers_in_millions
FROM city
ORDER BY 2 DESC

-- 2. Total Revenue from Coffee Sales
SELECT 
    ci.city_name,
    SUM(s.total) as total_revenue
FROM sales as s
JOIN customers as c
ON s.customer_id = c.customer_id
JOIN city as ci
ON ci.city_id = c.city_id
WHERE
    EXTRACT(YEAR FROM s.sale_date) = 2023
    AND
    EXTRACT(quarter FROM s.sale_date) = 4
GROUP BY 1
ORDER BY 2 DESC;

-- 3. Sales Count for Each Product
SELECT 
    p.product_name,
    COUNT(s.sale_id) as total_orders
FROM products as p
LEFT JOIN
sales as s
ON s.product_id = p.product_id
GROUP BY 1
Order BY 2 DESC;

-- 4. Average Sale Per Customer by City
SELECT 
    ci.city_name,
    SUM(s.total) as total_revenue,
    COUNT(DISTINCT s.customer_id) as total_cx,
    ROUND(
        SUM(s.total):: numeric/
        COUNT(DISTINCT s.customer_id):: numeric
    ,2) as avg_sale_pr_cx
    
FROM sales as s
JOIN customers as c
ON s.customer_id = c.customer_id
JOIN city as ci
ON ci.city_id = c.city_id
GROUP BY 1
ORDER BY 2 DESC;

-- 5. City Population and Coffee Consumers

WITH city_table as
(
    SELECT
        city_name,
        ROUND((population * 0.25)/1000000, 2) as coffee_consumers_in_millions
    FROM city
),
customers_table
AS
(
    SELECT
        ci.city_name,
        COUNT(DISTINCT c.customer_id) as unique_cx
    FROM sales as s
    JOIN customers as c
    ON c.customer_id = s.customer_id
    JOIN city as ci
    ON ci.city_id = c.city_id
    GROUP BY 1
)
SELECT
    ct.city_name,
    ct.coffee_consumers_in_millions,
    cit.unique_cx
FROM city_table as ct

-- 8. Average Sale vs Rent


JOIN
customers_table as cit
ON cit.city_name = ct.city_name;

-- 6. Top Selling Products by City
SELECT *
FROM
(
    SELECT
        ci.city_name,
        p.product_name,
        COUNT(s.sale_id) as total_orders,
        DENSE_RANK() OVER(PARTITION BY ci.city_name ORDER BY COUNT(s.sale_id) DESC) as rank
    FROM sales as s
    JOIN products as p
    ON s.product_id = p.product_id
    JOIN customers as c
    ON c.customer_id = s.customer_id
    JOIN city as ci
    ON ci.city_id = c.city_id
    GROUP BY 1, 2
) as t1
WHERE rank <= 3

-- 7. Customer Segmentation by City

SELECT
    ci.city_name,
    COUNT(DISTINCT c.customer_id) as unique_cx
FROM city as ci
LEFT JOIN
customers as c
ON c.city_id = ci.city_id
JOIN sales as s
ON s.customer_id = c.customer_id
WHERE
    s.product_id IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14)
GROUP BY 1

-- 8. Avg Sale and Avg Rent

WITH city_table
AS
(
    SELECT
        ci.city_name,
        SUM(s.total) as total_revenue,
        COUNT(DISTINCT s.customer_id) as total_cx,
        ROUND(
            SUM(s.total)::numeric/
            COUNT(DISTINCT s.customer_id)::numeric
        ,2) as avg_sale_pr_cx

    FROM sales as s
    JOIN customers as c
    ON s.customer_id = c.customer_id
    JOIN city as ci
    ON ci.city_id = c.city_id
    GROUP BY 1
    ORDER BY 2 DESC
),
city_rent
AS
(
    SELECT
        city_name,
        estimated_rent
    FROM city
)
SELECT
    cr.city_name,
    cr.estimated_rent,
    ct.total_cx,
    ct.avg_sale_pr_cx,
    ROUND(
        cr.estimated_rent::numeric /
        ct.total_cx::numeric
    , 2) as avg_rent_per_cx,
    ct.total_revenue
FROM city_rent as cr
JOIN city_table as ct
ON cr.city_name = ct.city_name;

-- 9. Monthly Sales Growth

WITH monthly_sales
AS
(
    SELECT
        ci.city_name,
        EXTRACT(MONTH FROM sale_date) as month,
        EXTRACT(YEAR FROM sale_date) as YEAR,
        SUM(s.total) as total_sale
    FROM sales as s
    JOIN customers as c
    ON c.customer_id = s.customer_id
    JOIN city as ci
    ON ci.city_id = c.city_id
    GROUP BY 1, 2, 3
    ORDER BY 1, 3, 2
),
growth_ratio
AS
(
    SELECT
        city_name,
        month,
        year,
        total_sale as cr_month_sale,
        LAG(total_sale, 1) OVER(PARTITION BY city_name ORDER BY year, month) as last_month_sale
    FROM monthly_sales
)
SELECT
    city_name,
    month,
    year,
    cr_month_sale,
    last_month_sale,
    ROUND(
        (cr_month_sale - last_month_sale)::numeric / last_month_sale::numeric * 100
        , 2
    ) as growth_ratio
FROM growth_ratio;

-- 10. Market Potential Analysis

WITH city_table
AS
(
    SELECT
        ci.city_name,
        SUM(s.total) as total_revenue,
        COUNT(DISTINCT s.customer_id) as total_cx,
        ROUND(
            SUM(s.total)::numeric/
            COUNT(DISTINCT s.customer_id)::numeric
        ,2) as avg_sale_pr_cx
    FROM sales as s
    JOIN customers as c
    ON s.customer_id = c.customer_id
    JOIN city as ci
    ON ci.city_id = c.city_id
    GROUP BY 1
    ORDER BY 2 DESC
),
city_rent
AS
(
    SELECT
        city_name,
        estimated_rent,
        ROUND((population * 0.25)/1000000,2) as estimated_coffee_consumer_in_mn
    FROM city
)
SELECT
    cr.city_name,
    total_revenue,
    cr.estimated_rent as total_rent,
    ct.total_cx,
    estimated_coffee_consumer_in_mn,
    ct.avg_sale_pr_cx,
    ROUND(
        cr.estimated_rent::numeric/
        ct.total_cx::numeric
    , 2) as avg_rent_per_cx
FROM city_rent as cr
JOIN city_table as ct
ON cr.city_name = ct.city_name
ORDER BY 2 DESC;
-- Recommendation: Top 3 Expansion Cities

/*
City 1: Pune
1. Average rent per customer is very low.
2. It has the highest total revenue.
3. Average sale per customer is also high.

City 2: Delhi
1. Highest estimated coffee consumer base at 7.7M.
2. Highest total customer count at 68.
3. Average rent per customer is 330 (still well under 500).

City 3: Jaipur
1. Highest customer count at 69.
2. Very low average rent per customer at 156.
3. Strong average sale per customer at 11.6k.
*/
