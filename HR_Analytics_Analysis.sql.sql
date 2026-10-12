-- Project: HR Analytics SQL Project --

CREATE DATABASE hr_analytics;
USE hr_analytics;

-- RENAME TABLE `hr_analytics.csv` TO employees;
SHOW TABLES;

-- Q1. How many employees are in the dataset?
select count(*) as total_employees
from employees;

-- Q2. How many employees have left the company?
select count(*) as employees_left
from employees
where attrition = "yes";

-- Q3. How many employees are in each department?
select department, count(*) as total_employees
from employees
group by department;

-- Q4. What is the average monthly salary of employees?
select round(avg(MonthlyIncome),2) as avg_monthly_salary
from employees;

-- Q5. How many employees work overtime?
select count(*) as over_time_emp
from employees
where OverTime = 'yes';

-- Q6. What is the maximum monthly salary?
select max(MonthlyIncome) as Maximum_salary
from employees;

-- Q7. How many employees are there in each gender?
select gender, count(*) as total_emp
from employees
group by gender;

-- Q8. What is the average age of employees?
select round(avg(Age), 2) as avg_age
from employees;

-- Q9. How many employees are there in each job role?
select JobRole, count(*) as total_emp
from employees
group by JobRole;

-- Q10. What is the average salary in each department?
select department, avg(MonthlyIncome) as avg_salary
from employees
group by department;

-- Q11. Which department has the highest average monthly salary?
select department, avg(MonthlyIncome) as avg_salary
from employees
group by department
order by avg_salary desc
limit 1;

-- Q12. How many employees have left the company in each department?
select department, count(*) as left_emp
from employees
where attrition = 'yes'
group by department
order by left_emp desc;

-- Q13. What is the attrition count for each job role?
select JobRole, count(*) as attrition_count
from employees
where attrition = 'yes'
group by JobRole
order by JobRole desc;

-- Q14. Which departments have more than 100 employees?
select department, count(*) as total_emp
from employees
group by department
having count(*) > 100;

-- Q15. What is the attrition rate in each department?
select department, count(*) as total_emp,
sum(case when attrition = 'yes' then 1 else 0 end) as employees_left,
round(sum(case when attrition = 'yes' then 1 else 0 end) * 100/ count(*), 2) as attrition_rate
from employees
group by department;

-- Q16. Which departments have an average monthly salary greater than 5000?
select department, avg(MonthlyIncome) as avg_salary
from employees
group by department
having avg_salary > 5000; 

-- Q17. Which employees earn more than the company's average monthly salary?
select * from employees
where MonthlyIncome > (select avg(MonthlyIncome) from employees);

-- Q18. Which employees earn the highest salary in each department?
select * from employees e
where MonthlyIncome = (select max(MonthlyIncome) from employees
where department = e.department);

-- Q19. Which employees have the highest salary in each department?
select * from employees e
join (
	select department, max(MonthlyIncome) as highest_salary
	from employees
	group by department) d
on e.department = d.department and
e.MonthlyIncome = d.highest_salary;

-- Q20. Find employees earning more than their department's average salary.
select * from employees e
where MonthlyIncome > (select avg(MonthlyIncome) 
from employees
where department = e.department);

-- Q21 Classify employees into salary categories using CASE WHEN.
-- Department, JobRole, MonthlyIncome, category
select department, JobROle, MonthlyIncome,
case
	when MonthlyIncome < 3000 then 'low salary'
    when MonthlyIncome <=7000 then 'Medium salary'
    else 'high salary'
    end as salary_categroy
from employees;

-- Q22. Calculate the total number of employees and the number of employees who work overtime in each department.
/* Requirements:
- Display Department.
- Calculate the total number of employees in each department.
- Calculate the number of employees who work overtime (OverTime = 'Yes').
- Sort the results by the number of overtime employees in descending order. */
select department, count(*) as total_emp,
sum(case
	when OverTime = 'yes' then 1 else 0 end) as overtime_emp
    from employees
    group by department
    order by overtime_emp desc;
    
-- Q23. Calculate the attrition rate for each job role.
/*Requirements:
- Display JobRole.
- Calculate the total number of employees in each job role.
- Calculate the number of employees who left the company (Attrition = 'Yes').
- Calculate the attrition rate as a percentage, rounded to 2 decimal places.
- Sort the results by attrition rate in descending order. */
SELECT
    JobRole, COUNT(*) AS total_emp,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS left_emp,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*), 2) AS attrition_rate
