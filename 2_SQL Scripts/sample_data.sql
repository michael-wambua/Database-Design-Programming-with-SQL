-- Sample Data for BookStore Database
USE bookstore_db;

-- Insert book languages
INSERT INTO book_language (language_code, language_name) VALUES
('en', 'English'),
('es', 'Spanish'),
('fr', 'French'),
('de', 'German'),
('ja', 'Japanese'),
('zh', 'Chinese');

-- Insert publishers
INSERT INTO publisher (publisher_name, contact_email, website) VALUES
('Penguin Random House', 'contact@penguinrandomhouse.com', 'https://www.penguinrandomhouse.com'),
('HarperCollins', 'info@harpercollins.com', 'https://www.harpercollins.com'),
('Simon & Schuster', 'customer.service@simonandschuster.com', 'https://www.simonandschuster.com'),
('O\'Reilly Media', 'orders@oreilly.com', 'https://www.oreilly.com'),
('Packt Publishing', 'customercare@packtpub.com', 'https://www.packtpub.com');

-- Insert authors
INSERT INTO author (author_first_name, author_last_name, author_email, author_bio) VALUES
('J.K.', 'Rowling', 'jkrowling@example.com', 'British author best known for the Harry Potter series'),
('Stephen', 'King', 'sking@example.com', 'American author of horror, supernatural fiction, suspense, and fantasy novels'),
('Agatha', 'Christie', NULL, 'English writer known for her detective novels'),
('Charles', 'Dickens', NULL, '19th-century English writer and social critic'),
('Mark', 'Twain', NULL, 'American writer, humorist, entrepreneur, publisher, and lecturer'),
('Michelle', 'Obama', NULL, 'American attorney and author who was the First Lady of the United States'),
('George', 'Orwell', NULL, 'English novelist, essayist, journalist and critic'),
('Robert C.', 'Martin', 'uncle.bob@example.com', 'American software engineer and author'),
('Martin', 'Fowler', 'martin@example.com', 'British software developer, author, and speaker');

-- Insert books
INSERT INTO book (title, isbn, isbn13, description, publisher_id, language_id, price, publication_date, page_count, stock_quantity) VALUES
('Harry Potter and the Philosopher\'s Stone', '0747532699', '9780747532699', 'The first novel in the Harry Potter series', 1, 1, 19.99, '1997-06-26', 223, 50),
('The Shining', '0385121679', '9780385121675', 'Horror novel by Stephen King', 2, 1, 15.99, '1977-01-28', 447, 35),
('Murder on the Orient Express', '0062073494', '9780062073495', 'Detective novel featuring Hercule Poirot', 2, 1, 12.99, '1934-01-01', 256, 40),
('1984', '0451524934', '9780451524935', 'Dystopian social science fiction novel', 1, 1, 9.99, '1949-06-08', 328, 60),
('Clean Code', '0132350882', '9780132350884', 'A Handbook of Agile Software Craftsmanship', 4, 1, 39.99, '2008-08-01', 464, 25),
('Refactoring', '0134757599', '9780134757599', 'Improving the Design of Existing Code', 5, 1, 49.99, '2018-11-30', 455, 20),
('Becoming', '1524763136', '9781524763138', 'Memoir by Michelle Obama', 3, 1, 24.99, '2018-11-13', 448, 45);

-- Associate books with authors
INSERT INTO book_author (book_id, author_id, author_order) VALUES
(1, 1, 1), -- Harry Potter by J.K. Rowling
(2, 2, 1), -- The Shining by Stephen King
(3, 3, 1), -- Murder on the Orient Express by Agatha Christie
(4, 7, 1), -- 1984 by George Orwell
(5, 8, 1), -- Clean Code by Robert C. Martin
(6, 9, 1), -- Refactoring by Martin Fowler
(7, 6, 1); -- Becoming by Michelle Obama

-- Insert countries
INSERT INTO country (country_code, country_name) VALUES
('US', 'United States'),
('CA', 'Canada'),
('GB', 'United Kingdom'),
('FR', 'France'),
('DE', 'Germany'),
('JP', 'Japan');

-- Insert address statuses
INSERT INTO address_status (status_name, description) VALUES
('Current', 'Currently active address'),
('Previous', 'Previously used address'),
('Billing', 'Address used for billing only'),
('Shipping', 'Address used for shipping only');

-- Insert shipping methods
INSERT INTO shipping_method (method_name, cost, estimated_days) VALUES
('Standard', 5.99, 5),
('Express', 12.99, 2),
('Overnight', 19.99, 1),
('Free Economy', 0.00, 7);

