create database salesdata;

use salesdata;

imported csv file 
select * from sales;

 Total Revenue
SELECT SUM(total_amount) AS total_revenue
FROM sales;

Monthly Revenue Trend
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(total_amount) AS monthly_revenue
FROM sales
GROUP BY month
ORDER BY month;

Top 5 Customers by Spending
SELECT
    customer_id,
    customer_name,
    SUM(total_amount) AS total_spent
FROM sales
GROUP BY customer_id, customer_name
ORDER BY total_spent DESC
LIMIT 5;

Sales by Product Category
SELECT
    product_category,
    COUNT(*) AS total_orders,
    SUM(total_amount) AS revenue
FROM sales
GROUP BY product_category;

Best-Selling Products
SELECT
    product_name,
    SUM(quantity) AS total_quantity_sold
FROM sales
GROUP BY product_name
ORDER BY total_quantity_sold DESC;

Average Order Value
SELECT
    ROUND(AVG(total_amount), 2) AS avg_order_value
FROM sales;

Payment Mode Analysis
SELECT
    payment_mode,
    COUNT(*) AS transactions
FROM sales
GROUP BY payment_mode
ORDER BY transactions DESC;

City-wise Revenue
SELECT
    city,
    SUM(total_amount) AS revenue
FROM sales
GROUP BY city
ORDER BY revenue DESC;

Customers with more than 2 orders
SELECT
    customer_id,
    customer_name,
    COUNT(*) AS orders
FROM sales
GROUP BY customer_id, customer_name
HAVING orders > 2;

Running Monthly Revenue (Window Function)
SELECT
    month,
    monthly_revenue,
    SUM(monthly_revenue) OVER (ORDER BY month) AS running_revenue
FROM (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        SUM(total_amount) AS monthly_revenue
    FROM sales
    GROUP BY month
) t;

Products by Revenue
SELECT
    product_name,
    SUM(total_amount) AS revenue,
    RANK() OVER (ORDER BY SUM(total_amount) DESC) AS revenue_rank
FROM sales
GROUP BY product_name;

Customer Segmentation (High / Medium / Low value)
SELECT
    customer_id,
    customer_name,
    SUM(total_amount) AS total_spent,
    CASE
        WHEN SUM(total_amount) >= 100000 THEN 'High Value'
        WHEN SUM(total_amount) >= 50000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM sales
GROUP BY customer_id, customer_name;

Month-over-Month Revenue Growth
SELECT
    month,
    monthly_revenue,
    monthly_revenue - LAG(monthly_revenue) OVER (ORDER BY month) AS revenue_change
FROM (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        SUM(total_amount) AS monthly_revenue
    FROM sales
    GROUP BY month
) t;
