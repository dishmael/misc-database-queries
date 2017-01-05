--
COL referenced_name		HEAD 'Table'		FORMAT a30
COL name				HEAD 'Dependency'	FORMAT a25
COL type				HEAD 'Type'			FORMAT a15
COL referenced_type		HEAD 'Type'			FORMAT a15
COL dependency_type		HEAD 'Dep Type'		FORMAT a10
--
SELECT		referenced_name, name, type referenced_type, dependency_type
FROM		user_dependencies
WHERE		referenced_owner = 'REPORTER'
ORDER BY	referenced_name
/
--
CLEAR COL BREAK COMPUTE
