--
COL table_name 	HEAD 'Table Name' 	FORMAT a25
COL index_name 	HEAD 'Index Name' 	FORMAT a30
COL index_type 	HEAD 'Index Type' 	FORMAT a15
COL degree 		HEAD 'Parallel'		FORMAT a10
--
SELECT table_name, index_name, index_type, status, degree
FROM user_indexes
/
