- query analysis strategy 
- steps:
	+ check query 
	+ check statistics
	+ check execution plan 
		. check access paths 
		. check join order and join types 
		. compare the actual and the estimated result -> may need hint 
		. check the operations where the cost and the logical reads differ significantly 
			.. data small but cost high ?? 
			
- reason of bad sql 
	+ poorly written 
	+ index used or not used 
	+ there is no index 
	+ predicated are not used 
	+ wrong types in predicateds 
	+ wrong join order 
	+ others 
	
- possible solutions 
	+ update statistics 
	+ use dynamic statistics 
	+ create or modify indexes 
	+ rewrite query to use an index 
	+ use hints 
	+ remove wrong hints 
	+ change the hints 
	+ eliminate implicit data type conversion 
	+ create function-based index 
	+ use index-organized table 
	+ change the optimizer mode 
	+ use parallel execution 
	+ use materialized views
	+ modify or disable triggers and constraints 
	+ others 