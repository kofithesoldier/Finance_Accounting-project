-- INTERMEDIATE KPIs

--Q.1. Calculate the Days Sales Outstanding (DSO) for the company.
--DSO = Average number of days between InvoiceDate and PaymentDate for invoices that have been paid.
SELECT 
    AVG(DATEDIFF(DAY, I.InvoiceDate, P.PaymentDate)) AS Avg_DSO
FROM Invoices I
JOIN Payments P 
    ON I.InvoiceID = P.InvoiceID;


--Q.2. Calculate the budget variance for each department.
--Budget variance = BudgetAmount – ActualSpent
--Show Department, Year, BudgetAmount, ActualSpent, and Variance.
select * from Budgets;
select 
      department,
      year,
      sum(budgetamount) as Budget_amount,
      sum(actualspent) as Actual_spent, 
      sum(budgetamount)-sum(actualspent)as variances
from budgets
group by department,year;

--Q.3. Find the top 5 customers who generated the highest total revenue in 2023.
select * from customers;
select * from invoices;

SELECT TOP 5
      C.CustomerName,
      SUM(I.TotalAmount) AS Total_Revenue
FROM Customers C
JOIN Invoices I
      ON C.CustomerID = I.CustomerID
WHERE YEAR(I.InvoiceDate) = 2023
GROUP BY C.CustomerName
ORDER BY Total_Revenue DESC;

--Q.4. Find the average payment delay per customer.
--Payment delay = difference (in days) between InvoiceDate and PaymentDate.
--Show CustomerName and their average delay.
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

--Q.5. Identify the top 3 departments with the highest total expenses in 2023.

select * from budgets;
select top 3
         department,
         sum(actualspent) as total_expenses
from budgets 
where year ='2023'
group by department
order by total_expenses desc;

--Q.6. Find all customers who have more than one invoice in the dataset.
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

--Q.7. Write a query to find the total number of customers from each country in the Customers table. 
--Display the country and the customer count, sorted from highest to lowest.
select * from customers;
select 
     country,
     count(*) as number_of_customers
from customers
group by country
order by number_of_customers desc;

--Q.8. Write a query to find the invoice with the highest total amount in the invoices table.
select * from invoices;
select top 1 * 
from invoices 
order  by totalamount desc;

--Q.9. Write a query to find the average salary per department from the employees table.
select * from employees;
select
      department,
      avg(salary) as avg_salary
from employees
group by department;

--Q.10. Write a query to find all invoices that are overdue.
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

