col event 			heading "Event"				format a45
col total_waits 	heading "Total Waits"		format 999,999,99
col time_waited 	heading "Time Waited (m)"	format 999,990.09
col average_wait	heading "AVG"				format 999,990.09
col max_wait		heading "MAX"				format 999,999
--
break on report
compute sum label "Totals" of time_waited on report
compute sum label "Totals" of average_wait on report
compute sum label "Totals" of max_wait on report
--
SELECT
	se.sid,
	se.event,
	se.total_waits,
	(se.time_waited/1000/60) time_waited,
	se.average_wait average_wait,
	se.max_wait max_wait
FROM
	v$session_event se left join v$session s on s.sid = se.sid
WHERE
	(se.time_waited/1000/60) > 1 AND
	se.event not like 'SQL*Net%' AND
	s.username is not null
ORDER BY
	1,4
/
