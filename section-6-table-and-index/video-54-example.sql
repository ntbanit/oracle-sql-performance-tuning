select * from sales where prod_id = 116 and cust_id = 100090 ;

create index prod_cust_idx on sales (prod_id, cust_id) ;
select prod_id, cust_id from sales where prod_id = 16 ;

select prod_id, cust_id, promo_id from sales where prod_id = 16 ;

drop index prod_cust_idx;