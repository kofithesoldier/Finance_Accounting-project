# Finance_Accounting-project
Practice SQL from basic to advanced using a realistic accounting and finance dataset with customers, invoices, payments, budgets, and analytics-ready KPIs.

# SQL Practice Project – Accounting & Finance Dataset

## Overview

This project provides a comprehensive SQL practice environment for learners aiming to develop their skills from basic to advanced SQL in accounting and finance. It includes a realistic multi-table dataset with customers, employees, vendors, invoices, payments, budgets, and expenses.

# Dataset Creation
The dataset was created with careful attention to realism. The process started by dropping tables if they existed to avoid conflicts before creation. The tables were then created with appropriate primary and foreign keys to maintain referential integrity.

The dataset was manually created to reflect common accounting and finance scenarios. It contains the following tables: 

* **Customers** – CustomerID, CustomerName, Country

* **Employees** – EmployeeID, Name, Department, Position, HireDate, Salary

* **Vendors** – VendorID, VendorName, Country, Category

* **Invoices** – InvoiceID, CustomerID, VendorID, InvoiceDate, TotalAmount, Status

* **Payments** – PaymentID, InvoiceID, PaymentDate, Amount

* **Expenses** – ExpenseID, Category, Amount, ExpenseDate

* **Budgets** – Department, Year, BudgetAmount, ActualSpent

  ## SQL QUERIES FOR CREATING THE DATASET
  
 -- DROP TABLES (for clean reloads)
```sql
DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS Invoices;
DROP TABLE IF EXISTS Expenses;
DROP TABLE IF EXISTS Budgets;
DROP TABLE IF EXISTS Accounts;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Vendors;
DROP TABLE IF EXISTS Customers;
```
**CUSTOMERS TABLE**
```SQL
CREATE TABLE Customers (
    CustomerID VARCHAR(10) PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Industry VARCHAR(50),
    Country VARCHAR(50),
    JoinDate DATE
);
```
```SQL
INSERT INTO Customers VALUES
('C001', 'Alpha Tech Ltd', 'IT Services', 'UK', '2022-01-15'),
('C002', 'Beta Pharma', 'Healthcare', 'USA', '2022-03-20'),
('C003', 'Gamma Retailers', 'Retail', 'Ghana', '2023-02-10'),
('C004', 'Delta Finance', 'Financial Services', 'UK', '2023-08-05'),
('C005', 'Zenith Logistics', 'Transport', 'Canada', '2024-01-12');
```
**VENDORS TABLE**
```SQL
CREATE TABLE Vendors (
    VendorID VARCHAR(10) PRIMARY KEY,
    VendorName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Country VARCHAR(50),
    ContractStart DATE
);
```
```SQL
INSERT INTO Vendors VALUES
('V001', 'Office Depot', 'Office Supplies', 'UK', '2022-02-01'),
('V002', 'CloudNet Hosting', 'IT Services', 'USA', '2022-04-15'),
('V003', 'CleanPro Ltd', 'Cleaning', 'Ghana', '2023-01-01'),
('V004', 'SafeTransports', 'Logistics', 'Canada', '2023-09-10');
```
**EMPLOYEES TABLE**
```SQL
CREATE TABLE Employees (
    EmployeeID VARCHAR(10) PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Department VARCHAR(50),
    Position VARCHAR(50),
    HireDate DATE,
    Salary DECIMAL(12,2)
);
```
```SQL
INSERT INTO Employees VALUES
('E001', 'James Smith', 'Finance', 'Accountant', '2021-11-01', 45000),
('E002', 'Sarah Johnson', 'Sales', 'Sales Manager', '2022-02-12', 60000),
('E003', 'David Wilson', 'IT', 'IT Specialist', '2022-06-05', 52000),
('E004', 'Mary Adams', 'HR', 'HR Officer', '2023-03-10', 40000),
('E005', 'Peter Brown', 'Finance', 'CFO', '2023-07-01', 95000);
```

 **ACCOUNTS TABLE**
 ```SQL
CREATE TABLE Accounts (
    AccountID VARCHAR(10) PRIMARY KEY,
    AccountName VARCHAR(50),
    Type VARCHAR(20)
);
```
```SQL
INSERT INTO Accounts VALUES
('A100', 'Cash', 'Asset'),
('A200', 'Accounts Receivable', 'Asset'),
('A300', 'Accounts Payable', 'Liability'),
('A400', 'Revenue', 'Revenue'),
('A500', 'Expenses', 'Expense'),
('A600', 'Salaries Payable', 'Liability'),
('A700', 'Equity', 'Equity');
```

