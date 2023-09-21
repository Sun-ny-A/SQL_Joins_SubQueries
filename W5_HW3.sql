

--1) List all customers who live in Texas (use JOINs):

SELECT first_name, last_name, district
FROM customer
JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';

-- output: 5 customers with live in Texas
-- Jenner Davis, Kim Cruz, Richard Mccray, Bryan Hardison, Ian Still



--2) Get all payments above $6.99 with the Customer's Full Name:

SELECT amount, first_name, last_name
FROM customer
JOIN payment
ON payment.customer_id = customer.customer_id
WHERE amount > 6.99;

-- output: 1406 customers with payments > 6.99



--3) Show all customer names who have made payments over $175 (use subqueries):


SELECT first_name, last_name, customer_id
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING SUM(amount) > 175
);

-- output: 6 customers with who have made payments > 175
-- Rhaonda Kennedy, Clara Shaw, Eleanor	Hunt	148, Marion	Snyder, Tommy	Collazo, Karl	Seal



--4) List all customers that live in Nepal (use the city table):


SELECT first_name, last_name
FROM customer
JOIN address
ON customer.address_id = address.address_id
JOIN city
ON address.city_id = city.city_id
JOIN country
ON city.country_id = country.country_id
WHERE country = 'Nepal';

--output: 1 customer
--Kevin Schuler



--5) Which staff member had the most transactions?
--SELECT *
--FROM payment;

SELECT first_name, last_name
FROM staff
WHERE staff_id = (
	SELECT staff_id
	FROM payment
	GROUP BY staff_id
	ORDER BY count(payment_date) DESC
	LIMIT 1  -- TO keep FROM RETURNING multiple ROWS WHEN we want ONLY one returned
);

--output: Jon Stephens



--6) How many movies of each rating are there?


SELECT count(DISTINCT film_id), rating
FROM film
GROUP BY rating;

--output: 178	G, 194	 PG, 223 	PG-13, 195	 R, 210	NC-17



--7) Show all customers who have made a single payment above $6.99 (Use Subqueries):


SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	WHERE amount > 6.99
	GROUP BY customer_id
	HAVING count(*) = 1
);

--output: 130 customers with one time payments > 6.99

-- confirming 130
-- SELECT count(payment_id) DESC, customer_id
-- FROM payment
-- WHERE amount > 6.99
--GROUP BY customer_id;



--8) How many free rentals did our stores give away?

--SELECT *
--FROM payment;

SELECT amount
FROM payment 
WHERE amount = 0;

--output: 24 amounts with 0 amount/ free rentals



