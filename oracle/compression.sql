--
--
SELECT	table_name, partition_name, compression
FROM	user_tab_partitions
WHERE	table_name='REPORTER_STATUS'
/
