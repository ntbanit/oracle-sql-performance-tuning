/*** DATABASE INSTALLATIONS FOR THE COURSE 

Oracle Database Structure : 
since 12c, there are many plugable database in a container database 

Express    - Free, a lot of limit 
Standard   - 
Enterprise - 

set up container database : orcl 
 plugable database : orclpdb 
*/

-- plugable database default not exists in tns file 
-- -> SHOULD CHANGE tnsnames.ora file to FIX IT 
sqlplus / as sysdba;
alter session set container=orclpdb; 
alter pluggable database open; -- ERROR 
alter pluggable database orclpdb save state;
alter user hr identified by hr account unlock;
/

-- system user -> full DBA priviliege 
-- sys -> more statics data 
-- these ones can connect to container database


-- oracle have some sample db for practice ?