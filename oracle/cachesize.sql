--
repheader page left 'Report: DB Cache Adviser'
--ttitle right 'Page: ' format 999 sql.pno
--
col size_for_estimate heading "Size (M)|" format 999,999
col size_factor heading "Size Factor|" format 90.99
col buffers_for_estimate heading "Buffers|" format 999,999,999
col estd_physical_read_factor heading "Estmate Physical|Read Factor" format 90.99
col estd_physical_reads heading "Estimate Physical|Reads" format 999,999,999
col cur heading "Current|" format a7
--
SELECT
	size_for_estimate,
	size_factor,
	buffers_for_estimate,
	estd_physical_read_factor,
	estd_physical_reads,
	CASE WHEN size_factor = estd_physical_read_factor THEN 'YES' ELSE '' END CUR
FROM
	v$db_cache_advice
/
repheader off
ttitle off
