/** CLUSTER INDEX 
- we can create indexes over index cluster 
- we can NOT create indexes for hash-type cluster 
- default create index cluster 
- we can not make DML operations over the index-clustered table before the index is created 
- cluster index :
    + are store in index segment 
    + store null vales 
    + have entries for each cluster key value 
- index cluster can not be used without the indexes  

*/
CREATE CLUSTER emp_dep_cluster (dep_id NUMBER(4,0))
TABLESPACE USERS
STORAGE (INITIAL 250K NEXT 50K )
HASH IS dep_id HASHKEYS 500;
 
CREATE CLUSTER emp_dep_cluster (dep_id NUMBER(4,0))
TABLESPACE USERS
STORAGE (INITIAL 250K NEXT 50K );
 
CREATE TABLE emps_clustered (
employee_id NUMBER(6,0) PRIMARY KEY,
first_name VARCHAR2(20),
last_name VARCHAR2(25),
department_id NUMBER(4,0)
) CLUSTER emp_dep_cluster (department_id);
 
CREATE TABLE deps_clustered (
department_id NUMBER(4,0) PRIMARY KEY,
department_name VARCHAR2(30)
) CLUSTER emp_dep_cluster (department_id);


/** indexing column is for key */ 
CREATE INDEX emp_dept_index
ON CLUSTER emp_dep_cluster
TABLESPACE USERS
STORAGE (INITIAL 250K NEXT 50K);
 
INSERT INTO emps_clustered (employee_id,first_name,last_name,department_id)
SELECT employee_id,first_name,last_name,department_id FROM employees;
 
INSERT INTO deps_clustered (department_id,department_name)
SELECT department_id,department_name FROM departments;
 
-- hash cluster: table access hash -> cost 0 wow  @@ 
-- index cluster: nested loop cost 3 
SELECT employee_id,first_name,department_name FROM emps_clustered E, deps_clustered D
WHERE E.department_id = D.department_id
AND E.department_id = 80;
-- hash cluster: table access full cost 143 more cost than non-cluster table (same cost like select all) 
-- index cluster: nested loop cost 16 : 
SELECT employee_id,first_name,department_name FROM emps_clustered E, deps_clustered D
WHERE E.department_id = D.department_id
AND E.department_id > 80;
-- index cluster:cost 9 -> useful for full scan 
SELECT * FROM emps_clustered;
 
DROP TABLE deps_clustered;
DROP TABLE emps_clustered;
DROP CLUSTER emp_dep_cluster;