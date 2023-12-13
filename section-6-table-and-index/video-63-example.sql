-- INDEX SKIP SCAN 
-- index (last_name, first_name)
select * from employees where first_name = 'Britney' ;
-- INDEX RANGE SCAN 
select * from employees where last_name = 'King' ;

-- using index skip scan with adding a new index 
select * from employees where salary between 6000 and 7000 ;

create index dept_sal_ix on employees (department_id, salary) ;
drop index dept_sal_ix;



-- ??? using index skip scan with adding a new index.
-- ??? this time the cost increases significantly 
alter index customers_yob_bix invisible ;
select * from customers where cust_year_of_birth between 1989 and 1990 ;
create index customers_gen_dob_ix on customers(CUST_GENDER, cust_year_of_birth);  -- NO CHANGE ???
drop index customers_gen_dob_ix ;
alter index customers_yob_bix visible ;

select count(*) from customers where cust_year_of_birth between 1989 and 1990 ;
select count(*) from customers ;