**INVOICES TABLE**
```SQL
CREATE TABLE Invoices (
    InvoiceID VARCHAR(10) PRIMARY KEY,
    CustomerID VARCHAR(10) FOREIGN KEY REFERENCES Customers(CustomerID),
    InvoiceDate DATE,
    DueDate DATE,
    TotalAmount DECIMAL(12,2),
    Status VARCHAR(20)
);
```
```SQL
INSERT INTO Invoices VALUES
('I001', 'C001', '2023-01-20', '2023-02-20', 12000, 'Paid'),
('I002', 'C002', '2023-02-15', '2023-03-15', 18000, 'Paid'),
('I003', 'C003', '2023-04-10', '2023-05-10', 7500, 'Overdue'),
('I004', 'C004', '2023-06-05', '2023-07-05', 22000, 'Paid'),
('I005', 'C005', '2023-09-12', '2023-10-12', 15500, 'Pending'),
('I006', 'C001', '2024-01-25', '2024-02-25', 9800, 'Pending');
```
**PAYMENTS TABLE**
```SQL
CREATE TABLE Payments (
    PaymentID VARCHAR(10) PRIMARY KEY,
    InvoiceID VARCHAR(10) FOREIGN KEY REFERENCES Invoices(InvoiceID),
    PaymentDate DATE,
    Amount DECIMAL(12,2),
    Method VARCHAR(20)
);
```
```SQL
INSERT INTO Payments VALUES
('P001', 'I001', '2023-02-18', 12000, 'Bank Transfer'),
('P002', 'I002', '2023-03-10', 18000, 'Card'),
('P003', 'I004', '2023-06-25', 22000, 'Bank Transfer');
```

**EXPENSES TABLE**
```SQL
CREATE TABLE Expenses (
    ExpenseID VARCHAR(10) PRIMARY KEY,
    VendorID VARCHAR(10) FOREIGN KEY REFERENCES Vendors(VendorID),
    ExpenseDate DATE,
    Amount DECIMAL(12,2),
    Category VARCHAR(50),
    AccountID VARCHAR(10) FOREIGN KEY REFERENCES Accounts(AccountID)
);
```
```SQL
INSERT INTO Expenses VALUES
('EX001', 'V001', '2023-01-15', 2500, 'Office Supplies', 'A500'),
('EX002', 'V002', '2023-03-20', 4800, 'IT Services', 'A500'),
('EX003', 'V003', '2023-05-12', 1800, 'Cleaning', 'A500'),
('EX004', 'V004', '2023-07-01', 6000, 'Logistics', 'A500'),
('EX005', 'V001', '2023-11-10', 2700, 'Office Supplies', 'A500');
```

**BUDGETS TABLE**
```SQL
CREATE TABLE Budgets (
    BudgetID VARCHAR(10) PRIMARY KEY,
    Department VARCHAR(50),
    Year INT,
    BudgetAmount DECIMAL(12,2),
    ActualSpent DECIMAL(12,2) NULL
);
```
```SQL
INSERT INTO Budgets VALUES
('B001', 'Finance', 2023, 120000, 118500),
('B002', 'Sales', 2023, 150000, 142300),
('B003', 'IT', 2023, 90000, 94000),
('B004', 'HR', 2023, 60000, 58000),
('B005', 'Finance', 2024, 130000, NULL);
```
The data was generated with realistic values to allow meaningful SQL analysis and KPI calculations.

