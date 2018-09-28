SELECT * FROM sakila.payment;

SELECT 
	payment_id, amount
FROM
             payment
WHERE
    amount BETWEEN 2 AND 7;

SELECT 
	title, description
FROM
             film
WHERE
    rating = 'PG-13';
    
UPDATE film, film_actor, film_category, film_text
SET field = REPLACE(field, 'film', 'movie') WHERE field LIKE '%film%';

RENAME TABLE  film TO  movie,
			  film_actor TO movie_actor,
              film_category TO movie_category,
              film_text TO movie_text;
              
ALTER TABLE movie
  CHANGE COLUMN film_id movie_id SMALLINT(5), ALGORITHM = INPLACE;
  
  
SELECT 
	first_name, last_name
FROM
             customer
WHERE
    customer_id IN 
   (SELECT customer_id FROM rental WHERE return_date BETWEEN '2018-04-01' AND '2018-04-30');
    