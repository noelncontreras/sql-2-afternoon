-- SQL PRACTICE: JOINS, NESTED QUERIES, UPDATING ROWS,
--GROUP BY, DISTINCT, AND FOREIGN KEYS
    --JOINS: line 5,
    --NESTED QUERIES: line 80,
    --UPDATING ROWS: line 135,
    --GROUP BY: line 173,
    --DISTINCT: line 202,
    --FOREIGN KEYS: line 258 (eCommerce Simulation)

-- PRACTICE JOINS --

--1.
-- Get all invoices where the unit_price on the 
    --invoice_line is greater than $0.99.
SELECT * FROM invoice i
JOIN invoice_line il
ON i.invoice_id = il.invoice_id
WHERE unit_price > 0.99;

--2. 
--Get the invoice_date, customer first_name and 
    --last_name, and total from all invoices.
SELECT i.invoice_date, c.first_name,c.last_name, i.total
FROM invoice i
JOIN customer c
ON i.customer_id = c.customer_id;

--3. 
--Get the customer first_name and last_name and 
    --the support rep's first_name and last_name from all customers.
        ---Support reps are on the employee table.
SELECT c.first_name, c.last_name, e.first_name, e.last_name
FROM customer c
JOIN employee e
ON c.support_rep_id = e.employee_id;

--4. 
--Get the album title and the artist name from all albums.
SELECT al.title, ar.name
FROM album al
JOIN artist ar
ON al.artist_id = ar.artist_id;

--5. 
--Get all playlist_track track_ids where the playlist name is Music.
SELECT pt.track_id
FROM playlist_track pt
JOIN playlist p
ON pt.playlist_id = p.playlist_id
WHERE p.name = 'Music';

--6. 
--Get all track names for playlist_id 5.
SELECT t.name
FROM track t
JOIN playlist_track pt
ON t.track_id = pt.track_id
WHERE pt.playlist_id = 5;

--7. 
--Get all track names and the playlist name that they're on ( 2 joins ).
SELECT t.name, p.name
FROM track t
JOIN playlist_track pt
ON t.track_id = pt.track_id
JOIN playlist p
ON pt.playlist_id = p.playlist_id;

--8. 
--Get all track names and album titles that are the genre Alternative & Punk ( 2 joins ).
SELECT t.name, al.title
FROM album al
JOIN track t
ON t.album_id = al.album_id
JOIN genre g
ON t.genre_id = g.genre_id
WHERE g.name = 'Alternative & Punk';

-- BLACK DIAMOND --
-- Get all tracks on the playlist(s) called Music and show their name, genre name, album name, 
    --and artist name.
        --At least 5 joins.

-- PRACTICE NESTED QUERIES --
--Complete the instructions without using any joins. Only use nested queries to come up with the solution.

--1.
-- Get all invoices where the unit_price on the invoice_line is greater than $0.99.
SELECT * FROM invoice
WHERE invoice_id IN
(SELECT invoice_id
FROM invoice_line
WHERE unit_price > 0.99);

--2.
-- Get all playlist tracks where the playlist name is Music.
SELECT * FROM playlist_track
WHERE playlist_id IN
(SELECT playlist_id
FROM playlist
WHERE name = 'Music');

--3.
-- Get all track names for playlist_id 5.
SELECT name FROM track
WHERE track_id IN
(SELECT track_id
FROM playlist_track
WHERE playlist_id = 5);

--4.
-- Get all tracks where the genre is Comedy.
SELECT * FROM track
WHERE genre_id IN 
(SELECT genre_id 
FROM genre
WHERE name = 'Comedy');

--5.
-- Get all tracks where the album is Fireball.
SELECT * FROM track
WHERE album_id IN
(SELECT album_id
FROM album
WHERE title = 'Fireball');

--6.
-- Get all tracks for the artist Queen ( 2 nested subqueries ).
SELECT * FROM track
WHERE album_id IN
(SELECT album_id
FROM album
WHERE artist_id IN
(SELECT artist_id
FROM artist
WHERE name = 'Queen'));

-- PRACTICE UPDATING ROWS --

--1.
-- Find all customers with fax numbers and set those numbers to null.
UPDATE customer
SET fax = NULL
WHERE fax IS NOT NULL;

--2.
-- Find all customers with no company (null) and set their company to "Self".
UPDATE customer
SET company = 'Self'
WHERE company IS NULL;

--3.
-- Find the customer Julia Barnett and change her last name to Thompson.
UPDATE customer
SET last_name = 'Thompson'
WHERE first_name = 'Julia'
AND last_name = 'Barnett';

--4.
-- Find the customer with this email luisrojas@yahoo.cl and change his support rep to 4.
UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';

--5.
-- Find all tracks that are the genre Metal and have no composer. Set the composer to "The darkness around us".
UPDATE track
SET composer = 'The darkness around us'
WHERE genre_id =
(SELECT genre_id
FROM genre
WHERE name = 'Metal')
AND composer IS NULL;

