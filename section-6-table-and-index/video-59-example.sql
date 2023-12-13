-- INDEX FULL SCAN

-- ORDER BY 
select * from departments order by department_id ;

-- when an index use multi columns
-- YOU ALREADY KNOW WHY ! 
-- CREATE INDEX "HR"."EMP_NAME_IX" ON "HR"."EMPLOYEES" ("LAST_NAME", "FIRST_NAME") 
select last_name, first_name from employees order by last_name; -- NO SORT 
select last_name, first_name from employees order by first_name; -- IT WILL SORT 
-- similar : order by last_name, first_name => NO SORT 
-- similar : order by first_name, last_name => SORT 

-- use right order with some unindexed one => TABLE ACCESS FULL then SORT
-- but the cost really small , cause you only have to sort value of the salary with have SAME LAST_NAME 
select last_name, first_name from employees order by last_name, salary ;   

select last_name, first_name, salary from employees order by last_name, salary ;   

-- in this case, optimizer choose  TABLE ACCESS FULL as a better access path 
select * from employees order by  last_name, first_name ; 

-- GROUP BY on non index column => FULL TABLE SCAN 
select salary, count(*) from employees e where salary is not null group by salary; 

-- GROUP BY on an index column => INDEX FULL SCAN 
select department_id, count(*) from employees where department_id is not null group by department_id ;
select department_id, count(*) from employees group by department_id ; -- FULL TABLE SCAN cause it have some NULL value !! 

-- GROUP BY multi columns in multi indexes may prevent INDEX FULL SCAN 
select department_id, manager_id, count(*) from employees e
where department_id is not null and manager_id is not null 
group by department_id, manager_id ;

-- SORT MERGE JOIN 
select * from employees e join departments d using (department_id); -- cost 6 

select employee_id, last_name, first_name, department_id, department_name
from employees e join departments d using (department_id); -- cost 6 
