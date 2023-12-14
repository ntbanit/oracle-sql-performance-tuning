/** SEMIJOIN : returns the first match => fast 
- is the way transforming the EXISTS subquery into a join (but some time optimizer dont choose SEMIJOIN for EXISTS)
- use EXISTS instead of IN if possible 
*/
select * from departments d where exists (select 1 from employees e where d.department_id = e.department_id);
/* some kind similar => be transformed */
select * from departments d where department_id in (select department_id from employees e where d.department_id = e.department_id);
/* not good => be transformed to select * from employees e where department_id is not null */
select * from employees e where exists (select 1 from departments d where d.department_id = e.department_id);
