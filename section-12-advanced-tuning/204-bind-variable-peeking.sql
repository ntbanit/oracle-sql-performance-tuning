/*** unexpected effect when use bind variable :
- optimizer use same plan of first one for second one ... to eliminate hard parse 
    -> however maybe the first one's plan is NOT optimal for the second 
        -> do not use bind variable when cardinality is very different between each values 
*/

CREATE TABLE customers_temp AS SELECT * FROM customers;
 
SELECT COUNT(*),cust_credit_limit FROM customers_temp 
GROUP BY cust_credit_limit
ORDER BY COUNT(*);
 
DELETE FROM customers_temp WHERE cust_credit_limit = 15000 AND ROWNUM < 1860;
COMMIT;
 
CREATE INDEX c_temp_ix ON customers_temp(cust_credit_limit);
 
BEGIN 
    dbms_stats.gather_table_stats(ownname => 'SH', tabname => 'CUSTOMERS_TEMP',
    method_opt  => 'for columns size 254 CUST_CREDIT_LIMIT', CASCADE=>TRUE);
END;
 
SELECT * FROM customers_temp WHERE cust_credit_limit = 1500;
SELECT * FROM customers_temp WHERE cust_credit_limit = 15000;
 
SELECT * FROM customers_temp WHERE cust_credit_limit = :b;
 
DROP TABLE customers_temp;