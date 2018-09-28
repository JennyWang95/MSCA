
# in DDL DEFAULT CHARACTER SET = latin1(limiting to English); why is that? (classic model is utf8)

    
INSERT INTO sakila_snowflake.dim_film (    
	film_id,
    film_title
)
(SELECT 
    film_id,
    title
FROM
    sakila.film); 
# Error Code: 1364. Field 'film_language' doesn't have a default value, does it mean NN values must be entered altogether?  Yes

# adding value seems to be sequencial there are queries like s_fa.film_id = d_f.film_id, 
# other than dimention first and fact last, what are some rule of thumbs, is it to add ones without any foreign keys first?

# why use film_key, staff_key when we already have film_id and staff_id from sakila schema # surrogate key is always 
# better in dimentional model's dimention table. 
#Surrogate keys are absolutely required if you’re tracking dimension attribute changes with a new dimension record 
# for each profile change. Even if your business users don’t initially visualize the value of tracking attribute changes, 
# using surrogates will make a downstream policy change less onerous.
# for example customer change addresses, we need to keep both addresses.

# film_has_XXX and film_in_XXXXX data type is CHAR(4), why in DML it's binary like 1 and 0, can add up together

# fact table, group by multiple columns https://stackoverflow.com/questions/2421388/using-group-by-on-multiple-columns



