/** 
- usually : EXISTS >>> IN or NOT EXISTS >>> NOT IN. they not exacly equally, must check 
- if outer table is big and subquery is small , IN may better 
- if outer table is small and subquery is big , EXISTS may better 
- optimizer may try to transform EXISTS to IN when it think it better 
*/

