--
set serveroutput ON
set feedback off
set linesize 200
set ver off
set long 55000
--
COL procs FORMAT a40 HEAD 'List of Stored Procedures'
PROMPT
--
-- Show the list of stored procedures for the user name
SELECT	TO_CHAR(rownum,'999') || ' - ' || object_name as procs
FROM	(SELECT		object_name 
         FROM		User_Objects
         WHERE		object_type = 'PROCEDURE'
         ORDER BY	object_name)
/
--
ACCEPT WHICH PROMPT "Enter the number of the Procedure you wish to see: "
--
prompt
prompt
COL code FORMAT a120
--
SELECT	'Procedure Name: ' || object_name || chr(10) || chr(10) ||
		dbms_metadata.get_ddl( 'PROCEDURE', object_name ) || chr(10) || '/' as code
FROM	(SELECT	rownum rn,object_name
         FROM	(SELECT	object_name 
				 FROM		user_objects
				 WHERE	object_type = 'PROCEDURE'
				 ORDER BY object_name))
WHERE	rn = &which;
--
PROMPT 
PROMPT
/
--
CLEAR COL BREAK COMPUTE
