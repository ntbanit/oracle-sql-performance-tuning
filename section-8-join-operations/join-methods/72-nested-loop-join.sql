-- NESTED LOOP JOIN EXAMPLE 
-- cost 2
select * from employees e join departments d using(department_id) where department_id = 60;

-- use LEADING hint to change driving table 
-- cost 7 
select /*+ leading(e) */ * from employees e join departments d using(department_id) where department_id = 60;

-- DONT use nested loop without hint 
-- cost 6 
select * from employees e join departments d using(department_id) ; 
-- hint to use nested loop
-- cost 6 (maybe more) 
select /*+ use_nl(e)*/ * from employees e join departments d using(department_id) ; 

-- nested loop prefetching and double nested loops example : read index multi time but read table just one 
/** prefetch: means first, read all rowid of index and if fetch missing column from table  by reading array of blocks by the array of index rowid
meaning read multi blocks simultaneously -> faster. It happnen when INDEX RANGE SCAN in INNER row source 
*/
select employee_id, last_name, department_id, department_name
from employees e join departments d using(department_id)
where department_name like 'A%';