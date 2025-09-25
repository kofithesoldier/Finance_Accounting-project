--ADVANCED KPIs

--Q.1. Find the top 3 customers by total payments in 2023, and 
--also show how much more each customer paid compared to the average payment of all customers in 2023.

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

--Q.2. Find the top 5 invoices with the highest delays in payment for 2023. For each invoice, show:
--Invoice ID
--Customer Name
--Invoice Date
--Payment Date
--Delay in days (PaymentDate - InvoiceDate)
--Rank of the delay (using a window function)

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


--Q.3. Analyze monthly revenue trends for 2023 and identify any month where revenue decreased compared to the previous month. Use a CTE and the LAG() window function. Display:
--Month
--Total Revenue
--Previous Month Revenue
--Difference
--Indicator (Increase/Decrease)

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

--Q.4. Find the top 3 customers who have made the largest total payments.Display CustomerName and TotalPaid.
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

--Q.5. Calculate the percentage contribution of each customer to the total revenue in 2023.
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


--Q.6. Write a query to calculate the average, minimum, and maximum invoice amount per month in 2023.
select * from invoices;
select
     avg(totalamount) as avg_amount,
     min(totalamount) as min_amount,
     max(totalamount) as max_amount
from invoices
where year(invoicedate)='2023'
group by month(invoicedate);
   
--Q.7. Find customers who have not made any payments in 2023.
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

--Q.8. Find the customers whose total payments are less than 50% of their total invoice amount in 2023.
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

--Q.9.Rank customers by total payments in 2023 using a window function so you can see the rank of each customer.
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

--Q.10. Find all customers whose total payments in 2023 are greater than the average payment of all customers in 2023.
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


--Q.11. Use a Common Table Expression (CTE) to find the top 5 customers with the highest total payments in 2023.
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


--Q.12. Find the top 3 departments with the highest average salary in 2023.
select * from employees;

select top 3
       department,
       avg(salary) as avg_salary
from employees 
where year(hiredate)=2023
group by department
order by avg_salary desc;

--Q.13. Write a query to find the total salary paid per department in 2023, 
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


--Q.14. Rank departments by total salary in 2023 using a window function, and also show each department’s percentage of total salary.

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

     




