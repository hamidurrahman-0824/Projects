-- ================================================
-- SAKILA DATABASE ANALYSIS
-- Author: Hamidur Rahman Majed
-- Database: MySQL Sakila Sample Database
-- ================================================

-- 1. Who are the top 10 highest spending customers

SELECT
	CONCAT(c.first_name,' ',c.last_name) as Name,
    SUM(p.amount) as Total
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY Total DESC
LIMIT 10;


-- 2.Which city has the most customers

SELECT
    ci.city,
    COUNT(c.customer_id) AS total_customers
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
GROUP BY ci.city
ORDER BY total_customers DESC
LIMIT 10;


-- 3.How many active customers

SELECT
	SUM(active = 1) as "Active",
    SUM(active = 0) as "Offline"
FROM customer;

-- with case

SELECT
	COUNT(
		 CASE 
			WHEN active = 1 THEN 1 
		 END) AS "Active",
    COUNT(CASE WHEN active = 0 THEN 1 END) as "Offline"
FROM
	customer;


-- 4.What is the average spending per customer

WITH mini_table AS (
SELECT
	customer_id,
	AVG(p.amount) AS avg_amount
FROM
	payment p
GROUP BY customer_id
)
SELECT AVG(avg_amount) AS overall_avg
FROM mini_table;


-- 5. Which film categories generate the most revenue?

SELECT
	c.name,
	SUM(p.amount) Revenue,
    RANK() OVER(ORDER BY SUM(p.amount) DESC) as Ranking_by_income
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film_category fc ON i.film_id = fc.film_id
JOIN category c ON c.category_id = fc.category_id
GROUP BY c.name
ORDER BY Revenue DESC
LIMIT 10;


-- 6. What are the top 10 most rented films?

SELECT
  f.title,
  COUNT(*) as times_rented
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film_category fc ON i.film_id = fc.film_id
JOIN category c ON c.category_id = fc.category_id
JOIN film f ON f.film_id = fc.film_id
GROUP BY f.title
ORDER BY times_rented DESC LIMIT 10;


-- 7. Which films have never been rented?

-- simple approach
SELECT
  title
FROM film
WHERE film_id NOT IN(
	SELECT DISTINCT i.film_id
  FROM rental r
  JOIN inventory i ON r.inventory_id = i.inventory_id
  );
  
--

WITH rented_films AS (
    SELECT DISTINCT i.film_id
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
)
SELECT f.title
FROM film f
WHERE f.film_id NOT IN (SELECT film_id FROM rented_films);


-- 8. What is the average film length per category

SELECT
    c.name AS category,
    ROUND(AVG(f.length), 2) AS avg_length
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_length DESC;


-- 9. Which rating category has the most films?

SELECT 
   rating,
	 COUNT(*) AS total_films
FROM film
GROUP BY rating
ORDER BY total_films DESC
LIMIT 1;


-- 10. Which store generates more revenue?

SELECT
    s.store_id,
    CONCAT(st.first_name, ' ', st.last_name) AS manager,
    SUM(p.amount) AS revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN store s ON s.store_id = i.store_id
JOIN staff st ON s.manager_staff_id = st.staff_id
GROUP BY s.store_id, st.first_name, st.last_name
ORDER BY revenue DESC;
--

SELECT
    s.store_id,
    ci.city AS store_location,
    SUM(p.amount) AS revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN store s ON s.store_id = i.store_id
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
GROUP BY s.store_id, ci.city
ORDER BY revenue DESC;


-- 11. Which staff member processed the most rentals

SELECT
    sf.staff_id,
    CONCAT(sf.first_name, ' ', sf.last_name) AS "name",
    COUNT(*) AS total_managed_rental
FROM rental r
JOIN staff sf ON r.staff_id = sf.staff_id
GROUP BY sf.staff_id
ORDER BY total_managed_rental DESC;


-- 12. What is the monthly revenue trend across both stores?

SELECT
  c.city,
  MONTHNAME(p.payment_date) AS "Month",
  SUM(p.amount) as Revenue
  
FROM payment p
JOIN rental r ON r.rental_id = p.rental_id
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN store s ON s.store_id = i.store_id
JOIN address a ON a.address_id = s.address_id
JOIN city c ON a.city_id = c.city_id
GROUP BY c.city,MONTH(p.payment_date),MONTHNAME(p.payment_date)
ORDER BY MONTH(p.payment_date);


-- 13. Which actors appear in the most films?

SELECT
  CONCAT(a.first_name ," " ,a.last_name )AS full_name,
  COUNT(*) AS total_appearence
FROM film_actor f
JOIN actor a ON f.actor_id = a.actor_id
GROUP BY a.actor_id
ORDER BY total_appearence DESC;


-- 14. Which film generates the most revenue per copy in inventory?

SELECT
  f.title,
  SUM(p.amount) AS total_revenue,
  COUNT(DISTINCT i.inventory_id) AS total_copies,
  ROUND(SUM(p.amount)/count(DISTINCT i.inventory_id),2) as revenue_per_cpy
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON f.film_id = i.film_id
GROUP BY f.title
ORDER BY revenue_per_cpy;

  
-- 15. What is the average rental duration per category?*/

SELECT
    c.name AS category,
    ROUND(AVG(f.rental_duration), 2) AS avg_rental_duration
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_rental_duration DESC;