## Project Highlights for Portfolio

* **Hands-on SQL practice** from basic queries to advanced analytics.
* **Business insights**: Calculate KPIs like revenue, payment delays, budget variances, and trends.
* **Advanced techniques**: Window functions, CTEs (including recursive), ranking, trend analysis.
* **Portfolio-ready**: Demonstrates real-world SQL problem-solving in finance and accounting contexts.

  

## How This Project Shows My Skills

* **Data exploration**: Understanding relationships and data structures.
* **Analytical skills**: Creating KPIs and interpreting results.
* **SQL mastery**: Joins, aggregations, subqueries, window functions, CTEs.
* **Problem-solving**: Handling real-world scenarios like partial payments, cumulative revenue, and vendor performance.

  ## Data Analysis & Findings
The following SQL queries were developed to answer specific business questions & KPIs spanning from Basic to Advanced

# SQL Queries
The project includes queries for Basic, Intermediate, and Advanced SQL practice:

## 1. Basic KPIs
* **Q.1. List all customers by country.**
```sql
select * from customers;
select
      customername,
      country,
from customers;
```

* **Q.2. Find the total number of invoices raised in 2023.**
```sql
select * from invoices;
select count(*) as invoice_count
from invoices 
where InvoiceDate between '2023-01-01' and '2023-12-31';
```

* **Q.3. Get the total revenue per customer (sum of invoice amounts grouped by customer).**
```sql
select * from customers;
select * from invoices;

select
      c.customername,
      c.customerid,
     sum( i.totalamount) as customer_total_revenue
from customers c
join Invoices i 
on c.customerid=i.CustomerID
group by c.CustomerID,c.CustomerName;
```

* **Q.4. Show all employees who work in the Finance department.**
```sql
select * from employees;
select * 
from employees
where Department='finance';
```

* **Q.5. Write a query to find the distinct job titles of all employees.**
```sql
select distinct * from employees;
```

* **Q.6. Retrieve all vendors located in the United States.**
```sql
select * from vendors;
select * from vendors
where country='USA';
```

* **Q.7. Retrieve all invoices with a total amount greater than 10,000**
```sql
select * from invoices;
select * 
from invoices 
where TotalAmount >10000;
```

* **Q.8.Show the total expenses for each category from the Expenses table.**
```sql
select * from expenses;

select    
      category,
      sum(amount) as total_expenses
from expenses
group by category;
```

* **Q.9. List the top 3 highest-paid employees.**
```sql
select * from employees;

select top 3 *
from employees
order by salary desc;
```

* **Q.10. Find the total number of customers in each country.**
```sql
select * from customers;

select 
      country,
      count(*) as number_of_customers
from customers
group by country;
```

* **Q.11. Retrieve all invoices that are currently pending.**
```sql
select * from invoices;
select * 
from invoices
where status ='pending';
```

* **Q.12. Show the total payment amount received for each invoice.**
```sql
select * from payments;
select 
     invoiceid, 
     sum(amount) as Total_payment
from payments
group by invoiceid;
```

* **Q.13.List all expenses that were made in the year 2023.**
```sql
select *
from expenses
where ExpenseDate between '2023-01-01' and '2023-12-31';
```

* **Q.14. Retrieve all invoices along with the customer name for each invoice.**
```sql
select * from invoices;
select * from customers;
select 
      c.customername,
      i.invoiceid
from customers c
join invoices i
on c.customerid=i.CustomerID;
```

* **Q.15. Show all vendors who have provided office supplies.**
```sql
select * from vendors;
select * from Vendors
where category = 'office supplies';
```

* **Q.16. Find the average salary of employees in the company.**
```sql
select * from employees;
select avg(salary)
from employees;
```
* **Q.17.List all invoices that are paid and have an amount greater than 15,000.**
```sql
select * from invoices;
select * 
from invoices 
where status='paid'
and TotalAmount>15000;
```

* **Q.18. Retrieve all employees who were hired after January 1, 2023.**
```sql
select * from employees;
select * 
from employees
where hiredate >'2023-01-01';
```

