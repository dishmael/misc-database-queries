--
COL table_name			HEAD 'Table Name'	FORMAT a25
COL constraint_name		HEAD 'Constraint'	FORMAT a30
COL constraint_type		HEAD 'Type'			FORMAT a4
COL status				HEAD 'Status'		FORMAT a10
COL search_condition	HEAD 'Condition'	FORMAT a30
--
SELECT
	table_name,
	constraint_name,
	constraint_type,
	status,
	search_condition
FROM
	user_constraints
--WHERE 
--	table_name = 'REPORTER_STATUS'
ORDER BY
	table_name, constraint_name
/
--
CLEAR COL BREAK COMPUTE
