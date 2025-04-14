-- Constraints and Indexes
USE bookstore_db;

-- Add CHECK constraints
ALTER TABLE book
ADD CONSTRAINT check_book_price CHECK (price >= 0),
ADD CONSTRAINT check_book_page_count CHECK (page_count > 0),
ADD CONSTRAINT check_book_stock CHECK (stock_quantity >= 0);

ALTER TABLE shipping_method
ADD CONSTRAINT check_shipping_cost CHECK (cost >= 0),
ADD CONSTRAINT check_shipping_days CHECK (estimated_days > 0);

ALTER TABLE order_line
ADD CONSTRAINT check_order_quantity CHECK (quantity > 0),
ADD CONSTRAINT check_unit_price CHECK (unit_price >= 0),
ADD CONSTRAINT check_line_total CHECK (line_total >= 0);

ALTER TABLE cust_order
ADD CONSTRAINT check_order_total CHECK (order_total >= 0),
ADD CONSTRAINT check_shipping_cost CHECK (shipping_cost >= 0),
ADD CONSTRAINT check_tax_amount CHECK (tax_amount >= 0),
ADD CONSTRAINT check_grand_total CHECK (grand_total >= 0);

-- Add additional indexes for performance
-- Books
CREATE INDEX idx_book_price ON book(price);
CREATE INDEX idx_book_publication_date ON book(publication_date);

-- Customers
CREATE INDEX idx_customer_is_active ON customer(is_active);
CREATE INDEX idx_customer_created_at ON customer(created_at);

-- Orders
CREATE INDEX idx_order_date_status ON cust_order(order_date, order_status_id);
CREATE INDEX idx_order_total ON cust_order(grand_total);

-- Order history
CREATE INDEX idx_order_history_status ON order_history(status_id);

-- Full-text search index for book titles and descriptions
ALTER TABLE book
ADD FULLTEXT INDEX ft_book_search (title, description);

-- Enable foreign key checks
SET foreign_key_checks = 1;