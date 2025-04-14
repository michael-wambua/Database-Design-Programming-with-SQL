# Change Log

## Version 1.0.0 (2025-04-01) - Initial Release

### Added
- Created initial database schema with core tables
- Implemented foreign key constraints and indexing
- Added sample data for testing
- Created user roles and permissions
- Implemented basic views for common queries

## Version 1.0.1 (2025-04-05) - Bug Fixes

### Fixed
- Corrected data type for `street_number` in `address` table from INT to VARCHAR(10) to accommodate alphanumeric street numbers
- Fixed foreign key constraint in `order_line` table that was referencing the wrong column
- Adjusted indexing strategy for `book` table to improve query performance
- Corrected inconsistent spelling in column names for `publisher_email` field

## Version 1.0.2 (2025-04-10) - Enhancements

### Added
- Created additional views for sales analytics
- Added trigger to update stock quantity when orders are placed
- Implemented stored procedures for common operations
- Added data validation checks for critical fields

### Changed
- Modified `customer` table to include date of birth for age verification
- Expanded `book` table to include additional metadata fields
- Updated user permission model to be more granular
- Enhanced indexing strategy based on query performance analysis

## Version 1.1.0 (2025-04-14) - Feature Addition

### Added
- Implemented order history tracking system
- Added support for multiple shipping addresses per customer
- Created reporting views for business intelligence
- Added audit logging for sensitive operations

### Changed
- Restructured order processing workflow
- Improved handling of book author relationships
- Enhanced security measures for user authentication

### Fixed
- Resolved performance bottleneck in customer order queries
- Fixed data consistency issues in order processing
- Corrected cascading delete behavior for related entities

## Planned Changes

### Short Term (Next 2 Weeks)
- Add support for book categories and genres
- Implement discount and promotion system
- Create automated backup procedures
- Add inventory management alerts

### Long Term (Next 3 Months)
- Integrate with external payment processing systems
- Develop customer loyalty program schema
- Implement advanced analytics capabilities
- Support for e-book and digital content delivery