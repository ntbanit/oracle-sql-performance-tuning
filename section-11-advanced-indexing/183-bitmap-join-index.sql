/** BIT MAP JOIN INDEX => usefull in data warehouse 

1. Problem: usually query on joining in big tables

2. Solutions :
2.1. Materialized view : not good when have more DML 
    - if not update usually, data is not accurate 
    - FULL table scan on Materialized view
        + create an index, but still can have problem
            . data changes in actual table 
            . high disk usage => $$ 
2.2 Cluster table 
    - FULL table scan lone -> high cost when clusted 

2.3 Another option : BIT MAP JOIN INDEX on 2 or more tables 
    - need less space than Materialized view
    
- drawback 
    + maintain cost is higher 
    + only 1 table among indexed tables can be updated concurrently by different transactions 
    + parellel DML only support on the fact table 
    + joined columns of dimension table needs to have unique or PK 
    + if dimension table has a multi-column PK, all must be in the join 
    + no table can be joined twice 
    + can NOT create on temporary tables 
*/

ALTER TABLE customers ENABLE VALIDATE CONSTRAINT customers_pk;

ALTER TABLE products ENABLE VALIDATE CONSTRAINT products_pk;



SELECT AVG(S.quantity_sold)
FROM sales S, products P, customers C
WHERE S.prod_id = P.prod_id
AND S.cust_id = C.cust_id
AND P.prod_subcategory = 'CD-ROM'
AND C.cust_city = 'Manchester';


/* sales - fact table (main) 
LOCAL -> use when fact table partitioning 
*/
CREATE BITMAP INDEX sales_temp_bjx ON sales(P.prod_subcategory, C.cust_city)
FROM sales S, products P, customers C
WHERE S.prod_id = P.prod_id
AND S.cust_id = C.cust_id
LOCAL;



DROP INDEX sales_temp_bjx;



SELECT DISTINCT C.cust_postal_code
FROM sales S, products P, customers C
WHERE S.prod_id = P.prod_id
AND S.cust_id = C.cust_id
AND C.cust_city = 'Manchester';



CREATE BITMAP INDEX sales_temp_bjx ON sales(C.cust_city)
FROM sales S, products P, customers C
WHERE S.prod_id = P.prod_id
AND S.cust_id = C.cust_id
LOCAL;


-- query from the fact table is less cost than the dimension table 
SELECT DISTINCT S.channel_id
FROM sales S, products P, customers C
WHERE S.prod_id = P.prod_id
AND S.cust_id = C.cust_id
AND C.cust_city = 'Manchester';



SELECT COUNT(*)
FROM sales S, products P, customers C
WHERE S.prod_id = P.prod_id
AND S.cust_id = C.cust_id
AND C.cust_city = 'Manchester';



DROP INDEX sales_temp_bjx;

ALTER TABLE customers ENABLE NOVALIDATE CONSTRAINT customers_pk;

ALTER TABLE products ENABLE NOVALIDATE CONSTRAINT products_pk;