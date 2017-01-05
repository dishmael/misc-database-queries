-- NOTE: Use the returned sql_id to query sql_text from v$sql
col username format a15
--
SELECT
	username,
	session_num,
	sql_id,
	tablespace,
	contents,
	segtype,
	segblk#,
	extents
FROM
	v$tempseg_usage
/
