--
COL table_name	HEAD 'Table Name'
COL num_rows	HEAD 'Rows'			format 999,999,999,999
--
BREAK on REPORT
COMPUT SUM LABEL "Total Rows" of num_rows ON REPORT
--
SELECT		table_name, num_rows
FROM		user_tables
ORDER BY	table_name
/
