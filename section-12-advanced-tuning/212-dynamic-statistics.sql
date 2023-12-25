/** DYNAMIC STATISTIC (DYNAMIC SAMPLING)
-> statistic gather before create query 

why and when 
- statistic problems 
- parallel execution 
- SQL plan directive 

*/

ALTER SYSTEM FLUSH SHARED_POOL;
 
 
CREATE TABLE customers_temp AS SELECT * FROM customers;
CREATE INDEX cost_prov_ix ON customers_temp(cust_city,cust_state_province);
 
SELECT /*+ GATHER_PLAN_STATISTICS */ * FROM customers_temp
WHERE cust_city='Los Angeles' AND cust_state_province='CA';
 
SELECT * FROM TABLE(dbms_xplan.display_cursor(FORMAT => 'allstats last'));
 
SELECT /*+ GATHER_PLAN_STATISTICS dynamic_sampling(1) */ * FROM customers_temp
WHERE cust_city='Los Angeles' AND cust_state_province='CA';
 
SELECT /*+ GATHER_PLAN_STATISTICS dynamic_sampling(4) */ * FROM customers_temp
WHERE cust_city='Los Angeles' AND cust_state_province='CA';
 
SELECT /*+ GATHER_PLAN_STATISTICS dynamic_sampling(7) */ * FROM customers_temp
WHERE cust_city='Los Angeles' AND cust_state_province='CA';
 
SELECT /*+ GATHER_PLAN_STATISTICS dynamic_sampling(10) */ * FROM customers_temp
WHERE cust_city='Los Angeles' AND cust_state_province='CA';
 
SELECT /*+ GATHER_PLAN_STATISTICS dynamic_sampling(11) */ * FROM customers_temp
WHERE cust_city='Los Angeles' AND cust_state_province='CA';
 
DROP TABLE customers_temp;
 
-- The dynamic sampling levels and their meanings
-- https://docs.oracle.com/database/121/TGSQL/tgsql_astat.htm#TGSQL451