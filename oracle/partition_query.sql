--
-- Query using partition for DATE
--
SELECT	COUNT(*)
FROM	REPORTER.STATUS
	PARTITION FOR ( TO_DATE( '2013-01-01', 'YYYY-MM-DD' ) )
/
