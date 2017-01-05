--
column dir			format a65			heading 'Directory'
column name			format a65			heading 'File Name'
column phyrds		format 999,999,999
column phywrts		format 999,999,999
column phyblkrd		format 999,999,999
column phyblkwrt	format 999,999,999
--
select
	substr(name, 0, instr(name, 'REPORTER') - 2) dir,
	sum(phyrds) phyrds,
	sum(phywrts) phywrts,
	sum(phyblkrd) phyblkrd,
	sum(phyblkwrt) phyblkwrt
from
	v$filestat a, v$datafile_header b
where
	tablespace_name = 'REPORTER' and
	a.file# = b.file#
group by
	substr(name, 0, instr(name, 'REPORTER') - 2)
order by
	dir
/
--
column dir noprint
break on dir skip 1
--
select
	substr(name, 0, instr(name, 'REPORTER') - 2) as dir,
	name, 
	phyrds,
	phywrts,
	phyblkrd,
	phyblkwrt
from
	v$filestat a, v$datafile_header b
where
	tablespace_name = 'REPORTER' and
	a.file# = b.file#
order by
	name
/
--
clear col
clear break
