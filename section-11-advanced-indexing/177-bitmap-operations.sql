/** BITMAP OPERATIONS 
- bitmap conversion to rowid : converts the bitmap to the corresponding rowid 
- bitmap conversion from rowid : generate a bitmap index from b-tree 
	+ incase: convert + bitmap compare faster than compare in b-tree 
	+ bitmap index can be join with other bitmap index -> efficient 
- bitmap conversion count: can count the NULL value 
	+ if b-tree index have null value -> table full scan 
- bitmap index single value 
- bitmap range scan 
- bitmap full scan 
- bitmap merge_ scan : 
	+ merges multiple bitmaps (result of a reange scan) into 1 bitmap 
- bitmap AND - performs an AND operation over the bits of 2 bitmaps 
- bitmap OR
- bitmap minus : A minus B = A AND (NOT B) 
- bitmap key iteration : 
	+ takes each row from a table row source, fins the corresponding bitmaps and merges them 