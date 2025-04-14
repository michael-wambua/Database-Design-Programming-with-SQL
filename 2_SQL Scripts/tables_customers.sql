-- Customer Tables: Customer, Address, Customer_Address, Country, Address_Status
USE bookstore_db;

-- Create country table
CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_code CHAR(2) NOT NULL UNIQUE COMMENT 'ISO 3166-1 alpha-2 country code',
    country_name VARCHAR(100) NOT NULL UNIQUE,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Countries for addresses';

-- Create address_status table
CREATE TABLE address_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(30) NOT NULL UNIQUE,
    description VARCHAR(255),
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Address statuses (current, old, etc.)';

-- Create address table
CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street_address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state_province VARCHAR(100),
    postal_code VARCHAR(20) NOT NULL,
    country_id INT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (country_id) REFERENCES country(country_id) ON DELETE RESTRICT,
    INDEX address_postal_idx (postal_code),
    INDEX address_city_idx (city)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Physical addresses';

-- Create customer table
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    password_hash VARCHAR(255) NOT NULL COMMENT 'Hashed password',
    date_of_birth DATE,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_login DATETIME,
    INDEX customer_name_idx (last_name, first_name),
    INDEX customer_email_idx (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Bookstore customers';

-- Create customer_address junction table
CREATE TABLE customer_address (
    customer_id INT NOT NULL,
    address_id INT NOT NULL,
    status_id INT NOT NULL,
    is_default BOOLEAN NOT NULL DEFAULT FALSE,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (address_id) REFERENCES address(address_id) ON DELETE CASCADE,
    FOREIGN KEY (status_id) REFERENCES address_status(status_id) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Junction table for customers and addresses';