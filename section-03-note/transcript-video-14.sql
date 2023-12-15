/** REDO LOG 

We know that, Oracle guarantees that it handles the data loss. So it takes some actions for that.
One of these actions is, creating redo log files.
Let’s first start with what is a redo log and why we use it.

When we make a change on the table data by an insert, update delete, create, alter, drop operations, the Oracle server creates redo log entries about that changes. 
Redo log entries contain the information about the changes to the database.
Actually, this is a bit complicated issue. So no need to confuse you about the redo log entries details.
But we can simply say that, it has the changes made to the database with many details.

So where it is used?
If somehow you need to recover the database or a table to a previous state, you can use the redo log data for this recovery.
This is what DBAs can do. As a programmer you don’t have the privilege to do that.

These redo log entries are stored in the redo log buffer in the SGA. Redo log buffer is a memory area that stores these entries for some time.
When you commit what you did, or when the buffer gets full, the log writer process gives a system change number to these redo log entries, and write them to the redo log files in the redo log discs.

Actually, it does not wait for all the buffer to be filled to write it. It writes when the buffer is one-third full.
But this is a technical issue. Not so important for us.
 And generally, the log writer process does not wait these things to happen.
So it runs in every 3 seconds and writes these to the disc. 

Like all the others this memory area is finite and because of that, it is created as a circular buffer.
That means, when it is full, the server starts writing to it starting from the beginning.

Since this is a circular action, they call this kind of buffers as circular buffers. But sometimes, the redo log is filled before you commit all the changes.

This time, the change is saved to the redo log files by the log writer process and if you rollback, they are deleted from there. Because since the memory is limited, and since the server must store all the changes, they needed to take an action like that.

By the way. Do not confuse about the rollback. Rollback is not done with these redo files.
It has a different mechanism. Redo is for the recovery.
 But when you rollback since you did not do any change, in the end, the related redo files are deleted, too.

To sum up, all the changes are stored as the redo log entries in the redo log buffer until we commit or redo log buffer gets full. 
After the commit or memory limit exceeds, they are stored into the redo log files in the disc.

So whenever you need to recover the database or a table to its previous state, or a period of time, it can easily be done by using the redo log files. But recovery is done when something unexpected happens like system crash or something like that.
So do not think that rollback is done with the redo log files.
It is done in some other ways. But the importance of the redo logs for our course is, each change in the database will create a redo log entry and this will have a cost on the database.
So we need to consider this issue in tuning techniques.
