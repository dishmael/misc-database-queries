column username format a10
column optimizer_mode heading MODE
colum sql_text format a75 word_wrap

SELECT
	sesion.sid,
	sesion.serial#,
	sesion.username,
	--sesion.sql_id,
	--sesion.sql_child_number,
	optimizer_mode,
	--hash_value,
	--address,
	--status,
	sql_text
FROM
	v$sqlarea sqlarea, v$session sesion
WHERE
	sesion.sql_hash_value = sqlarea.hash_value and
	sesion.sql_address = sqlarea.address and 
	sesion.username is not null
/
