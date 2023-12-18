/** TEMPORARY TABLES => using in global/private session -> create when the similar query is use multi times 
- it will be truncate when the session end 

*/

SELECT P.prod_name,C.cust_first_name,sum(S.amount_sold) sold FROM  products P , sales S, customers C
WHERE S.prod_id = P.prod_id
AND S.cust_id = C.cust_id
group by p.prod_name, c.cust_first_name
having sum(amount_sold) > 10
order by sold;
 
SELECT P.prod_name,C.cust_first_name,sum(S.amount_sold) sold FROM  products P , sales S, customers C
WHERE S.prod_id = P.prod_id
AND S.cust_id = C.cust_id
and p.prod_name like 'DVD-R%'
group by p.prod_name, c.cust_first_name
order by sold;
 
SELECT P.prod_name,C.cust_first_name,sum(S.amount_sold) sold FROM  products P , sales S, customers C
WHERE S.prod_id = P.prod_id
AND S.cust_id = C.cust_id
and p.prod_name like 'CD-R%'
group by p.prod_name, c.cust_first_name
order by sold;
 
create global temporary table products_sum_sold_amount(prod_name, cust_first_name, sum_amount_sold) 
on commit preserve rows as
SELECT P.prod_name,C.cust_first_name,sum(S.amount_sold) sold FROM  products P , sales S, customers C
WHERE S.prod_id = P.prod_id
AND S.cust_id = C.cust_id
group by p.prod_name, c.cust_first_name
order by sold;
 
SELECT prod_name,cust_first_name, sum_amount_sold FROM  products_sum_sold_amount
WHERE sum_amount_sold > 10;
 
SELECT prod_name,cust_first_name, sum_amount_sold FROM  products_sum_sold_amount
WHERE prod_name like 'DVD-R%';
 
SELECT prod_name,cust_first_name, sum_amount_sold FROM  products_sum_sold_amount
WHERE prod_name like 'CD-R%';