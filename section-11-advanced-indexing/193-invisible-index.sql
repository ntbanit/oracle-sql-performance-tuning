/** change index to invisile index to compare the cost -> safer than drop it
OPTIMIZER_USE_INVISIBLE_INDEXES parameter can be set to True

*/
create table customers_temp as select * from customers;
 
select * from customers_temp;
 
create index name_idx on customers_temp(cust_first_name,cust_last_name);
 
select * from customers_temp where cust_first_name = 'Arnold';
 
alter index name_idx invisible;
alter index name_idx visible;
 -- seem like B-Tree is better than bit map in this case 
create bitmap index name_bidx on customers_temp(cust_first_name,cust_last_name);
 
drop table customers_temp;