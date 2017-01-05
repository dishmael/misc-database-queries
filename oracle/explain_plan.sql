EXPLAIN PLAN FOR
SELECT
	reporter_status.EVENTID,
    --reporter_status.NODE, 
    --reporter_status.NODEALIAS, 
    reporter_status.ORIGINALSEVERITY, 
    reporter_status.FIRSTOCCURRENCE, 
    reporter_status.LASTOCCURRENCE, 
    --reporter_status.CLASS, 
    --reporter_status.TALLY, 
    reporter_status.ALERTGROUP, 
    reporter_status.ALERTKEY, 
    reporter_status.SUMMARY, 
    --reporter_status.ARSNUMBER, 
    reporter_status.LOCATION, 
    reporter_status.NMCFLAG, 
    reporter_status.MANAGER, 
    --reporter_status.SPAREVC2, 
    --reporter_status.SERIAL, 
    --reporter_status.SERVERSERIAL, 
    --reporter_status.ACKNOWLEDGED, 
    --reporter_status.SERVERSERIAL, 
    --reporter_status.OWNERUID, 
    reporter_status.EKBID, 
    reporter_status.AGENT
FROM
    REPORTER_USER.reporter_status PARTITION (DEC2013)
WHERE
--    ( reporter_status.FIRSTOCCURRENCE BETWEEN to_date('01 December 2013') AND to_date('20 November 2013’) + 1 ) AND 
    ( reporter_status.MANAGER LIKE 'ECI%’ )
ORDER BY 
    reporter_status.FIRSTOCCURRENCE;

@?/RDBMS/ADMIN/UTLXPLS
