# Query Results Sample Output

## Basic Table Validation

```
+-----------------+--------------+
| table_name      | record_count |
+-----------------+--------------+
| book            | 7            |
| author          | 9            |
| book_author     | 7            |
| publisher       | 5            |
| book_language   | 6            |
| customer        | 5            |
| address         | 5            |
| customer_address| 5            |
| country         | 6            |
| cust_order      | 5            |
| order_line      | 6            |
| order_history   | 12           |
+-----------------+--------------+
```

## Book Catalog with Authors

```
+---------+------------------------------------------+-------------+---------------------+----------------------+--------------+-------+----------------+
| book_id | title                                    | isbn        | authors             | publisher_name       | language_name| price | publication_date|
+---------+------------------------------------------+-------------+---------------------+----------------------+--------------+-------+----------------+
| 7       | Becoming                                 | 1524763136  | Michelle Obama      | Simon & Schuster     | English      | 24.99 | 2018-11-13     |
| 5       | Clean Code                               | 0132350882  | Robert C. Martin    | O'Reilly Media       | English      | 39.99 | 2008-08-01     |
| 1       | Harry Potter and the Philosopher's Stone | 0747532699  | J.K. Rowling        | Penguin Random House | English      | 19.99 | 1997-06-26     |
| 3       | Murder on the Orient Express             | 0062073494  | Agatha Christie     | HarperCollins        | English      | 12.99 | 1934-01-01     |
| 6       | Refactoring                              | 0134757599  | Martin Fowler       | Packt Publishing     | English      | 49.99 | 2018-11-30     |
| 2       | The Shining                              | 0385121679  | Stephen King        | HarperCollins        | English      | 15.99 | 1977-01-28     |
| 4       | 1984                                     | 0451524934  | George Orwell       | Penguin Random House | English      | 9.99  | 1949-06-08     |
+---------+------------------------------------------+-------------+---------------------+----------------------+--------------+-------+----------------+
```

## Customer Order Details

```
+----------+---------------------+-------------------+-------------+----------------+----------------+----------------+-------------+---------------+-----------+-------------+
| order_id | order_date          | customer_name     | order_status| shipping_method| number_of_items| total_quantity | order_total | shipping_cost | tax_amount | grand_total |
+----------+---------------------+-------------------+-------------+----------------+----------------+----------------+-------------+---------------+-----------+-------------+
| 4        | 2025-04-09 13:20:00 | michael sylvester | Delivered   | Overnight      | 1              | 1              | 49.99       | 19.99         | 7.00      | 76.98       |
| 1        | 2025-04-10 09:00:00 | michael sylvester | Shipped     | Standard       | 2              | 2              | 32.98       | 5.99          | 3.90      | 42.87       |
| 2        | 2025-04-12 11:20:00 | Jane Smith        | Processing  | Express        | 1              | 1              | 24.99       | 12.99         | 3.80      | 41.78       |
| 3        | 2025-04-13 16:30:00 | teddy owino       | Pending     | Free Economy   | 1              | 1              | 19.99       | 0.00          | 2.60      | 22.59       |
| 5        | 2025-04-08 10:10:00 | Bob Brown         | Cancelled   | Standard       | 1              | 1              | 15.99       | 5.99          | 2.20      | 24.18       |
+----------+---------------------+-------------------+-------------+----------------+----------------+----------------+-------------+---------------+-----------+-------------+
```

## Order History for Order #1

```
+----------+---------------+---------------------+-------------+-------------------+------------+
| order_id | customer_name | status_date         | status_name | comments          | created_by |
+----------+---------------+---------------------+-------------+-------------------+------------+
| 1     | Michael sylvester| 2025-04-10 09:00:00 | Pending     | Order placed      | system     |
| 1     | Michael sylvester| 2025-04-10 14:30:00 | Processing  | Payment confirmed | system     |
| 1     | Michael sylvester| 2025-04-11 10:15:00 | Shipped     | Shipped via USPS  | staff_user |
+----------+---------------+---------------------+-------------+-------------------+------------+
```

## Best-Selling Books

```
+---------+------------------------------------------+----------------------+------------+---------------+
| book_id | title                                    | authors              | total_sold | total_revenue |
+---------+------------------------------------------+----------------------+------------+---------------+
| 1       | Harry Potter and the Philosopher's Stone | J.K. Rowling         | 2          | 39.98         |
| 6       | Refactoring                              | Martin Fowler        | 1          | 49.99         |
| 7       | Becoming                                 | Michelle Obama       | 1          | 24.99         |
| 3       | Murder on the Orient Express             | Agatha Christie      | 1          | 12.99         |
+---------+------------------------------------------+----------------------+------------+---------------+
```

## Customer Purchase Analysis

```
+-------------+----------------+--------------+-------------+----------------------+-------------------+---------------------+----------------------+
| customer_id | customer_name  | total_orders | total_spent | average_order_value | first_order_date  | most_recent_order   | days_since_last_order|
+-------------+----------------+--------------+-------------+----------------------+-------------------+---------------------+----------------------+
| 1          |Michael sylvester| 2            | 119.85      | 59.93               | 2025-04-09 13:20  | 2025-04-10 09:00:00 | 4                    |
| 2           | mary diana     | 1            | 41.78       | 41.78               | 2025-04-12 11:20  | 2025-04-12 11:20:00 | 2                    |
| 3           | teddy owino    | 1            | 22.59       | 22.59               | 2025-04-13 16:30  | 2025-04-13 16:30:00 | 1                    |
| 4           | Bob Brown      | 0            | NULL        | NULL                | NULL              | NULL                | NULL                 |
| 5           | Sarah Davis    | 0            | NULL        | NULL                | NULL              | NULL                | NULL                 |
+-------------+----------------+--------------+-------------+----------------------+-------------------+---------------------+----------------------+
```

## Low Stock Alert Report

```
+---------+------------------------------------------+--------------------+---------------+-------------------+
| book_id | title                                    | authors            | stock_quantity| sold_last_30_days |
+---------+------------------------------------------+--------------------+---------------+-------------------+
| 6       | Refactoring                              | Martin Fowler      | 5             | 1                 |
| 5       | Clean Code                               | Robert C. Martin   | 5             | 0                 |
+---------+------------------------------------------+--------------------+---------------+-------------------+
```