-- GROUP BY --

--1.
-- Find a count of how many tracks there are per genre. Display the genre name with the count.
SELECT g.name, count(*)
FROM genre g
JOIN track t
ON g.genre_id = t.genre_id
GROUP BY g.name;

--2.
-- Find a count of how many tracks are the "Pop" genre and how many tracks are the "Rock" genre.
SELECT count(*), g.name
FROM genre g
JOIN track t
ON g.genre_id = t.genre_id
WHERE g.name = 'Pop'
OR g.name = 'Rock'
GROUP BY g.name;

--3.
-- Find a list of all artists and how many albums they have.
SELECT ar.name, count(*)
FROM artist ar
JOIN album al
ON ar.artist_id = al.artist_id
GROUP BY ar.name;

--USE DISTINCT

--1.
-- From the track table find a unique list of all composers.
SELECT DISTINCT composer 
FROM track;

--2.
-- From the invoice table find a unique list of all billing_postal_codes.
SELECT DISTINCT billing_postal_code
FROM invoice;

--3.
-- From the customer table find a unique list of all companys.
SELECT DISTINCT company
FROM customer;

-- DELETE ROWS --
--Always do a select before a delete to make sure you get back exactly what 
    --you want and only what you want to delete! Since we cannot delete anything 
    --from the pre-defined tables ( foreign key restraints ), use the following 
    --SQL code to create a dummy table:

--1.
-- Copy, paste, and run the SQL code from the summary.
CREATE TABLE practice_delete ( name TEXT, type TEXT, value INTEGER );
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'bronze', 50);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'bronze', 50);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'bronze', 50);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'silver', 100);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'silver', 100);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);

SELECT * FROM practice_delete;

--2.
-- Delete all 'bronze' entries from the table.
DELETE FROM practice_delete
WHERE type = 'bronze';

--3.
-- Delete all 'silver' entries from the table.
DELETE FROM practice_delete
WHERE type = 'silver';

--4.
-- Delete all entries whose value is equal to 150.
DELETE 
FROM practice_delete 
WHERE value = 150;


--eCOMMERCE SIMULATION - NO HINTS --
-- Let's simulate an e-commerce site. We're going to need users, products, and orders.
    -- users need a name and an email.
    -- products need a name and a price
    -- orders need a ref to product.
    -- All 3 need primary keys.


--1.
-- Create 3 tables following the criteria in the summary.
CREATE TABLE users (
user_id SERIAL PRIMARY KEY,
name VARCHAR(100),
email VARCHAR(100)
);

CREATE TABLE products (
product_id SERIAL PRIMARY KEY,
name VARCHAR(255),
price FLOAT
);

CREATE TABLE orders (
order_id SERIAL PRIMARY KEY,
product_id INTEGER,
FOREIGN KEY(product_id) REFERENCES products(product_id)
);

--2.
-- Add some data to fill up each table.
    -- At least 3 users, 3 products, 3 orders.
INSERT INTO users
(name, email)
VALUES
('Mykenzie Rogers', 'mrodgers@devmtn.com'),
('David Newman', 'dnewman@devmtn.com'),
('Eric Sellors', 'esellors@devmtn.com');

INSERT INTO products
(name, price)
VALUES
('computer', 1999.99),
('monitor', 499.99),
('chair', 99.99);

INSERT INTO orders
(product_id)
VALUES
(1), (2), (3);

--3.
-- Run queries against your data.
    -- Get all products for the first order.
    -- Get all orders.
    -- Get the total cost of an order ( sum the price of all products on an order ).
SELECT * FROM orders
WHERE order_id = 1;

SELECT * FROM orders;

SELECT  o.order_id, sum(p.price) 
FROM orders o
JOIN products p
ON o.product_id = p.product_id
WHERE o.order_id = 1
GROUP BY o.order_id;

--4.
-- Add a foreign key reference from orders to users.
ALTER TABLE users
ADD COLUMN order_id INTEGER
REFERENCES orders(order_id);

--5.
-- Update the orders table to link a user to each order.
UPDATE users 
SET order_id = user_id;

--6.
-- Run queries against your data.
    -- Get all orders for a user.
    -- Get how many orders each user has.
SELECT u.name, count(o.order_id)
FROM users u
JOIN orders o
ON o.order_id = u.order_id
GROUP BY u.name;

SELECT u.name, count(*) 
FROM users u
JOIN orders o
ON o.order_id = u.order_id
GROUP BY u.name;

--BLACK DIAMOND--
--Get the total amount on all orders for each user.
SELECT u.name, sum(p.price)
FROM products p
JOIN orders o
ON p.product_id = o.product_id
JOIN users u
ON o.order_id = u.order_id
GROUP BY u.name;