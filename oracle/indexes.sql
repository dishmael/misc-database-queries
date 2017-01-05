--
column table_name 	format a30
column index_name 	format a30
column degree 		format a6
column num_rows 	format 999,999,999,999
column column_name 	format a20
-- 
SELECT	 u.table_name, u.index_name, u.status, u.degree, u.num_rows, u.last_analyzed
FROM	 user_indexes u
WHERE	 u.table_owner='REPORTER'
ORDER BY u.table_name
/
--
exec dbms_output.put_line('Press ENTER to continue')
pause
break on table_name skip 1
--
SELECT	 u.table_name, u.index_name, d.column_name
FROM	 user_indexes u, dba_ind_columns d
WHERE	 u.index_name = d.index_name AND u.table_owner='REPORTER'
ORDER BY u.table_name, u.index_name, d.column_name
/
--
clear col break
