/** BITMAP INDEX => fit with low selectivity index 
- leaf structure of bitmap index 
    + key
    + start rowid & end rowid (intervals) 
    + bitmap column 
        . save 0 and 1 sequencely 
- benefits 
    + work faster BTree for large results 
    + less disk space than BTree 
        . only store 1 distinct value & bits for each row in 1 leaf 
        . store intervals 
        . store bitmaps compressed 
    + more efficient when the query contains multi conditions 
    + can be use for parallel DML or parallel queries 
    + indexes the NULL values 
    + bitmap join indexes for multi table read 
    
- others infors : 
    + easier to remove & re-create than maintain 
    + suited for data warehouse 
        . B-Tree suited for OLTP 
    + low selectivity is better for bitmap indexs (example : gender : F /M)
    + must select global or local index partitioning carefully 
        . global have 1-to-many relationship on partitions 
            .. 1 index -> multi partitions (range / hash / parrell on multi partitions) 
        . local have 1-to-1 relationship on partition 
            .. can NOT range / hash multi partitions with 1 index 
*/
-- B-Tree 
-- table access full
SELECT * FROM employees WHERE department_id IS NOT NULL;
-- index full scan  
SELECT department_id FROM employees WHERE department_id IS NOT NULL; 
-- table access full
SELECT department_id FROM employees WHERE department_id IS NULL;
 
-- Bit map : 
-- full table scan 
SELECT * FROM customers WHERE cust_marital_status IS NOT NULL;
-- fast full scan 
SELECT cust_marital_status FROM customers WHERE cust_marital_status IS NOT NULL;
-- single value 
SELECT cust_marital_status FROM customers WHERE cust_marital_status IS NULL;
-- single value 
SELECT COUNT(cust_marital_status) FROM customers WHERE cust_marital_status IS NULL;
 
CREATE TABLE customers_temp AS SELECT * FROM customers;
 
-- b tree
CREATE INDEX cust_mar_stat_ix ON customers_temp(cust_marital_status);
-- full table scan cost 400
SELECT /*+ FULL(ct) */* FROM customers_temp ct WHERE cust_marital_status = 'married';
-- b tree index: cost 300
SELECT * FROM customers_temp WHERE cust_marital_status = 'married';
 

CREATE INDEX cust_gender_ix ON customers_temp(cust_gender);
-- full table scan
SELECT * FROM customers_temp WHERE cust_gender = 'M';
-- index in cust_marital_status only 
SELECT * FROM customers_temp WHERE cust_gender = 'M' AND cust_marital_status = 'married';
 
DROP INDEX cust_gender_ix;
DROP INDEX cust_mar_stat_ix;
 
-- bit map index 
CREATE BITMAP INDEX cust_mar_stat_bix ON customers_temp(cust_marital_status);
-- bit map tree index: cost 400 => b tree is better than bit map in this case 
SELECT * FROM customers_temp WHERE cust_marital_status = 'married';
 
CREATE BITMAP INDEX cust_gender_bix ON customers_temp(cust_gender);
 
SELECT * FROM customers_temp WHERE cust_gender = 'M';
-- index in both column : cost 273 
SELECT * FROM customers_temp WHERE cust_gender = 'M' AND cust_marital_status = 'married';
 
DROP TABLE customers_temp;