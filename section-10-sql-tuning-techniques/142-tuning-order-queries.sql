/** TUNING ORDERED QUERY => SORT problem 
- reason : SORT cost $$ 
    + ** SORT in disk is very COSTLY 
- handle ways :
    + create or modify B-Tree indexes including the column used in the order 
    + increase PGA size 
    + query only the indexed columns in the SELECT clause
    + restrict the returning rows
*/

select prod_id,cust_id,time_id from sales order by amount_sold;
-- a little better 
select prod_id,cust_id,time_id from sales order by cust_id;

select prod_id,cust_id,time_id from sales where cust_id < 100 order by cust_id;

-- BIT MAP INDEX, still NEED to SORT 
select cust_id from sales order by cust_id;
-- B-TREE INDEX NO NEED to SORT 
select cust_id from customers order by cust_id;

select cust_id,cust_first_name, cust_last_name from customers where cust_id < 100 order by cust_id;

select cust_id, cust_first_name, cust_last_name from customers order by cust_first_name;