--
--exec dbms_stats.gather_system_stats;
--
column PLAN_TABLE_OUTPUT format a72 truncate
set autotrace traceonly explain
--
COL sname	HEAD 'S Name'	FORMAT a30
COL pname	HEAD 'P Name'	FORMAT a30
COL pval1	HEAD 'Value 1'	FORMAT 9,990.09
COL pval2	HEAD 'Value 2'	format a20
--
SELECT * FROM sys.aux_stats$
/
--
COL name		HEAD 'Name'			FORMAT a30
COL value		HEAD 'Value'		FORMAT a5
COL isDefault	HEAD 'isDefault'	FORMAT a10
--
SELECT	name, value, isdefault
FROM	v$parameter
WHERE	name like '%multiblock_read%'
/
--
set autotrace off
--
--drop table t;
--create table t as select * from all_objects where 1=0;
--exec dbms_stats.set_table_stats( user, 'T', numrows=>100000, numblks => 10000 );
--column PLAN_TABLE_OUTPUT format a72 truncate
--set autotrace traceonly explain
--alter session set db_file_multiblock_read_count = 1;
--select * from t;
--alter session set db_file_multiblock_read_count = 64;
--select * from t;
--set autotrace off

--exec dbms_stats.set_system_stats( 'sreadtim', 1.932 )
--exec dbms_stats.set_system_stats( 'mreadtim', .554 )
--exec dbms_stats.set_system_stats( 'cpuspeed', 340 )
--exec dbms_stats.set_system_stats( 'mbrc', 49 )

--column PLAN_TABLE_OUTPUT format a72 truncate
--set autotrace traceonly explain
--alter session set db_file_multiblock_read_count = 1;
--select * from t;
--alter session set db_file_multiblock_read_count = 64;
--select * from t;
--set autotrace off
CLEAR COL
