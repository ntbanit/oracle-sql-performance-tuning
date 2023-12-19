/** FULL TEXT SEARCH 
Type index
- CONTEXT -> search text in document (BLOB TYPE) 
- CTXCAT -> smaller documents or text fragments 
- CTXRULE -> build a document classification application 
- 


*/

GRANT EXECUTE ON ctxsys.ctx_ddl TO sh;
 
CREATE TABLE products_temp AS SELECT * FROM products;
 
EXEC ctx_ddl.create_index_set('products_iset');
EXEC ctx_ddl.add_index('products_iset','prod_list_price');
--EXEC CTX_DDL.REMOVE_INDEX('products_iset','price');
CREATE INDEX my_products_name_idx ON products_temp(prod_desc) INDEXTYPE IS ctxsys.ctxcat
PARAMETERS ('index set products_iset');

-- DOMAIN INDEX CATSEARCH : dont get LCD something ... 
SELECT prod_id, prod_list_price, prod_name,prod_subcategory,prod_desc
FROM   products_temp
WHERE  catsearch(prod_desc, 'CD', 'prod_list_price > 10')> 0;
 
SELECT prod_id, prod_list_price, prod_name,prod_subcategory,prod_desc FROM products 
WHERE prod_desc LIKE '%CD%' AND prod_list_price > 10;
 
DROP INDEX my_products_name_idx;
DROP TABLE products_temp;
 
 
CREATE TABLE temp_table(CLASSIFICATION VARCHAR2(50),text VARCHAR2(2000));
 
INSERT INTO temp_table VALUES('US Politics', 'democrat or republican');
INSERT INTO temp_table VALUES('Music', 'ABOUT(music)');
INSERT INTO temp_table VALUES('Football', 'footballer');
INSERT INTO temp_table VALUES('Countries', 'United States or Great Britain or Argentina');
INSERT INTO temp_table VALUES('Names', 'Lionel NEAR Messi OR David or Ronaldo');
 
CREATE INDEX temp_rule ON temp_table(text) INDEXTYPE IS ctxsys.ctxrule;
-- can use for some kind big data 
SELECT CLASSIFICATION FROM temp_table WHERE matches(text, 'Lionel Messi is a famous footballer from Argentina') > 0;
 
EXEC ctx_ddl.drop_index_set('products_iset');
DROP TABLE temp_table;
 
/**
https://docs.oracle.com/cd/A64702_01/doc/cartridg.805/a63821/ling.htm#7641
https://docs.oracle.com/cd/A64702_01/doc/cartridg.805/a63821/know.htm# */