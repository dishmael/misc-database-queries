SELECT
        m.total_physical_memory_kb,
		m.available_physical_memory_kb,
		i.physical_memory_in_use_kb,
		CONVERT(FLOAT, i.physical_memory_in_use_kb ) / CONVERT(FLOAT, m.available_physical_memory_kb) * 100
    FROM sys.dm_os_sys_memory m, sys.dm_os_process_memory i;