USE SAKILA_SNOWFLAKE;

# start with outter layer  

# location_country
INSERT INTO sakila_snowflake.dim_location_country (    
	location_country_id,
    location_country_name,
    location_country_last_update)
(SELECT 
    country_id,
    country,
    last_update
FROM
    sakila.country);

# staff
INSERT INTO sakila_snowflake.dim_staff (    
	staff_id,
    staff_first_name,
    staff_last_name,
    staff_store_id,
    staff_last_update)
(SELECT 
    staff_id,
    first_name,
    last_name,
    store_id,
    last_update
FROM
    sakila.staff);
    
    
#actor
    INSERT INTO sakila_snowflake.dim_actor (    
	actor_id,
    actor_first_name,
    actor_last_name,
    actor_last_update)
(SELECT 
    actor_id,
    first_name,
    last_name,
    last_update
FROM
    sakila.actor);

# staff
INSERT INTO sakila_snowflake.dim_staff (    
	staff_id,
    staff_first_name,
    staff_last_name,
    staff_store_id,
    staff_last_update)
(SELECT 
    staff_id,
    first_name,
    last_name,
    store_id,
    last_update
FROM
    sakila.staff);


    
    