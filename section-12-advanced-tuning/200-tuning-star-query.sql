/**
STAR SCHEMA : the simplest data ware house schema 
    * it's called star schema cuz the relationships like a star 
        . in center, fact table : largest table or most important table 
        . other tables all connect with fact table 
    -> we call that's STAR QUERY cost $$ a lot cause there's many of join 

alter session set star_transformation_enabled = true;

*/


create table sales_temp as select * from sales;
create index sales_temp_pk on sales_temp (prod_id,cust_id,time_id,channel_id);
 
select sum(amount_sold) from sales_temp
where prod_id between 100 and 300
and cust_id between 100 and 300;
 
select sum(amount_sold) from sales_temp s, products p
where s.prod_id = p.prod_id 
and p.prod_id between 100 and 300
and s.cust_id between 100 and 300;
 
select /*+ index_rs ( sales_temp sales_temp_pk)*/sum(amount_sold) from sales_temp
where prod_id between 100 and 300
and cust_id between 100 and 300;
 
select c.cust_last_name,s.amount_sold, p.prod_name, c2.channel_desc
from sales s, products p, customers c, channels c2
where s.prod_id = p.prod_id
and s.cust_id = c.cust_id
and s.channel_id = c2.channel_id
and p.prod_id < 100
and c2.channel_id = 2
and c.cust_postal_code = 52773;
 
alter session set star_transformation_enabled = true;

-- COST MORE @@ 
select /*+ star_transformation fact(s)*/
c.cust_last_name,s.amount_sold, p.prod_name, c2.channel_desc
from sales s, products p, customers c, channels c2
where s.prod_id = p.prod_id
and s.cust_id = c.cust_id
and s.channel_id = c2.channel_id
and p.prod_id < 100
and c2.channel_id = 2
and c.cust_postal_code = 52773;
 
drop table sales_temp;