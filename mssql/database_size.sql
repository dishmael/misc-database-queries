SELECT 
      DB_NAME(database_id) AS 'Database',
	  state_desc AS 'State',
	  CAST(SUM(CASE WHEN type_desc = 'LOG' THEN size END) * 8. / 1024 AS DECIMAL(8,2)) AS 'Log Size (MB)',
	  CAST(SUM(CASE WHEN type_desc = 'ROWS' THEN size END) * 8. / 1024 AS DECIMAL(8,2)) AS 'Row Size (MB)',
	  CAST(SUM(size) * 8. / 1024 AS DECIMAL(8,2)) AS 'Total Size (MB)',
	  crdate AS 'Creation Date'
FROM sys.master_files M WITH(NOWAIT) LEFT JOIN sys.sysdatabases D ON M.database_id = D.dbid
--WHERE database_id = DB_ID() -- for current db 
GROUP BY database_id, state_desc, crdate;
