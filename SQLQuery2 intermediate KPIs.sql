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

--Q.11. Find the top 3 customers who have made the largest total payments.Display CustomerName and TotalPaid.
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

--Q.11. Calculate the percentage contribution of each customer to the total revenue in 2023.
--Show: CustomerName, TotalRevenue, RevenuePercentage.
--Round the percentage to 2 decimal places.
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


--Q.12 Write a query to calculate the average, minimum, and maximum invoice amount per month in 2023.
select * from invoices;
select
     avg(totalamount) as avg_amount,
     min(totalamount) as min_amount,
     max(totalamount) as max_amount
from invoices
where year(invoicedate)='2023'
group by month(invoicedate);
   
--Q.13. Find customers who have not made any payments in 2023.
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

--Q.14. Find the customers whose total payments are less than 50% of their total invoice amount in 2023.
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

--Q.15.Rank customers by total payments in 2023 using a window function so you can see the rank of each customer.
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

--Q.16. Find all customers whose total payments in 2023 are greater than the average payment of all customers in 2023.
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


--Q.17. Use a Common Table Expression (CTE) to find the top 5 customers with the highest total payments in 2023.
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


--Q.18. Find the top 3 departments with the highest average salary in 2023.
select * from employees;

select top 3
       department,
       avg(salary) as avg_salary
from employees 
where year(hiredate)=2023
group by department
order by avg_salary desc;

--Q.19. Write a query to find the total salary paid per department in 2023, 
--and also calculate what percentage of the company’s total 2023 salary each department represents.
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


--Q.20. Rank departments by total salary in 2023 using a window function, and also show each department’s percentage of total salary.

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

     
