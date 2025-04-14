-- Create BookStore Database
CREATE DATABASE IF NOT EXISTS bookstore_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Use the BookStore Database
USE bookstore_db;

-- Basic settings
SET NAMES utf8mb4;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';