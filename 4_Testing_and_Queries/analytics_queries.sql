-- Analytics Queries for BookStore
USE bookstore_db;

-- 1. Best-selling books by quantity
SELECT 
    b.book_id,
    b.title,
    GROUP_CONCAT(DISTINCT CONCAT(a.author_first_name, ' ', a.author_last_name) SEPARATOR ', ') AS authors,
    SUM(ol.quantity) AS total_sold,
    SUM(ol.line_total) AS total_revenue
FROM 
    book b
JOIN 
    order_line ol ON b.book_id = ol.book_id
JOIN 
    cust_order o ON ol.order_id = o.order_id
JOIN 
    book_author ba ON b.book_id = ba.book_id
JOIN 
    author a ON ba.author_id = a.author_id
WHERE 
    o.order_status_id != 5  -- Exclude cancelled orders
GROUP BY 
    b.book_id
ORDER BY 
    total_sold DESC;

-- 2. Sales by month (for current year)
SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(o.order_total) AS product_revenue,
    SUM(o.shipping_cost) AS shipping_revenue,
    SUM(o.tax_amount) AS tax_collected,
    SUM(o.grand_total) AS total_revenue
FROM 
    cust_order o
WHERE 
    o.order_status_id != 5 -- Exclude cancelled orders
    AND YEAR(o.order_date) = YEAR(CURRENT_DATE)
GROUP BY 
    month
ORDER BY 
    month;

-- 3. Customer purchase analysis
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(o.grand_total) AS total_spent,
    AVG(o.grand_total) AS average_order_value,
    MIN(o.order_date) AS first_order_date,
    MAX(o.order_date) AS most_recent_order,
    DATEDIFF(CURRENT_DATE, MAX(o.order_date)) AS days_since_last_order
FROM 
    customer c
LEFT JOIN 
    cust_order o ON c.customer_id = o.customer_id AND o.order_status_id != 5
GROUP BY 
    c.customer_id
ORDER BY 
    total_spent DESC;

-- 4. Book sales by publisher
SELECT 
    p.publisher_name,
    COUNT(DISTINCT b.book_id) AS number_of_books,
    SUM(ol.quantity) AS total_books_sold,
    SUM(ol.line_total) AS total_revenue
FROM 
    publisher p
JOIN 
    book b ON p.publisher_id = b.publisher_id
JOIN 
    order_line ol ON b.book_id = ol.book_id
JOIN 
    cust_order o ON ol.order_id = o.order_id
WHERE 
    o.order_status_id != 5  -- Exclude cancelled orders
GROUP BY 
    p.publisher_id
ORDER BY 
    total_revenue DESC;

-- 5. Book sales by language
SELECT 
    l.language_name,
    COUNT(DISTINCT b.book_id) AS number_of_books,
    SUM(ol.quantity) AS total_books_sold,
    SUM(ol.line_total) AS total_revenue
FROM 
    book_language l
JOIN 
    book b ON l.language_id = b.language_id
JOIN 
    order_line ol ON b.book_id = ol.book_id
JOIN 
    cust_order o ON ol.order_id = o.order_id
WHERE 
    o.order_status_id != 5  -- Exclude cancelled orders
GROUP BY 
    l.language_id
ORDER BY 
    total_revenue DESC;

-- 6. Best-selling authors
SELECT 
    CONCAT(a.author_first_name, ' ', a.author_last_name) AS author_name,
    COUNT(DISTINCT b.book_id) AS number_of_books,
    SUM(ol.quantity) AS total_books_sold,
    SUM(ol.line_total) AS total_revenue
FROM 
    author a
JOIN 
    book_author ba ON a.author_id = ba.author_id
JOIN 
    book b ON ba.book_id = b.book_id
JOIN 
    order_line ol ON b.book_id = ol.book_id
JOIN 
    cust_order o ON ol.order_id = o.order_id
WHERE 
    o.order_status_id != 5  -- Exclude cancelled orders
GROUP BY 
    a.author_id
ORDER BY 
    total_revenue DESC;

-- 7. Average time between order status changes
SELECT 
    s1.status_name AS from_status,
    s2.status_name AS to_status,
    AVG(TIMESTAMPDIFF(HOUR, h1.status_date, h2.status_date)) AS avg_hours_between
FROM 
    order_history h1
JOIN 
    order_history h2 ON h1.order_id = h2.order_id AND h1.history_id < h2.history_id
JOIN 
    order_status s1 ON h1.status_id = s1.status_id
JOIN 
    order_status s2 ON h2.status_id = s2.status_id
WHERE 
    NOT EXISTS (
        SELECT 1 
        FROM order_history h3 
        WHERE h3.order_id = h1.order_id AND h3.history_id > h1.history_id AND h3.history_id < h2.history_id
    )
GROUP BY 
    s1.status_id, s2.status_id
ORDER BY 
    s1.status_name, s2.status_name;

-- 8. Inventory value by publisher
SELECT 
    p.publisher_name,
    COUNT(b.book_id) AS number_of_titles,
    SUM(b.stock_quantity) AS total_books,
    SUM(b.stock_quantity * b.price) AS inventory_value
FROM 
    publisher p
JOIN 
    book b ON p.publisher_id = b.publisher_id
GROUP BY 
    p.publisher_id
ORDER BY 
    inventory_value DESC;

-- 9. Sales by shipping method
SELECT 
    sm.method_name,
    COUNT(o.order_id) AS number_of_orders,
    SUM(o.shipping_cost) AS shipping_revenue,
    SUM(o.grand_total) AS total_order_value,
    ROUND(AVG(o.shipping_cost / o.grand_total) * 100, 2) AS avg_shipping_percentage
FROM 
    shipping_method sm
JOIN 
    cust_order o ON sm.method_id = o.shipping_method_id
WHERE 
    o.order_status_id != 5  -- Exclude cancelled orders
GROUP BY 
    sm.method_id
ORDER BY 
    number_of_orders DESC;

-- 10. Low stock alert report
SELECT 
    b.book_id,
    b.title,
    GROUP_CONCAT(DISTINCT CONCAT(a.author_first_name, ' ', a.author_last_name) SEPARATOR ', ') AS authors,
    b.stock_quantity,
    IFNULL(SUM(ol.quantity), 0) AS sold_last_30_days
FROM 
    book b
LEFT JOIN 
    order_line ol ON b.book_id = ol.book_id
LEFT JOIN 
    cust_order o ON ol.order_id = o.order_id AND o.order_date >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)
JOIN 
    book_author ba ON b.book_id = ba.book_id
JOIN 
    author a ON ba.author_id = a.author_id
WHERE 
    b.stock_quantity < 10
GROUP BY 
    b.book_id
ORDER BY 
    b.stock_quantity ASC, sold_last_30_days DESC;