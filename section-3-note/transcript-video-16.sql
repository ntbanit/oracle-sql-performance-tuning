/**HOW A DML IS PROCESSED AND COMMITED 

Hi. In this lecture, you will see how a DML is processed by the server and how it is committed.
This is also an important subject. 
Because, in SQL tuning strategies, we don’t try to tune only the select queries.
We also tune some DML operations, too. Alright.
I will explain a DML process step by step by starting the first run of a DML code. 
When we run a DML code, the server checks the shared SQL area in the library cache to find if there are any similar SQL statements in there. 
If yes there is no need to parse the same query.
And then checks the data dictionary cache.
If the related table info is there, then there is no need to get the privileges or definitions of the related tables.
If these data are not there in the library cache and data dictionary cache, these are returned from the disc and written into these areas.
So when these data is ready, it first checks if your query is true.
That means, if it is a valid query.
So when these steps are done, then it checks the buffer cache for the related data and the undo segments. 
As we know even if you do a DML operation, the related data is written to the buffer cache first. 
This is valid both for querying and running a DML operation.
So, if the data that needs to be modified is not in the buffer cache, the server fetches these data from the discs, and writes them to the buffer cache. 
After being sure that the related data is in the buffer cache, it locks the related blocks for the other users. 
So no one else cannot change these blocks until you commit or rollback. 
All of your changes are written into the related blocks in the buffer cache.
These changed blocks are called as dirty blocks.
Besides, all the related redo log data is written into the redo log buffer before the changes are done in the buffer cache.
They call it as "write-ahead logging".
So redo log data is created before the modifications for the data consistency.
When the redo logs are created and the changes are applied to the data buffers, the server returns the number of affected rows to the user.
But the user can continue modifying the data in its transaction.
If the new modifications are on the same blocks, they are done in the buffer cache.
If new data needed, they are also fetched from the discs, and the same process is done for the new ones.
Once the user commits the changes, the following steps are executed respectively. 
As we remember, the redo log buffer assigns a system change number(SCN) to the changes while writing them to the redo log files. 
A system change number is a unique number including the timestamp of that date. 
So, the server creates a commit record with the current system change number in the redo log buffer.
Then, the log writer process starts writing all the redo log buffer entries created up to now about the related operations including the just created commit record to the redo log files, and then deletes them from the redo log buffer. 
Then, the database writer process writes the dirty blocks to the disc and the server unlocks the related blocks for the other users.
After completing all these, the server returns a feedback to the user about the completion of the transaction.
So when the commit occurs successfully, your transaction finishes and you start another transaction with the next DML operation. Alright.
In this lecture, you saw the steps of how a DML operation is executed and how a commit is done by the Oracle server.

So this is the end of this lecture.

See you in the next lectures.