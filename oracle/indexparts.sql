--
repheader page left "Report: Index Partition Statistics"
--
col partition_name	heading Partition
col num_rows		heading 'Row Count' format 999,999,999
col last_analyzed	heading 'Analyzed'
col status 			heading 'Status'
--
break on report
compute sum label 'Total Rows' of num_rows on report
--
SELECT
	partition_name,
	num_rows,
	last_analyzed,
	status
FROM
	user_ind_partitions
/
repheader off
clear col
