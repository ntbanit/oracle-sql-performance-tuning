/** Do NOT use SELECT * for all queries 
- unnecessary columns 
- need to check in data dictionary 
- more I/O cost 
- if column have some large objetc be get -> MORE cost   
- network cpst 
*/

select * from sales ;
select prod_id, cust_id,amount_sold from sales ;

select * from employees;
select employee_id, first_name, last_name from employees;