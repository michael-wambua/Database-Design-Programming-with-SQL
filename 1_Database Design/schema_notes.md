# BookStore Database Schema Notes

## Schema Design Philosophy
The BookStore database schema is designed with normalization principles in mind to minimize data redundancy while maintaining data integrity. The schema is organized into logical groups:

1. **Core Book Data**: Books, authors, publishers, and languages
2. **Customer Information**: Customer details and addresses
3. **Order Processing**: Order management, order lines, shipping, and status tracking

## Key Relationships

### Book Relationships
- Books have a many-to-many relationship with authors (through the book_author junction table)
- Books have a many-to-one relationship with publishers
- Books have a many-to-one relationship with languages

### Customer Relationships
- Customers have a many-to-many relationship with addresses (through customer_address junction table)
- Addresses are associated with countries

### Order Relationships
- Orders belong to a single customer
- Orders contain multiple order lines (books)
- Orders have a shipping method
- Order status changes are tracked in order_history

## Design Decisions

### Primary Keys
- Using auto-incrementing integers as primary keys for most tables
- Using composite keys for junction tables (book_author, customer_address, order_line)

### Data Types
- Using VARCHAR for variable-length strings (names, titles, etc.)
- Using TEXT for longer descriptions
- Using DECIMAL for monetary values (price)
- Using DATETIME for timestamp information
- Using TINYINT for status fields and flags

### Indexes
- Added indexes on foreign keys to improve join performance
- Added indexes on frequently searched fields (ISBN, email, etc.)

### Constraints
- Implemented foreign key constraints with ON DELETE and ON UPDATE actions
- Added CHECK constraints where appropriate for data validation

## Future Considerations
- Partitioning for order history as it grows larger
- Adding full-text search capabilities for book titles and descriptions
- Consider adding book categories and tags for improved searchability