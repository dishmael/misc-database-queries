--
repheader page left "Report: Scheduled Jobs"
--
column job_name			heading "Job Name"			format a30
column state			heading "State"				format a10
column owner 			heading "Owner"				format a15
column next_run_date 	heading "Next Run Date"		format a25
column last_run_date 	heading "Last Run Date"		format a20
column run_duration 	heading "Last Run Duration"	format a30
column run_count 		heading "Run Count"			format 999,999
column failure_count 	heading "Failures"			format 999,999
--
SELECT
	job_name,
	state,
	--owner,
	to_char(last_start_date, 'DD-MON-YYYY') as last_run_date,
	--nvl(to_char(next_run_date, 'DD-MON-YYYY'), schedule_name) as next_run_date,
	--job_class,
	extract( DAY from last_run_duration ) || ' days '  
		|| extract( HOUR from last_run_duration ) || ' hours ' 
		|| extract( MINUTE from last_run_duration ) || ' minutes' as run_duration,
	run_count,
	failure_count
FROM
	dba_scheduler_jobs
WHERE
	enabled = 'TRUE'
ORDER BY
	to_char(last_start_date, 'DD-MON-YYYY HH24:MI:SS')
/
repheader off
