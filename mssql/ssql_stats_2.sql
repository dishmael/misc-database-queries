IF object_id('tempdb..#CPUSTATS') IS NOT NULL BEGIN
	DROP TABLE #CPUSTATS
END
DECLARE @FirstCollectionTime DateTime
    , @SecondCollectionTime DateTime
    , @NumberOfSeconds Int
SELECT TOP(1) SQLProcessUtilization AS 'cpu_util'
	, cpu_idle			= (SystemIdle * 1.)
	, cpu_busy			= (100 - (SystemIdle * 1.))
	, cpu_other_util	= (100 - ((SystemIdle * 1.) - (SQLProcessUtilization * 1.)))
INTO #CPUSTATS
FROM ( 
	SELECT record.value('(./Record/@id)[1]', 'int') AS record_id
		, record.value('(./Record/SchedulerMonitorEvent/SystemHealth/SystemIdle)[1]', 'int') AS [SystemIdle]
		, record.value('(./Record/SchedulerMonitorEvent/SystemHealth/ProcessUtilization)[1]', 'int') AS [SQLProcessUtilization]
	FROM (
		SELECT convert(xml, record) AS [record] 
		FROM sys.dm_os_ring_buffers 
		WHERE ring_buffer_type = N'RING_BUFFER_SCHEDULER_MONITOR' AND record LIKE '%<SystemHealth>%'
	) AS x 
) AS y 
ORDER BY record_id DESC
SELECT @@SERVERNAME AS 'Server Name'
	, 'Active Connections'			= p.connections
	, 'Total Database Size (MB)'	= d.total_db_size_mb
	, 'CPU Util (%)'				= s.cpu_util
	, 'CPU Other Util (%)'			= s.cpu_other_util
	, 'CPU Busy (%)'				= s.cpu_busy
	, 'CPU Idle (%)'				= s.cpu_idle
	, 'Total Memory (MB)'			= (CONVERT(FLOAT, m.total_physical_memory_kb) / 1024)
	, 'Total Avail Memory (MB)'		= (CONVERT(FLOAT, m.available_physical_memory_kb) / 1024)
	, 'Memory In Use (MB)'			= (CONVERT(FLOAT, i.physical_memory_in_use_kb) / 1024)
	, 'Memory Remaining (MB)'		= ((CONVERT(FLOAT, m.total_physical_memory_kb ) - CONVERT(FLOAT, m.available_physical_memory_kb)) / 1024)
	, 'Memory Remaining (%)'		= (((CONVERT(FLOAT, m.total_physical_memory_kb ) - CONVERT(FLOAT, m.available_physical_memory_kb)) / CONVERT(FLOAT, m.total_physical_memory_kb ) ) * 100)
	, 'Memory In Use (%)'			= (CONVERT(FLOAT, i.physical_memory_in_use_kb ) / CONVERT(FLOAT, m.available_physical_memory_kb) * 100)
	, 'Data Received/sec (KB)'		= ((@@PACK_RECEIVED * 4096) / 1024) / @@TIMETICKS
	, 'Data Sent/sec (KB)'			= ((@@PACK_SENT * 4096) / 1024) / @@TIMETICKS
	, 'Total Data/sec (KB)'			= (((@@PACK_RECEIVED * 4096) / 1024) + ((@@PACK_SENT * 4096) / 1024 )) / @@TIMETICKS
	, 'Packet Errors/sec'			= (@@PACKET_ERRORS / @@TIMETICKS)
	, 'IO Busy (ms)'				= (@@IO_BUSY * CAST( @@TIMETICKS AS FLOAT))
	, 'Total Reads/sec'				= ((@@TOTAL_READ * 1.) / @@TIMETICKS)
	, 'Total Writes/sec'			= ((@@TOTAL_WRITE * 1.) / @@TIMETICKS)
	, 'Total IO/sec'				= (((@@TOTAL_READ * 1.) + (@@TOTAL_WRITE * 1.)) / @@TIMETICKS)
	, 'Total Errors/sec'			= ((@@TOTAL_ERRORS * 1.) / @@TIMETICKS)
	, 'Product Version'				= CONVERT(VARCHAR, SERVERPROPERTY('productversion')) 
	, 'Product Level'				= CONVERT(VARCHAR,SERVERPROPERTY('productlevel'))
	, 'Server Edition'				= CONVERT(VARCHAR, SERVERPROPERTY('edition'))
FROM
	(SELECT COUNT(dbid) AS 'connections' FROM sys.sysprocesses WHERE dbid > 0) p,
	(SELECT CAST(SUM(size) * 8.0 / 1024 AS DECIMAL(8,2)) AS 'total_db_size_mb' FROM sys.master_files WITH(NOWAIT)) d,
	sys.dm_os_sys_memory m,
	sys.dm_os_process_memory i,
	#CPUSTATS s
DROP TABLE #CPUSTATS