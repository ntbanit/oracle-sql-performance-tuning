/** CLUSTER 
- main goal of clustering is improving the performance with a different way of storage 
- example : some table usually join together like sale and product, should be placed in same data block -> read faster 
- create cluster table with cluster key is the common columns 

- CLUSTER is the container for database blocks => it have size
    + if can not estimate size -> many unused space -> divide to so many cluster pieces -> decrease performance 
    
- Type of CLUSTER :
    + INDEX CLUSTER -> place cluster key, not the rows 
        . useful when it reads multi rows at the same time 
        . cluster indexes are much smaller than regular index 
    + HASH CLUSTER -> generate hash value of cluster key 
        . useful in equal and non-equal operation 
    + SINGLE TABLE HASH CLUSTER -> store only 1 table in cluster 
         . useful in equal operation -> faster with INDEX UNIQUE SCAN 
         . NOT so useful with INDEX RANGE SCAN 
    + SORTED HASH CLUSTER -> reduce the cost of accessing the order data 
        . useful with equal search 

- CLUSTER + FULL TABLE SCAN -> much high cost 
*/

-- HASH CLUSTER example 
CREATE CLUSTER emp_dep_cluster (dep_id NUMBER(4,0))
    TABLESPACE users
    STORAGE (INITIAL 250K     NEXT 50K )
    HASH IS dep_id HASHKEYS 500;
 
create table emps_clustered (
    employee_id number(6,0) primary key,
    first_name varchar2(20),
    last_name varchar2(25),
    department_id number(4,0)
) cluster emp_dep_cluster (department_id);
 
insert into emps_clustered (employee_id,first_name,last_name,department_id)
select employee_id,first_name,last_name,department_id from employees;
 
create table deps_clustered (
    department_id number(4,0) primary key,
    department_name varchar2(30)
) cluster emp_dep_cluster (department_id);
 
insert into deps_clustered (department_id,department_name)
select department_id,department_name from departments;

-- decrease cost
select employee_id,first_name,department_name from employees e, departments d
where e.department_id = d.department_id
and e.department_id = 80;
 
select employee_id,first_name,department_name from emps_clustered e, deps_clustered d
where e.department_id = d.department_id
and e.department_id = 80;
 
-- increase cost
select employee_id,first_name,department_name from emps_clustered e, deps_clustered d
where e.department_id = d.department_id
and e.department_id > 80;
 
select employee_id,first_name,department_name from employees e, departments d
where e.department_id = d.department_id
and e.department_id > 80;

-- full scan in cluster table -> expensive cost $$ 
select * from emps_clustered;
 
drop table deps_clustered;
drop table emps_clustered;
    drop cluster emp_dep_cluster;