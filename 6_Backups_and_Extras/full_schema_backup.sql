-- BookStore Database Full Schema and Data Backup
-- Generated: 2025-04-14
-- MySQL Version: 8.0

-- Disable foreign key checks to avoid dependency issues during restoration
SET FOREIGN_KEY_CHECKS = 0;

-- Create the bookstore database if it doesn't exist
DROP DATABASE IF EXISTS bookstore;
CREATE DATABASE bookstore CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE bookstore;

-- -----------------------------------------------------
-- Table `book_language`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `book_language` (
  `language_id` INT NOT NULL AUTO_INCREMENT,
  `language_code` CHAR(2) NOT NULL,
  `language_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`language_id`),
  UNIQUE INDEX `language_code_UNIQUE` (`language_code`)
) ENGINE = InnoDB;

-- Sample data for book_language
INSERT INTO `book_language` (`language_code`, `language_name`) VALUES
('en', 'English'),
('es', 'Spanish'),
('fr', 'French'),
('de', 'German'),
('zh', 'Chinese'),
('ja', 'Japanese'),
('ko', 'Korean'),
('ru', 'Russian'),
('it', 'Italian'),
('pt', 'Portuguese');

-- -----------------------------------------------------
-- Table `publisher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `publisher` (
  `publisher_id` INT NOT NULL AUTO_INCREMENT,
  `publisher_name` VARCHAR(100) NOT NULL,
  `publisher_email` VARCHAR(100),
  `publisher_phone` VARCHAR(20),
  `publisher_website` VARCHAR(255),
  `date_added` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`publisher_id`),
  UNIQUE INDEX `publisher_name_UNIQUE` (`publisher_name`)
) ENGINE = InnoDB;

-- Sample data for publisher
INSERT INTO `publisher` (`publisher_name`, `publisher_email`, `publisher_phone`, `publisher_website`) VALUES
('Penguin Random House', 'info@penguinrandomhouse.com', '212-782-9000', 'www.penguinrandomhouse.com'),
('HarperCollins', 'info@harpercollins.com', '212-207-7000', 'www.harpercollins.com'),
('Simon & Schuster', 'customer.service@simonandschuster.com', '800-223-2336', 'www.simonandschuster.com'),
('Macmillan Publishers', 'feedback@macmillan.com', '646-307-5151', 'www.macmillan.com'),
('Hachette Book Group', 'customerservice@hbgusa.com', '800-759-0190', 'www.hachettebookgroup.com'),
('Scholastic', 'customer_service@scholastic.com', '800-724-6527', 'www.scholastic.com'),
('Oxford University Press', 'customer.service@oup.com', '800-445-9714', 'www.oup.com'),
('Wiley', 'info@wiley.com', '877-762-2974', 'www.wiley.com'),
('O\'Reilly Media', 'orders@oreilly.com', '800-998-9938', 'www.oreilly.com'),
('Pearson', 'customerservice@pearson.com', '800-848-9500', 'www.pearson.com');

-- -----------------------------------------------------
-- Table `author`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `author` (
  `author_id` INT NOT NULL AUTO_INCREMENT,
  `author_first_name` VARCHAR(50) NOT NULL,
  `author_last_name` VARCHAR(50) NOT NULL,
  `author_bio` TEXT,
  `date_added` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`author_id`),
  INDEX `idx_author_last_name` (`author_last_name`)
) ENGINE = InnoDB;

-- Sample data for author
INSERT INTO `author` (`author_first_name`, `author_last_name`, `author_bio`) VALUES
('J.K.', 'Rowling', 'British author best known for writing the Harry Potter fantasy series.'),
('Stephen', 'King', 'American author of horror, supernatural fiction, suspense, crime, science-fiction, and fantasy novels.'),
('Agatha', 'Christie', 'English writer known for her 66 detective novels and 14 short story collections.'),
('George', 'Orwell', 'English novelist, essayist, journalist and critic, best known for Animal Farm and 1984.'),
('Jane', 'Austen', 'English novelist known primarily for her six major novels which interpret, critique and comment upon the British landed gentry.'),
('Ernest', 'Hemingway', 'American novelist, short-story writer, journalist, and sportsman.'),
('Toni', 'Morrison', 'American novelist, essayist, book editor, and college professor.'),
('Gabriel', 'García Márquez', 'Colombian novelist, short-story writer, screenwriter, and journalist.'),
('Haruki', 'Murakami', 'Japanese writer whose books and stories have been bestsellers in Japan and internationally.'),
('Margaret', 'Atwood', 'Canadian poet, novelist, literary critic, essayist, and environmental activist.');

