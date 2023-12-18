/** B Tree Index have order intervals in each node (root, branches, leaves) 
- it will ALWAYS BALANCED -> leaves always same depth 
    . if some insert / update have a row too large value, leaf -> it can split into 2 blocks of leaf or sometime in another leaf / branch 
        .. can fix by REBUILD / COALESCE
- a leaf will have many index entries 
- INDEX COMPRESSION may help the index have low selectivity 
*/
CREATE TABLE employees_copy AS SELECT * FROM employees;
 
SELECT * FROM employees_copy WHERE employee_id = 120;
 
CREATE INDEX emp_id_idx ON employees_copy(employee_id) COMPUTE STATISTICS;
 
SELECT * FROM employees_copy WHERE employee_id = 120;
 
EXEC dbms_stats.gather_table_stats (ownname=>'HR',tabname => 'EMPLOYEES_COPY',CASCADE => TRUE);
 
SELECT * FROM employees_copy WHERE employee_id = 120;
 
ALTER TABLE employees_copy ADD CONSTRAINT unique_emps UNIQUE (employee_id);
 
SELECT * FROM employees_copy WHERE employee_id = 120;
 
ALTER INDEX emp_id_idx REBUILD;
 
SELECT * FROM employees_copy WHERE employee_id = 120;
 
ALTER TABLE employees_copy DROP CONSTRAINT unique_emps;
 
ALTER TABLE employees_copy ADD CONSTRAINT unique_emps UNIQUE (employee_id)
USING INDEX emp_id_idx;
 
SELECT * FROM employees_copy WHERE employee_id = 120;
 
ALTER TABLE employees_copy DROP CONSTRAINT unique_emps;
DROP INDEX emp_id_idx;
 
ALTER TABLE employees_copy ADD CONSTRAINT unique_emps UNIQUE (employee_id);
 
SELECT * FROM employees_copy WHERE employee_id = 120;
 
DROP TABLE employees_copy;