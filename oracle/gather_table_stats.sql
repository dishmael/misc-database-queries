exec dbms_stats.gather_table_stats( -
	ownname => 'reporter', -
	tabname => 'status', -
	degree  => 4 -
)
/
