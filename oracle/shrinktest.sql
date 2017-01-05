-- This script was written by Tom Kyte and retrieved from asktom.oracle.com
-- http://cglendenningoracle.blogspot.com/2009/08/how-do-i-shrink-datafiles-to-reclaim.html
--set pages 0
set lin 150
set verify off
--
column file_name format a32 word_wrapped
column smallest heading "Possible (MB)" format 999,990
column currsize heading "Current (MB) " format 999,990
column savings  heading "Savings (MB) " format 999,990
column sum format 999,999,999
--
break on report
compute sum of savings on report
--
column value new_val blksize format a10 heading "Block Size" 
--
select value from v$parameter where name = 'db_block_size'
/

select regexp_substr(file_name, '([a-zA-Z0-9_\.]+)$') as file_name,
       ceil( (nvl(hwm,1)*&&blksize)/1024/1024 ) smallest,
       ceil( blocks*&&blksize/1024/1024) currsize,
       ceil( blocks*&&blksize/1024/1024) -
       ceil( (nvl(hwm,1)*&&blksize)/1024/1024 ) savings
from dba_data_files a,
     ( select file_id, max(block_id+blocks-1) hwm
         from dba_extents
        group by file_id ) b
where a.file_id = b.file_id(+)
order by file_name
/

column cmd heading "Datafile Resize Command" format a95 word_wrapped

select 'alter database datafile '''||file_name||''' resize ' ||
       ceil( (nvl(hwm,1)*&&blksize)/1024/1024 )  || 'm;' cmd
from dba_data_files a,
     ( select file_id, max(block_id+blocks-1) hwm
         from dba_extents
        group by file_id ) b
where a.file_id = b.file_id(+)
  and ceil( blocks*&&blksize/1024/1024) -
      ceil( (nvl(hwm,1)*&&blksize)/1024/1024 ) > 0
/
