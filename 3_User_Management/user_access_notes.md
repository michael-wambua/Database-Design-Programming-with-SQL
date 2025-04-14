# User Access Management Notes

## User Roles Overview

### 1. bookstore_admin
- **Purpose**: Full administrative access to the entire database
- **Permissions**: All privileges on all tables
- **Use Cases**: Schema changes, user management, critical data fixes

### 2. bookstore_staff
- **Purpose**: Day-to-day operations management 
- **Permissions**: Read, insert, and update on most tables
- **Restrictions**: Cannot update sensitive customer data or modify completed orders
- **Use Cases**: Order processing, inventory checks, customer service

### 3. bookstore_report
- **Purpose**: Generates reports and analytics
- **Permissions**: Read-only access to all tables
- **Use Cases**: Sales reports, inventory analysis, customer insights

### 4. bookstore_api
- **Purpose**: Used by the web application and API services to interact with the database
- **Permissions**: Read access to all tables, write access to order-related tables
- **Use Cases**: Processing online orders, customer registrations

### 5. bookstore_inventory
- **Purpose**: Manages the book catalog and inventory
- **Permissions**: Read access to all tables, write access to book-related tables only
- **Use Cases**: Adding new books, updating stock levels, adding authors and publishers

## Security Considerations

1. **Password Management**
   - All passwords in scripts are placeholders and should be replaced with strong, unique passwords
   - Consider implementing a password rotation policy
   - Store credentials securely outside of version control

2. **Connection Restrictions**
   - Most users are restricted to localhost connections
   - Only API user can connect from remote hosts (denoted by '%')
   - Consider further restricting API user to specific IP ranges in production

3. **Principle of Least Privilege**
   - Each role has only the minimum permissions needed to perform its job
   - No DELETE permissions except for admin to prevent accidental data loss

## Monitoring and Auditing

1. **Usage Logging**
   - Enable MySQL general query log temporarily for auditing if needed
   - Consider implementing application-level logging for sensitive operations

2. **Regular Reviews**
   - Periodically review user permissions to ensure they match job responsibilities
   - Remove or deactivate unused accounts

## Future Enhancements

1. Consider implementing row-level security for multi-store deployments
2. Evaluate using MySQL roles feature (MySQL 8.0+) for more flexible permission management
3. Implement database activity monitoring for security purposes