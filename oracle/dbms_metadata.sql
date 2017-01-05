--
--set pagesize 0
set long 90000
--spool results.out
--
SELECT dbms_metadata.get_ddl('TABLE', 'REPORTER_STATUS_NEW') from dual
/
--
--spool off
