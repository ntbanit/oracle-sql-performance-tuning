/** Analytical Functions 
Analytical Functions in Oracle: Understanding with Examples
Oracle's analytical functions enable calculations that analyze data within a set, providing deeper insights without complex joins or subqueries. 
They operate on a group of rows and return a single value for each row based on the entire group.

Types of Analytical Functions:

- Window Functions: Apply calculations over a defined window of rows (e.g., preceding, following, entire partition).
Examples: ROW_NUMBER(), RANK(), PERCENTILE_CONT(), SUM(salary) OVER (PARTITION BY department).
- Aggregate Functions with Window Clauses: Enhance traditional aggregates like SUM or COUNT with window definitions.
Examples: SUM(salary) OVER (ORDER BY hire_date), COUNT(*) OVER (ROWS 10 PRECEDING).
- Set Functions: Perform calculations based on the entire result set or a specific group.
Examples: FIRST_VALUE(name) OVER (ORDER BY salary DESC), AVG(salary) WITHIN GROUP (ORDER BY department).
*/ 
select e1.employee_id, e1.first_name, e1.last_name, 
       e1.department_id, e1.salary, e3.next_sal, e2.avg_sal
from employees e1,
    (select department_id, round(avg(salary),2) as avg_sal from employees
     group by department_id) e2,
    (select employee_id, salary next_sal from employees) e3
where e1.department_id = e2.department_id(+)
and e1.employee_id+1 = e3.employee_id(+)
order by e1.employee_id;
 
select employee_id, first_name, last_name, department_id, salary, 
       lead(salary,1) over (order by employee_id) next_sal,
       round(avg(salary) over (partition by department_id),2) as avg_sal
from employees
order by employee_id;