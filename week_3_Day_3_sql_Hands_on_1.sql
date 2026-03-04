/*
Pre-Requisites: Before starting with problem solving, please make sure that you have created a database and restored data (refer Sample Database create objects.txt and load data.txt)
Level-1: Problem 1 - Basic Customer Order Report
Scenario:
The store manager wants a simple report showing customer orders along with their order dates and status. This report will help track pending and completed orders.
 Requirements
1. Retrieve customer first name, last name, order_id, order_date, and order_status.
2. Display only orders with status Pending (1) or Completed (4).
3. Sort the results by order_date in descending order.

 Technical Constraints
- Use SELECT statement.
- Use WHERE clause with logical operators (AND/OR).
- Use ORDER BY clause.
- Use INNER JOIN between customers and orders tables.

Expectations:
Students should write a correct query using joins and filters, and properly order the result set.
 Learning Outcome 
Understand basic SELECT queries, filtering using WHERE conditions, logical operators, and sorting using ORDER BY clause with INNER JOIN.
*/
CREATE DATABASE StoreDB;
GO

USE StoreDB;
GO
CREATE TABLE customers (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    created_date DATETIME DEFAULT GETDATE()
);
CREATE TABLE orders (
    order_id INT IDENTITY(1001,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME DEFAULT GETDATE(),
    order_status INT NOT NULL,
    total_amount DECIMAL(10,2),

    CONSTRAINT FK_orders_customers
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    CONSTRAINT CHK_order_status
        CHECK (order_status IN (1,2,3,4))
);
INSERT INTO customers (first_name, last_name, email)
VALUES 
('John', 'Smith', 'john.smith@email.com'),
('Maria', 'Brown', 'maria.brown@email.com'),
('David', 'Wilson', 'david.wilson@email.com'),
('Anita', 'Kumar', 'anita.kumar@email.com'),
('Rahul', 'Sharma', 'rahul.sharma@email.com');

INSERT INTO orders (customer_id, order_status, total_amount)
VALUES
(1, 1, 2500.00),   -- Pending
(1, 4, 4500.00),   -- Completed
(2, 2, 1800.00),   -- Processing
(3, 4, 3200.00),   -- Completed
(4, 3, 1500.00),   -- Cancelled
(5, 1, 2100.00),   -- Pending
(2, 4, 5000.00);   -- Completed

SELECT * FROM customers;
SELECT * FROM orders;

select c.first_name,c.last_name,ord.order_id,ord.order_date,ord.order_status
from customers c inner join orders Ord
on c.customer_id=ord.customer_id
where ord.order_status =1 or ord.order_status=4
--where order_status in (1,4)
order by ord.order_date desc
