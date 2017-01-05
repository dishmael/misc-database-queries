--
COL owner			HEAD 'Owner'
COL segment_name	HEAD 'Segment'		format a30
COL partition_name	HEAD 'Partition'	format a30
COL bytes			HEAD 'Size (MB)'	format 999,990.09
--
break on report
compute sum label 'Total Bytes' of bytes on report
--
SELECT		owner, segment_name, partition_name, (bytes/1024/1024) bytes
FROM		dba_segments
WHERE		owner = 'REPORTER'
ORDER BY	segment_name, partition_name
/