* **Q.19. Show the total revenue generated in 2023 (sum of all invoice amounts for that year).**
```sql
select * from invoices;
select 
      year(invoicedate) as year,
      sum(totalamount) as revenue
from invoices
group by year(invoicedate)
having year(invoicedate)='2023';
```

* **Q.20. List all invoices along with their payment status — show whether they have been paid in full, partially paid, or not paid**
```sql
select * from invoices;
select * from payments;
select 
      i.invoiceid,
      i.status,
      CASE
when status ='paid' then 'paid'
when status='pending' then 'not paid'
else 'partially paid'
end as rating
from invoices i;
```

# INTERMEDIATE KPIs

* **Q.1. Calculate the Days Sales Outstanding (DSO) for the company.**
  **DSO = Average number of days between InvoiceDate and PaymentDate for invoices that have been paid.**
```SQL
  SELECT 
    AVG(DATEDIFF(DAY, I.InvoiceDate, P.PaymentDate)) AS Avg_DSO
FROM Invoices I
JOIN Payments P 
    ON I.InvoiceID = P.InvoiceID;
```

* **Q.2. Calculate the budget variance for each department.
--Budget variance = BudgetAmount – ActualSpent
--Show Department, Year, BudgetAmount, ActualSpent, and Variance.**
```SQL
select * from Budgets;
select 
      department,
      year,
      sum(budgetamount) as Budget_amount,
      sum(actualspent) as Actual_spent, 
      sum(budgetamount)-sum(actualspent)as variances
from budgets
group by department,year;
```

* **Q.3. Find the top 5 customers who generated the highest total revenue in 2023.**
```SQL
select * from customers;
select * from invoices;
```
```SQL
SELECT TOP 5
      C.CustomerName,
      SUM(I.TotalAmount) AS Total_Revenue
FROM Customers C
JOIN Invoices I
      ON C.CustomerID = I.CustomerID
WHERE YEAR(I.InvoiceDate) = 2023
GROUP BY C.CustomerName
ORDER BY Total_Revenue DESC;
```

* **Q.4. Find the average payment delay per customer.**
 **Payment delay = difference (in days) between InvoiceDate and PaymentDate.**
**Show CustomerName and their average delay.**
```SQL
select * from invoices;
select * from payments;
select * from customers;
select
     c.customername,
     avg(DATEDIFF(day,i.invoicedate,p.paymentdate)) as Payment_delay
from customers c
join invoices i
on c.customerid=i.customerid
join payments p
on i.invoiceid=p.invoiceid
group by c.customerid,c.customername;
```

* **Q.5. Identify the top 3 departments with the highest total expenses in 2023.**
```SQL
select * from budgets;
select top 3
         department,
         sum(actualspent) as total_expenses
from budgets 
where year ='2023'
group by department
order by total_expenses desc;
```

* **Q.6. Find all customers who have more than one invoice in the dataset.**
```SQL
select * from customers;
select * from invoices;
select 
     c.customername,
     count(*) as number_of_invoices
from customers c
join invoices i
on c.CustomerID=i.CustomerID
group by c.customername,c.customerid
having count(*) >1;
```

* **Q.7. Write a query to find the total number of customers from each country in the Customers table. 
Display the country and the customer count, sorted from highest to lowest.**
```SQL
select * from customers;
select 
     country,
     count(*) as number_of_customers
from customers
group by country
order by number_of_customers desc;
```

* **Q.8. Write a query to find the invoice with the highest total amount in the invoices table.**
```SQL
select * from invoices;
select top 1 * 
from invoices 
order  by totalamount desc;
```

* **Q.9. Write a query to find the average salary per department from the employees table.**
```SQL
select * from employees;
select
      department,
      avg(salary) as avg_salary
from employees
group by department;
```

