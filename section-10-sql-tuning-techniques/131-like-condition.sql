-- BAD 
select employee_id, first_name, last_name, salary from employees
where last_name like '%on';
-- BAD  
select employee_id, first_name, last_name, salary from employees
where last_name like '%on%';
-- Good -> trigger index 
select employee_id, first_name, last_name, salary from employees
where last_name like 'Ba%';


-- try to reverse index in case search multi time with ending word 
create index last_name_reverse_index on employees(REVERSE(last_name));
-- the key word must reverse too 
select employee_id, first_name, last_name, reverse(last_name), salary
from employees
where reverse(last_name) like 'rahh%'; 
 
drop index last_name_reverse_index;