/** VIEWS (created by multi tables) 
- things to be careful 
     + if don;t need to use all the tables in a view -> use the ACTUAL table 
     + DO NOT join the complex view with a table or another view 
     + AVOID outer join with view 
     + careful with SUBQUERY UNNESTING 
     + AVOID using views inside of a view 
*/

CREATE OR REPLACE VIEW vw_emp_dept AS
SELECT E.employee_id, E.last_name, E.first_name, E.salary, E.job_id,
    D.department_id, D.department_name, D.location_id, L.state_province
    FROM employees E, departments D , locations L
WHERE E.department_id(+) = D.department_id
AND D.location_id = L.location_id;

-- BAD : basically a view is a subquery 
SELECT  V.first_name, V.last_name, j.job_title
FROM jobs j, vw_emp_dept V
WHERE j.job_id = 'IT_PROG'
AND V.job_id = j.job_id;
 
select * from vw_emp_dept;

-- GOOD : use the ACTUAL table 
SELECT  E.first_name, E.last_name, j.job_title
FROM employees E, jobs j
WHERE j.job_id = 'IT_PROG'
AND E.job_id = j.job_id;
 
 
CREATE OR REPLACE VIEW vw_cust_num_sold AS
SELECT C.cust_id, cust_first_name,cust_last_name, prod_id, COUNT(*) num_sold FROM sales S, customers C
WHERE S.cust_id = C.cust_id
GROUP BY C.cust_id,cust_first_name, cust_last_name, prod_id
ORDER BY num_sold DESC;

-- BAD  
SELECT cust_id,prod_name,num_sold
FROM vw_cust_num_sold V, products P
WHERE V.prod_id = P.prod_id
AND V.prod_id = 13;
-- EVEN WORSE : OUTER JOIN : NOT push the PREDICATE to the VIEW 
SELECT cust_id,prod_name,num_sold
FROM vw_cust_num_sold V, products P
WHERE V.prod_id = P.prod_id(+)
AND V.prod_id = 13;
 
-- MORE WAY BETTER : use the ACTUAL table 
SELECT C.cust_id, P.prod_name, COUNT(*) num_sold FROM sales S, customers C, products P
WHERE S.cust_id = C.cust_id
AND S.prod_id = P.prod_id(+)
AND P.prod_id = 13
GROUP BY C.cust_id, P.prod_name
ORDER BY num_sold DESC;
 
DROP VIEW hr.vw_emp_dept;
DROP VIEW vw_cust_num_sold;