-- -----------------------------------------------------
-- Table `book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `book` (
  `book_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `isbn13` CHAR(13) NOT NULL,
  `language_id` INT NOT NULL,
  `num_pages` INT,
  `publication_date` DATE NOT NULL,
  `publisher_id` INT NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `stock_quantity` INT NOT NULL DEFAULT 0,
  `description` TEXT,
  `date_added` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`book_id`),
  UNIQUE INDEX `isbn13_UNIQUE` (`isbn13`),
  INDEX `fk_book_book_language_idx` (`language_id`),
  INDEX `fk_book_publisher_idx` (`publisher_id`),
  INDEX `idx_book_title` (`title`),
  CONSTRAINT `fk_book_book_language`
    FOREIGN KEY (`language_id`)
    REFERENCES `book_language` (`language_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_book_publisher`
    FOREIGN KEY (`publisher_id`)
    REFERENCES `publisher` (`publisher_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Sample data for book
INSERT INTO `book` (`title`, `isbn13`, `language_id`, `num_pages`, `publication_date`, `publisher_id`, `price`, `stock_quantity`, `description`) VALUES
('To Kill a Mockingbird', '9780061120084', 1, 336, '1960-07-11', 2, 14.99, 120, 'The unforgettable novel of a childhood in a sleepy Southern town and the crisis of conscience that rocked it.'),
('1984', '9780451524935', 1, 328, '1949-06-08', 1, 12.99, 85, 'A dystopian novel set in a totalitarian society ruled by the Party, who employ the Thought Police to persecute individuality and independent thinking.'),
('Pride and Prejudice', '9780141439518', 1, 432, '1813-01-28', 1, 9.99, 73, 'A romantic novel about the Bennet family, focusing on the main character Elizabeth Bennet.'),
('The Great Gatsby', '9780743273565', 1, 180, '1925-04-10', 3, 11.99, 96, 'A novel that follows a cast of characters living in the fictional town of West Egg on prosperous Long Island in the summer of 1922.'),
('The Hobbit', '9780547928227', 1, 366, '1937-09-21', 4, 13.99, 110, 'A fantasy novel about the journey of Bilbo Baggins who sets out to win a share of the treasure guarded by Smaug the dragon.'),
('One Hundred Years of Solitude', '9780060883287', 1, 417, '1967-05-30', 2, 15.99, 42, 'A landmark of magical realism and one of the most significant works in the history of literature.'),
('The Alchemist', '9780062315007', 1, 208, '1988-06-01', 2, 10.99, 126, 'A fable about following your dreams and listening to your heart.'),
('The Da Vinci Code', '9780307474278', 1, 597, '2003-03-18', 1, 9.99, 82, 'A mystery thriller novel that follows symbologist Robert Langdon and cryptologist Sophie Neveu.'),
('The Hunger Games', '9780439023528', 1, 374, '2008-09-14', 6, 12.99, 101, 'A dystopian novel set in Panem, a North American country consisting of the wealthy Capitol and 12 districts in varying states of poverty.'),
('Harry Potter and the Sorcerer\'s Stone', '9780590353427', 1, 309, '1997-06-26', 6, 24.99, 158, 'The first book in the Harry Potter series, featuring a young wizard\'s adventures at Hogwarts School of Witchcraft and Wizardry.');

-- -----------------------------------------------------
-- Table `book_author`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `book_author` (
  `book_id` INT NOT NULL,
  `author_id` INT NOT NULL,
  `author_order` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`book_id`, `author_id`),
  INDEX `fk_book_author_author_idx` (`author_id`),
  CONSTRAINT `fk_book_author_book`
    FOREIGN KEY (`book_id`)
    REFERENCES `book` (`book_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_book_author_author`
    FOREIGN KEY (`author_id`)
    REFERENCES `author` (`author_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Sample data for book_author
INSERT INTO `book_author` (`book_id`, `author_id`, `author_order`) VALUES
(1, 2, 1),
(2, 4, 1),
(3, 5, 1),
(4, 6, 1),
(5, 1, 1),
(6, 8, 1),
(7, 3, 1),
(8, 2, 1),
(9, 10, 1),
(10, 1, 1);

-- -----------------------------------------------------
-- Table `country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `country` (
  `country_id` INT NOT NULL AUTO_INCREMENT,
  `country_code` CHAR(2) NOT NULL,
  `country_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`country_id`),
  UNIQUE INDEX `country_code_UNIQUE` (`country_code`)
) ENGINE = InnoDB;

