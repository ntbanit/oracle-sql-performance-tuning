/** OUTER JOIN -> left / right / outer join . can use with all join methods 
- with nested loop, the inner table (second table to join) is the one whose non matching rows will return 
- with hash join, hash table is built for the one matching rows will NOT return 
*/

select * from employees e right outer join departments d using(department_id);


select * from employees e left outer join departments d using(department_id);


select /*+ use_merge(e d) */* from employees e left outer join departments d using(department_id);

select /*+ use_nl(e d) */* from employees e left outer join departments d using(department_id);

select /*+ use_nl(e d) */* from employees e right outer join departments d using(department_id);



select * from employees e full outer join departments d using(department_id);

select * from employees e, departments d where e.department_id = d.department_id(+);
-- same as the query below 
-- select * from employees e left join departments d using (department_id) 
