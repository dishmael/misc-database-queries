--
-- The following will create a table for capturing errors (err$_TABLE_NAME):
-- 
-- 	DBMS_ERRLOG.create_error_log( dml_table_name => 'TABLE_NAME' );
-- 
-- View the error table:
--
COLUMN ora_err_rowid$  HEAD 'Row ID'        FORMAT a70
COLUMN ora_err_number$ HEAD 'Error Number'  FORMAT a70
COLUMN ora_err_mesg$   HEAD 'Error Message' FORMAT a70
--
SELECT ora_err_rowid$, ora_err_number$, ora_err_mesg$
FROM   err$_reporter_status
/
