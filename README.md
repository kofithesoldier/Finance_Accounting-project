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
