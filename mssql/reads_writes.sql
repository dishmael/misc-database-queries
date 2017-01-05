SELECT
	DB_NAME(database_id),
	SUM(user_seeks + user_scans + user_lookups) AS 'User Reads',
	SUM(user_updates) AS 'User Writes',
	SUM(system_seeks + system_scans + system_lookups) AS 'System Reads',
	SUM(system_updates) AS 'System Writes',
	SUM(user_seeks + user_scans + user_lookups + system_seeks + system_scans + system_lookups) AS 'Total Reads',
	SUM(user_updates + system_updates) AS 'Total Writes'
FROM sys.dm_db_index_usage_stats
GROUP BY database_id;

select * from sys.dm_db_index_usage_stats;