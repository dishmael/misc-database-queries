--
repheader page left "Report: Partition Statistics"
--
col tablespace_name	heading	'Tablespace'	foramt a10
col table_name		heading 'Table Name'	format a30
col partition_name	heading 'Partition'		format a25
col logging			heading 'Log'			format a3
col high_value		heading 'High Value'	format a35
col num_rows		heading 'Row Count'		format 999,999,999,999
col last_analyzed	heading 'Analyzed'		format a16
--
break on report
compute sum label "Total Rows" of num_rows on report
--
SELECT
	tablespace_name,
	table_name,
	partition_name,
	--logging,
	--high_value,
	num_rows,
	TO_CHAR(last_analyzed, 'MM/DD/YYYY') last_analyzed
FROM
	all_tab_partitions
WHERE
	partition_name not like '%2014'
	--table_name = 'NEW_STATUS'
	--user = 'REPORTER'
	--table_name = 'STATUS'
ORDER BY
	table_name,
	partition_name
/
repheader off
