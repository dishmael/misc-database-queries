-- Locks
--SELECT * FROM sys.dm_os_performance_counters WHERE counter_name LIKE '%Lock%' ORDER BY counter_name;

-- Full View
SELECT	 object_name, 
		 RTRIM(SUBSTRING(object_name, CHARINDEX(':', objecT_name) + 1, (LEN(object_name) - CHARINDEX(':', objecT_name)))) AS object_nice_name,
		 RTRIM(counter_name) AS counter_name,
		 RTRIM(instance_name) AS instance_name,
		 cntr_value
FROM	 sys.dm_os_performance_counters;