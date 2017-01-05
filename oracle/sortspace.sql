--
column sid_serial  head 'SID,Serial' format a10
column username    head 'Username'   format a10
column osuser      head 'OS User'    format a10
column spid        head 'SPID'       format a10
column module      head 'Module'     format a10
column program     head 'Program'    format a30
column mb_used     head 'Used (MB)'  format 99,990
column tablespace  head 'Tablespace' format a15
column sort_ops    head 'Sort Ops'   format 9,999
--
SELECT   S.sid || ',' || S.serial# sid_serial, S.username, S.osuser, P.spid, S.module,
         S.program, SUM (T.blocks) * TBS.block_size / 1024 / 1024 mb_used, T.tablespace,
         COUNT(*) sort_ops
FROM     v$sort_usage T, v$session S, dba_tablespaces TBS, v$process P
WHERE    T.session_addr = S.saddr
AND      S.paddr = P.addr
AND      T.tablespace = TBS.tablespace_name
GROUP BY S.sid, S.serial#, S.username, S.osuser, P.spid, S.module,
         S.program, TBS.block_size, T.tablespace
ORDER BY sid_serial
/
