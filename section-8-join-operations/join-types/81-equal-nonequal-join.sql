/* EQUAL JOIN => common type, can use all join methods (4) 
In equijoins, the sort merge join is not an efficient way. Because it first sorts the sources. And this increases the cost. And in equijoins, there is no need to sort. ? 
*/
select * from employees e, departments d where e.department_id = d.department_id;


/* NON EQUAL JOIN => non-common type, can NOT use hash join */
select * from employees e, jobs j where e.salary between j.min_salary and j.max_salary;