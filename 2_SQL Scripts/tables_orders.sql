-- Order Tables: Cust_Order, Order_Line, Shipping_Method, Order_Status, Order_History
USE bookstore_db;

-- Create shipping_method table
CREATE TABLE shipping_method (
    method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(50) NOT NULL UNIQUE,
    cost DECIMAL(10, 2) NOT NULL,
    estimated_days TINYINT NOT NULL COMMENT 'Estimated delivery time in days',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Available shipping methods';

-- Create order_status table
CREATE TABLE order_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255),
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Possible statuses for orders';

-- Create cust_order table (named cust_order to avoid conflict with ORDER keyword)
CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    shipping_address_id INT NOT NULL,
    billing_address_id INT NOT NULL,
    shipping_method_id INT NOT NULL,
    order_status_id INT NOT NULL,
    order_total DECIMAL(10, 2) NOT NULL,
    shipping_cost DECIMAL(10, 2) NOT NULL,
    tax_amount DECIMAL(10, 2) NOT NULL,
    grand_total DECIMAL(10, 2) NOT NULL COMMENT 'order_total + shipping_cost + tax_amount',
    payment_method VARCHAR(50) NOT NULL,
    tracking_number VARCHAR(100),
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE RESTRICT,
    FOREIGN KEY (shipping_address_id) REFERENCES address(address_id) ON DELETE RESTRICT,
    FOREIGN KEY (billing_address_id) REFERENCES address(address_id) ON DELETE RESTRICT,
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(method_id) ON DELETE RESTRICT,
    FOREIGN KEY (order_status_id) REFERENCES order_status(status_id) ON DELETE RESTRICT,
    INDEX order_date_idx (order_date),
    INDEX order_customer_idx (customer_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Customer orders';

-- Create order_line table
CREATE TABLE order_line (
    order_id INT NOT NULL,
    line_number INT NOT NULL,
    book_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL COMMENT 'Price at the time of order',
    line_total DECIMAL(10, 2) NOT NULL COMMENT 'quantity * unit_price',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (order_id, line_number),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES book(book_id) ON DELETE RESTRICT,
    INDEX orderline_book_idx (book_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Individual line items in an order';

-- Create order_history table
CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    status_id INT NOT NULL,
    status_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    comments TEXT,
    created_by VARCHAR(50) NOT NULL COMMENT 'User or system that created this entry',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id) ON DELETE CASCADE,
    FOREIGN KEY (status_id) REFERENCES order_status(status_id) ON DELETE RESTRICT,
    INDEX order_history_order_idx (order_id),
    INDEX order_history_date_idx (status_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='History of status changes for orders';