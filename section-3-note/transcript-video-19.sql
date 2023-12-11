/** LOGICAL AND PHYSICAL DATABASE STRUCTURE 

Hi. In this lecture, you will learn the logical and physical database structures briefly. As we know the discs store the data in individual bits.
These bits are sequential.
So if you want to store a data of 4-bits, it is stored in the sequential 4-bits most of the times.
Actually, the disc management is organized by the operating systems.
So, they do that in a different way.
They have an allocation unit size like 2 kilobytes etc.
So even if you write 1 byte of data, it will write that into one unit. 
So the rest of the allocation unit will be empty.
Anyway. This is not our subject. 
But, this is used in the logical memory structure of Oracle database.
As we have learned from the data blocks lecture, a data block is the smallest unit of the memory and disc in the database structure.
You can specify a size between 2 kilobytes and 32 kilobytes of space for the data blocks in Oracle.
So, this will mean the combination of many individual operating system data blocks.
And because of that, block structure is a logical structure.
So even if you write your data in one database data block, it might be written in different operating system allocation units. 
We know data blocks well.
So let’s see the others now. The next level of logical database storage in Oracle database is, extents.
An extent is the combination of several consecutive data blocks.
Extents are used for storing a specific type of information. 
A segment is the combination of many extents.
There are 4 types of segments which are data segments, index segments, undo segments and temporary segments.
The first 3 can be understood from their names. 
The temporary segments are created to provide a temporary work area for the SQL statements to complete the executions. 
Segments are designed to store some big data like tables, indexes, etc.
But as we can understand, while our table is stored in the data segments, our indexes are stored in index segments. 
Not in the same segments.
The next memory areas are the tablespaces. 
Tablespaces are the combinations of the segments.
They are the greatest logical data unit in the database.
They are created to group the related data in one container.
For example, you can create a tablespace and collect all the data of an application in one tablespace.
In here I think tablespace subject is important. 
Because it has some benefits for some tuning issues.
So let’s go a little deeper for the tablespace issue.
There are two types of tablespaces. 
Temporary tablespace and Permanent tablespace.
A temporary tablespace contains temporary data that needs to be stored for only the duration of a session.
The data in temporary tablespaces are stored in the temporary files. 
Permanent tablespace has the persistent schema objects.
This type of tablespace is stored in data files. 
A database must have at least 2 tablespaces.
They are SYSTEM tablespace and SYSAUX tablespace. 
But, there can be more tablespaces if created by the DBAs.
Each user is assigned to a default permanent tablespace.
So every data of that user is stored this tablespace. 
So all the data created under a specific schema is stored in the assigned tablespace.
It is recommended to create more tablespaces since this will have many benefits. With tablespaces, you can control the disc space allocation for the database data.
You can assign a disc quota for a database user by assigning that user to that tablespace and specifying the size of that tablespace.
You can make some operations to a single tablespace in order to make it to the whole database.
For example, you can take an individual tablespace to online or offline status, or you can perform backup or recovery to an individual tablespace, or import or export the data of an individual tablespace or even you can create a transportable tablespace and move that tablespace to another database.
Actually, this subject is also a detailed subject.
So no need to go deeper at this point.

You will most probably see the data block and tablespace names on this course.
But sometimes we may need to refer to the other logical structures.
So it will be good to know these subjects at least so much.

The last one to touch here is, schema. You must have known what the schema is, but if I need to explain simply I can say that, a schema is the collection of database objects that are owned by a database user.
These objects are tables, views, procedures, etc.
So a schema object is a logical structure that can directly refer to the data in the database.

Alright. In this lecture, you saw the logical and physical structure of the database.
Some of them are explained very basically and some are in a bit detailed way.
All the architecture subjects are really detailed subjects and can take days to explain them all.
So I explained as how much you need to know for this course. But you can check Oracle’s documentation from the internet for further knowledge.

So this is the end of this lecture.

See you in the next lectures.