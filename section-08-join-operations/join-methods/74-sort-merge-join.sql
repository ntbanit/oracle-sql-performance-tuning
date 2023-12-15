-- SORT MERGE JOIN EXAMPLE 
select * from employees e join departments d using (department_id) where last_name like 'K%';

-- my example: try to add more sort => still the same cause sort the index one 
select last_name, department_id
from employees e join departments d using (department_id) where last_name like 'K%' order by department_id desc;

-- force NESTED LOOP => cost more 
select /*+ use_nl(e d)*/* from employees e join departments d using (department_id) where last_name like 'K%'; 

-- another SORT MERGE JOIN EXAMPLE 
select * from employees e join departments d on d.department_id = e.department_id where d.manager_id > 110;
-- NESTED LOOP will faster => can use "index" on department_id column of table employee (EMP_DEPARTMENT_IX) then table access by id 
select * from employees e join departments d on d.department_id = e.department_id where d.manager_id = 110; 
-- force to use sort merge => cost more cause it have to sort the employee "table" base on department_id then JOIN 2 "table" 
select /*+ use_merge(e d)*/* from employees e join departments d on d.department_id = e.department_id where d.manager_id = 110; 