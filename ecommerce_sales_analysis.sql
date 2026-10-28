CREATE DATABASE ecommerce_sales;

USE ecommerce_sales;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),
    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

INSERT INTO customers (customer_id, customer_name, city)
VALUES
(101, 'Amit Patil', 'Nashik'),
(102, 'Priya Sharma', 'Pune'),
(103, 'Rahul Deshmukh', 'Mumbai'),
(104, 'Sneha Joshi', 'Nashik'),
(105, 'Neha Kulkarni', 'Pune'),
(106, 'Rohan Pawar', 'Nagpur'),
(107, 'Pooja Shinde', 'Mumbai'),
(108, 'Akash Jadhav', 'Nashik'),
(109, 'Kavita More', 'Pune'),
(110, 'Sagar Chavan', 'Aurangabad');
SELECT * FROM customers;

INSERT INTO products (product_id, product_name, category, price)
VALUES
(101, 'Laptop', 'Electronics', 55000.00),
(102, 'Smartphone', 'Electronics', 25000.00),
(103, 'Headphones', 'Electronics', 1500.00),
(104, 'Office Chair', 'Furniture', 4500.00),
(105, 'Study Table', 'Furniture', 6000.00),
(106, 'T-Shirt', 'Clothing', 800.00),
(107, 'Jeans', 'Clothing', 1800.00),
(108, 'Running Shoes', 'Footwear', 2500.00),
(109, 'Backpack', 'Accessories', 1200.00),
(110, 'Wrist Watch', 'Accessories', 3500.00);
SELECT * FROM products;

INSERT INTO orders (order_id, customer_id, order_date)
VALUES
(101, 101, '2026-01-05'),
(102, 102, '2026-01-10'),
(103, 103, '2026-01-15'),
(104, 104, '2026-02-02'),
(105, 105, '2026-02-08'),
(106, 106, '2026-02-14'),
(107, 107, '2026-03-03'),
(108, 108, '2026-03-12'),
(109, 109, '2026-03-18'),
(110, 110, '2026-03-25');
SELECT * FROM orders;

INSERT INTO order_details
(order_detail_id, order_id, product_id, quantity)
VALUES
(101, 101, 101, 1),
(102, 102, 102, 2),
(103, 103, 103, 1),
(104, 104, 104, 2),
(105, 105, 105, 1),
(106, 106, 106, 3),
(107, 107, 107, 2),
(108, 108, 108, 1),
(109, 109, 109, 2),
(110, 110, 110, 1);
SELECT * FROM order_details;

SELECT
    o.order_id,
    p.product_name,
    p.price,
    od.quantity,
    (p.price * od.quantity) AS total_sales
FROM orders o
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id;

SELECT
    SUM(p.price * od.quantity) AS total_revenue
FROM products p
JOIN order_details od
    ON p.product_id = od.product_id;

SELECT
    p.product_name,
    p.price,
    od.quantity,
    (p.price * od.quantity) AS total_sales
FROM products p
JOIN order_details od
    ON p.product_id = od.product_id;

SELECT
    p.product_name,
    SUM(p.price * od.quantity) AS total_sales
FROM products p
JOIN order_details od
    ON p.product_id = od.product_id
GROUP BY p.product_name
ORDER BY total_sales DESC
LIMIT 1;

SELECT
    p.category,
    SUM(p.price * od.quantity) AS total_sales
FROM products p
JOIN order_details od
    ON p.product_id = od.product_id
GROUP BY p.category
ORDER BY total_sales DESC;

SELECT
    c.customer_id,
    c.customer_name,
    SUM(p.price * od.quantity) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC;

SELECT
    MONTH(o.order_date) AS sales_month,
    SUM(p.price * od.quantity) AS total_sales
FROM orders o
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
GROUP BY MONTH(o.order_date)
ORDER BY sales_month;

SELECT
    p.product_name,
    SUM(od.quantity) AS total_quantity_sold
FROM products p
JOIN order_details od
    ON p.product_id = od.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 1;

SELECT
    c.customer_name,
    SUM(p.price * od.quantity) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(p.price * od.quantity) > 5000
ORDER BY total_spent DESC;

SELECT
    category,
    COUNT(*) AS total_products,
    AVG(price) AS average_price
FROM products
GROUP BY category
ORDER BY total_products DESC;

SELECT
    c.customer_id,
    c.customer_name
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

SELECT
    o.order_id,
    c.customer_name,
    p.product_name,
    p.price,
    od.quantity,
    (p.price * od.quantity) AS total_amount,
    o.order_date
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
ORDER BY o.order_date;

SELECT
    MONTHNAME(order_date) AS month_name,
    COUNT(*) AS total_orders
FROM orders
GROUP BY MONTH(order_date), MONTHNAME(order_date)
ORDER BY MONTH(order_date);





