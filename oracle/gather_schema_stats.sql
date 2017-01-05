EXEC DBMS_STATS.gather_schema_stats(
	ownname          => 'REPORTER',
	tabname          => 'REPORTER_STATUS',
	options          => 'GATHER AUTO',
	estimate_percent => dbms_stats.auto_sample_size,
	method_opt       => 'for all columns size repeat',
	cascade          => true,
	degree           => 8
)
/
