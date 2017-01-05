IF object_id('tempdb..#OSPC') IS NOT NULL BEGIN 
	DROP TABLE #OSPC
END
DECLARE @FirstCollectionTime DateTime
    , @SecondCollectionTime DateTime
    , @NumberOfSeconds Int
    , @BatchRequests Float
    , @LazyWrites Float
    , @Deadlocks BigInt
	, @ForwardedRecords Float
	, @LatchWaits Float
	, @LockWaits Float
	, @PageLife Float
    , @PageLookups Float
    , @PageReads Float
    , @PageWrites Float
	, @PageSplits Float
    , @SQLCompilations Float
    , @SQLRecompilations Float
    , @Transactions Float
	, @WorkfilesCreated Float
	, @WorktablesCreated Float
DECLARE @CounterPrefix NVARCHAR(30)
SET @CounterPrefix = CASE WHEN @@SERVICENAME = 'MSSQLSERVER'
						THEN 'SQLServer:'
						ELSE 'MSSQL$' + @@SERVICENAME + ':'
						END
SELECT counter_name, cntr_value
INTO #OSPC 
FROM sys.dm_os_performance_counters 
WHERE object_name like @CounterPrefix + '%'
    AND instance_name IN ('', '_Total')
    AND counter_name IN ( N'Batch Requests/sec'
                        , N'Buffer cache hit ratio'
                        , N'Buffer cache hit ratio base'
						, N'Forwarded Records/sec'
						, N'Extension free pages'
						, N'Latch waits/sec'
                        , N'Lock waits/sec'
						, N'Lazy Writes/sec'
                        , N'Memory Grants Pending'
                        , N'Number of Deadlocks/sec'
                        , N'Page life expectancy'
                        , N'Page Lookups/Sec'
                        , N'Page Reads/Sec'
                        , N'Page Writes/Sec'
						, N'Page Splits/Sec'
                        , N'SQL Compilations/sec'
                        , N'SQL Re-Compilations/sec'
                        , N'Target Server Memory (KB)'
                        , N'Total Server Memory (KB)'
                        , N'Transactions/sec'
						, N'Workfiles Created/sec'
						, N'Worktables Created/sec')
SELECT @SecondCollectionTime = GetDate()
SELECT @FirstCollectionTime = ISNULL(@FirstCollectionTime, (SELECT create_date FROM sys.databases WHERE name = 'TempDB'))
    , @BatchRequests		= ISNULL(@BatchRequests, 0)
    , @LazyWrites			= ISNULL(@LazyWrites, 0)
    , @Deadlocks			= ISNULL(@Deadlocks, 0)
	, @ForwardedRecords		= ISNULL(@ForwardedRecords, 0)
	, @LatchWaits			= ISNULL(@LatchWaits, 0)
    , @LockWaits			= ISNULL(@LockWaits, 0)
	, @PageLife				= ISNULL(@PageLife, 0)
	, @PageLookups			= ISNULL(@PageLookups, 0)
    , @PageReads			= ISNULL(@PageReads, 0)
    , @PageWrites			= ISNULL(@PageWrites, 0)
	, @PageSplits			= ISNULL(@PageSplits, 0)
    , @SQLCompilations		= ISNULL(@SQLCompilations, 0)
    , @SQLRecompilations	= ISNULL(@SQLRecompilations, 0)
    , @Transactions			= ISNULL(@Transactions, 0)
	, @WorkfilesCreated		= ISNULL(@WorkfilesCreated, 0)
	, @WorktablesCreated	= ISNULL(@WorktablesCreated, 0)
