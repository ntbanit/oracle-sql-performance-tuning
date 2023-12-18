/** COMBINE SIMILAR QUERY INTO ONE
same solution with the insert all and merge 
*/

SELECT MAX(S.amount_sold) max_sold FROM products P , sales S, customers C
WHERE S.prod_id = P.prod_id
AND S.cust_id = C.cust_id
AND P.prod_id = 13;
 
SELECT COUNT(S.amount_sold) count_sold FROM products P , sales S, customers C
WHERE S.prod_id = P.prod_id
AND S.cust_id = C.cust_id
AND C.cust_first_name = 'Brant';
 
SELECT AVG(S.amount_sold) avg_sold FROM products P , sales S, customers C
WHERE S.prod_id = P.prod_id
AND S.cust_id = C.cust_id
AND P.prod_category = 'Photo';
 
-- decode -> transform to another value 
SELECT
MAX(decode(P.prod_id,13,S.amount_sold,0)) max_sold,
SUM(decode(C.cust_first_name,'Brant',1,0)) count_sold,
SUM(decode(P.prod_category,'Photo',amount_sold)) / SUM(decode(P.prod_category,'Photo',1)) avg_sold
FROM products P , sales S, customers C
WHERE S.prod_id = P.prod_id
AND S.cust_id = C.cust_id;