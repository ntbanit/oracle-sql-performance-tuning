/**COMBINE BITMAP INDEX
-> index useful when have multi conditions (AND,OR..) cause it merge quickly 
*/

CREATE TABLE customers_temp AS SELECT * FROM customers;
 
CREATE INDEX cust_city_ix ON customers_temp(cust_city);
CREATE INDEX cust_name_ix ON customers_temp(cust_first_name,cust_last_name);
 
-- index range scan: cost 338 
SELECT * FROM customers_temp WHERE cust_city IN ('Aachen','Abingdon','Bolton','Santos');
-- table access full: cost 405
SELECT * FROM customers_temp WHERE cust_city IN ('Aachen','Abingdon','Bolton','Santos','Barry','Westminster','Tilburg');
-- bitmap conversion : cost 7
SELECT * FROM customers_temp WHERE cust_city IN ('Aachen','Abingdon','Bolton','Santos') AND cust_first_name = 'Abigail';
-- force use b-tree index: index range scan: cost 9 
SELECT /*+ index(c cust_name_ix, cust_name_ix)*/* FROM customers_temp C WHERE cust_city IN ('Aachen','Abingdon','Bolton','Santos') AND cust_first_name = 'Abigail';
 
DROP INDEX cust_city_ix;
DROP INDEX cust_name_ix;
CREATE BITMAP INDEX cust_city_bix ON customers_temp(cust_city);
CREATE BITMAP INDEX cust_name_bix ON customers_temp(cust_first_name,cust_last_name);

-- bitmap conversion : cost 81 
SELECT * FROM customers_temp WHERE cust_city IN ('Aachen','Abingdon','Bolton','Santos');
-- bitmap conversion : cost 133
SELECT * FROM customers_temp WHERE cust_city IN ('Aachen','Abingdon','Bolton','Santos','Barry','Westminster','Tilburg');
-- bitmap conversion : cost 6
SELECT * FROM customers_temp WHERE cust_city IN ('Aachen','Abingdon','Bolton','Santos') AND cust_first_name = 'Abigail';
 
DROP TABLE customers_temp;