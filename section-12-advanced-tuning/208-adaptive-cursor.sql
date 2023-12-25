/* to use adaptive cursor -> need to gather statistics 
- bind-sensetive
- bind-aware query : check selectivity 

*/

ALTER SYSTEM FLUSH SHARED_POOL;


drop table customers_temp ;
 
CREATE TABLE customers_temp AS SELECT * FROM customers;
 
SELECT COUNT(*),country_id FROM customers GROUP BY country_id order by count(*);

CREATE INDEX cost_temp_country_id ON customers_temp(country_id);
 
BEGIN
dbms_stats.gather_table_stats(ownname => 'SH', tabname => 'CUSTOMERS_TEMP',
method_opt => 'for columns size 254 COUNTRY_ID', CASCADE=>TRUE);
END;
 
VARIABLE country_id NUMBER;
EXEC :country_id := 52787;
SELECT * FROM customers_temp WHERE country_id = :country_id;
EXEC :country_id := 52790;
SELECT * FROM customers_temp WHERE country_id = :country_id;
EXEC :country_id := 52770;
SELECT * FROM customers_temp WHERE country_id = :country_id;
EXEC :country_id := 52788;
SELECT * FROM customers_temp WHERE country_id = :country_id;
EXEC :country_id := 52790;
SELECT * FROM customers_temp WHERE country_id = :country_id;
 
SELECT * FROM TABLE(dbms_xplan.display_cursor(NULL,NULL,'TYPICAL +PEEKED_BINDS'));
 
SELECT sql_id,child_number,executions,loads,parse_calls,is_bind_sensitive,is_bind_aware,sql_text
FROM v$sql WHERE sql_text LIKE 'SELECT * FROM customers_temp WHERE country_id =%';

-- caculate selectivity and choose a plan properly
SELECT hash_value,sql_id,child_number,range_id,LOW,HIGH,predicate
FROM v$sql_cs_selectivity;
 
DROP TABLE customers_temp;