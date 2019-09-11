--PRACTICE JOINS
--1. Get all invoices where the unit_price on the 
    --invoice_line is greater than $0.99.
SELECT * FROM invoice i
JOIN invoice_line il
ON i.invoice_id = il.invoice_id
WHERE unit_price > 0.99;

--2. Get the invoice_date, customer first_name and 
    --last_name, and total from all invoices.
SELECT i.invoice_date, c.first_name,c.last_name, i.total
FROM invoice i
JOIN customer c
ON i.customer_id = c.customer_id;

--3. Get the customer first_name and last_name and 
    --the support rep's first_name and last_name from all customers.
        ---Support reps are on the employee table.
SELECT c.first_name, c.last_name, e.first_name, e.last_name
FROM customer c
JOIN employee e
ON c.support_rep_id = e.employee_id;

--4. Get the album title and the artist name from all albums.
SELECT al.title, ar.name
FROM album al
JOIN artist ar
ON al.artist_id = ar.artist_id;

--5. Get all playlist_track track_ids where the playlist name is Music.
SELECT pt.track_id
FROM playlist_track pt
JOIN playlist p
ON pt.playlist_id = p.playlist_id
WHERE p.name = 'Music';

--6. Get all track names for playlist_id 5.
SELECT t.name
FROM track t
JOIN playlist_track pt
ON t.track_id = pt.track_id
WHERE pt.playlist_id = 5;

--7. Get all track names and the playlist name that they're on ( 2 joins ).
SELECT t.name, p.name
FROM track t
JOIN playlist_track pt
ON t.track_id = pt.track_id
JOIN playlist p
ON pt.playlist_id = p.playlist_id;

--8. Get all track names and album titles that are the genre Alternative & Punk ( 2 joins ).
SELECT t.name, al.title
FROM album al
JOIN track t
ON t.album_id = al.album_id
JOIN genre g
ON t.genre_id = g.genre_id
WHERE g.name = 'Alternative & Punk';

--BLACK DIAMOND
--Get all tracks on the playlist(s) called Music and show their name, genre name, album name, 
    --and artist name.
        --At least 5 joins.

--PRACTICE NESTED QUERIES
--Complete the instructions without using any joins. Only use nested queries to come up with the solution.

--Get all invoices where the unit_price on the invoice_line is greater than $0.99.
--1.
SELECT * FROM invoice
WHERE invoice_id IN
(SELECT invoice_id
FROM invoice_line
WHERE unit_price > 0.99);

-- Get all playlist tracks where the playlist name is Music.
--2.


-- Get all track names for playlist_id 5.
--3.

-- Get all tracks where the genre is Comedy.
--4.


-- Get all tracks where the album is Fireball.
--5.


-- Get all tracks for the artist Queen ( 2 nested subqueries ).
--.6
