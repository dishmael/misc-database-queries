SELECT	concat( table_schema, '.', table_name ) as table_name,
		ifnull( partition_name, 'No Partitions' ) as partition_name,
		format(table_rows, 0) as table_rows
FROM	information_schema.partitions
WHERE	table_schema in ( 'alerts', 'lightsquared', 'REPORTER' )
