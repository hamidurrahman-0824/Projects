# Sakila Business Insights — SQL Portfolio Project

A business intelligence analysis of the Sakila DVD rental database using MySQL.  
This project demonstrates real-world SQL skills by answering 15 business questions across customer behavior, film performance, store operations, and rental trends.

---

## Tools Used
- MySQL 8.0
- MySQL Workbench
- Sakila Sample Database

---

## Database Schema

Sakila is a relational database representing a DVD rental business with 16 tables including `customer`, `film`, `rental`, `payment`, `inventory`, `store`, `staff`, `actor`, and `category`.

---

## Business Questions Answered

### Customer Analysis
1. Who are the top 10 highest spending customers?
2. Which city has the most customers?
3. How many active vs inactive customers are there?
4. What is the average spending per customer?

### Film & Inventory Analysis
5. Which film categories generate the most revenue?
6. What are the top 10 most rented films?
7. Which films have never been rented?
8. What is the average film length per category?
9. Which rating category has the most films?

### Store & Staff Analysis
10. Which store generates more revenue?
11. Which staff member processed the most rentals?
12. What is the monthly revenue trend across both stores?

### Actor Analysis
13. Which actors appear in the most films?
14. Which actor combination appears together most often?

### Rental Behavior
15. What is the average rental duration per category?

---

## Key Findings

- Store 2 generates higher total revenue than Store 1
- Sports and Animation are among the top revenue-generating categories
- A significant number of films in the inventory have never been rented
- PG-13 and NC-17 have the highest number of films by rating

---

## SQL Concepts Used

| Concept | Applied In |
|---|---|
| JOINs (INNER, LEFT) | Most queries |
| Aggregate functions | Revenue, counts, averages |
| GROUP BY / HAVING | Grouping by category, store, staff |
| Subqueries / CTEs | Films never rented |
| Window functions | Rankings and trends |
| String functions | Concatenating names |
| Date functions | Monthly revenue trends |

---

## Repository Structure

```
sakila_analysis/
├── README.md
├── sakila_analysis.sql
└── results/
    ├── top_customers.csv
    ├── top_categories.csv
    ├── most_rented_films.csv
    ├── store_revenue.csv
    └── never_rented_films.csv
```

---

## How to Run

1. Install MySQL and import the Sakila database from [MySQL's official site](https://dev.mysql.com/doc/index-other.html)
2. Open `sakila_analysis.sql` in MySQL Workbench
3. Run each query section by section

---

## Author

**Hamidur Rahman**  
Industrial & Production Engineering, SUST  
GitHub: [hamidurrahman-0824](https://github.com/hamidurrahman-0824)
