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
-- ===============================
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
-- ===============================
```SQL
CREATE TABLE Customers (
    CustomerID VARCHAR(10) PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Industry VARCHAR(50),
    Country VARCHAR(50),
    JoinDate DATE
);
```
The data was generated with realistic values to allow meaningful SQL analysis and KPI calculations.

## Project Highlights for Portfolio

* **Hands-on SQL practice** from basic queries to advanced analytics.
* **Business insights**: Calculate KPIs like revenue, payment delays, budget variances, and trends.
* **Advanced techniques**: Window functions, CTEs (including recursive), ranking, trend analysis.
* **Portfolio-ready**: Demonstrates real-world SQL problem-solving in finance and accounting contexts.

  

## How This Project Shows Your Skills

* **Data exploration**: Understanding relationships and data structures.
* **Analytical skills**: Creating KPIs and interpreting results.
* **SQL mastery**: Joins, aggregations, subqueries, window functions, CTEs.
* **Problem-solving**: Handling real-world scenarios like partial payments, cumulative revenue, and vendor performance.

## Suggested Usage

* Clone the repository to your local environment.
* Load the dataset using `dataset.sql`.
* Practice queries from `basic_queries.sql`, `intermediate_queries.sql`, and `advanced_queries.sql`.
* Use the assessment report to track your progress.

**Showcase this project on GitHub** to demonstrate your SQL expertise in a finance and accounting context. It’s portfolio-ready and demonstrates structured, real-world SQL problem-solving skills.
