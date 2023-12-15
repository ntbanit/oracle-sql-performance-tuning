- explain plan <> execution plan. maybe when the statistic is old, they will be different 
	. explain plan -> first way the optimizer want to run 
	. execution plan -> the one really RUN ACTUALLY 

- ways to get the exceution plan and the statistic :
	+ autotrace 
	+ sql monitor 
	+ tkprof
	+ dbms_xplan
	
- autotrace	
	+ free 
	+ use SQL Developer 
		. can compare 2 different execution plans and statistics 
		. hospot button to shows problem area 
		. export a plan 
		
- SQL monitoring -> developed version of auto trace 
	+ can show the plan right now, before it finish running (autotrace must to run query first) 
	- tracks to find the top comsuming queries 
	+ v$sql_monitor and v$sql_plan_monitor
	+ only capture queries longer than 5 seconds or run in parallel mode 
		. can use MONITOR hint to make it counted 
	+ paid tool $$ 

- tkprof : convert trace files to readable 
	+ need permission db to do 
	+ includes all sql statements run between the tracing starts and ends (in a function...) 
	+ breaks down yo parse, execute and fetch times 

- dbms_xplan : if it has run before, no need to run again 
	