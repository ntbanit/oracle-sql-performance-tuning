/** DATA TYPE MISMATCH -> can effect a lot 
if want to converse, do it with the compared value 
*/
-- GOOD : can trigger index 
SELECT cust_id, cust_first_name, cust_last_name FROM customers WHERE cust_id = 3228;
-- BAD. but the optimizer can handle it 
SELECT cust_id, cust_first_name, cust_last_name FROM customers WHERE cust_id = '3228';


CREATE INDEX cust_postal_code_idx ON customers (cust_postal_code);
-- BAD : FULL TABLE SCAN 
SELECT cust_id, cust_first_name, cust_last_name FROM customers WHERE cust_postal_code = 60332;
-- GOOD -> INDEX RANGE SCAN 
SELECT cust_id, cust_first_name, cust_last_name FROM customers WHERE cust_postal_code = '60332';
 -- exactly same with the BAD one above 
SELECT cust_id, cust_first_name, cust_last_name FROM customers WHERE to_number(cust_postal_code) = 60332;
 
DROP INDEX cust_postal_code_idx;