-- Sample data for country
INSERT INTO `country` (`country_code`, `country_name`) VALUES
('US', 'United States'),
('CA', 'Canada'),
('GB', 'United Kingdom'),
('AU', 'Australia'),
('DE', 'Germany'),
('FR', 'France'),
('ES', 'Spain'),
('IT', 'Italy'),
('JP', 'Japan'),
('CN', 'China');

-- -----------------------------------------------------
-- Table `address_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `address_status` (
  `address_status_id` INT NOT NULL AUTO_INCREMENT,
  `address_status_name` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`address_status_id`),
  UNIQUE INDEX `address_status_name_UNIQUE` (`address_status_name`)
) ENGINE = InnoDB;

-- Sample data for address_status
INSERT INTO `address_status` (`address_status_name`) VALUES
('Active'),
('Inactive'),
('Billing'),
('Shipping'),
('Both'),
('Former');

-- -----------------------------------------------------
-- Table `address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `address` (
  `address_id` INT NOT NULL AUTO_INCREMENT,
  `street_number` VARCHAR(10),
  `street_name` VARCHAR(100) NOT NULL,
  `city` VARCHAR(50) NOT NULL,
  `state_province` VARCHAR(50),
  `postal_code` VARCHAR(20) NOT NULL,
  `country_id` INT NOT NULL,
  `other_address_details` VARCHAR(255),
  PRIMARY KEY (`address_id`),
  INDEX `fk_address_country_idx` (`country_id`),
  CONSTRAINT `fk_address_country`
    FOREIGN KEY (`country_id`)
    REFERENCES `country` (`country_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Sample data for address
INSERT INTO `address` (`street_number`, `street_name`, `city`, `state_province`, `postal_code`, `country_id`, `other_address_details`) VALUES
('123', 'Main St', 'New York', 'NY', '10001', 1, 'Apt 4B'),
('456', 'Elm St', 'Los Angeles', 'CA', '90001', 1, NULL),
('789', 'Oak Dr', 'Chicago', 'IL', '60601', 1, 'Suite 302'),
('101', 'Maple Ave', 'Toronto', 'ON', 'M5V 2L7', 2, NULL),
('202', 'King St', 'London', NULL, 'EC1A 1BB', 3, 'Floor 5'),
('303', 'Queen Rd', 'Sydney', 'NSW', '2000', 4, NULL),
('404', 'Berlin Blvd', 'Berlin', NULL, '10115', 5, 'Unit 7'),
('505', 'Paris Ln', 'Paris', NULL, '75001', 6, NULL),
('606', 'Madrid Way', 'Madrid', NULL, '28001', 7, 'Building C'),
('707', 'Roma St', 'Rome', NULL, '00100', 8, NULL);

-- -----------------------------------------------------
-- Table `customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `customer` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(20),
  `date_of_birth` DATE,
  `date_joined` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`customer_id`),
  UNIQUE INDEX `email_UNIQUE` (`email`),
  INDEX `idx_customer_last_name` (`last_name`)
) ENGINE = InnoDB;

