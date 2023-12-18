/** COMPOSITE INDEX  = CONCATNATED INDEX 
- multi column in 1 index 
- advantages 
	+ higher selectivity 
	+ less I/O 
	+ can be used for 1 or multi column 
	
- example : first_name , last_name, job_id 
	+ predicate: first_name & job_id 
		. check selectivity of first_name 
			.. if high selectivity => because it is not consecutive 
				...INDEX RANGE SCAN on first_name
				..._then filter job_id
	+ predicate : last_name -> maybe full scan or index skip scan 

- select column order is important ! I KNEW IT WHY ! 
- choose order of mostly queried and most selective ! 
*/ 


CREATE TABLE sales_temp AS SELECT * FROM sales;
 
CREATE INDEX sales_idx ON sales_temp(prod_id,cust_id,time_id);
-- index range scan  
SELECT * FROM sales_temp WHERE prod_id = 13 AND cust_id = 2380 AND time_id = '10-JUL-98';
 
SELECT * FROM sales_temp WHERE prod_id = 13 AND cust_id = 2380;

SELECT * FROM sales_temp WHERE prod_id = 13 AND time_id = '10-JUL-98';
-- index skip scan  
SELECT * FROM sales_temp WHERE cust_id = 2380 AND time_id = '10-JUL-98';
 
-- reorder index to test performance 
DROP INDEX sales_idx;
CREATE INDEX sales_idx ON sales_temp(cust_id,prod_id,time_id);
 
SELECT * FROM sales_temp WHERE cust_id = 2380 AND time_id = '10-JUL-98';
 
DROP TABLE sales_temp;