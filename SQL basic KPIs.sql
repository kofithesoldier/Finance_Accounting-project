--BASIC KPIs
--Q.1. List all customers by country.
select * from customers;
select
      customername,
      country
from customers;

--Q.2. Find the total number of invoices raised in 2023.
select * from invoices;
select count(*) as invoice_count
from invoices 
where InvoiceDate between '2023-01-01' and '2023-12-31';

--Q.3. Get the total revenue per customer (sum of invoice amounts grouped by customer).
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

--Q.4. Show all employees who work in the Finance department.
select * from employees;
select * 
from employees
where Department='finance';

--Q.5. Write a query to find the distinct job titles of all employees.
select * from employees;

--Q.6. Retrieve all vendors located in the United States.
select * from vendors;
select * from vendors
where country='USA';

--Q.7. Retrieve all invoices with a total amount greater than 10,000
select * from invoices;
select * 
from invoices 
where TotalAmount >10000;

--Q.8.Show the total expenses for each category from the Expenses table.
select * from expenses;

select    
      category,
      sum(amount) as total_expenses
from expenses
group by category;

--Q.9. List the top 3 highest-paid employees.
select * from employees;

select top 3 *
from employees
order by salary desc;

--Q.10. Find the total number of customers in each country.
select * from customers;

select 
      country,
      count(*) as number_of_customers
from customers
group by country;

--Q.11. Retrieve all invoices that are currently pending.
select * from invoices;
select * 
from invoices
where status ='pending';

--Q.12. Show the total payment amount received for each invoice.
select * from payments;
select 
     invoiceid,
     sum(amount) as Total_payment
from payments
group by invoiceid;

--Q.13.List all expenses that were made in the year 2023.
select *
from expenses
where ExpenseDate between '2023-01-01' and '2023-12-31';

--Q.14. Retrieve all invoices along with the customer name for each invoice.
select * from invoices;
select * from customers;
select 
      c.customername,
      i.invoiceid
from customers c
join invoices i
on c.customerid=i.CustomerID;

--Q.15. Show all vendors who have provided office supplies.
select * from vendors;
select * from Vendors
where category = 'office supplies';

--Q.16. Find the average salary of employees in the company.
select * from employees;
select avg(salary)
from employees;

--Q.17. List all invoices that are paid and have an amount greater than 15,000.
select * from invoices;
select * 
from invoices 
where status='paid'
and TotalAmount>15000;

--Q.18. Retrieve all employees who were hired after January 1, 2023.
select * from employees;
select * 
from employees
where hiredate >'2023-01-01';

--Q.19. Show the total revenue generated in 2023 (sum of all invoice amounts for that year).
select * from invoices;
select 
      year(invoicedate) as year,
      sum(totalamount) as revenue
from invoices
group by year(invoicedate)
having year(invoicedate)='2023';

--Q.20. List all invoices along with their payment status — show whether they have been paid in full, partially paid, or not paid
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

