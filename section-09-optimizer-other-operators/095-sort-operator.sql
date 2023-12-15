/** SORT OPERATOR 
- Sort Operator Types :
    + SORT AGGREGATE : not actually a sort ? pick 1 row from groups of the selected rows 
        . example : COUNT or MIN (aggregate functions) 
    + SORT UNIQUE : when need unique value. there are 2 methods 
        . group rows and select 1 from each group 
        . OR sort rows and remove duplicated => SORT UNIQUE 
    + SORT JOIN : use with SORT-MERGE JOIN 
        . maybe sort the small or large table or maybe both
    + SORT GROUP BY : when data is grouped (when use GROUP BY or db group it) 
    + SORT ORDER BY : when use ORDER BY in non-index column 
    + HASH GROUP BY : when need GROUP but dont need ORDER -> faster than SORT GROUP BY 
    + HASH UNIQUE : -> faster than SORT UNIQUE
    + BUFFER SORT : in cartesion product -> read data multi time -> sort and store small table in buffer cache 
    
*/

-- HASH UNIQUE cause it need  distinct 
select distinct prod_id, cust_id from sales;
-- SORT UNIQUE cause it need to be ordered   
select distinct prod_id, cust_id from sales order by prod_id;
 
-- HASH GROUP BY
select prod_id, cust_id, sum(amount_sold) from sales
group by prod_id,cust_id;
-- SORT GROUP BY 
select prod_id, cust_id, sum(amount_sold) from sales
group by prod_id,cust_id
order by prod_id;

-- cartesion product => BUFFER SORT 
select prod_id, cust_first_name, amount_sold from sales, customers