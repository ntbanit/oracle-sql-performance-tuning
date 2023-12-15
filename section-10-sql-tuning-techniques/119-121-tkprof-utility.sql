/** TKPROK Tool generate readable format for traces file ( do NOT show commit / rollback) 

- SQL Trace file have infor :
    + performance infor
    + CPU Time 
    + Elapsed time : all the time user wait for the execution until the database hands off the result 
    + Wait Time / Network Time 
    + Wait Events -> tuning query NOT solve problem 
    + Execution Plans 
    + Row Counts 
    + Call Counts ( Parse, Execute, Fetch (go to buffer & disc) ) 
    + Physical & Logical Reads 

- find trace file paths 

- enable / disable tracing for specific user /session / entire db (SHOULD NOT)


*/

-- enable the trace 
-- can see wait 
exec dbms_session.set_sql_trace();
-- enable the trace FOR SESSION 
alter session set sql_trace = true;
exec dbms_session.session_trace_enable(waits => true, binds => false);
exec dbms_session.session_trace_enable(session_id => 27, serial_num => 60, waits => true, binds => false);
-- disable the trace FOR SESSION  
alter session set sql_trace = false;
exec dbms_session.session_trace_disable();
-- for a specific session 
exec dbms_session.session_trace_disable(session_id => 27, serial_num => 60);

-- sqlplus / as sysdba;
 -- trace files have postfix is TUN 
alter session set tracefile_identifier= TUN; 
 
select * from hr.employees;
 
select value from v$diag_info where name ='Diag Trace';
 
-- cd C:\ORACLEAPP\diag\rdbms\orcl\orcl\trace
-- tkprof file_name.trc tun_ex.txt
 
/********************************************************************/

alter session set timed_statistics=true;
 
select s.prod_id,p.prod_name,s.cust_id,c.cust_first_name 
from sales s, products p, customers c
where s.prod_id = p.prod_id
and s.cust_id = c.cust_id
and s.amount_sold > 1500;
 
 exec dbms_session.session_trace_disable();
