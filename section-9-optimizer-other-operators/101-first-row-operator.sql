/** FIRST ROW operator -> when use min max of a indexed column 
use with INDEX RANGE SCAN  
*/
--  FIRST ROW after INDEX RANGE SCAN 
select min(employee_id) from employees where employee_id < 140;
 
select max(employee_id) from employees where employee_id < 140;


-- INDEX FULL SCAN -> then use SORT AGGREGATE 
select min(employee_id) from employees;
 
-- same as above 
select min(employee_id), max(employee_id) from employees where employee_id < 140;

-- SORT AGGREGATE after TABLE ACCESS FULL cau the column is not index 
select min(commission_pct) from employees where commission_pct < 0.1;