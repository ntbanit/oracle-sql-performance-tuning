/** AUTOMATIC MEMORY MANAGEMENT 

Hi. In this lecture, you will see the Automatic Memory Management feature of the Oracle Database briefly.
Actually, these are the DBA subjects.
So I will give you a brief knowledge about these not to confuse you, since you are not a DBA most probably.
So you learn these to be able to say to your DBA that, maybe the shared pool is small, so it decreases the performance for example.
So if you know the exact problem, you may inform your DBAs more precisely. 
The size of each memory area is really important for the execution performance of our SQL codes.
So if one memory area is not enough it will decrease the performance of our queries.
But it is really difficult to manage all of these manually. 
To handle this problem, Oracle created "Automatic Memory Management" feature to manage the memory automatically between the memory areas. 
like how it does in the SGA, the server can manage the memory in PGA, too. 
So more memory will be assigned to more memory consuming PGAs and decrease the size of the memory of the less memory consuming PGAs. 
Between all the PGAs, there is an aggregated memory area which is a free memory for specifying more memory to the PGAs.
In the earlier versions of the Oracle Database, you need to specify the size of PGA’s manually. 
But now it can be managed automatically.
So it is recommended to leave automatic memory management enabled to increase the performance.

Alright.
This was a short lecture.
The main point here is, assigning the automatic memory management increases the performance of your queries in most cases, and prevents out of memory errors.

So this is the end of this lecture.
See you in the next lectures.