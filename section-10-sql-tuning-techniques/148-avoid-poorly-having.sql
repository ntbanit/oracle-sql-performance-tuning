/** WARNING to POORLY query for HAVING :

*/
-- BAD : FULL TABLE SCAN 
select time_id,sum(amount_sold) from sales
group by time_id
having time_id between '01-JAN-01' and '28-FEB-01';
 
-- GOOD 
select time_id,sum(amount_sold) from sales
where time_id between '01-JAN-01' and '28-FEB-01'
group by time_id;

-- BAD : FULL TABLE SCAN 
select prod_id,sum(amount_sold) from sales
group by prod_id
having prod_id = 136;
 
-- GOOD : INDEX trigger 
select prod_id,sum(amount_sold) from sales
where prod_id = 136
group by prod_id;