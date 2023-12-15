/**DATABASE STORAGE ARCHITECTURE 

Hi. In this lecture, you will see the overall picture of the Oracle database storage management. 
When we say storage for the Oracle database, you should think about the files stored in the discs. 
The memory is not considered as storage in Oracle.

As we can see on the schema, Oracle database has many different storage files in it
So in this lecture, I will explain them to you basically. 

The first storage file is, control file. 
A control file includes the physical database structure information about the database itself.
These files are really critical for the database.
 Because without them, you cannot access to data in the database.

The second one is the data files. 
As the name implies, these files store the actual data of the database. 
Our tables, procedures, application data etc are all stored in these files.

The third one is the online redo log files. 
As we remember from our previous lectures, the redo log entries are stored from the buffer cache to the online redo log files.
These files are for the recovery of the database if any system crash occurs. 
This guarantees to prevent any data loss in the database. 

The next one is the archived redo log files.
The online redo log files should be fast so it must be lightweight and mostly empty for the new entries.
To do that, the data in the online redo log files are constantly moved to the archived redo log files to provide more space in the online redo log files.

The next one is the backup files. Backup files are also used for database recovery.
Most of the times, the companies create one or more backup discs for the actual data. 
The exact copy of the data in our data files is stored in these discs. 
And these discs are mostly in different places from the data discs.

So if any damage occurs in the data discs, maybe because of a fire, or a flood etc, the database directly starts working with the backup files.
Or you can recover your database from these backup files, too.
So these files are the copies of the real data files and used for disaster recovery.

The next one is the parameter file. This file includes the configure data of the database instance. 
It has the database parameters.

The next one is the password file. 
This file includes the passwords of the admin users like sysdba, sysoper and sysasm.
So these users can connect with these passwords and perform administrative tasks. 

The last one is the alert log and trace files. 
The alert log files store the log of messages and errors occurred in the database.
And the trace files store the error trace info of the process.
It has lots of information about the error to trace it.

ome of them are useful for the developers and some of them are specialized for the Oracle support service.

Great!

In this lecture, I explained the database storage architecture basically to have you see the overall picture.
Because, you might see these files in your company or in this course so many times.
So you need to know what they are at least this much.
Alright.
This is the end of this lecture.
See you in the next lectures.