FROM employees
GROUP BY JobRole
ORDER BY attrition_rate DESC;


-- Q24. Write a SQL query to calculate the attrition rate for each age group.
/*Requirements:
- Create these age groups using CASE WHEN:
  - Under 25
  - 25–34
  - 35–44
  - 45 and above
- Display the age group and total number of employees.
- Calculate the number of employees who left the company.
- Calculate the attrition rate as a percentage, rounded to 2 decimal places.
- Sort the results by attrition rate in descending order. */
select count(*) as total_emp,
case when age < 25 then 'Under 25'
	when age between 25 and 34 then '25-34'
    when age between 35 and 44 then '35-44'
    else '45 and above' end as age_group,
sum(case
	when attrition = 'yes' then 1 else 0 end ) as left_emp,
round(sum(case when attrition = 'yes' then 1 else 0 end) *100.0 / count(*), 2) as attrition_rate
from employees
group by age_group
order by attrition_rate desc;


-- Q25. Write a SQL query to find the top 3 job roles with the highest average monthly income.
/*Requirements:
- Display JobRole.
- Calculate the average monthly income for each job role.
- Round the average salary to 2 decimal places.
- Sort by average monthly income in descending order.
- Return only the top 3 job roles.*/
select JobRole, round(avg(MonthlyIncome), 2) as avg_monthlyIncome
from employees
group by JobRole
order by avg_monthlyIncome desc
limit 3;


-- Q26. Write a SQL query to find the top 5 employees with the highest monthly income.
/*Requirements:
- Display JobRole, Department, MonthlyIncome, and OverTime.
- Sort employees by MonthlyIncome in descending order.
- Return only the top 5 employees.*/
select JobRole, Department, MonthlyIncome, OverTime
from employees
order by MonthlyIncome desc
limit 5;


-- Q27. Write a SQL query to rank employees by monthly income within each department.
/*Requirements:
- Display Department, JobRole, and MonthlyIncome.
- Use RANK() to rank employees within each department.
- The highest salary should receive rank 1.
- Display the result ordered by department and salary rank. */
SELECT
    Department,
    JobRole,
    MonthlyIncome,
    RANK() OVER (
        PARTITION BY Department
        ORDER BY MonthlyIncome DESC
    ) AS salary_rank
FROM employees
ORDER BY Department, salary_rank;


-- Q28. Find the top 3 highest-paid employees in each department using a subquery.
SELECT * FROM 
( SELECT
        Department,
        JobRole,
        MonthlyIncome,
        RANK() OVER (
            PARTITION BY Department
            ORDER BY MonthlyIncome DESC
        ) AS salary_rank
    FROM employees
) AS ranked_employees
WHERE salary_rank <= 3
ORDER BY Department, salary_rank;


/*Q29. Write a SQL query to identify the departments where employees working 
overtime have a higher average monthly income than employees not working overtime. */
select department, round(
	avg(case when OverTime = 'yes' then MonthlyIncome end), 2)as avg_overtime_income,
    round(
		avg(case when OverTime = 'no' then MonthlyIncome end), 2) as avg_non_overtime_income
from employees
group by department
having avg(case when OverTime = 'yes' then MonthlyIncome end)
 > avg(case when OverTime = 'no' then MonthlyIncome end)
 order by avg_overtime_income desc;
 
 
 -- Q30. Find the Department with the Highest Attrition Rate.
 select department, count(*) as total_emp,
 sum(case
		when attrition = 'yes' then 1 else 0 end) as left_emp,
        round(sum(case when attrition = 'yes' then 1 else 0 end) * 100.0 / count(*), 2) as attrition_rate
	from employees
	group by department
	order by attrition_rate desc
	limit 1;
    
    
    -- Business Insights
    
-- 1. Department-wise attrition
SELECT
    Department,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY Department
ORDER BY attrition_rate DESC;


-- 2. Job role-wise attrition
SELECT
    JobRole,
    COUNT(*) AS total_employees,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY JobRole
ORDER BY attrition_rate DESC;


-- 3. Overtime comparison
SELECT
    OverTime,
    COUNT(*) AS total_employees,
    ROUND(AVG(MonthlyIncome), 2) AS avg_monthly_income,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left
FROM employees
GROUP BY OverTime;


-- 4. Age group-wise attrition
SELECT
    CASE
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        ELSE '45 and above'
    END AS age_group,
    COUNT(*) AS total_employees,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY age_group
ORDER BY attrition_rate DESC;
        



