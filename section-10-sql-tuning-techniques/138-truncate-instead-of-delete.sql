/** TRUNCATE always faster than DELETE (cuz TRUNCATE dont have UNDO data) 
- TRUNCATE is DDL. 
    + CAN NOT rollback. 
    + CAN NOT fire DML trigger. 
    + but CAN fire DDL trigger 
    + make unsuable indexes useable again. which DELETE DO NOT
    + can TRUNCATE a single partition as well 
*/

create table sales_temp1 as select * from sales;
create table sales_temp2 as select * from sales;
 
delete from sales_temp1;
 
truncate table sales_temp2;
 
drop table sales_temp1;
drop table sales_temp2;