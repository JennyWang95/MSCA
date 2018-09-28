SET SQL_SAFE_UPDATES=0; 

#dim_film
INSERT INTO sakila_snowflake.dim_film (film_last_update, film_id, film_title)
SELECT film_id, title, last_update
FROM sakila.film;



INSERT INTO sakila_snowflake.dim_store (store_key,store_manager_staff_id,location_address_key,store_last_update)
SELECT store_id,manager_staff_id, address_id, last_update
FROM sakila.store;