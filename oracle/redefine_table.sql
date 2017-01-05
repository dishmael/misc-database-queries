DECLARE
	SRC VARCHAR2(32) := 'REPORTER_STATUS';
	DST VARCHAR2(32) := 'REPORTER_STATUS_PART';
BEGIN
	DBMS_REDEFINITION.start_redef_table(
		uname 		=> USER,
		orig_table 	=> SRC,
		int_table 	=> DST
	);
END;
/
