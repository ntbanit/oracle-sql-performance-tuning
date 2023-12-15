/** FUNCTION can PREVENT index 
*/
-- btree index 
create index emp_date_temp_idx on employees (hire_date) compute statistics;
-- BAD
select employee_id, first_name, last_name
from employees where trunc(hire_date,'YEAR') = '01-JAN-2002';

-- GOOD 
-- BUT STILL TABLE ACCESS FULL CAUSE SELECTIVITY IS SO HIGH 
select employee_id, first_name, last_name
from employees where hire_date between '01-JAN-2002' and '31-DEC-2002';
-- count = 7 
select count(*) from employees where hire_date between '01-JAN-2002' and '31-01-2002';
-- count = 107 
select count(*) from employees;
 
drop index emp_date_temp_idx;
 
select prod_id,prod_category,prod_subcategory from products
where substr(prod_subcategory,1,2) = 'Po';
 
select prod_id,prod_category,prod_subcategory from products
where prod_subcategory like 'Po%';