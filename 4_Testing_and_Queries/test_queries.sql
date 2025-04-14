-- Test Queries for BookStore Database
USE bookstore_db;

-- 1. Basic table validation queries
-- Count records in all tables to verify data load
SELECT 'book' AS table_name, COUNT(*) AS record_count FROM book
UNION ALL
SELECT 'author', COUNT(*) FROM author
UNION ALL
SELECT 'book_author', COUNT(*) FROM book_author
UNION ALL
SELECT 'publisher', COUNT(*) FROM publisher
UNION ALL
SELECT 'book_language', COUNT(*) FROM book_language
UNION ALL
SELECT 'customer', COUNT(*) FROM customer
UNION ALL
SELECT 'address', COUNT(*) FROM address
UNION ALL
SELECT 'customer_address', COUNT(*) FROM customer_address
UNION ALL
SELECT 'country', COUNT(*) FROM country
UNION ALL
SELECT 'cust_order', COUNT(*) FROM cust_order
UNION ALL
SELECT 'order_line', COUNT(*) FROM order_line
UNION ALL
SELECT 'order_history', COUNT(*) FROM order_history;

-- 2. Test book catalog functionality
-- Get all books with their authors
SELECT 
    b.book_id,
    b.title,
    b.isbn,
    GROUP_CONCAT(CONCAT(a.author_first_name, ' ', a.author_last_name) ORDER BY ba.author_order SEPARATOR ', ') AS authors,
    p.publisher_name,
    l.language_name,
    b.price,
    b.publication_date
FROM 
    book b
JOIN 
    book_author ba ON b.book_id = ba.book_id
JOIN 
    author a ON ba.author_id = a.author_id
LEFT JOIN 
    publisher p ON b.publisher_id = p.publisher_id
LEFT JOIN 
    book_language l ON b.language_id = l.language_id
GROUP BY 
    b.book_id
ORDER BY 
    b.title;

-- 3. Test customer management
-- Get customers with their default addresses
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    a.street_address,
    a.city,
    a.state_province,
    a.postal_code,
    co.country_name
FROM 
    customer c
JOIN 
    customer_address ca ON c.customer_id = ca.customer_id AND ca.is_default = TRUE
JOIN 
    address a ON ca.address_id = a.address_id
JOIN 
    country co ON a.country_id = co.country_id
ORDER BY 
    c.last_name, c.first_name;

-- 4. Test order processing functionality
-- Get order details with customer info and items
SELECT 
    o.order_id,
    o.order_date,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    os.status_name AS order_status,
    sm.method_name AS shipping_method,
    COUNT(ol.book_id) AS number_of_items,
    SUM(ol.quantity) AS total_quantity,
    o.order_total,
    o.shipping_cost,
    o.tax_amount,
    o.grand_total
FROM 
    cust_order o
JOIN 
    customer c ON o.customer_id = c.customer_id
JOIN 
    order_status os ON o.order_status_id = os.status_id
JOIN 
    shipping_method sm ON o.shipping_method_id = sm.method_id
JOIN 
    order_line ol ON o.order_id = ol.order_id
GROUP BY 
    o.order_id
ORDER BY 
    o.order_date DESC;

-- 5. Test order history tracking
-- Get complete history for a specific order
SELECT 
    o.order_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    oh.status_date,
    os.status_name,
    oh.comments,
    oh.created_by
FROM 
    cust_order o
JOIN 
    customer c ON o.customer_id = c.customer_id
JOIN 
    order_history oh ON o.order_id = oh.order_id
JOIN 
    order_status os ON oh.status_id = os.status_id
WHERE 
    o.order_id = 1  -- Test with order_id 1
ORDER BY 
    oh.status_date;

-- 6. Test foreign key constraints
-- This should fail due to foreign key constraint (intentional error for testing)
-- INSERT INTO book (title, isbn, isbn13, publisher_id, language_id, price, stock_quantity) 
-- VALUES ('Test Book', '1234567890', '9781234567890', 999, 999, 19.99, 10);

-- 7. Test complex joins and aggregations
-- Get detailed order line information with book and author details
SELECT 
    ol.order_id,
    b.title,
    GROUP_CONCAT(CONCAT(a.author_first_name, ' ', a.author_last_name) SEPARATOR ', ') AS authors,
    ol.quantity,
    ol.unit_price,
    ol.line_total
FROM 
    order_line ol
JOIN 
    book b ON ol.book_id = b.book_id
JOIN 
    book_author ba ON b.book_id = ba.book_id
JOIN 
    author a ON ba.author_id = a.author_id
GROUP BY 
    ol.order_id, ol.line_number
ORDER BY 
    ol.order_id, ol.line_number;

-- 8. Test full-text search
SELECT 
    book_id, title, description, price 
FROM 
    book
WHERE 
    MATCH(title, description) AGAINST('potter' IN NATURAL LANGUAGE MODE);