/** ADAPTIVE PLANS -> cost-based optimizition 
- 4 statistics 
- if statistics wrong -> worng plan 
-> since 12c optimizer can change the plan on runtime 
( project dang dung 19) 

*/

ALTER SYSTEM FLUSH SHARED_POOL;
 
SELECT COUNT(*)
FROM sales S, products P, customers C
WHERE S.prod_id = P.prod_id
AND S.cust_id = C.cust_id;
 
SELECT * FROM TABLE(dbms_xplan.display_cursor());
 
SELECT * FROM TABLE(dbms_xplan.display_cursor(FORMAT => 'adaptive'));
 
SELECT /*+ GATHER_PLAN_STATISTICS */COUNT(*)
FROM sales S, products P, customers C
WHERE S.prod_id = P.prod_id
AND S.cust_id = C.cust_id;
 
SELECT * FROM TABLE(dbms_xplan.display_cursor(FORMAT => 'adaptive allstats last'));