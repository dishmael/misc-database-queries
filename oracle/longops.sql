col opname			heading 'Operation (sid, session)'	format a30
col target			heading 'Target'					format a25
col sofar			heading 'Complete'					format 999,999,999
col totalwork		heading 'Total'						format 999,999,999
col pct_complete	heading 'Prog (%)'					format 990.99
col time_remaining	heading 'Remain (m)'				format 999,999
col message			heading 'Message'					format a35
select
	opname || ' (' || sid || ', ' || serial# || ')' opname,
	substr(target, instr(target, '.', 1, 1) + 1) target,
	--sum(sofar) sofar,
	--sum(totalwork) totalwork,
	substr(message,instr(message, ':', 1, 2) + 2) message,
	((sum(sofar)/sum(totalwork)) * 100) pct_complete,
	(sum(time_remaining)/60) time_remaining
FROM
	v$session_longops
WHERE
	--username = 'REPORTER' AND
	time_remaining > 0
GROUP BY
	sid, serial#, opname, target, message
ORDER BY
	target, opname
/
