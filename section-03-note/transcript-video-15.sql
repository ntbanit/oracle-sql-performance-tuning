/**UNDO TERM 

Hi. In this lecture, you will see the undo term basically. 
We will mention the undo in the further lectures, and in the previous lectures, we said that, rollback is done with another way.
So in this lesson, you will see what is "undo" and how a change in the database is recovered or applied a rollback with the undo operations.
When a transaction modifies any data, the database server copies the original data from the disc and stores them into the memory before modifying it. 
The original copy of the related data is called as "undo data". 
Then, another copy of the related data is also written into the buffer cache and all the changes are done in these blocks.
So undo data is kept unchanged.
There are a couple reasons for that.

The first one is, if you want to rollback your changes, or if your changes needed to be roll-backed because of a system failure etc, the undo blocks are used for the rollbacks.

The second one is, providing read consistency.
We know that, when we make any change to the tables, only we can see these changes until we commit them.
This is provided by the undo data.
The server reads the undo data for the other users who need to get the changed data.
Since they are still the same as the original data, the other users do not see the changes.
They see what writes in the undo segments. 
But you see the changes because the server reads the changed  blocks by your session from the buffer cache.
However, this is not guaranteed for all the time. 
The database guarantees the operations done in 15 seconds.
But a DBA can guarantee to store all the changes by altering its tablespace.

The third reason is, providing the flashback feature.
With flashback feature you can recover the database to a certain point, or you can view the changes made in time.
When we do our changes I mean when we commit all the changes, the undo data is stored for some time.
The reason for that is for providing the flashback feature, and for enabling the other users to read consistently for the long queries.

What I mean is, if you update a row that another user is still reading, it is better to send the old value to the user. 
So the undo data is stored for a while to provide that.
Alright. You may see the undo mostly with undo segments.
So I want to explain to you briefly what segment means.

We know that, a block is the smallest logical group of data in memory or discs.
The next level, I mean the larger one of the logical database space is, extents. 
And the larger one is called as segments.
The one on the right side includes a group of the left side. 
So we can think segments as a larger memory area which includes a group of extents.
A larger memory area including segments is called as tablespace.
We will see all these more detailed in the further lectures. 
Great! 
Undo operation is a detailed subject, so we will not go so deep in this course. 
But since we will mention in the further lectures, it is good to know so much at that point
