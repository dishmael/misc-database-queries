--
COL grantor			HEAD 'Grantor'		FORMAT a15
COL grantee			HEAD 'Grantee'
COL table_schema	HEAD 'Schema'
COL table_name		HEAD 'Package'
COL privilege		HEAD 'Privilege'	FORMAT a10
spool packages.out
--
SELECT
	grantor,
	grantee,
	table_schema,
	table_name,
	privilege
FROM
	all_tab_privs JOIN all_objects ON (table_name = object_name)
WHERE
	object_type = 'PACKAGE' AND privilege = 'EXECUTE'
ORDER BY
	table_name
/
--
spool off
clear col
