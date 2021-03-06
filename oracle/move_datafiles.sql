-- The following is an example of moving datafiles
--
-- 1) View Datafiles
-- SQL> SELECT name FROM v$datafile;
--
-- 2) Shutdown Database (sqlplus sys/oracle as sysdba)
-- SQL> SHUTDOWN IMMEDIATE
--
-- 3) Move the Datafiles
-- SQL> HOST MV /directory/source /directory/destination
--
-- 4) Startup the Database
-- SQL> STARTUP MOUNT
--
-- 5) Rename the File Destinations
-- SQL> ALTER DATABASE RENAME FILE '/directory/source' TO '/directory/destination';
--
-- 6) Open the Database
-- SQL> ALTER DATABASE OPEN;
--
-- 7) View Datafiles
-- SQL> SELECT name FROM v$datafile;
