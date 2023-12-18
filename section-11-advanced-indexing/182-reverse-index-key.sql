/*** REVERSE KEY INDEX 
-> store the bytes of indexed columns in reverse order (ROWID are not reverse) 
    + usecase: minultaneous insert/uptade for sequan value may cause contention in dex blocks 
        .. reverse them: store in different index blocks 
        
- drawback: 
    + only work in equal searches 
    + use more CU 
    
*/ 
create index ix on temp(a,b) reverse; 