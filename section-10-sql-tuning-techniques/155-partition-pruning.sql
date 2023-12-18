/** PARTITION PRUNING 
- FULL TABLE SCAN WHEN LOW SELECTIVITY  
=> create PARTITION can increase performance
- How ? 
    + by select directly frin partition name 
    + add predicates including partition keys  
*/ 

create table sales_temp as select * from sales;
 
select sum(amount_sold) from sales_temp where time_id between '01-JAN-01' and '31-DEC-03';

-- decide which partition will run in runtime -> dynamic  
select sum(amount_sold) from sales where time_id between '01-JAN-01' and '31-DEC-03';
 
drop table sales_temp;