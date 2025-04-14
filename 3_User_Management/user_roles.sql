-- User Management and Roles
USE bookstore_db;

-- Create user roles
-- Note: Replace 'password' with secure passwords in a production environment

-- Create admin user with all privileges
CREATE USER 'bookstore_admin'@'localhost' IDENTIFIED BY 'admin_password';
GRANT ALL PRIVILEGES ON bookstore_db.* TO 'bookstore_admin'@'localhost';

-- Create staff user with limited privileges
CREATE USER 'bookstore_staff'@'localhost' IDENTIFIED BY 'staff_password';
GRANT SELECT, INSERT, UPDATE ON bookstore_db.* TO 'bookstore_staff'@'localhost';
REVOKE UPDATE ON bookstore_db.customer FROM 'bookstore_staff'@'localhost';
REVOKE UPDATE ON bookstore_db.cust_order FROM 'bookstore_staff'@'localhost';

-- Create read-only user for reporting
CREATE USER 'bookstore_report'@'localhost' IDENTIFIED BY 'report_password';
GRANT SELECT ON bookstore_db.* TO 'bookstore_report'@'localhost';

-- Create API user with specific permissions
CREATE USER 'bookstore_api'@'%' IDENTIFIED BY 'api_password';

-- API user can perform read operations on all tables
GRANT SELECT ON bookstore_db.* TO 'bookstore_api'@'%';

-- API user can update/insert into specific tables needed for order processing
GRANT INSERT, UPDATE ON bookstore_db.cust_order TO 'bookstore_api'@'%';
GRANT INSERT, UPDATE ON bookstore_db.order_line TO 'bookstore_api'@'%';
GRANT INSERT ON bookstore_db.order_history TO 'bookstore_api'@'%';
GRANT INSERT, UPDATE ON bookstore_db.customer TO 'bookstore_api'@'%';
GRANT INSERT, UPDATE ON bookstore_db.address TO 'bookstore_api'@'%';
GRANT INSERT, UPDATE ON bookstore_db.customer_address TO 'bookstore_api'@'%';

-- Create inventory manager user
CREATE USER 'bookstore_inventory'@'localhost' IDENTIFIED BY 'inventory_password';
GRANT SELECT ON bookstore_db.* TO 'bookstore_inventory'@'localhost';
GRANT INSERT, UPDATE ON bookstore_db.book TO 'bookstore_inventory'@'localhost';
GRANT INSERT, UPDATE ON bookstore_db.author TO 'bookstore_inventory'@'localhost';
GRANT INSERT, UPDATE ON bookstore_db.publisher TO 'bookstore_inventory'@'localhost';
GRANT INSERT, UPDATE ON bookstore_db.book_author TO 'bookstore_inventory'@'localhost';

-- Apply changes
FLUSH PRIVILEGES;