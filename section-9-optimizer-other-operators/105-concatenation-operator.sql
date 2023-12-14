/**CONCATENATION : concat 2 row sources -> DO remove duplicate 

LNNVL -> remove duplicate ones 
*/

select * from employees where employee_id = 103 or department_id = 80;
 
-- hint to force 
select /*+ use_concat */* from employees where employee_id = 103 or department_id = 80;