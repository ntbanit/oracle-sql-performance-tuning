/** MINUS operator 
A minus B 
-> get tresult like UNION,
but only get the result which have in A but not in B  
-> need to sort both row sources 
*/


SELECT employee_id FROM employees where employee_id between 145 and 179
MINUS
SELECT employee_id FROM employees WHERE first_name LIKE 'A%';
 
-- similar to INTERSECT, if we can use NOT EXISTS, it will more faster than MINUS 
SELECT employee_id FROM employees e where employee_id between 145 and 179
and not exists
(SELECT employee_id FROM employees t WHERE first_name LIKE 'A%' and e.employee_id = t.employee_id);