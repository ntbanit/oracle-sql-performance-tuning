/**BUFFER CACHE 

The database buffer cache is the largest memory area in the SGA. This memory area stores the copies of the data blocks that are read from the database discs.

As this area is in the SGA, this data is available for all the users.

So when the first user runs a query, the related data is read from the disc and stored into the buffer cache.
So when any other user, or maybe the same user wants to reach to the same data, before checking the disc the server checks the buffer cache first.
If all the data we need is already in the buffer cache, it can read the data from the buffer cache directly.
If some of the data is not there but some of it is already in the buffer cache, it goes to the discs only for the absent blocks.
If there is no related data with our query in the buffer cache, the server reads all the data from the disc into the buffer cache.

So why to read into the buffer cache?
Of course, the reason is, it is much faster than the database discs.
So if the same data will be used for the next times, it’s better to store it in the memory.

But let me explain with another way to let you understand better.

If you are making a join operation. Let’s say it is a Cartesian product, then all the rows of the first table will be joined with the other one.
Or if it is a nested join, it will be like that.
So I mean, the data is read maybe several times.

If we do that by reading from the disc all the time, it would be a very costly operation.
So the data is stored in the buffer cache and read from here rapidly.
It is maintained with a complex algorithm 
Since the size of the memory is finite, we cannot store all the data in the buffer cache.
This kind of databases are called "in-memory databases". But storing all the data in the memory is really expensive and Oracle does not do that in this way.
It stores "some" of the blocks. 
So the buffers in the buffer cache are managed by a complex algorithm.
It stores the most recently used data and the most touched ones.
So it deletes the first stored one, but if it is frequently read from the cache it does not delete it. Instead, it deletes the least used one among the most aged ones.
The database write processes handle the write operations to the disc.
Between the buffer cache and the database files we have the database write processes.
 As we saw in the overview lecture, the buffer cache can read from the disc and can write to the disc, too. 
 Actually, it is not done by the buffer cache. Because it isa memory and cannot make any process.
So, reading from the disc is handled by the server. It reads the related data from the disc and stores it into the buffer cache. To write to the disc from the buffer cache, Oracle uses database writer processes.

This is also important. Because let’s say, if you make an update statement on a block in the buffer cache, it is not updated directly to the disc.
You make the update to the block in the buffer cache and when you commit, these blocks are written to the disc with using the database writer processes.
This also increases the performance because instead of writing one by one, it writes all the changed blocks in one step.
These changed blocks are called as "dirty blocks" in the database terminology.

Not only storing the table data, buffer cache stores the index data, too. Because if an index is commonly used, it will be efficient to store its data, too. As we remember, indexes are also stored in the database blocks and we can easily store these blocks into the buffer cache and reach to them rapidly.

So basically, a database buffer cache stores the recent and most commonly used blocks in it, for a faster access in the next usages. 
As you have learned, if your query needs exactly the same data, it will most probably come from the result cache if it is not deleted from there.
 But even if you write a different query asking for the data that the server read before, since it is stored in the buffer cache, your query will be much faster than the first call

So buffer cache increases the performance for not only the same query, but also the queries ask for the same table or same index.