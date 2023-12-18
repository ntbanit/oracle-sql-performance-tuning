/** A query cover all column of the index => covering index 
- benefit 
    + no need to look up the data in table 
    + less I/O 
- draw back  : 
    + increase the index size 
    + will be used for fewer queries 
    + maintain cost incresase 

*/

CREATE TABLE sales_temp AS SELECT * FROM sales;
 
CREATE INDEX sales_idx ON sales_temp(prod_id,cust_id,time_id);
-- INDEX RANGE SCAN 
SELECT prod_id,cust_id FROM sales_temp
WHERE prod_id = 13;
 
SELECT prod_id,cust_id,time_id FROM sales_temp
WHERE prod_id = 13;

-- TABLE ACCESS FULL 
SELECT prod_id,cust_id,time_id,amount_sold FROM sales_temp
WHERE prod_id = 13;
 
DROP INDEX sales_idx;
CREATE INDEX sales_idx ON sales_temp(prod_id,cust_id,time_id,amount_sold);
 
SELECT prod_id,cust_id,time_id,amount_sold FROM sales_temp
WHERE prod_id = 13;
 
DROP TABLE sales_temp;