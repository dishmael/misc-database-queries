col file_name heading "File Name" format a40
col tblsize heading "Table Size (MB)" format 999,999,999
col maxsize heading "Max Size (MB)" format 999,999,999
col autoextensible heading "Ext"
--
select
	file_name,
	status,
	autoextensible,
	(bytes/1024/1024) as tblsize,
	(maxbytes/1024/1024) as maxsize
from
	dba_temp_files
where
	tablespace_name = 'TEMP'
/
