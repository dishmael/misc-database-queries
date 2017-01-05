--
COL table_name		HEAD 'Table Name'
COL logging			HEAD 'Log'
COL degree			HEAD 'Parallel'		FORMAT 99
COL num_rows		HEAD 'Rows'			FORMAT 999,999,999,999
COL last_analyzed	HEAD 'Analyzed'
--
BREAK ON REPORT
COMPUTE SUM LABEL 'Total' OF num_rows ON REPORT
--
SELECT		owner, table_name, logging, degree, num_rows, last_analyzed
FROM		all_tables
ORDER BY	table_name
/
--
CLEAR COL BREAK COMPUTE
