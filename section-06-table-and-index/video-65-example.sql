-- INDEX JOIN SCAN with 2 indexes 
SELECT employee_id, email from employees ;

-- INDEX JOIN SCAN with 2 indexes, but with INDEX RANGE SCAN incldued
SELECT last_name, email from employees where last_name like 'B%' ;


-- INDEX JOIN SCAN is NOT performes when add ROWID 
SELECT rowid, employee_id, email from employees ;