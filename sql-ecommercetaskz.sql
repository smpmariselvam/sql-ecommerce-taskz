```sql
CREATE DATABASE ecommerce;

USE ecommerce;

-- Customers Table
CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    address VARCHAR(255)
);

-- Products Table
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2),
    description VARCHAR(255)
);

-- Orders Table
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),

    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

-- Insert Customers
INSERT INTO customers (name, email, address)
VALUES
('Alice', 'alice@gmail.com', 'Chennai'),
('Bob', 'bob@gmail.com', 'Coimbatore'),
('Charlie', 'charlie@gmail.com', 'Madurai');

-- Insert Products
INSERT INTO products (name, price, description)
VALUES
('Product A', 25.00, 'Mobile Charger'),
('Product B', 35.00, 'Bluetooth Mouse'),
('Product C', 40.00, 'Keyboard'),
('Product D', 60.00, 'Headset');

-- Insert Orders
INSERT INTO orders (customer_id, order_date, total_amount)
VALUES
(1, CURDATE() - INTERVAL 10 DAY, 200.00),
(2, CURDATE() - INTERVAL 20 DAY, 120.00),
(3, CURDATE() - INTERVAL 40 DAY, 300.00),
(1, CURDATE() - INTERVAL 5 DAY, 180.00);

-- Customers who placed orders in last 30 days
SELECT DISTINCT customers.*
FROM customers
JOIN orders
ON customers.id = orders.customer_id
WHERE orders.order_date >= CURDATE() - INTERVAL 30 DAY;

-- Total amount spent by each customer
SELECT customers.name,
       SUM(orders.total_amount) AS total_spent
FROM customers
JOIN orders
ON customers.id = orders.customer_id
GROUP BY customers.name;

-- Update Product C price
UPDATE products
SET price = 45.00
WHERE id = 3;

-- Add discount column
ALTER TABLE products
ADD discount DECIMAL(5,2);

-- Top 3 highest priced products
SELECT *
FROM products
ORDER BY price DESC
LIMIT 3;

-- Create order_items table
CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,

    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Insert order_items data
INSERT INTO order_items (order_id, product_id, quantity)
VALUES
(1, 1, 2),
(1, 2, 1),
(2, 3, 1),
(3, 1, 3),
(4, 4, 1);

-- Customers who ordered Product A
SELECT DISTINCT customers.name
FROM customers
JOIN orders
ON customers.id = orders.customer_id
JOIN order_items
ON orders.id = order_items.order_id
JOIN products
ON order_items.product_id = products.id
WHERE products.name = 'Product A';

-- Customer name and order date
SELECT customers.name,
       orders.order_date
FROM customers
JOIN orders
ON customers.id = orders.customer_id;

-- Orders greater than 150
SELECT *
FROM orders
WHERE total_amount > 150.00;

-- Average order total
SELECT AVG(total_amount) AS average_order_total
FROM orders;
```
