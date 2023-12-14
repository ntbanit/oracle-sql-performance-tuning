/** FILTER operation 
-> filter data return from a row source 
*/

select min(salary),department_id from employees 
group by department_id 
having min(salary) < 10000;