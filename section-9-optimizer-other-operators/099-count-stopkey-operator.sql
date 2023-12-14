/** COUNT STOPKEY Operator -> when limit the result 
*/

-- old syntax 
-- cardinality : 10 
select * from employees where rownum < 11;
 
select * from employees where rownum < 11 order by employee_id desc;

-- new syntax : use NOSORT STOPKEY : windown function to finish the execution when already fetch all needed ones 
-- cardinality : all rows of the table -> use old syntac seem better 
select * from employees fetch first 10 rows only;

