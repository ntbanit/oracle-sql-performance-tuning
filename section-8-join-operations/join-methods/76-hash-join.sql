/*
-- HASH JOIN EXAMPLE 
hash only work in EQUAL JOIN. hash index are supported 

STATISTICS COLLECTOR -> adaptive one : update statistic & update plan based on new statistic
*/


-- grant permission for hr user to use autotrace 
grant select_catalog_role to hr; 
grant select any dictionary to hr; 
-- cost 4 
select * from employees e join departments d on d.department_id = e.department_id where d.manager_id = 110; 
-- cost 6
select /*+ use_hash(d e)*/ * from employees e join departments d on d.department_id = e.department_id where d.manager_id = 110;