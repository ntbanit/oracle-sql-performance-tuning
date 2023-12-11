/*** SHARED POOL 

The shared pool is one of the SGA components. SGA has some components that shared by all the sessions.

 As you remember, shared pool has some sub-memories, too. Library cache, data dictionary cache, result cache, and some other caches. We can think shared pool as the container of these sub-caches.

The first one is, data dictionary cache. In a middle scale database, hundreds or maybe thousands of sessions are making some operations in one second.
And the point is, most of them are doing pretty similar things.
For example, if your database has a salary table, most of the customers query from the salary table with different parameters.

When you run an SQL query, there are some steps that need to be done before the execution.
You will see how an SQL query is executed in the further lectures but for now, let me explain you very simply.
When you run an SQL query, the database first needs to check if the table or columns that you typed is true.
I mean if these are there in the database or not.
Or, checks if you have the right privilege to reach to these objects or not.
Or, if you used select star, the database needs to know which columns represent the star.
I mean, what are the columns of that table.
So there will be no need to go to the discs and check these data again and again.
It seems so fast for a single user, but
if we think thousands of users per second, it will be very costly.
So, the data dictionary cache stores the definitions of the database objects and their permissions.

The next sub-memory area of the shared pool is, result cache.
If a query is being used repeatedly in time, the result of that query is stored in the result cache and used for the next calls.
As you might have realized, if you run a query for the first time, it returns in a couple seconds.
But if you run the same query again, it returns immediately. Because in the second time, the result is returned directly from the result cache instead of the disc read.
So it is so fast. Result cache does not only store the query results, but also stores the function results.
If a function is repeatedly used with returning the same result, it will also be stored in here and handled to the next call from the result cache.
Of course, depending on how much its size is allocated and how many different queries or functions are executed, the result cache stores the most commonly used data. When it reaches to the maximum memory, it deletes the least used one and inserts the new one. So, storing data in a result cache increases the performance so much.
But this is not something that we do.
It is done by the database automatically.
However, sometimes we may need to command the result cache to store our data or not to store it. We can do that in some ways, and you will see how to do that in the further lectures.

The next sub-memory area is the library cache.
As I had mentioned before, when you run an SQL query, the database does not directly go to the discs and start reading. Because there are maybe terabytes of data in the database and may be your tables will have gigabytes of it.
So trying to read directly will not be so efficient.
In order to do that, Oracle creates some execution plans about how to read the data from the discs or from the buffer cache.
It may use some indexes, or maybe reading the whole table will be better, or joining the tables by which type of join methods will be more efficient etc.
There are hundreds of ways to execute your query and the server needs to find the best plan. So generating this plan is a costly operation.
The server needs to lookup many places, views, statistics etc. to generate it.
So it takes some time and many I/O operations. But most of the times, we see that, many of these queries are very similar. Or sometimes exactly the same.
So, using the same execution plan for similar queries will be much efficient.
In order to do that, Oracle stores these execution plans in the library cache, actually in the shared SQL areas in the library cache and when another session, or maybe your session uses the same query now it knows how to read the data easily.
So this will improve the performance so much. In addition to the queries and their execution plans the library cache stores the procedures and packages, and the control structures like locks, too. Great!

To sum up, basically, the shared pool checks the dictionary cache if your query is a suitable query, and checks the library cache if there are any execution plans created before for this query.
If yes, it uses that plan directly. 
And checks if there is any result in the result cache for this query. 
If yes, it returns that result directly. 
And if not, it goes to the disc or buffer cache based onthe execution plan.
If there is no execution plan in the library cache, it creates a new one and goes to the disc or buffer cache with the new plan.
*/