-- Insert order statuses
INSERT INTO order_status (status_name, description) VALUES
('Pending', 'Order has been placed but not yet processed'),
('Processing', 'Order is being processed'),
('Shipped', 'Order has been shipped'),
('Delivered', 'Order has been delivered'),
('Cancelled', 'Order has been cancelled'),
('Refunded', 'Order has been refunded');

-- Insert customers
INSERT INTO customer (first_name, last_name, email, phone, password_hash, date_of_birth, is_active) VALUES
('sylvester', 'Michael', 'sylvester@gmail.com', '555-123-4567', '$2y$10$abcdefghijklmnopqrstuv', '1980-01-15', TRUE),
('mary', 'diana', 'diana@gmail.com', '555-987-6543', '$2y$10$abcdefghijklmnopqrstuv', '1985-05-20', TRUE),
('Teddy', 'owino', 'teddy@gmail.com', '555-555-5555', '$2y$10$abcdefghijklmnopqrstuv', '1990-10-10', TRUE),
('Bob', 'Brown', 'bobn@gmail.com', '555-111-2222', '$2y$10$abcdefghijklmnopqrstuv', '1975-12-25', TRUE),
('Sarah', 'Davis', 'sarahk@gmail.com', '555-333-4444', '$2y$10$abcdefghijklmnopqrstuv', '1988-07-07', TRUE);

-- Insert addresses
INSERT INTO address (street_address, city, state_province, postal_code, country_id) VALUES
('123 Main St', 'New York', 'NY', '10001', 1),
('456 Oak Ave', 'Los Angeles', 'CA', '90001', 1),
('789 Maple Rd', 'Toronto', 'ON', 'M5V 2H1', 2),
('10 Downing Street', 'London', NULL, 'SW1A 2AA', 3),
('1600 Pennsylvania Ave', 'Washington', 'DC', '20500', 1);

-- Associate customers with addresses
INSERT INTO customer_address (customer_id, address_id, status_id, is_default) VALUES
(1, 1, 1, TRUE),  -- John Doe's current default address
(2, 2, 1, TRUE),  -- Jane Smith's current default address
(3, 3, 1, TRUE),  -- Alice Johnson's current default address
(4, 4, 1, TRUE),  -- Bob Brown's current default address
(5, 5, 1, TRUE);  -- Sarah Davis's current default address

-- Insert sample orders
INSERT INTO cust_order (customer_id, shipping_address_id, billing_address_id, shipping_method_id, order_status_id, order_total, shipping_cost, tax_amount, grand_total, payment_method) VALUES
(1, 1, 1, 1, 3, 32.98, 5.99, 3.90, 42.87, 'Credit Card'),
(2, 2, 2, 2, 2, 24.99, 12.99, 3.80, 41.78, 'PayPal'),
(3, 3, 3, 4, 1, 19.99, 0.00, 2.60, 22.59, 'Credit Card'),
(1, 1, 1, 3, 4, 49.99, 19.99, 7.00, 76.98, 'Credit Card'),
(4, 4, 4, 1, 5, 15.99, 5.99, 2.20, 24.18, 'PayPal');

-- Insert order lines
INSERT INTO order_line (order_id, line_number, book_id, quantity, unit_price, line_total) VALUES
(1, 1, 1, 1, 19.99, 19.99),  -- Harry Potter
(1, 2, 3, 1, 12.99, 12.99),  -- Murder on the Orient Express
(2, 1, 7, 1, 24.99, 24.99),  -- Becoming
(3, 1, 1, 1, 19.99, 19.99),  -- Harry Potter
(4, 1, 6, 1, 49.99, 49.99),  -- Refactoring
(5, 1, 2, 1, 15.99, 15.99);  -- The Shining

-- Insert order history
INSERT INTO order_history (order_id, status_id, status_date, comments, created_by) VALUES
(1, 1, '2025-04-10 09:00:00', 'Order placed', 'system'),
(1, 2, '2025-04-10 14:30:00', 'Payment confirmed', 'system'),
(1, 3, '2025-04-11 10:15:00', 'Shipped via USPS', 'staff_user'),
(2, 1, '2025-04-12 11:20:00', 'Order placed', 'system'),
(2, 2, '2025-04-12 15:45:00', 'Processing started', 'staff_user'),
(3, 1, '2025-04-13 16:30:00', 'Order placed', 'system'),
(4, 1, '2025-04-09 13:20:00', 'Order placed', 'system'),
(4, 2, '2025-04-09 14:00:00', 'Payment confirmed', 'system'),
(4, 3, '2025-04-10 09:30:00', 'Shipped via FedEx', 'staff_user'),
(4, 4, '2025-04-12 11:45:00', 'Delivered', 'system'),
(5, 1, '2025-04-08 10:10:00', 'Order placed', 'system'),
(5, 5, '2025-04-08 16:20:00', 'Cancelled by customer', 'customer');