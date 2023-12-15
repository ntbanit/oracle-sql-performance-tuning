-- prevent index 
SELECT prod_id,cust_id,time_id FROM sales WHERE time_id+10 = '20-JAN-98';

-- change to this to trigger index 
SELECT prod_id,cust_id,time_id FROM sales WHERE time_id = '10-JAN-98';
 
SELECT prod_id, cust_id, time_id FROM sales 
WHERE time_id = TO_DATE('20-JAN-98', 'DD-MON-RR')-10;