SELECT @NumberOfSeconds		= DATEDIFF(ss, @FirstCollectionTime, @SecondCollectionTime)
SELECT @@SERVERNAME AS 'Server Name'
    , 'Batch Request/sec'			= ((SELECT cntr_value FROM #OSPC WHERE counter_name = N'Batch Requests/sec') - @BatchRequests) / @NumberOfSeconds
    , 'Cache Hit Ratio'				= (SELECT cntr_value FROM #OSPC WHERE counter_name = N'Buffer cache hit ratio')/(SELECT cntr_value FROM #OSPC WHERE counter_name = N'Buffer cache hit ratio base')
    , 'Deadlocks'					= ((SELECT cntr_value FROM #OSPC WHERE counter_name = N'Number of Deadlocks/sec') - @Deadlocks)
	, 'Forwarded Records/sec'		= ((SELECT cntr_value FROM #OSPC WHERE counter_name = N'Forwarded Records/sec') - @ForwardedRecords) / @NumberOfSeconds
    , 'Free Pages'					= (SELECT cntr_value FROM #OSPC WHERE counter_name = N'Extension free pages')
	, 'Latch Waits/sec'				= ((SELECT cntr_value FROM #OSPC WHERE counter_name = N'Latch Waits/sec') - @LatchWaits) / @NumberOfSeconds
	, 'Lock Waits/sec'				= ((SELECT cntr_value FROM #OSPC WHERE counter_name = N'Lock Waits/sec') - @LockWaits) / @NumberOfSeconds
	, 'Lazy Writes/sec'				= ((SELECT cntr_value FROM #OSPC WHERE counter_name = N'Lazy Writes/sec') - @LazyWrites) / @NumberOfSeconds
    , 'Memory Grants Pending'		= (SELECT cntr_value FROM #OSPC WHERE counter_name = N'Memory Grants Pending')
    , 'Page Life Exp'				= ((SELECT cntr_value FROM #OSPC WHERE counter_name = N'Page life expectancy') - @PageLife) / @NumberOfSeconds
    , 'Page Lookups/sec'			= ((SELECT cntr_value FROM #OSPC WHERE counter_name = N'Page lookups/sec') - @PageLookups) / @NumberOfSeconds
    , 'Page Reads/sec'				= ((SELECT cntr_value FROM #OSPC WHERE counter_name = N'Page reads/sec') - @PageReads) / @NumberOfSeconds
    , 'Page Writes/sec'				= ((SELECT cntr_value FROM #OSPC WHERE counter_name = N'Page writes/sec') - @PageWrites) / @NumberOfSeconds
	, 'Page Splits/sec'				= ((SELECT cntr_value FROM #OSPC WHERE counter_name = N'Page splits/sec') - @PageSplits) / @NumberOfSeconds
    , 'SQL Compilations/sec'		= ((SELECT cntr_value FROM #OSPC WHERE counter_name = N'SQL Compilations/sec') - @SQLCompilations) / @NumberOfSeconds
    , 'SQL Recompilations/sec'		= ((SELECT cntr_value FROM #OSPC WHERE counter_name = N'SQL Re-Compilations/sec') - @SQLRecompilations) / @NumberOfSeconds
    , 'Server Memory Target (MB)'	= ((SELECT cntr_value FROM #OSPC WHERE counter_name = N'Target Server Memory (KB)') / 1024)
    , 'Server Memory Total (MB)'	= ((SELECT cntr_value FROM #OSPC WHERE counter_name = N'Total Server Memory (KB)') / 1024)
	, 'Server Memory Ratio'			= ((SELECT cntr_value * 1. FROM #OSPC WHERE counter_name = N'Total Server Memory (KB)') / (SELECT cntr_value * 1. FROM #OSPC WHERE counter_name = N'Target Server Memory (KB)')) * 100
	, 'Workfiles Created/sec'		= ((SELECT cntr_value FROM #OSPC WHERE counter_name = N'Workfiles created/sec') - @WorkfilesCreated) / @NumberOfSeconds
	, 'Worktables Created/sec'		= ((SELECT cntr_value FROM #OSPC WHERE counter_name = N'Worktables created/sec') - @WorktablesCreated) / @NumberOfSeconds
	, 'Collection Date'				= @SecondCollectionTime
DROP TABLE #OSPC