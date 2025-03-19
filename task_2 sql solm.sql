SELECT * FROM CUSTOMERS
SELECT * FROM ORDERS
SELECT * FROM ORDER_ITEMS
SELECT * FROM PRODUCTS

--1. JOINS
--Task 1:
--Retrieve the customer_name, city, and order_date for each customer who 
--placed an order in 2023 by joining the customers and orders tables
SELECT C.CUSTOMER_NAME,C.CITY,O.ORDER_DATE FROM ORDERS AS O JOIN CUSTOMERS AS C ON 
C.CUSTOMER_ID=O.CUSTOMER_ID WHERE ORDER_DATE BETWEEN '2023-01-01' AND '2023-12-31'

--Task 2:
--Get a list of all products (with product_name, category, and total_price) 
--ordered by customers living in Mumbai, by joining the customers, orders, 
--order_items, and products tables.
SELECT p.product_name, p.category, oi.total_price
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE c.city = 'Mumbai';

--Task 3:
--Find all orders where customers paid using 'Credit Card' and display the 
--customer_name, order_date, and total_price by joining the customers, 
--orders, and order_items tables.
select c.customer_name,o.order_date,oi.total_price from customers as c
join orders o on c.customer_id=o.customer_id
join order_items as oi on o.order_id=oi.order_id
where payment_mode='Credit Card'

--Task 4:
--Display the product_name, category, and the total_price for all products 
--ordered in the first half of 2023 (January - June) by joining the orders, 
--order_items, and products tables
select p.product_name,p.category,oi.total_price from products as p 
join order_items oi on p.product_id=oi.product_id
join orders o on o.order_id=oi.order_id
where order_date between '2023-01-01 'and '2023-06-30'

--Task 5:
--Show the total number of products ordered by each customer, displaying 
--customer_name and total products ordered, using joins between 
--customers, orders, and order_items
select c.customer_name,p.product_name from orders as o
join customers c on c.customer_id=o.customer_id
join order_items oi on o.order_id=oi.order_id
join products p on p.product_id=oi.product_id


--2. DISTINCT
--Task 1:
--Get a distinct list of cities where customers are located
select distinct city from customers

--Task 2:
--Retrieve distinct supplier_name from the products table.
select distinct supplier_name from products

--Task 2:
--Retrieve distinct supplier_name from the products table.
select distinct payment_mode method from orders

--Task 4:
--List all distinct product categories that have been ordered
select distinct category from products

--Task 5:
--Find distinct cities from which suppliers supply products by querying the 
--products table
select distinct supplier_city from products


--3. ORDER BY
--Task 1:
--List all customers sorted by customer_name in ascending order.
select * from customers
order by customer_name

--Task 2:
--Display all orders sorted by total_price in descending order.
select * from order_items
order by total_price desc

--Task 3:
--Retrieve a list of products sorted by price in ascending order and then by 
--category in descending order.
select * from products
order by price desc ,category asc

--Task 4:
--Sort all orders by order_date in descending order and display the order_id, 
--customer_id, and order_date.
select order_id,customer_id,order_date from orders
order by order_date desc

--Task 5:
--Get the list of cities where orders were placed, sorted in alphabetical order, 
--and display the total number of orders placed in each city
SELECT city, COUNT(*) AS total_orders
FROM customers
GROUP BY city
ORDER BY city ASC;


--4. LIMIT & OFFSET
--Task 1:
--Retrieve the first 10 rows from the customers table ordered by 
--customer_name.
select * from customers
order by customer_name
limit 10

--Task 2:
--Display the top 5 most expensive products (sorted by price in descending 
--order).
select * from products 
order by price desc
limit 5

--Task 3:
--Get the orders for the 11th to 20th customers (using OFFSET and LIMIT), 
--sorted by customer_id.
SELECT * 
FROM orders 
ORDER BY customer_id 
LIMIT 10 OFFSET 10;

--Task 4:
--List the first 5 orders placed in 2023, displaying order_id, order_date, and 
--customer_id.
SELECT order_id, order_date, customer_id
FROM orders
WHERE order_date BETWEEN '2023-01-01' AND '2023-12-31'
ORDER BY order_date ASC
LIMIT 5;

--Task 5:
--Fetch the next 10 distinct cities where orders were placed, using LIMIT and 
--OFFSET.
select distinct delivery_city from orders
order by delivery_city
limit 10 offset 10


--5. AGGREGATE FUNCTIONS
--Task 1:
--Calculate the total number of orders placed by all customers.
select COUNT(*) as total_orders from customers

--Task 2:
--Find the total revenue generated from orders paid via 'UPI' from the orders
select SUM(ORDER_AMOUNT) AS TOTAL_REVENUE from orders
where payment_mode='UPI'

--Task 3:
--Get the average price of all products in the products table.
SELECT AVG(PRICE) AS AVG_PRICE FROM PRODUCTS

--Task 4:
--Find the maximum and minimum total price of orders placed in 2023.
SELECT MAX(ORDER_AMOUNT) AS TOTAL_MAX_PRICE,MIN(ORDER_AMOUNT) AS TOTAL_MIN_PRICE 
FROM ORDERS
WHERE ORDER_DATE BETWEEN '2023-01-01' AND '2023-12-30'

--Task 5:
--Calculate the total quantity of products ordered for each product_id using 
--the order_items table.
SELECT SUM(QUANTITY) AS TOTAL_QUANTITY_PRODUCTS,PRODUCT_ID FROM ORDER_ITEMS
GROUP BY PRODUCT_ID


--6. SET OPERATIONS
--Task 1:
--Get the list of customers who have placed orders in both 2022 and 2023 
--(use INTERSECT)
SELECT customer_id 
FROM orders 
WHERE ORDER_DATE BETWEEN '2022-01-01' AND '2022-12-30'

INTERSECT

SELECT customer_id 
FROM orders 
WHERE ORDER_DATE BETWEEN '2023-01-01' AND '2023-12-30'

--Task 2:
--Find the products that were ordered in 2022 but not in 2023 (use EXCEPT).
SELECT DISTINCT product_id 
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
WHERE ORDER_DATE BETWEEN '2023-01-01' AND '2023-12-30'

EXCEPT

SELECT DISTINCT product_id 
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
WHERE ORDER_DATE BETWEEN '2023-01-01' AND '2023-12-30'

--Task 3:
--Display the list of supplier_city from the products table that do not match 
--any customer_city in the customers table (use EXCEPT).
SELECT DISTINCT supplier_city 
FROM products 

EXCEPT 

SELECT DISTINCT city 
FROM customers

--Task 4:
--Show a combined list of supplier_city from products and city from 
--customers (use UNION).
SELECT DISTINCT supplier_city AS city 
FROM products 

UNION 

SELECT DISTINCT city 
FROM customers;

--Task 5:
--Find the list of product_name from the products table that were ordered in 
--2023 (use INTERSECT with the orders and order_items tables)
SELECT DISTINCT product_name 
FROM products 

INTERSECT 

SELECT DISTINCT p.product_name 
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE ORDER_DATE BETWEEN '2023-01-01' AND '2023-12-30'


--7. SUBQUERIES
--Task 1:
--Find the names of customers who placed orders with a total price greater 
--than the average total price of all orders.

Task 2:
Get a list of products that have been ordered more than once by any 
customer.

Task 3:
Retrieve the product names that were ordered by customers from Pune 
using a subquery.
Task 4:
Find the top 3 most expensive orders using a subquery.
Task 5:
Get the customer names who placed orders for a product that costs more 
than ₹30,000 using a subquery









