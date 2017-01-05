col sql_text format a60
--
SELECT
	sql_text,
	--command_Type,
	rows_processed,
	round((sysdate-to_date(first_load_time,'yyyy-mm-dd hh24:mi:ss'))*24*60,1) minutes,
	trunc(rows_processed/((sysdate-to_date(first_load_time,'yyyy-mm-dd hh24:mi:ss'))*24*60)) rows_per_min
FROM
    v$sqlarea sqlarea, v$session sesion
WHERE
    sesion.sql_hash_value = sqlarea.hash_value and
    sesion.sql_address = sqlarea.address and
    sesion.username is not null and
	open_versions > 0 and
	command_type in (
		1,	-- create
		2,	-- insert
		6,	-- update
		7	-- delete
	)
/
