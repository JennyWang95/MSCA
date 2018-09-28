USE santander;


INSERT INTO product VALUES (1, 'savings_acct'),
(2, 'guarantees'),
(3, 'current_acct'),
(4, 'derivative_acct'),
(5, 'payroll_acct'),
(6, 'junior_acct'),
(7, 'mas_particular_acct'),
(8, 'particular_acct'),
(9, 'particular_plus_acct'),
(10, 'short_term_deposits'),
(11, 'medium_term_deposits'),
(12, 'long_term_deposits'),
(13, 'e_account'),
(14, 'funds'),
(15, 'mortgage'),
(16, 'pensions_fin'),
(17, 'loans'),
(18, 'taxes'),
(19, 'credit_card'),
(20, 'securities'),
(21, 'home_acct'),
(22, 'payroll'),
(23, 'pensions_nom'),
(24, 'direct_debit');



INSERT INTO province (    
	province_id,
    province)
(SELECT DISTINCT
    province_id,
    province
FROM
    stdata);
    
INSERT INTO segment VALUES (1, 'TOP'),
(2, 'PARTICULARES'),
(3, 'UNIVERSITARIO');
    
INSERT INTO customer (    
	customer_id,
    gender,
    foreign_cntr,
    join_channel,
    first_join)
(SELECT DISTINCT
    customer_id,
    gender,
    foreign_citizen,
    join_channel,
    str_to_date(first_join,'%Y-%m-%d') 
FROM
    stdata);

INSERT INTO customer (    
	customer_id,
    gender,
    foreign_cntr,
    join_channel,
    first_join)
(SELECT DISTINCT
    customer_id,
    gender,
    foreign_citizen,
    join_channel,
    STR_TO_DATE(first_join,'%Y-%m-%d%')
FROM
    stdata sd);

INSERT INTO transaction (    
    transaction_id,
    date,
    product_id,
    customer_id,
	age,
    senior_mo,
    rel_type,
    gross_house_inc,
    segment_id,
    province_id)
(SELECT DISTINCT
    str.transaction_id,
    STR_TO_DATE(str.date,'%Y-%m-%d%'),
    str.product_id,
    str.customer_id,
    sd.age,
    sd.senior_mo,
    sd.activeness,
    sd.gross_house_inc,
    sd.segment_id,
    sd.province_id
FROM
    sttransaction str,
    stdata sd,
    product pd
WHERE
    str.product_id = sd.product_id AND
    sd.customer_id = str.customer_id AND
    sd.date = str.date);
    

DROP TABLE stdata;

DROP TABLE sttransaction;