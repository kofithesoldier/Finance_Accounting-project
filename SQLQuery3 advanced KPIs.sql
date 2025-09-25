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

