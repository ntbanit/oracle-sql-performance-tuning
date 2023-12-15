-- adding a different column than index has will prevent the INDEX FAST FULL SCAN 
select employee_id, first_name, department_id, department_name
from employees e join departments d using (department_id); 

-- if all columns are indexed it may perform INDEX FAST FULL SCAN 
select employee_id, department_id, department_name
from employees e join departments d using (department_id); 
 -- ?? department_name is not indexed btw 
 -- => THE REASON is departments is THE DRIVE TABLE and employees is THE JOIN TABLE !  

-- INDEX FAST FULL SCAN  can be applied to BITMAP index too 
-- even if there is an order by here, it used IFF Scan 
select prod_id from sales order by prod_id ;

-- optimizer thinks IF Scan is better here 
select time_id from sales order by time_id ;

-- IFF SCAN HERE  
select time_id from sales ;