exec dbms_stats.gather_system_stats('Start');

select * from sys.aux_stats$;

exec dbms_stats.gather_table_stats('');

analyze table employees compute statistics ;

exec dbms_stats.gather_database_stats ;

exec dbms_stats.gather_dictionary_stats;

exec dbms_stats.gather_schema_stats(ownname=>'SH') ;

exec dbms_stats.gather_table_stats(ownname=>'SH', tabname=>'SALES', cascade => true ) ;
 -- cascade = true -> applyh to index of this table 

select * from dba_tab_statistics where table_name = 'SALES' ;

exec dbms_stats.gather_index_stats;-- for one index 