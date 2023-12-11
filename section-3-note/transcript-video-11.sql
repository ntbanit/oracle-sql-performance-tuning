/** PGA
A PGA, which is the abbreviation of Program Global Area, or some people call it as Private Global Area is a memory area that contains a couple sub-areas in it.

Unlike the SGAs, PGAs are private for each user.
So any other user cannot see or touch to that memory area. In PGAs there are a couple of sub-memory areas. As you can see in the diagram these memory areas are Session Area, Private SQL Area, Cursors Area, and SQL Work Area.
Some of them are divided into more sub-areas individually.

The first one is the Session Memory Area. When a user connects to the database the database creates a session for that user. This session information is stored in this area. No need to go deeper but basically, this area stores the session’s variables, login information, session status etc. So, if you open unnecessary connections, you should know that, they all have some memory in the database.
So it is not good to have unnecessary connections.
It is extremely important when you use another language like Java or .net etc. Because sometimes you forget to close the connections and it causes some problems.

So you need to close all the connections when you are done with them. The next memory are is the Private SQL Area

It is divided into two sub-areas. Persistent area and run time area. The persistent area contains the bind variable values of the cursors.
We know from our SQL lessons that, each query is turned to a cursor in the database.
Either you create it as an explicit cursor or implicit cursor.
So the bind variables used in these cursors are stored in here and released when the cursor is closed. The other private SQL area component is the run time area.
It stores the execution state information.
I mean, did we start reading the tables, or how percentage we read till now, or did we finish reading etc.

The next memory area in a PGA is the cursor area. This area stores the information of the cursors. 

The next memory area is the SQL Work Area. This area is used to operate the data returned from the discs. As I have mentioned before the data is read from the discs with its memory order.
I mean how it is stored.
But most of the times, they need to be sorted, grouped, merged etc.
This area does these kind of operations. As you can see it is divided into 4 sub-areas. In the sort area the data read from the discs is sorted because of the order by, group by, roll-up or window commands of your queries. You can easily understand what the next ones do by their names.
They make hash join operations, bitmap merge and bitmap create operations. Not so crucial to know where all these are done, but we will learn what these mean in the further lectures. 

We can think that, basically, A PGA has 4 major memory areas. 
Session Memory Area,
Private SQL Area, 
Cursor Area, 
and SQL Work Area.
So what we understand from here is, all the session-specific operations are stored in the PGAs. And all the session-specific data operations are done in here.

But there is one more important thing here.
The size of the PGA is important.
If you assign less memory for the PGA, it will decrease the performance.
Assigning a large memory for the PGAs will significantly increase the performance specially for the sessions which needs a large memory.
There are two methods to assign the size of memory for the PGAs.
You can either specify the size by yourself and say that the PGAs will be 10 MB for example or you can let Oracle to automatically change it.

This feature is really good because while some sessions need very small memory, the other may need a very large memory. If you command the server to automatically allocate the memory, it will assign memory to the PGAs how much they need.

*/