- data save on disk randomly 
- index save exactly location : block address, row address 
- if dont have index -> full table scan 
- indexing cost 
	+ similar data saving 
	+ maintainance cost => burden cost 
- Why & How ?
	+ if our queries search for a small fraction of table 
	+ if the related column are queried often and selective 
	+ index type must be choose carefully 
	
- index selectivity & cardinality 

- if the index is not selective, cost might >> table full scan 
	+ when >5% usually, optimizer wont use index 

- index selectivity = number of unique values of column(s) / total rows 
	+ statistic saved in all_tab_column (only single column index) 


	
	
