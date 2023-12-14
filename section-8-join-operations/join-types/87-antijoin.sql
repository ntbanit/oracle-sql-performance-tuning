/**ANTI-JOIN : return the rows N OT match in NOT IN or NOT EXISTS 
- be default use with SORT MERGE join
*/

select * from departments d where department_id not in (select department_id from employees e where d.department_id = e.department_id);
select * from departments d where not exists (select 1 from employees e where d.department_id = e.department_id);

--use hash anti join 
select /*+ HASH_AJ*/ * from departments d where not exists (select 1 from employees e where d.department_id = e.department_id);

-- the right hint placed 
select * from departments d where not exists (select /*+ HASH_AJ*/1 from employees e where d.department_id = e.department_id);

/* not good => be transformed to select * from employees e where department_id is null */
select * from employees e where not exists (select 1 from departments d where d.department_id = e.department_id);
