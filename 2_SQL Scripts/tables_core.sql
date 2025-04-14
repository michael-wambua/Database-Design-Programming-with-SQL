-- Core Tables: Book, Author, Publisher, Book_Language, Book_Author
USE bookstore_db;

-- Create book_language table
CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_code CHAR(2) NOT NULL UNIQUE COMMENT 'ISO 639-1 language code',
    language_name VARCHAR(50) NOT NULL UNIQUE,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Languages that books can be written in';

-- Create publisher table
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    publisher_name VARCHAR(255) NOT NULL UNIQUE,
    contact_email VARCHAR(100),
    contact_phone VARCHAR(20),
    website VARCHAR(255),
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Book publishers';

-- Create author table
CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_first_name VARCHAR(50) NOT NULL,
    author_last_name VARCHAR(50) NOT NULL,
    author_email VARCHAR(100) UNIQUE,
    author_bio TEXT,
    birth_date DATE,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX author_name_idx (author_last_name, author_first_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Book authors';

-- Create book table
CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    isbn13 VARCHAR(20) UNIQUE,
    description TEXT,
    publisher_id INT,
    language_id INT,
    price DECIMAL(10, 2) NOT NULL,
    publication_date DATE,
    page_count INT,
    cover_image_url VARCHAR(255),
    stock_quantity INT NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id) ON DELETE SET NULL,
    FOREIGN KEY (language_id) REFERENCES book_language(language_id) ON DELETE SET NULL,
    INDEX book_title_idx (title),
    INDEX book_isbn_idx (isbn),
    INDEX book_isbn13_idx (isbn13)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Books available in the bookstore';

-- Create book_author junction table
CREATE TABLE book_author (
    book_id INT NOT NULL,
    author_id INT NOT NULL,
    author_order TINYINT NOT NULL DEFAULT 1 COMMENT 'Order of authors for the book',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES author(author_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Junction table for books and authors';