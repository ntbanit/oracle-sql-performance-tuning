/** INDEX-ORGANIZED TABLE (IOT) 

- Idea: 
    + add all the column need to the index 
    + kind of improved version of ordinary B-tree indexes 
    + store non-key column in index leaves 

- feature 
    + store the rows in order of PK values 
    + reads faster than the ordinary indexes over the PK values 
    + the changes are only over the index (since there is no table)
    + less store (no duplicate data in index & table) 
    + other feature like normal tables 
    
- disadvantages :
    + can NOT create bitmap index 
    + needs to have a unique primary key (isn't it normal thing ?? ) 
    + can have max 100 columns (255 in index portion - rest in the overflow segment)
    + PK can have max 32 columns 
    + can not contain virtural column 
    + PCTTHRESHOLD can not be larger than 50% of the index block size 
    + faster in updates but slower in inserts 
    + no physical ROWID, only logical
    + slower when create secondary index 
    
- when to use : must to test 
    + if WHERE mostly have PK but SELECT have other column as well 
    + queries returning small number of rows 
    + data is not so often changing (look up table) 
    + do not need additional indexes over the IOTs 
    + small count in row count and column count
    + if an index already need the majority of columns 
    
*/
CREATE TABLE customers_temp AS
SELECT cust_id,cust_first_name,cust_last_name,cust_gender,cust_year_of_birth,
cust_marital_status,cust_postal_code,cust_city_id,cust_credit_limit FROM customers;
 
CREATE INDEX cus_ix ON customers_temp(cust_id);

/** how to create  ??
ORGANIZATION INDEX -> must have 
TABLESPACE -> if want to have a different table space than default 
PCTTHRESHOLD -> max length of a row in the index block size 
    example : PCTTHRESHOLD 40 -> can not exceed 40% of the index block size 
OVERFLOW TABLESPACE -> if exceed, store in this tablespace 
    example : 40% size can contains first 3 columns -> last 6 columns store here->  slower when get data in last 6 columns 
INCLUDING column_name -> store this column in index area (but if exceed threshold, some rows of it in overflow too) 
*/
CREATE TABLE customers_iot (cust_id NUMBER,
cust_first_name VARCHAR2(20),
cust_last_name VARCHAR2(40),
cust_gender CHAR(1),
cust_year_of_birth NUMBER(4,0),
cust_marital_status VARCHAR2(20),
cust_postal_code VARCHAR2(10),
cust_city_id NUMBER,
cust_credit_limit NUMBER,
CONSTRAINT cid_pk PRIMARY KEY (cust_id))
ORGANIZATION INDEX
PCTTHRESHOLD 40;
 
INSERT INTO customers_iot SELECT cust_id,cust_first_name,cust_last_name,cust_gender,cust_year_of_birth,
cust_marital_status,cust_postal_code,cust_city_id,cust_credit_limit FROM customers;
 
/
SELECT * FROM customers_temp WHERE cust_id = 47006;
SELECT * FROM customers_iot WHERE cust_id = 47006;
SELECT * FROM customers_temp WHERE cust_id BETWEEN 5000 AND 5050;
SELECT * FROM customers_iot WHERE cust_id BETWEEN 5000 AND 5050;
-- TABLE ACCESS FULL 
SELECT * FROM customers_temp WHERE cust_id BETWEEN 5000 AND 10000;
-- INDEX RANGE SCAN 
SELECT * FROM customers_iot WHERE cust_id BETWEEN 5000 AND 10000;
-- FULL TABLE SCAN : cost 109 
SELECT * FROM customers_temp WHERE cust_year_of_birth = 1978;
-- INDEX FAST FULL SCAN " cost 238 wow @@ 
SELECT * FROM customers_iot WHERE cust_year_of_birth = 1978;
 
DROP TABLE customers_temp;
DROP TABLE customers_iot;