/** WITH clause idea : if same value is used again -> WITH come for save
-> results svaing in user temporary table space like materialized views 

- if data small -> view in memory 
- if large -> global temporary table -> should consider the cost $$ 
*/ 

SELECT prod_name, 
    (SELECT SUM(amount_sold) amt_sold FROM sales WHERE prod_id = P.prod_id) / (SELECT COUNT(*) num_prods FROM products)
FROM products P
WHERE P.prod_id IN (SELECT prod_id FROM sales GROUP BY prod_id HAVING SUM(amount_sold) > 100000);
 
WITH sum_amount AS
        (SELECT SUM(amount_sold) amt_sold, prod_id FROM sales GROUP BY prod_id),
     num_of_prods AS
        (SELECT COUNT(*) num_prods FROM products)
SELECT prod_name, 
    amt_sold / (SELECT num_prods FROM num_of_prods)
FROM products P, sum_amount S
WHERE P.prod_id = S.prod_id
AND amt_sold > 100000;
 
 
SELECT DISTINCT S.cust_id,S.prod_id,S.amount_sold, 
(SELECT AVG(amount_sold) avg_sold FROM sales s1 WHERE channel_id = 2 
        AND S.prod_id = s1.prod_id) avg_sold ,
(SELECT COUNT(s2.amount_sold) amt_sold FROM customers c2, sales s2 
        WHERE s2.cust_id = c2.cust_id
              AND c2.cust_marital_status = 'married'
              AND S.cust_id = s2.cust_id 
              GROUP BY c2.cust_first_name,c2.cust_last_name,c2.cust_id) amt_sold
FROM  sales S
WHERE S.channel_id = 2
AND S.amount_sold >
    (SELECT AVG(amount_sold) avg_sold FROM sales s1 WHERE channel_id = 2 AND S.prod_id = s1.prod_id)
AND (SELECT COUNT(s2.amount_sold) amt_sold FROM customers c2, sales s2 
        WHERE s2.cust_id = c2.cust_id
              AND c2.cust_marital_status = 'married'
              AND S.cust_id = s2.cust_id
              GROUP BY c2.cust_first_name,c2.cust_last_name,c2.cust_id) > 200
ORDER BY cust_id,prod_id;
 
 
 
WITH avg_amounts_per_prod AS
        (SELECT AVG(amount_sold) avg_sold, prod_id FROM sales WHERE channel_id = 2 GROUP BY prod_id),
    amounts_sold AS
        (SELECT C.cust_first_name, C.cust_last_name, C.cust_id, COUNT(S.amount_sold) tot_amt_sold FROM customers C, sales S 
            WHERE S.cust_id = C.cust_id
                  AND C.cust_marital_status = 'married'
                  GROUP BY C.cust_first_name,C.cust_last_name,C.cust_id)
SELECT DISTINCT S.cust_id,S.prod_id,S.amount_sold, 
(SELECT avg_sold FROM avg_amounts_per_prod A WHERE A.prod_id = S.prod_id) avg_sold,
(SELECT tot_amt_sold FROM amounts_sold T WHERE T.cust_id = S.cust_id)
FROM  sales S
WHERE S.channel_id = 2
AND S.amount_sold > (SELECT avg_sold FROM avg_amounts_per_prod A WHERE A.prod_id = S.prod_id)
AND (SELECT tot_amt_sold FROM amounts_sold T WHERE T.cust_id = S.cust_id) > 200
ORDER BY cust_id,prod_id;