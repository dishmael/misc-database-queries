col GROUP# heading Group#
col SEQUENCE# heading Sequence# format 999,999
col BYTES heading "Size (MB)" format 999,999
col MEMBERS heading Members format 9999999
col STATUS heading Status
col NAME heading "File Name" format a60
--
SELECT
	log.GROUP#,
	log.SEQUENCE#,
	(log.BYTES/1024/1024) BYTES,
	--log.MEMBERS,
	--SUBSTR( log.ARCHIVED, 1, 1 ) ARCHIVED,
	log.STATUS,
	logfile.MEMBER NAME
FROM
	v$log log left join v$logfile logfile on log.GROUP# = logfile.GROUP#
ORDER BY
	log.GROUP#
/
