/** Usually UNION ALL is >>>> UNION cause no need to SORT 

*/

select prod_id, cust_id, time_id, amount_sold, channel_id from sales where channel_id = 3
union 
select prod_id, cust_id, time_id, amount_sold, channel_id from sales where channel_id = 4;


select prod_id, cust_id, time_id, amount_sold, channel_id from sales where channel_id = 3
union all 
select prod_id, cust_id, time_id, amount_sold, channel_id from sales where channel_id = 4;