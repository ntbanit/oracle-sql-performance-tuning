select * from sales ;

select * from sales where amount_sold > 1770;

select * from employees where employee_id < 200; 

select * from employees ;
select count(*) from employees ;

select count(*) from employees where employee_id < 200; 

select * from employees e join departments d on e.employee_id = d.manager_id ;

select * from employees e join departments d using (DEPARTMENT_ID);