# BookStore Database Project

## Overview
This project implements a comprehensive database solution for a bookstore business. The database manages books, authors, customers, orders, and all associated data necessary for operating a modern bookstore with both physical and online presence.

## Project Structure

```
Bookstore-SQL-Project/
│
├── 📁 1_Database_Design/
│   ├── bookstore_schema.drawio         # Draw.io ERD file
│   ├── bookstore_schema.png            # Exported image of ERD
│   └── schema_notes.md                 # Notes or explanations on the schema design
│
├── 📁 2_SQL_Scripts/
│   ├── create_database.sql             # SQL script to create the database
│   ├── tables_core.sql                 # Book, Author, Publisher, Book_Language, Book_Author
│   ├── tables_customers.sql            # Customer, Address, Customer_Address, Country, Address_Status
│   ├── tables_orders.sql               # Cust_Order, Order_Line, Shipping_Method, Order_Status, Order_History
│   ├── sample_data.sql                 # Sample INSERTs for testing
│   └── constraints_indexes.sql         # Foreign keys, indexes, and other constraints
│
├── 📁 3_User_Management/
│   ├── user_roles.sql                  # SQL to create users and assign roles/permissions
│   └── user_access_notes.md            # Notes on user roles, privileges, and restrictions
│
├── 📁 4_Testing_and_Queries/
│   ├── test_queries.sql                # SELECT queries for validation/testing
│   ├── analytics_queries.sql           # Insights (top selling books, frequent customers, etc.)
│   └── query_results.md                # Output samples from tested queries
│
├── 📁 5_Documentation/
│   ├── README.md                       # Project overview, team members, and guide
│   ├── team_work_distribution.md       # Who did what (task division)
│   ├── objectives.md                   # Project goals and expected outcomes
│   └── tools_used.md                   # Tools and technologies (MySQL, Draw.io, etc.)
│
└── 📁 6_Backups_and_Extras/
    ├── full_schema_backup.sql          # Exported full SQL backup of schema and data
    └── change_log.md                   # Log of any changes made to the schema
```

## Installation and Setup

1. **Prerequisites**
   - MySQL Server 8.0 or higher
   - MySQL client or MySQL Workbench

2. **Database Setup**
   ```bash
   # Login to MySQL
   mysql -u root -p
   
   # Run the create database script
   source /path/to/2_SQL_Scripts/create_database.sql
   
   # Run scripts to create tables
   source /path/to/2_SQL_Scripts/tables_core.sql
   source /path/to/2_SQL_Scripts/tables_customers.sql
   source /path/to/2_SQL_Scripts/tables_orders.sql
   
   # Add constraints and indexes
   source /path/to/2_SQL_Scripts/constraints_indexes.sql
   
   # Load sample data
   source /path/to/2_SQL_Scripts/sample_data.sql
   
   # Set up users (optional)
   source /path/to/3_User_Management/user_roles.sql
   ```

3. **Testing**
   ```bash
   # Run test queries to validate setup
   source /path/to/4_Testing_and_Queries/test_queries.sql
   ```

## Database Design Highlights

- **Normalized Structure**: The database follows normalization principles to reduce redundancy and maintain data integrity
- **Scalable Design**: Designed to handle large volumes of books, customers, and orders
- **Comprehensive Tracking**: Full order history and status tracking
- **Secure Access**: Multiple user roles with specific permissions
- **Performance Optimized**: Strategic indexes for common query patterns

## Key Features

1. **Book Management**
   - Comprehensive book metadata (title, ISBN, price, etc.)
   - Support for multiple authors per book
   - Publisher and language tracking

2. **Customer Management**
   - Customer profiles with contact information
   - Multiple addresses per customer with address types
   - Global address support with country information

3. **Order Processing**
   - Complete order life cycle management
   - Order status tracking and history
   - Multiple shipping methods
   - Detailed line items for each order

4. **Business Intelligence**
   - Sales analytics by book, author, publisher
   - Customer purchase history and patterns
   - Inventory management and alerts

## Usage Examples

See the `4_Testing_and_Queries` directory for example SQL queries that demonstrate:
- Book catalog queries
- Customer information retrieval
- Order processing workflows
- Sales analytics and reporting

## Maintenance and Extensions

This database design supports several potential extensions:
- Book categories and tags for advanced classification
- Customer reviews and ratings
- Staff/employee management
- Store location management (for multi-store operations)
- Loyalty program integration

## Contributors
- Michael Sylvester Wambua
- Teddy Owino
- Mary Akinyi