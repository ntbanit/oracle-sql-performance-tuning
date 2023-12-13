/* A query without a hint. It performs a INDEX RANGE SCAN */
SELECT employee_id, last_name
  FROM employees e 
  WHERE last_name LIKE 'A%';
 
-- Using a hint to command the optimizer to use FULL TABLE SCAN  => COST MORE -> MISLEAD 
SELECT /*+ FULL(e) */ employee_id, last_name
  FROM employees e 
  WHERE last_name LIKE 'A%';
 
/* Using the hint with the table name as the parameter: MUST NOT USE ALIAS */
SELECT /*+ FULL(employees) */ employee_id, last_name
  FROM employees 
  WHERE last_name LIKE 'A%';
 
/* Using the hint with the table name while we aliased it => NO WORK : ignored  */  
SELECT /*+ FULL(employees) */ employee_id, last_name
  FROM employees e 
  WHERE last_name LIKE 'A%';
 
/* Using an unreasonable hint. The optimizer will NOT consider this hint  :ignored 
EMP_DEPARTMENT_IX is on department_id => number BUT last_name have type varchar 
*/
SELECT /*+ INDEX(EMP_DEPARTMENT_IX) */ employee_id, last_name
  FROM employees e 
  WHERE last_name LIKE 'A%';
  
/* Using multiple hints. But they aim for the same area. So unreasonable. 
=> MULTI HINTS MUST TARGET ON MULTI RESOURCES 
-> optimizer choose ONE OF THEM or NOTHING  */
SELECT /*+ INDEX(EMP_NAME_IX) FULL(e)  */ employee_id, last_name
  FROM employees e 
  WHERE last_name LIKE 'A%'; -- there is no guarantee about which hint will be choosen
 
SELECT /*+ INDEX(EMP_NAME_IX) */ employee_id, last_name
  FROM employees e 
  WHERE last_name LIKE 'A%'; -- cost 2 ??? 
  
SELECT /*+ FULL(e) */ employee_id, last_name
  FROM employees e 
  WHERE last_name LIKE 'A%'; -- cost 3
  
SELECT employee_id, last_name
  FROM employees e 
  WHERE last_name LIKE 'A%'; -- INDEX RANGE SCAN cost 2 
 
 
/* When we change the order of the hints. But it did not change the Optimizer's decision*/
SELECT /*+ FULL(e) INDEX(EMP_NAME_IX)   */ employee_id, last_name
  FROM employees e 
  WHERE last_name LIKE 'A%';
 
/* There is no hint. To see the execution plan to compare with the next one */  
SELECT  
  e.department_id, d.department_name, 
  MAX(salary), AVG(salary)
FROM employees e, departments d
WHERE e.department_id=e.department_id
GROUP BY e.department_id, d.department_name; 
-- select departments as driving table => COST 42
 
/* Using multiple hints to change the execution plan. Optinizer choose all of them cause it's reasonable*/
-- COST 223 
SELECT /*+ LEADING(e d)  INDEX(d DEPT_ID_PK) INDEX(e EMP_DEPARTMENT_IX)*/ 
  e.department_id, d.department_name, 
  MAX(salary), AVG(salary)
FROM employees e, departments d
WHERE e.department_id=e.department_id
GROUP BY e.department_id, d.department_name;

-- 2 paths: job_id & department_id 
-- no hint : INDEX RANGE SCAN, cost 2 
select employee_id, last_name from employees e where job_id = 'SA_MAN' and department_id < 90; 
-- hint use index on department -> cost 10 
select /*+ INDEX(e EMP_DEPARTMENT_IX) */employee_id, last_name from employees e where job_id = 'SA_MAN' and department_id < 90; 

-- no paths for the index => IGNORED cuz no reasonable! 
select /*+ INDEX(e EMP_DEPARTMENT_IX) */employee_id, last_name from employees e where job_id = 'SA_MAN' ; 

/* Using hints when there are two access paths. */  
SELECT /*+ INDEX(EMP_DEPARTMENT_IX) */ employee_id, last_name
  FROM employees e 
  WHERE last_name LIKE 'A%'
  and department_id > 120;
  
-- no hint to compare : cost 2
SELECT employee_id, last_name
  FROM employees e 
  WHERE last_name LIKE 'A1%'
  and department_id > 120;
 
/* When we change the selectivity of last_name search, it did not consider our hint.*/
SELECT /*+ INDEX(EMP_DEPARTMENT_IX) */ employee_id, last_name
  FROM employees e 
  WHERE last_name LIKE 'Al%'
  and department_id > 120;
 
/* Another example with multiple joins, groups etc. But with no hint*/ -- cost : 871 
SELECT customers.cust_first_name, customers.cust_last_name, 
  MAX(QUANTITY_SOLD), AVG(QUANTITY_SOLD)
FROM sales, customers
WHERE sales.cust_id=customers.cust_id
GROUP BY customers.cust_first_name, customers.cust_last_name;
 
/* Performance increase when performing parallel execution hint*/ -- cost : 243 
SELECT /*+ PARALLEL(4) */ customers.cust_first_name, customers.cust_last_name, 
  MAX(QUANTITY_SOLD), AVG(QUANTITY_SOLD)
FROM sales, customers
WHERE sales.cust_id=customers.cust_id
GROUP BY customers.cust_first_name, customers.cust_last_name;
-- when write 100, it not mean that it will up to 100 times cause have additional cost to join the results 
-- write 100 => will be slower 


SELECT /*+ INDEX(e EMP_EMP_ID_PK) */ employee_id, last_name, department_id
  FROM employees e
  where e.employee_id > 120
  and last_name like 'A%';
  

SELECT  employee_id, last_name, department_id
  FROM employees e
  where e.employee_id > 120
  and last_name like 'A%';

/*
Q: Why this hint usage is not efficient? (but still, the optimizer choose it cause it is reasonable) 
A: This index is not very selective for the employee_id > 120 predicate. Instead, last_name like 'A%' is more selective because there are few people starting with A. So, if we wouldn't force the optimizer to use EMP_ID_PK index, it would use the EMP_NAME_IX index with index range scan, so that it would perform much better.
*/