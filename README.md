Coffee Shop Sales Analysis & Market Expansion Strategy | Advanced SQL

Project Overview

How can a coffee business use sales data to identify promising cities for future branch expansion?

This project uses PostgreSQL to analyze coffee shop sales, customer purchasing behavior, product performance, monthly revenue trends, and city-level market indicators. The objective is to transform raw transactional data into actionable business insights and evaluate potential expansion opportunities using historical sales performance, customer metrics, estimated coffee-consumer populations, and rent-related indicators.

Rather than focusing solely on sales figures, this analysis connects SQL-based data exploration with a practical business decision: which cities warrant further investigation for expansion?

Business Objectives

Evaluate revenue performance across cities.

Estimate the potential coffee-consumer population in each city.

Measure customer acquisition and average revenue per customer.

Identify the best-selling coffee products by city.

Analyze monthly sales growth and fluctuations.

Compare average customer spending with estimated rental costs.

Identify and compare the top three candidate cities for further expansion analysis.

Business Questions

The analysis addresses the following business requirements:

Coffee Consumer Estimates: How many potential coffee consumers live in each city, assuming 25% of the population consumes coffee?

Quarterly Revenue: What revenue was generated in each city during Q4 2023?

Product Performance: Which coffee products generate the highest number of recorded sales?

Customer Spending: What is the average historical sales amount per unique customer in each city?

Population Analysis: How do city populations compare with their estimated coffee-consumer populations?

Product Rankings: Which three products have the highest sales counts in each city?

Customer Segmentation: How many unique customers purchased coffee products in each city?

Sales and Rent Comparison: How do average revenue per customer and estimated rent per customer compare across cities?

Monthly Sales Growth: How does revenue change month over month in each city?

Expansion Opportunity Analysis: Which cities demonstrate promising combinations of historical revenue, customer base, estimated market size, and rent-related indicators?

Tools & Technologies

Database: PostgreSQL

Query Language: SQL

Environment: pgAdmin

Analysis Techniques: Data aggregation, multi-table joins, CTEs, window functions, ranking, date-based analysis, and financial calculations.

SQL Skills Demonstrated

Technique

Business Application

JOIN

Combine sales, customer, product, and city data

Aggregate Functions

Calculate revenue, customer counts, and sales metrics

COUNT(DISTINCT)

Measure unique purchasing customers

Common Table Expressions (CTEs)

Structure multi-step analytical queries

Window Functions

Rank products and compare monthly sales

DENSE_RANK()

Identify top-selling products within each city

LAG()

Retrieve the previous month's revenue

Date Functions

Analyze quarterly and monthly performance

Type Casting and ROUND()

Perform financial calculations and format results

Conditional Filtering

Restrict analysis to specific periods and product groups

Key Performance Indicators

The project calculates and examines the following metrics:

Total Revenue: Sum of recorded sales amounts.

Unique Customers: Number of distinct purchasing customers.

Average Revenue per Customer: Total revenue divided by unique purchasing customers.

Product Sales Count: Number of recorded sales transactions per product.

Estimated Coffee Consumers: 25% of the reported city population.

Average Rent per Customer: Estimated city rent divided by the number of unique purchasing customers.

Monthly Revenue Growth: Percentage change in revenue compared with the previous available month.

Note: Average revenue per customer is not necessarily average transaction value or customer lifetime value. The rent-per-customer metric is a comparative indicator, not a direct measure of branch profitability.

Business Analysis & Findings

The analysis evaluates city-level performance using historical sales, purchasing customers, estimated market size, and rental indicators.

Preliminary Expansion Recommendations

Based on the project's current analysis, the following cities were shortlisted for further investigation:

1. Pune

Highest total revenue among the cities identified in the analysis.

Low estimated rent relative to its existing customer base.

Strong average revenue per customer.

2. Delhi

Large estimated coffee-consumer population.

Substantial existing customer base.

Estimated rent per customer below the project's cited comparison threshold.

3. Jaipur

Large existing customer base.

Low estimated rent per customer.

Strong average revenue per customer.

These are preliminary, data-informed candidates rather than confirmed optimal expansion locations. The analysis does not establish future branch revenue or profitability, and the recommendations should be validated against the underlying query results.

Business Value

This project demonstrates how SQL can support practical business analysis by helping decision-makers:

Compare sales performance across geographic markets.

Understand differences in customer spending and purchasing behavior.

Identify high-performing products and local sales patterns.

Evaluate estimated market size alongside rental indicators.

Prioritize cities for deeper market research and site-level feasibility analysis.

The approach provides an initial analytical framework for expansion decisions without treating historical performance as a guarantee of future success.

Limitations & Assumptions

Estimated coffee consumers are based on the assumption that 25% of the population consumes coffee.

Historical revenue and customer metrics do not independently predict the performance of a new branch.

Estimated rent per customer is a comparative indicator, not a direct measure of profitability.

The analysis does not include all operating costs, competitor market shares, foot traffic, site-level demand, or projected investment returns.

Market-expansion recommendations should be validated before capital is committed.

Conclusion

This project applies advanced SQL techniques to a practical business problem: evaluating coffee shop performance and comparing cities for potential expansion.

By combining revenue analysis, customer metrics, product rankings, monthly trends, estimated market size, and rental indicators, the project demonstrates how structured data analysis can inform business decisions and help prioritize opportunities for further investigation.

Core takeaway: SQL is not just a tool for retrieving data; it can be used to structure business questions, quantify performance, and develop evidence-based recommendations.