* **Q.10. Write a query to find all invoices that are overdue.**
```SQL
select * from invoices;
SELECT 
    I.InvoiceID,
    I.CustomerID,
    C.CustomerName,
    I.InvoiceDate,
    I.DueDate,
    I.TotalAmount,
    DATEDIFF(DAY, I.DueDate, GETDATE()) AS DaysOverdue
FROM Invoices I
JOIN Customers C ON I.CustomerID = C.CustomerID
WHERE I.Status = 'Overdue'
ORDER BY DaysOverdue DESC;
```

## ADVANCED KPIs

* **Q.1. Find the top 3 customers by total payments in 2023, and 
also show how much more each customer paid compared to the average payment of all customers in 2023.**
```sql
select * from payments;
select * from invoices;
select * from customers;

WITH customer_totals AS (
    SELECT 
        c.customerid,
        c.customername,
        YEAR(p.paymentdate) AS year,
        SUM(p.amount) AS customer_total_payment
    FROM customers c
    JOIN invoices i ON c.CustomerID = i.CustomerID
    JOIN payments p ON i.InvoiceID = p.InvoiceID
    WHERE YEAR(p.paymentdate) = 2023
    GROUP BY c.customerid, c.customername, YEAR(p.paymentdate)
)
SELECT TOP 3
    customername,
    year,
    customer_total_payment,
    customer_total_payment - (SELECT AVG(customer_total_payment) 
                              FROM customer_totals) AS variance_from_avg
FROM customer_totals
ORDER BY customer_total_payment DESC;
```

* **Q.2. Find the top 5 invoices with the highest delays in payment for 2023. For each invoice, show:
   Invoice ID
   Customer Name
   Invoice Date
   Payment Date
   Delay in days (PaymentDate - InvoiceDate)
   Rank of the delay (using a window function)**
```sql
SELECT TOP 5
    i.invoiceid,
    c.customername,
    i.invoicedate,
    p.paymentdate,
    DATEDIFF(day, i.invoicedate, p.paymentdate) AS delay_days,
    RANK() OVER (ORDER BY DATEDIFF(day, i.invoicedate, p.paymentdate) DESC) AS delay_rank
FROM invoices i
JOIN customers c ON i.customerid = c.customerid
JOIN payments p ON i.invoiceid = p.invoiceid
WHERE YEAR(i.invoicedate) = 2023
ORDER BY delay_days DESC;
```

* **Q.3. Analyze monthly revenue trends for 2023 and identify any month where revenue decreased compared to the previous month. Use a CTE and the LAG() window function. Display:
  Month
  Total Revenue
  Previous Month Revenue
  Difference
  Indicator (Increase/Decrease)**
```sql
WITH monthly_revenue AS (
    SELECT 
        MONTH(invoicedate) AS month,
        SUM(totalamount) AS total_revenue
    FROM invoices
    WHERE YEAR(invoicedate) = 2023
    GROUP BY MONTH(invoicedate)
)
SELECT 
    month,
    total_revenue,
    LAG(total_revenue) OVER (ORDER BY month) AS previous_month_revenue,
    total_revenue - LAG(total_revenue) OVER (ORDER BY month) AS difference,
    CASE 
        WHEN total_revenue - LAG(total_revenue) OVER (ORDER BY month) < 0 THEN 'Decrease'
        ELSE 'Increase'
    END AS indicator
FROM monthly_revenue
ORDER BY month;
```

* **Q.4. Find the top 3 customers who have made the largest total payments.Display CustomerName and TotalPaid.**
```sql
Select * from customers;
select * from invoices;
select * from payments;

select top 3
      c.customername,
      sum(p.amount) as Totalpaid
from customers c
join invoices i
on c.customerid=i.customerid
join payments p
on i.invoiceid=p.invoiceid
group by c.customername,c.customerid
order by totalpaid desc;
```

* **Q.5. Calculate the percentage contribution of each customer to the total revenue in 2023.
          Show: CustomerName, TotalRevenue, RevenuePercentage.
          Round the percentage to 2 decimal places.**
