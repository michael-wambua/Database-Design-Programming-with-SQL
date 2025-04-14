# 📚 BookStore Database Project

## 📌 Overview
This project focuses on designing and implementing a **relational database** for managing bookstore operations. The database efficiently stores information about books, authors, customers, orders, and shipping, enabling seamless data retrieval and analysis.

## 🚀 Tools & Technologies
- **MySQL** – For database creation and management.
- **MySQL Workbench** – For designing queries and visualizing relationships.
- **Draw.io** – For database schema visualization.
- **GitHub** – For collaboration and version control.

## 🎯 Project Objectives
- Design a structured **MySQL database** to store bookstore data.
- Implement tables, relationships, and security roles.
- Optimize queries for efficient **data retrieval** and **analysis**.
- Enable **team collaboration** through GitHub.

## 📂 Database Schema (Tables)
The database consists of multiple interconnected tables:
- **book** – Stores book details (title, price, stock, etc.).
- **author** – Stores author details.
- **book_author** – Manages book-author relationships.
- **customer** – Stores customer information.
- **cust_order** – Stores customer orders.
- **order_line** – Tracks order details.
- **shipping_method** – Stores available shipping options.
- **order_status** – Tracks order progress (pending, shipped, etc.).
  
## 🔄 Workflow & Collaboration
1. **Branch Strategy** – Each member works on a separate Git branch.
2. **Pull Requests** – Changes are reviewed before merging into `main`.
3. **GitHub Issues** – Used for task tracking and discussion.
4. **Code Reviews** – Ensure consistency and quality.

## ✅ Getting Started
# How to Run Your Bookstore Database Project

Here's a step-by-step guide on how to implement and run your Bookstore SQL project based on the project structure:

## 1. Setting Up Your Environment

1. **Install MySQL**:
   - Download and install MySQL Community Server from the [official website](https://dev.mysql.com/downloads/mysql/)
   - Install MySQL Workbench for a graphical interface (optional but recommended)

2. **Install Draw.io** (for ERD creation):
   - Either use the web version at [app.diagrams.net](https://app.diagrams.net/) 
   - Or download the desktop application from [diagrams.net](https://www.diagrams.net/downloads)

## 2. Project Implementation Process

### Step 1: Database Design
1. Open Draw.io and create your ERD as per the earlier instructions
2. Save the file as `bookstore_schema.drawio` in the `1_Database_Design` folder
3. Export the diagram as PNG and save it as `bookstore_schema.png` in the same folder
4. Document your design decisions in `schema_notes.md`

### Step 2: Creating the Database

1. Open MySQL Workbench or your preferred MySQL client
2. Create and run the database creation script:
   ```sql
   -- Execute create_database.sql
   SOURCE /path/to/2_SQL_Scripts/create_database.sql;
   ```

3. Run the table creation scripts in this order:
   ```sql
   -- Core tables
   SOURCE /path/to/2_SQL_Scripts/tables_core.sql;
   
   -- Customer tables
   SOURCE /path/to/2_SQL_Scripts/tables_customers.sql;
   
   -- Order tables
   SOURCE /path/to/2_SQL_Scripts/tables_orders.sql;
   
   -- Constraints and indexes
   SOURCE /path/to/2_SQL_Scripts/constraints_indexes.sql;
   
   -- Sample data
   SOURCE /path/to/2_SQL_Scripts/sample_data.sql;
   ```

### Step 3: User Management

1. Set up user roles and permissions:
   ```sql
   SOURCE /path/to/3_User_Management/user_roles.sql;
   ```

2. Document the user access structure in `user_access_notes.md`

### Step 4: Testing and Validation

1. Run the test queries to verify database functionality:
   ```sql
   SOURCE /path/to/4_Testing_and_Queries/test_queries.sql;
   ```

2. Execute analytics queries to demonstrate database capabilities:
   ```sql
   SOURCE /path/to/4_Testing_and_Queries/analytics_queries.sql;
   ```

3. Document the query results in `query_results.md`

### Step 5: Documentation and Backup

1. Complete all documentation files in the `5_Documentation` folder
2. Create a full database backup:
   ```sql
   -- From MySQL command line
   mysqldump -u username -p bookstore > /path/to/6_Backups_and_Extras/full_schema_backup.sql
   ```

## 3. Running Sample Queries

After setting up, you can run these types of queries to test your database:

1. **Basic SELECT queries**:
   ```sql
   -- Get all books with their authors
   SELECT b.title, a.first_name, a.last_name
   FROM book b
   JOIN book_author ba ON b.book_id = ba.book_id
   JOIN author a ON ba.author_id = a.author_id
   ORDER BY b.title;
   ```

2. **Advanced analytics queries**:
   ```sql
   -- Find top selling books
   SELECT b.title, SUM(ol.quantity) as total_sold
   FROM book b
   JOIN order_line ol ON b.book_id = ol.book_id
   GROUP BY b.book_id, b.title
   ORDER BY total_sold DESC
   LIMIT 10;
   ```

## 4. Common Commands Reference

```sql
-- Create database
CREATE DATABASE bookstore;

-- Use the database
USE bookstore;

-- Show all tables
SHOW TABLES;

-- Describe table structure
DESCRIBE book;

-- Backup database
mysqldump -u username -p bookstore > backup.sql

-- Restore database
mysql -u username -p bookstore < backup.sql
```

## 5. Troubleshooting

- **Error with foreign keys**: Make sure you've created all tables before adding constraints
- **Access denied**: Verify user permissions are set correctly
- **Invalid data**: Check your sample data against table constraints
