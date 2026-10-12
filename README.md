# HR Analytics SQL Project

## Project Overview
This project analyzes employee data using MySQL to identify workforce trends, employee attrition patterns, salary distribution, and overtime-related insights. The goal is to use SQL queries to answer business questions and support data-driven HR decisions.

## Project Objectives
- Analyze employee demographics and department distribution.
- Calculate employee attrition counts and rates.
- Identify job roles with high attrition.
- Compare monthly income across departments and job roles.
- Analyze overtime patterns and employee attrition.
- Rank employees by monthly income within departments.

## Tools and Technologies
- MySQL
- MySQL Workbench
- SQL

## Dataset
The project uses the IBM HR Analytics Employee Attrition dataset.

The dataset contains employee information such as age, gender, department, job role, monthly income, overtime status, and attrition status.

## SQL Concepts Used
- SELECT, WHERE, ORDER BY, LIMIT
- Aggregate functions: COUNT, SUM, AVG, MIN, MAX
- GROUP BY and HAVING
- CASE WHEN and conditional aggregation
- Subqueries and correlated subqueries
- JOINs and derived tables
- Window functions, including RANK()
- Attrition rate calculations
- Salary comparisons and employee ranking

## Business Analysis
The project explores:
- Department-wise employee attrition
- Job role-wise attrition rates
- Age group-wise attrition
- Average monthly income by department and job role
- Overtime and monthly income comparisons
- Highest-paid employees in each department

## Project Structure
- `HR_Analytics_Analysis.sql` — SQL analysis queries
- `business_insights.md` — Key findings from the analysis
- `screenshots/` — Query result screenshots
- `dataset/` — Dataset files, 

## How to Run the Project
1. Install MySQL Server and MySQL Workbench.
2. Import the dataset into MySQL.
3. Create or select the `hr_analytics` database.
4. Ensure the imported table is named `employees` and its column names match the SQL queries.
5. Open `HR_Analytics_Analysis.sql` in MySQL Workbench.
6. Execute the queries and review the results.

## Key Findings
Refer to `business_insights.md` for the findings calculated from the SQL analysis.

## Author
**Rohit Kumar**

Aspiring Data Analyst
