/*RESULT CACHE OPERATOR -> get the result from the cache in SGA
- to ways to store results in cache 
    + MANUAL (DEFAULT - need result_cache hint to store and get from cache )
    + FORCE (no_result_cache hint is used not to store in the result cache) => BAD choice cause the cache is small 
- DBMS_RESULT_CACHE -> package for DBA 
- V$RESULT_CACHE_OBJECTS -> view has result cache data
- table annotations (annotations = metadata) can be used as default storage option to the result cache
Examples of annotations: (can use when CREATE TABLE too 
ALTER TABLE ORDERS CLUSTER(customer_id); --(Clusters the orders table by the customer_id column)
ALTER TABLE USERS RESULT_CACHE (MODE FORCE); --(Forces the optimizer to use the result cache for queries on the users table)
ALTER TABLE PRODUCTS ADD COMMENT='List of available products'; --(Adds a comment describing the products table)
hints is >>> annotation 

*/

-- flush result cache to test 
exec dbms_result_cache.flush ;
select * from V$RESULT_CACHE_OBJECTS;

select cust_id, avg(amount_sold) from sales group by cust_id order by cust_id ;

select /*+ result_cache */ cust_id, avg(amount_sold) from sales group by cust_id order by cust_id ;
-- different from above and dont have in result cache (another ahsh key based on query string)
select /*+ result_cache */ cust_id, min(amount_sold), avg(amount_sold) from sales group by cust_id order by cust_id ;

 -- DEFAULT
select result_cache from user_tables where table_name='SALES';

alter table sales result_cache(mode force);
-- force to save result to cache . if have more table in query, ALL tables need this annotation
select cust_id, max(amount_sold) from sales group by cust_id order by cust_id ;

alter table sales result_cache(mode default);

