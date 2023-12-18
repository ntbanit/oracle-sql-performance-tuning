/**FUNCTION BASED INDEX -> store the results of the function for each row
- helpful when usually use the result of function 
- can use on multi column 
- restrictions: 
    + function needs to be deterministic 
        . can NOT use RANDOM .. 
    + can NOT use aggregate functions 
    + function needs to have a finxed-length data type 

*/
SELECT * FROM employees;
SELECT * FROM employees WHERE last_name = 'KING';
-- index rang scan after create new index 
SELECT * FROM employees WHERE UPPER(last_name) = 'KING';
 
CREATE INDEX last_name_fix ON employees (UPPER(last_name));
-- must use same function in query 
SELECT * FROM employees WHERE UPPER(substr(last_name,1,1)) = 'K';
DROP INDEX last_name_fix;
 
CREATE INDEX last_name_fix ON employees (UPPER(substr(last_name,1,1)));
SELECT * FROM employees WHERE UPPER(substr(last_name,1,1)) = 'K';
-- same as above, must same 
SELECT * FROM employees WHERE UPPER(substr(last_name,1,2)) = 'KI';
DROP INDEX last_name_fix;
 
CREATE INDEX annual_salary_fix ON employees(salary*12-300);
SELECT * FROM employees WHERE salary > 10000;
SELECT * FROM employees WHERE salary*12 > 10000;
-- if the math operation -> same rule !
SELECT * FROM employees WHERE salary*12-300 > 10000;
SELECT * FROM employees WHERE salary*12-301 > 10000+1;
DROP INDEX annual_salary_fix;