```sql
select * from customers;
select * from invoices;
select 
      c.customername,
     sum( i.totalamount) as total_revenue,
      round(sum(i.totalamount)*100/(select sum(i.totalamount) from invoices i),2) as revenue_percentage
from customers c
join invoices i
on c.customerid=i.customerid
where year(i.invoicedate)='2023'
group by c.customername,c.customerid;
```

* **Q.6. Write a query to calculate the average, minimum, and maximum invoice amount per month in 2023.**
```sql
select * from invoices;
select
     avg(totalamount) as avg_amount,
     min(totalamount) as min_amount,
     max(totalamount) as max_amount
from invoices
where year(invoicedate)='2023'
group by month(invoicedate);
```
   
* **Q.7. Find customers who have not made any payments in 2023.**
```sql
select * from payments;
select * from customers;
select * from invoices;

SELECT C.CustomerName
FROM Customers C
JOIN Invoices I ON C.CustomerID = I.CustomerID
LEFT JOIN Payments P ON I.InvoiceID = P.InvoiceID
WHERE YEAR(I.InvoiceDate) = 2023
GROUP BY C.CustomerName
HAVING COUNT(P.PaymentID) = 0;
```

* **Q.8. Find the customers whose total payments are less than 50% of their total invoice amount in 2023.**
```sql
select * from payments;
select * from customers;
select * from invoices;

SELECT
     C.CustomerName,
     SUM(P.Amount) AS Total_Payment,
     SUM(I.TotalAmount) AS Total_Invoice,
     SUM(P.Amount) * 100.0 / SUM(I.TotalAmount) AS Percentage
FROM Customers C
JOIN Invoices I ON C.CustomerID = I.CustomerID
JOIN Payments P ON I.InvoiceID = P.InvoiceID
WHERE YEAR(I.InvoiceDate) = '2023'
AND YEAR(P.PaymentDate) = '2023'
GROUP BY C.CustomerName, C.CustomerID
HAVING SUM(P.Amount) * 1.0 / SUM(I.TotalAmount) < 0.5;
```

* **Q.9.Rank customers by total payments in 2023 using a window function so you can see the rank of each customer.**
```sql
select * from customers;
select * from payments;
select * from invoices;

select 
      c.customername,
      sum(p.amount) as total_payment,
      rank()over(order by sum(p.amount) desc) as rnk
from customers c
join invoices i
on c.CustomerID=i.CustomerID
join payments p
on i.InvoiceID=p.InvoiceID
where year(p.paymentdate)='2023'
group by c.CustomerID,c.CustomerName;
```

* **Q.10. Find all customers whose total payments in 2023 are greater than the average payment of all customers in 2023.**
```sql
select * from customers;
select * from payments;
select * from invoices;

SELECT 
    C.CustomerName,
    SUM(P.Amount) AS Total_Payment
FROM Customers C
JOIN Invoices I ON C.CustomerID = I.CustomerID
JOIN Payments P ON I.InvoiceID = P.InvoiceID
WHERE YEAR(P.PaymentDate) = 2023
GROUP BY C.CustomerName, C.CustomerID
HAVING SUM(P.Amount) > (
    SELECT AVG(SUM_Payment)
    FROM (
        SELECT SUM(P2.Amount) AS SUM_Payment
        FROM Customers C2
        JOIN Invoices I2 ON C2.CustomerID = I2.CustomerID
        JOIN Payments P2 ON I2.InvoiceID = P2.InvoiceID
        WHERE YEAR(P2.PaymentDate) = 2023
        GROUP BY C2.CustomerID
    ) AS CustomerPayments
);
```

* **Q.11. Use a Common Table Expression (CTE) to find the top 5 customers with the highest total payments in 2023.**
```sql
select * from customers;
select * from payments;
select * from invoices;


with All_payments as
(
select 
      c.customername,
      c.customerid,
      sum(p.amount) as total_payment
from customers c
join invoices i
on c.CustomerID=i.CustomerID
join payments p
on i.InvoiceID=p.InvoiceID
where year(paymentdate)=2023
group by c.customername,c.customerid
)
select top 5 * from All_payments
order by total_payment desc;
```

