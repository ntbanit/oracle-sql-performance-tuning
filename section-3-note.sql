/*** ORACLE DATABASE ARCHITECTURE OVERVIEW -> really complex 


MEMORY OPERATIONS EXPLAINATION

1. CLIENT AREA 
Oracle is a multi user database ( up to Millions) 
User processes send some SQL commands to the database and get some data if they need.


2. SERVER AREA : PGA (Program/Private Global Area) - memory cache

User processes send commands to the database server, the server takes the control and pushes the statement to the Program Global Area, abbreviated as "PGA". A PGA is a memory area that is dedicated to a single user and every user has its own PGAs.

While your code is interpreting, your session specific data is stored in here and this area can only be read by its owner.
So, since your SQL is specific for your session, your SQL and some other data are stored here to be executed.


3. SERVER AREA : SGA (Shared Global Area) - memory cache

Every SQL statement is executed with an execution plan (execution plans are the ways or techniques of how your code will be executed) 

Execution plan will be created in shared SQL Area and stored there in case of the owner user or other users can reuse later (execution plan is a costly operation sometimes) -> increase performance 


4. SERVER AREA : SGA - smaller parts 

4.1. Shared pool : is a very large cache including some sub-caches like library cache, result cache, etc.

4.1.1. Data dictionary cache : the definition of the tables are stored in this cache and the server decides if our query is right or wrong by making a check from that cache.

4.1.2. Result cache : run same query again -> run faster (decrease  disc reads and CPU cycles ) 
*** If the data in the original table changes -> result cache is flushed. (query re run) 
*** But of course, all the query results are not stored in here cause  memory is more expensive than the disc 

4.2. Library Cache :  including the SQL statement process information - container & organizer  of the shared SQL areas.
It manages the size of these shared (when full memory, arranges memory of the shared SQL areas by deleting the most unused one and creating a new one, maybe increasing the size ...)

4.3. Database Buffer cache : memory area that stores the data blocks in it for a short period of time.
So in order not to read the same data from the disks all the time, the database stores these data blocks in the buffer cache and read any time it needs from here faster.
When you run a query, for example, or perform an update, etc., the related data block is checked if it is in the buffer cache or not. If not, it is read from the disk and written here.
And after the related operation is done on that block, that block is written into the disks again.
=> performance data concurrency and consistency. 

4.4. Redo Log buffer : keep the initial status of the changed values with some specific info about these values. 
With this way, the values can turn back to its initial status easily with the redo log data.
This is extremely useful when something unexpected occurs like a system failure. You can easily turn back with using the redo log files.
(some kind like ROLLBACK ?) 





DISK OPERATIONS EXPLAINATION

1. DATA FILE 
The first one is disks that include the "data" files. The actual data is stored in here. Our tables, triggers, functions, etc., all the database objects are stored in these files.

The connection between these disks and memory areas are simply established by the database buffer cache and the PGA.
When you read some data from the disk, this data is stored in the buffer cache for any kind of operations.
And if you make any change on any table or something, it is written into the database buffer cache first, and then stored into the database disks when you commit them.

Database disks have some interaction with the PGAs too. As you can see from the arrow, PGAs do not write anything to the disk directly. But if there is no need to organize the returning data, sometimes it is handled to the PGA’s directly from the disk.

2. REDO LOG FILE 
Redo log buffer is for the instant redo operations.
The redo log data in the redo log buffer is constantly stored in the redo log discs and deleted from the redo log buffer.

*/