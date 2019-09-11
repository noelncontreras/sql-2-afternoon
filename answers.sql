--PRACTICE JOINS

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

--BLACK DIAMOND
-- Get all tracks on the playlist(s) called Music and show their name, genre name, album name, 
    --and artist name.
        --At least 5 joins.

--PRACTICE NESTED QUERIES
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

--PRACTICE UPDATING ROWS

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

--GROUP BY

--1.
-- Find a count of how many tracks there are per genre. Display the genre name with the count.
SELECT g.name, count(*)
FROM genre g
JOIN track t
ON g.genre_id = t.genre_id
GROUP BY g.name;

--2.
-- Find a count of how many tracks are the "Pop" genre and how many tracks are the "Rock" genre.


--3.
-- Find a list of all artists and how many albums they have.
