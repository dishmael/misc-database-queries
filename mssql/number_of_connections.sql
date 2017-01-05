SELECT 
    loginame as 'Login Name',
	hostname as 'Hostname',
	DB_NAME(dbid) as 'Database', 
    COUNT(dbid) as 'Number of Connections'
FROM
    sys.sysprocesses
WHERE 
    dbid > 0
GROUP BY 
    dbid, loginame, hostname;


SELECT * FROM sys.sysprocesses WHERE dbid > 0;