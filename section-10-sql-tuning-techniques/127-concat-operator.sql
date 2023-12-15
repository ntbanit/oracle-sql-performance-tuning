select first_name, last_name, employee_id, salary from employees 
where first_name||last_name = 'StevenKING';

-- remove concat to trigger index 
-- should AVOID CONCAT index column 
select first_name, last_name, employee_id, salary from employees 
where first_name = 'Steven' and last_name = 'KING';