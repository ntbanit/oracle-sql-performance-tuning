/*** ORACLE DATABASE ARCHITECTURE OVERVIEW -> really complex 


video 8-9: MEMORY OPERATIONS EXPLAINATION

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





video 9: DISK OPERATIONS EXPLAINATION

1. DATA FILE 
The first one is disks that include the "data" files. The actual data is stored in here. Our tables, triggers, functions, etc., all the database objects are stored in these files.

The connection between these disks and memory areas are simply established by the database buffer cache and the PGA.
When you read some data from the disk, this data is stored in the buffer cache for any kind of operations.
And if you make any change on any table or something, it is written into the database buffer cache first, and then stored into the database disks when you commit them.

Database disks have some interaction with the PGAs too. As you can see from the arrow, PGAs do not write anything to the disk directly. But if there is no need to organize the returning data, sometimes it is handled to the PGA’s directly from the disk.

2. REDO LOG FILE 
Redo log buffer is for the instant redo operations.
The redo log data in the redo log buffer is constantly stored in the redo log discs and deleted from the redo log buffer.





video 10: DATABASE BLOCKS EXPLAINATION

1. DATABASE BLOCKS OVERVIEW 
- All data is stored in blocks in both disc and memory. A block the smallest unit of the database for storing the data. A block is a logical unit that consists of multiple Operating System blocks.
- There can be millions or billions of blocks and they store the actual data in it.
- A block can have a whole table, or a couple rows of a table. Or sometimes, a block can have rows of different tables when multiple tables are clustered.
- A block has a specific size and cannot be extended directly.
- A block can have a size from 2KB to 32KB but generally, it is set to 8KB by default. This size is specified by the DBAs on the database installation. 8KB is not a small size.
- It can have hundreds or maybe thousands of rows based on the size of your row data of course. Because depending on the row size of your tables, your rows can be a couple bytes or even a couple bits.
- ABlock can have the index data. 
- So, a block consists of the block header and the rows.
- A block header includes :
  + block type information (row / index )
  + information of tables which have the rows in it
  + the row directory, means the addresses of each row in this block. 
- We will call these addresses as ROWIDs. With this address, we can directly go to the exact location of that row and read it easily.
- A block header has lots of data, so it has about 100 bytes of data generally.
- The rest of the block has the rows and some free spaces. 
- These white areas next to the rows and at the bottom of all rows represents space here.
- These spaces are important. Because, if you make an update and increase the size of a row, it will be costly to take this row and carry to another place in that block or maybe to another block. In order to do that, Oracle leaves some space after each row.
- But sometimes the new row size can exceed the total size of the row and the space after it. If such thing happens, if there is enough space in the block, this row is deleted from here and written into the big space area. 
- But if there is not enough space in the block, this time it is written into another block.
- Actually I said that, there are some spaces after the rows. But this is not true for all the times.
- It is generally like so, but when you are creating a table, you can use PCTFREE or PCTUSE parameters to specify how much free space will be left in a block. So you can change these free space size or you can say that do not leave any space, just use all the space. 
- But if you don’t leave any free space in a block, each update will most probably change the place of the row, and this will decrease the performance. Because the IO operations will increase significantly and IO means cost in tuning. And moreover, as we will learn later, the place of the rows might be stored in many places like indexes etc. So these indexes may need to be updated because of the address changes of the rows.
- After all the rows, there is an extra space left. This space is for the new inserts. Even if there might be more than one table’s rows in a block, it is not preferred. This can only occur only if these tables are clustered.
- If a table is not clustered, a block will most probably have one table’s rows. Because reading a table’s rows from one block will be faster than reading from multiple blocks.
- When Oracle tries to find your row, it first finds the block that your row is in, and then goes to the address of that row with using the rowid.
- A row also has some additional data in it. A row area in a block does not consist of only the column data.

2. ROW AREA IN BLOCK OVERVIEW 
- A row also has some additional data in it. A row area in a block does not consist of only the column data.
   + row overhead
   + number of columns in this row
   + cluster key id if it is clustered,
   + rowid of chained row pieces (if any) 
   + column length (how many bytes will be read for that column)
   + column values 
*/