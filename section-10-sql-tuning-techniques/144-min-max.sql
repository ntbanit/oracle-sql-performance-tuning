/**MIN MAX problem -> nuch better with B-TREE INDEX 
- even if have some LIMIT range, it stll really work well with low cost 
- if the query has multiple aggregate functions or another column, it will perform INDEX FULL SCAN or TABLE ACCESS FULL 
*/
-- do not have index -> FULL TABLE SCAN 
select max(CUST_STREET_ADDRESS) from customers;
-- BIT MAP INDEX -> SINGLE VALUE : still small cost : 17 
select max(cust_year_of_birth) from customers;
-- INDEX FAST FULL SCAN = same cost as above cause BITMAP INDEX is NOT sorted 
select cust_year_of_birth from customers;

-- B-TREE is SORT -> cost small : 2
select max(cust_id) from customers;
-- INDEX FAST FULL SCAN => cost 33 
select cust_id from customers;
-- INDEX RANGE SCAN -> cost : 4 
select cust_id from customers where cust_id < 1000;
-- INDEX RANGE SCAN  then FIRST ROW -> cost small : 2
select max(cust_id) from customers where cust_id < 1000;
-- same as MAX 
select min(cust_id) from customers;
-- COST 33 like INDEX FAST FULL SCAN when MULTI AGGREGATE FUNCTION 
select min(cust_id), max(cust_id) from customers;

SELECT MAX(cust_id), MAX(cust_id) FROM customers;

-- cost 4 -> more better 
select * from
 (select min(cust_id) min_cust from customers) min_customer,
 (select max(cust_id) max_cust from customers) max_customer;
 
-- try abother way : cost still 4 
select max(cust_id) value1 from customers
union all 
select min(cust_id) value1 from customers;