-- Sample data for customer
INSERT INTO `customer` (`first_name`, `last_name`, `email`, `phone`, `date_of_birth`) VALUES
('John', 'Smith', 'john.smith@example.com', '212-555-1234', '1985-06-15'),
('Mary', 'Johnson', 'mary.johnson@example.com', '312-555-6789', '1992-02-21'),
('Robert', 'Williams', 'robert.williams@example.com', '415-555-9876', '1978-11-30'),
('Patricia', 'Jones', 'patricia.jones@example.com', '713-555-4321', '1989-07-04'),
('Michael', 'Brown', 'michael.brown@example.com', '305-555-8765', '1995-03-12'),
('Jennifer', 'Davis', 'jennifer.davis@example.com', '617-555-2345', '1982-09-28'),
('David', 'Miller', 'david.miller@example.com', '702-555-7890', '1971-04-17'),
('Linda', 'Wilson', 'linda.wilson@example.com', '206-555-3456', '1990-12-05'),
('James', 'Taylor', 'james.taylor@example.com', '404-555-6543', '1987-08-23'),
('Elizabeth', 'Anderson', 'elizabeth.anderson@example.com', '503-555-7654', '1993-05-19');

-- -----------------------------------------------------
-- Table `customer_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `customer_address` (
  `customer_id` INT NOT NULL,
  `address_id` INT NOT NULL,
  `address_status_id` INT NOT NULL,
  `date_from` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_to` TIMESTAMP NULL,
  PRIMARY KEY (`customer_id`, `address_id`),
  INDEX `fk_customer_address_address_idx` (`address_id`),
  INDEX `fk_customer_address_address_status_idx` (`address_status_id`),
  CONSTRAINT `fk_customer_address_customer`
    FOREIGN KEY (`customer_id`)
    REFERENCES `customer` (`customer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_customer_address_address`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`address_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_customer_address_address_status`
    FOREIGN KEY (`address_status_id`)
    REFERENCES `address_status` (`address_status_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Sample data for customer_address
INSERT INTO `customer_address` (`customer_id`, `address_id`, `address_status_id`, `date_from`) VALUES
(1, 1, 5, '2020-01-15 00:00:00'),
(2, 2, 5, '2020-02-20 00:00:00'),
(3, 3, 5, '2020-03-25 00:00:00'),
(4, 4, 5, '2020-04-10 00:00:00'),
(5, 5, 5, '2020-05-05 00:00:00'),
(6, 6, 5, '2020-06-30 00:00:00'),
(7, 7, 5, '2020-07-22 00:00:00'),
(8, 8, 5, '2020-08-18 00:00:00'),
(9, 9, 5, '2020-09-12 00:00:00'),
(10, 10, 5, '2020-10-07 00:00:00');

-- -----------------------------------------------------
-- Table `shipping_method`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shipping_method` (
  `shipping_method_id` INT NOT NULL AUTO_INCREMENT,
  `method_name` VARCHAR(50) NOT NULL,
  `cost` DECIMAL(10,2) NOT NULL,
  `estimated_days` INT NOT NULL,
  PRIMARY KEY (`shipping_method_id`),
  UNIQUE INDEX `method_name_UNIQUE` (`method_name`)
) ENGINE = InnoDB;

-- Sample data for shipping_method
INSERT INTO `shipping_method` (`method_name`, `cost`, `estimated_days`) VALUES
('Standard Shipping', 4.99, 5),
('Express Shipping', 9.99, 2),
('Next-Day Shipping', 19.99, 1),
('Economy Shipping', 2.99, 7),
('International Standard', 14.99, 10),
('International Express', 24.99, 5),
('Local Pickup', 0.00, 0),
('Media Mail', 2.99, 7),
('Priority Mail', 7.99, 3),
('Courier', 29.99, 1);

-- -----------------------------------------------------
-- Table `order_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `order_status` (
  `order_status_id` INT NOT NULL AUTO_INCREMENT,
  `status_name` VARCHAR(50) NOT NULL,
  `status_description` TEXT,
  PRIMARY KEY (`order_status_id`),
  UNIQUE INDEX `status_name_UNIQUE` (`status_name`)
) ENGINE = InnoDB;

-- Sample data for order_status
INSERT INTO `order_status` (`status_name`, `status_description`) VALUES
('Pending', 'Order has been placed but not yet processed'),
('Processing', 'Order is being processed'),
('Shipped', 'Order has been shipped'),
('Delivered', 'Order has been delivered'),
('Cancelled', 'Order has been cancelled'),
('Returned', 'Order has been returned'),
('On Hold', 'Order is on hold pending further action'),
('Backordered', 'One or more items in the order are currently out of stock'),
('Refunded', 'Order has been refunded'),
('Partially Shipped', 'Some items have shipped, others are still being processed');

-- -----------------------------------------------------
-- Table `cust_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cust_order` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `order_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `shipping_address_id` INT NOT NULL,
  `shipping_method_id` INT NOT NULL,
  `order_status_id` INT NOT NULL DEFAULT 1,
  `order_total` DECIMAL(10,2) NOT NULL,
  `tracking_number` VARCHAR(50),
  PRIMARY KEY (`order_id`),
  INDEX `fk_cust_order_customer_idx` (`customer_id`),
  INDEX `fk_cust_order_address_idx` (`shipping_address_id`),
  INDEX `fk_cust_order_shipping_method_idx` (`shipping_method_id`),
  INDEX `fk_cust_order_order_status_idx` (`order_status_id`),
  CONSTRAINT `fk_cust_order_customer`
    FOREIGN KEY (`customer_id`)
    REFERENCES `customer` (`customer_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_cust_order_address`
    FOREIGN KEY (`shipping_address_id`)
    REFERENCES `address` (`address_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_cust_order_shipping_method`
    FOREIGN KEY (`shipping_method_id`)
    REFERENCES `shipping_method` (`shipping_method_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_cust_order_order_status`
    FOREIGN KEY (`order_status_id`)
    REFERENCES `order_status` (`order_status_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Sample data for cust_order
INSERT INTO `cust_order` (`customer_id`, `order_date`, `shipping_address_id`, `shipping_method_id`, `order_status_id`, `order_total`, `tracking_number`) VALUES
(1, '2023-01-05 12:30:00', 1, 1, 4, 29.98, 'TRK12345678'),
(2, '2023-01-10 14:45:00', 2, 2, 3, 52.97, 'TRK23456789'),
(3, '2023-01-15 09:20:00', 3, 1, 4, 14.99, 'TRK34567890'),
(4, '2023-01-20 16:15:00', 4, 3, 3, 44.98, 'TRK45678901'),
(5, '2023-01-25 11:30:00', 5, 2, 4, 25.98, 'TRK56789012'),
(6, '2023-01-30 13:45:00', 6, 1, 3, 15.99, 'TRK67890123'),
(7, '2023-02-05 10:10:00', 7, 2, 2, 22.98, NULL),
(8, '2023-02-10 15:25:00', 8, 1, 1, 9.99, NULL),
(9, '2023-02-15 08:50:00', 9, 3, 5, 37.98, NULL),
(10, '2023-02-20 17:40:00', 10, 1, 1, 14.99, NULL);

-- -----------------------------------------------------
-- Table `order_line`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `order_line` (
  `order_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  `quantity` INT NOT NULL DEFAULT 1,
  `price_at_time` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`order_id`, `book_id`),
  INDEX `fk_order_line_book_idx` (`book_id`),
  CONSTRAINT `fk_order_line_cust_order`
    FOREIGN KEY (`order_id`)
    REFERENCES `cust_order` (`order_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_line_book`
    FOREIGN KEY (`book_id`)
    REFERENCES `book` (`book_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Sample data for order_line
INSERT INTO `order_line` (`order_id`, `book_id`, `quantity`, `price_at_time`) VALUES
(1, 1, 2, 14.99),
(2, 3, 1, 9.99),
(2, 5, 2, 13.99),
(2, 8, 1, 9.99),
(3, 6, 1, 14.99),
(4, 10, 1, 24.99),
(4, 4, 1, 19.99),
(5, 2, 2, 12.99),
(6, 7, 1, 15.99),
(7, 9, 1, 12.99),
(7, 1, 1, 9.99),
(8, 3, 1, 9.99),
(9, 4, 1, 11.99),
(9, 5, 1, 13.99),
(9, 2, 1, 11.99),
(10, 1, 1, 14.99);

-- -----------------------------------------------------
-- Table `order_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `order_history` (
  `history_id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `order_status_id` INT NOT NULL,
  `status_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `comments` TEXT,
  PRIMARY KEY (`history_id`),
  INDEX `fk_order_history_cust_order_idx` (`order_id`),
  INDEX `fk_order_history_order_status_idx` (`order_status_id`),
  CONSTRAINT `fk_order_history_cust_order`
    FOREIGN KEY (`order_id`)
    REFERENCES `cust_order` (`order_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_history_order_status`
    FOREIGN KEY (`order_status_id`)
    REFERENCES `order_status` (`order_status_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Sample data for order_history
INSERT INTO `order_history` (`order_id`, `order_status_id`, `status_date`, `comments`) VALUES
(1, 1, '2023-01-05 12:30:00', 'Order placed online'),
(1, 2, '2023-01-06 09:15:00', 'Payment confirmed'),
(1, 3, '2023-01-07 11:20:00', 'Order shipped via Standard Shipping'),
(1, 4, '2023-01-12 14:45:00', 'Order delivered'),
(2, 1, '2023-01-10 14:45:00', 'Order placed online'),
(2, 2, '2023-01-11 10:30:00', 'Payment confirmed'),
(2, 3, '2023-01-12 13:10:00', 'Order shipped via Express Shipping'),
(3, 1, '2023-01-15 09:20:00', 'Order placed online'),
(3, 2, '2023-01-16 11:05:00', 'Payment confirmed'),
(3, 3, '2023-01-17 14:25:00', 'Order shipped via Standard Shipping'),
(3, 4, '2023-01-22 09:50:00', 'Order delivered'),
(4, 1, '2023-01-20 16:15:00', 'Order placed online'),
(4, 2, '2023-01-21 10:40:00', 'Payment confirmed'),
(4, 3, '2023-01-21 15:55:00', 'Order shipped via Next-Day Shipping'),
(5, 1, '2023-01-25 11:30:00', 'Order placed online'),
(5, 2, '2023-01-26 09:20:00', 'Payment confirmed'),
(5, 3, '2023-01-27 13:40:00', 'Order shipped via Express Shipping'),
(5, 4, '2023-01-29 10:15:00', 'Order delivered'),
(6, 1, '2023-01-30 13:45:00', 'Order placed online'),
(6, 2, '2023-01-31 11:30:00', 'Payment confirmed'),
(6, 3, '2023-02-01 14:20:00', 'Order shipped via Standard Shipping'),
(7, 1, '2023-02-05 10:10:00', 'Order placed online'),
(7, 2, '2023-02-06 09:45:00', 'Payment confirmed, processing order'),
(8, 1, '2023-02-10 15:25:00', 'Order placed online, awaiting payment confirmation'),
(9, 1, '2023-02-15 08:50:00', 'Order placed online'),
(9, 2, '2023-02-16 10:30:00', 'Payment confirmed'),
(9, 5, '2023-02-17 14:15:00', 'Order cancelled at customer request'),
(10, 1, '2023-02-20 17:40:00', 'Order placed online, awaiting payment confirmation');

-- -----------------------------------------------------
-- Create users and roles
-- -----------------------------------------------------

-- Drop existing users if they exist
DROP USER IF EXISTS 'bookstore_admin'@'localhost';
DROP USER IF EXISTS 'bookstore_manager'@'localhost';
DROP USER IF EXISTS 'bookstore_staff'@'localhost';
DROP USER IF EXISTS 'bookstore_readonly'@'localhost';

-- Create users with secure passwords
CREATE USER 'bookstore_admin'@'localhost' IDENTIFIED BY 'admin_secure_password123';
CREATE USER 'bookstore_manager'@'localhost' IDENTIFIED BY 'manager_secure_password123';
CREATE USER 'bookstore_staff'@'localhost' IDENTIFIED BY 'staff_secure_password123';
CREATE USER 'bookstore_readonly'@'localhost' IDENTIFIED BY 'readonly_secure_password123';

-- Grant appropriate privileges
-- Admin (Full access)
GRANT ALL PRIVILEGES ON bookstore.* TO 'bookstore_admin'@'localhost';

-- Manager (Can modify data but not structure)
GRANT SELECT, INSERT, UPDATE, DELETE ON bookstore.* TO 'bookstore_manager'@'localhost';

-- Staff (Limited data modification)
GRANT SELECT ON bookstore.* TO 'bookstore_staff'@'localhost';
GRANT INSERT, UPDATE ON bookstore.book TO 'bookstore_staff'@'localhost';
GRANT INSERT, UPDATE ON bookstore.book_author TO 'bookstore_staff'@'localhost';
GRANT INSERT, UPDATE ON bookstore.cust_order TO 'bookstore_staff'@'localhost';
GRANT INSERT, UPDATE ON bookstore.order_line TO 'bookstore_staff'@'localhost';
GRANT INSERT, UPDATE ON bookstore.order_history TO 'bookstore_staff'@'localhost';
GRANT UPDATE ON bookstore.cust_order TO 'bookstore_staff'@'localhost';

-- Read-only user
GRANT SELECT ON bookstore.* TO 'bookstore_readonly'@'localhost';

-- Apply changes
FLUSH PRIVILEGES;

-- -----------------------------------------------------
-- Views for common queries
-- -----------------------------------------------------

-- View for book details with author and publisher
CREATE OR REPLACE VIEW v_book_details AS
SELECT 
    b.book_id,
    b.title,
    b.isbn13,
    GROUP_CONCAT(CONCAT(a.author_first_name, ' ', a.author_last_name) ORDER BY ba.author_order SEPARATOR ', ') AS authors,
    p.publisher_name,
    l.language_name,
    b.publication_date,
    b.num_pages,
    b.price,
    b.stock_quantity
FROM 
    book b
    JOIN book_author ba ON b.book_id = ba.book_id
    JOIN author a ON ba.author_id = a.author_id
    JOIN publisher p ON b.publisher_id = p.publisher_id
    JOIN book_language l ON b.language_id = l.language_id
GROUP BY 
    b.book_id;

-- View for customer orders with details
CREATE OR REPLACE VIEW v_customer_orders AS
SELECT 
    co.order_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email AS customer_email,
    co.order_date,
    os.status_name AS order_status,
    COUNT(ol.book_id) AS number_of_items,
    co.order_total,
    sm.method_name AS shipping_method,
    co.tracking_number,
    CONCAT(a.street_number, ' ', a.street_name, ', ', a.city, ', ', a.state_province, ' ', a.postal_code) AS shipping_address
FROM 
    cust_order co
    JOIN customer c ON co.customer_id = c.customer_id
    JOIN order_status os ON co.order_status_id = os.order_status_id
    JOIN shipping_method sm ON co.shipping_method_id = sm.shipping_method_id
    JOIN address a ON co.shipping_address_id = a.address_id
    JOIN order_line ol ON co.order_id = ol.order_id
GROUP BY 
    co.order_id;

-- View for bestselling books
CREATE OR REPLACE VIEW v_bestselling_books AS
SELECT 
    b.book_id,
    b.title,
    GROUP_CONCAT(CONCAT(a.author_first_name, ' ', a.author_last_name) ORDER BY ba.author_order SEPARATOR ', ') AS authors,
    SUM(ol.quantity) AS total_sold,
    b.price,
    (b.price * SUM(ol.quantity)) AS total_revenue
FROM 
    book b
    JOIN book_author ba ON b.book_id = ba.book_id
    JOIN author a ON ba.author_id = a.author_id
    JOIN order_line ol ON b.book_id = ol.book_id
    JOIN cust_order co ON ol.order_id = co.order_id
WHERE 
    co.order_status_id NOT IN (5, 6, 9) -- Excluding cancelled, returned, and refunded orders
GROUP BY 
    b.book_id
ORDER BY 
    total_sold DESC;

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;