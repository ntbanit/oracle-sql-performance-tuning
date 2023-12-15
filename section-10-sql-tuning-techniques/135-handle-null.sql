/**
- By Default  B-Tree index do NOT index the NULL value and may SUPPRESS the index of query 
- Solution : 
    + Should add IS NOT NULL to query 
    + insert another value to NULL 
    + if reasonable, create a BITMAP INDEX -> BITMAP store NULL 

*/ 

CREATE TABLE employees_temp AS SELECT * FROM employees;
 
CREATE INDEX comm_pct_idx ON employees_temp(commission_pct) COMPUTE STATISTICS;

-- TABLE ACCESS FULL 
SELECT * FROM employees_temp WHERE commission_pct <> 1;
-- INDEX FULL SCAN 
SELECT * FROM employees_temp WHERE commission_pct <> 1 AND commission_pct IS NOT NULL;

-- TABLE ACCESS FULL 
SELECT employee_id,commission_pct FROM employees_temp WHERE commission_pct IS NULL;
-- Not reasonale, ignored 
SELECT /*+ index(employees_temp comm_pct_idx)*/employee_id,commission_pct 
FROM employees_temp WHERE commission_pct IS NULL;
 
UPDATE employees_temp SET commission_pct = 0 WHERE commission_pct IS NULL;
COMMIT;
 
SELECT employee_id,commission_pct FROM employees_temp WHERE commission_pct = 0;
 
UPDATE employees_temp SET commission_pct = NULL WHERE commission_pct = 0;
COMMIT;
 
DROP INDEX comm_pct_idx;
CREATE BITMAP INDEX comm_pct_idx ON employees_temp(commission_pct) COMPUTE STATISTICS;

-- TABLE ACCESS FULL 
SELECT employee_id,commission_pct FROM employees_temp WHERE commission_pct IS NULL;
-- COST a lot MORE 
SELECT /*+ index(employees_temp comm_pct_idx)*/employee_id,commission_pct 
FROM employees_temp WHERE commission_pct IS NULL;
 
DROP TABLE employees_temp;