--
COL sid				HEAD 'SID'
COL lock_type		HEAD 'Lock Type'		format a26
COL lock_held		HEAD 'Lock Held'		format a15
COL lock_requested	HEAD 'Lock Requested'	format a15
COL status			HEAD 'Status'			format a15
COL object_name		HEAD 'Obj Name'			format a30
--
select
	l.SID,
	decode(TYPE,
		'MR', 'Media Recovery',
		'RT', 'Redo Thread',
		'UN', 'User Name',
		'TX', 'Transaction',
		'TM', 'DML',
		'UL', 'PL/SQL User Lock',
		'DX', 'Distributed Xaction',
		'CF', 'Control File',
		'IS', 'Instance State',
		'FS', 'File Set',
		'IR', 'Instance Recovery',
		'ST', 'Disk Space Transaction',
		'TS', 'Temp Segment',
		'IV', 'Library Cache Invalidation',
		'LS', 'Log Start or Switch',
		'RW', 'Row Wait',
		'SQ', 'Sequence Number',
		'TE', 'Extend Table',
		'TT', 'Temp Table', type) as lock_type,
	decode(LMODE,
		0, 'None',
		1, 'Null',
		2, 'Row-S (SS)',
		3, 'Row-X (SX)',
		4, 'Share',
		5, 'S/Row-X (SSX)',
		6, 'Exclusive', lmode) lock_held,
	decode(REQUEST,
		0, 'None',
		1, 'Null',
		2, 'Row-S (SS)',
		3, 'Row-X (SX)',
		4, 'Share',
		5, 'S/Row-X (SSX)',
		6, 'Exclusive', request) lock_requested,
	decode(BLOCK,
		0, 'Not Blocking',
		1, 'Blocking',
		2, 'Global', block) status,
	OBJECT_NAME
FROM
	v$locked_object lo,
	dba_objects do,
	v$lock l
WHERE
	lo.OBJECT_ID = do.OBJECT_ID AND l.SID = lo.SESSION_ID
/
