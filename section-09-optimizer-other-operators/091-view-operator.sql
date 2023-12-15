/* VIEW OPERATOR 
- if some kind subquery can not merge, operator give it a name and shows that VIEW 
- it means that code block execute that this code block is executed as a seperate query block 

- VIEW MERGING means joining the inner query and the outer for a better performance 
- eventually, every inner query is VIEW operator when they can not be merged with the outer one 
*/

SELECT e.first_name, e.last_name, dept_locs_v.street_address,
       dept_locs_v.postal_code
FROM   employees e,
      ( SELECT d.department_id, d.department_name, 
               l.street_address, l.postal_code
        FROM   departments d, locations l
        WHERE  d.location_id = l.location_id ) dept_locs_v
WHERE  dept_locs_v.department_id = e.department_id
AND    e.last_name = 'Smith';
-- after run: no VIEW cause query transformer try to convert it to the below -> better  
 select e.first_name, e.last_name, l.street_address, l.postal_code
from employees e, departments d, locations l
where d.location_id = l.location_id
and d.department_id = e.department_id
and e.last_name = 'Smith';
 
-- hint to no merge to show VIEW operator : use in inner query 
-- PUSH MERGE PREDICATE : predicate of outer query is push into inner 
SELECT e.first_name, e.last_name, dept_locs_v.street_address,
       dept_locs_v.postal_code
FROM   employees e,
      ( SELECT /*+ NO_MERGE */ d.department_id, d.department_name, 
               l.street_address, l.postal_code
        FROM   departments d, locations l
        WHERE  d.location_id = l.location_id ) dept_locs_v
WHERE  dept_locs_v.department_id = e.department_id
AND    e.last_name = 'Smith';
 
-- no merge cause only need to group the inner query -> faster.
-- if merge : group the outer query too -> longer 
select v.*,d.department_name from (select department_id, sum(salary) SUM_SAL
from employees group by department_id) v, departments d 
where v.department_id=d.department_id;
 
-- VIEW operator in operation of explain plan is DIFFERENT from logical VIEW 
create view v as select department_id, salary from employees;
select department_id, salary from v;
-- equal to 
select department_id, salary from (select department_id, salary from employees);
 -- and can convert to 
select department_id, salary from employees;
drop view v;
 
-- a VIEW is just a query and no data in it 
create view v as select /*+ NO_MERGE */ department_id, salary from employees;

select department_id, salary from v;
-- it will seem like that from the database point for view 
select department_id, salary from (select /*+ NO_MERGE */ department_id, salary from employees);
 -- because of the NO_MERGE hint => can not transform to this query  
select department_id, salary from employees;
drop view v;
 
select * from ALL_TAB_MODIFICATIONS;