--
--
SELECT	 PARTITION_NAME, SUBPARTITION_NAME, TABLESPACE_NAME
FROM	 DBA_TAB_SUBPARTITIONS
WHERE	 TABLE_NAME='QUARTERLY_REGIONAL_SALES'
ORDER BY PARTITION_NAME
/