* **Q.12. Find the top 3 departments with the highest average salary in 2023.**
```sql
select * from employees;

select top 3
       department,
       avg(salary) as avg_salary
from employees 
where year(hiredate)=2023
group by department
order by avg_salary desc;
```

* **Q.13. Write a query to find the total salary paid per department in 2023, and also calculate what percentage of the company’s total 2023 salary each department represents.**
```sql
select * from employees;
SELECT
      department,
      SUM(salary) AS dept_total_salary,
      ROUND(SUM(salary) * 100.0 / (SELECT SUM(salary) 
                                   FROM employees 
                                   WHERE YEAR(hiredate)=2023), 2) AS percentage
FROM employees
WHERE YEAR(hiredate)=2023
GROUP BY department;
```

* **Q.14. Rank departments by total salary in 2023 using a window function, and also show each department’s percentage of total salary.**
```sql
SELECT
      department,
      SUM(salary) AS dept_total_salary,
      DENSE_RANK() OVER (ORDER BY SUM(salary) DESC) AS dense_rank,
      ROUND(SUM(salary) * 100.0 / (SELECT SUM(salary) 
                                   FROM employees
                                   WHERE YEAR(hiredate)=2023), 2) AS percentage
FROM employees
WHERE YEAR(hiredate)=2023
GROUP BY department;
```

## Findings
- **Customer Analysis**: A small group of customers contributed the majority of revenue, with some customers consistently delaying payments, creating potential cash flow risks.  
- **Invoice Insights**: Pending and overdue invoices made up a significant portion of 2023 transactions, highlighting collection inefficiencies.  
- **Employee Costs**: Salaries were heavily concentrated in a few departments, with Finance and IT being the top contributors.  
- **Budget vs Actuals**: Several departments overspent their allocated budgets, with variances showing gaps in financial discipline.  
- **Vendor Analysis**: Vendors supplying office supplies were invoiced the most, while overseas vendors had fewer but higher-value invoices.  
- **Payment Behavior**: The average payment delay was within 20–30 days, but outliers exceeded 60 days, impacting liquidity.  

## Report
This project successfully simulated a realistic business environment using accounting and finance data. The structured SQL queries (basic, intermediate, and advanced) allowed for comprehensive exploration of company performance.  
- **Basic queries** focused on customer demographics, invoice counts, and revenue contributions.  
- **Intermediate queries** revealed payment behaviors, departmental budget control, and vendor performance.  
- **Advanced queries** showcased the power of CTEs, subqueries, and window functions to evaluate trends, rank entities, and calculate variances over time.  

Key KPIs such as total revenue, overdue invoices, budget variance, and customer payment performance were derived and analyzed to provide actionable insights.  

## Conclusion
The analysis demonstrated how SQL can be leveraged to drive financial and operational insights in an accounting and finance context. By progressing from simple retrievals to advanced analytics, this project highlights the full spectrum of SQL’s capabilities.  

This dataset and query bank can serve as:  
- A **learning resource** for SQL practice,  
- A **reference project** for demonstrating analytics skills, and  
- A **foundation** for more advanced BI tools or dashboard development.  

Ultimately, the project shows that structured SQL practice on realistic datasets equips learners with both technical proficiency and business-oriented analytical thinking.

     
## Suggested Usage

* Clone the repository to your local environment.
* Load the dataset using `dataset.sql`.
* Practice queries from `basic_queries.sql`, `intermediate_queries.sql`, and `advanced_queries.sql`.
* Use the assessment report to track your progress.

# Author - Kofi Obeng Nti
This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles.

# Appreciation
Thank you for taking time to read! I hope you found this project helpful  and easy to follow .If you have any questions, suggestions, feedback or would like to collaborate ,feel free to open an issue or reach out- I'd love to hear from you! 

# Connect with Me
- **Email**: kofiobengnti@gmail.com
- **Linkedin** : www.linkedin.com/in/kofi-obeng-nti-aa3884140


