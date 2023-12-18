# oracle-sql-performance-tuning
course : https://udemy.com/course/sql-performance-tuning-masterclass/learn/lecture/12101954#questions
- this is the place i saved my notes and do the task for the course 

# helpful query but HARD to searching 
*TKPROF can also check plan in trace file for a PL/SQL*
<pre><code>
-- find directory of trace files 
select value from v$diag_info where name ='Diag Trace';
-- create a postfix in trace file 
alter session set tracefile_identifier = ZON_BULK_COLLECT ;
-- setting tracing
alter session set sql_trace = true;
-- query need to check 
select * from hr.employees ;
-- turn off tracing 
alter session set sql_trace = false;
</code></pre>