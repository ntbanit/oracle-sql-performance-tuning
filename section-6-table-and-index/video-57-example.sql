-- one side bounded : BITMAP index range scan 
select * from sales where time_id > to_date('01-NOV-01','DD-MON-RR');

-- both sides bounded : BITMAP index range scan 
select * from sales where time_id between to_date('01-NOV-01','DD-MON-RR') and to_date('05-NOV-01','DD-MON-RR');

-- B-TREE index range scan 
select * from employees where employee_id > 190 ;

-- non-unique index range scan 
select * from employees where department_id > 80 ;

-- order by with the indexed column - sort is processed if use another column other than predicates 
select * from employees where employee_id > 190 order by email; -- email also indexed 
select * from employees where department_id > 80 order by employee_id; 

-- order by with the indexed column - sort is NOT processed if use same column in predicates
select * from employees where employee_id > 190 order by employee_id; 
select * from employees where employee_id < 190 ;
select * from employees where department_id > 80 order by department_id desc; 

-- index range scan with wildcard 
select * from products where prod_subcategory like 'Accessories%';-- triggered 
select * from products where prod_subcategory like '%Accessories';-- FULL TABLE SCAN 
select * from products where prod_subcategory like 'A_cessories%';-- triggered 