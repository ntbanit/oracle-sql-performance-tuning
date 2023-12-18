/** MATERIALIZED VIEW -> unlike view, store both query & data -> increase performance  
- auto resfresh on DMLs 
- Materialized view = burnden 
- can create indexed, partitions.. in Materialized view like a Regular Table 
- when query rewrite is enabled in Materialized view, the optimizer may use it auto 
*/

SELECT C.cust_id, cust_first_name,cust_last_name, prod_id, COUNT(*) num_sold FROM sales S, customers C
WHERE S.cust_id = C.cust_id
GROUP BY C.cust_id,cust_first_name, cust_last_name, prod_id
ORDER BY num_sold DESC;
 
CREATE MATERIALIZED VIEW vw_cust_num_sold
ENABLE QUERY REWRITE AS
SELECT C.cust_id, cust_first_name,cust_last_name, prod_id, COUNT(*) num_sold FROM sales S, customers C
WHERE S.cust_id = C.cust_id
GROUP BY C.cust_id,cust_first_name, cust_last_name, prod_id
ORDER BY num_sold DESC;
 
SELECT * FROM vw_cust_num_sold;
 
SELECT cust_id,prod_name,num_sold
FROM vw_cust_num_sold V, products P
WHERE V.prod_id = P.prod_id
AND V.prod_id = 13;
 
SELECT cust_id,prod_name,num_sold
FROM vw_cust_num_sold V, products P
WHERE V.prod_id = P.prod_id(+)
AND V.prod_id = 13;

-- the optimizer may use it automatically -> increase performance 
SELECT C.cust_id, cust_first_name,cust_last_name, prod_id, COUNT(*) num_sold FROM sales S, customers C
WHERE S.cust_id = C.cust_id
AND prod_id = 13
GROUP BY C.cust_id,cust_first_name, cust_last_name, prod_id
ORDER BY num_sold DESC;
 
DROP MATERIALIZED VIEW vw_cust_num_sold;