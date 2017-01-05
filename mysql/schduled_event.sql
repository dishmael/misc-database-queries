DELIMITER $$
CREATE EVENT five_minute_aggregate
ON SCHEDULE EVERY 1 HOUR DO
BEGIN
    -- Declare variables
    DECLARE v_startTime DATETIME;
    DECLARE v_stopTime DATETIME;

    -- Initialize the date/time boundaries
    SELECT numbers.normalize_date( date_sub(now(), interval 1 hour), 3600 ) INTO v_startTime;
    SELECT numbers.normalize_date( now(), 3600 ) INTO v_stopTime;

    -- Drop temporary tables
    DROP TEMPORARY TABLE IF EXISTS five_min_hour_temp;
    DROP TEMPORARY TABLE IF EXISTS five_min_avg_temp;

    -- Create table of element and dates/times
    CREATE TEMPORARY TABLE five_min_hour_temp ENGINE=MEMORY
    SELECT element_id, date_add( v_startTime, interval 5 * m minute ) as polltime
    FROM elements, numbers.minutes
    WHERE m < 12
    ORDER BY polltime, element_id;

    -- Create table of averages
    CREATE TEMPORARY TABLE five_min_avg_temp ENGINE=MEMORY
    SELECT
        element_id, 
        max(alive) as alive, 
        min(responsetime) as minrtt, 
        max(responsetime) as maxrtt, 
        avg(responsetime) as avgrtt, 
        count(element_id) as samples, 
        numbers.normalize_date(polltime, 300) as polltime
    FROM rawmetrics
    WHERE alive is true
    GROUP BY element_id, numbers.normalize_date(polltime, 300)
    ORDER BY polltime, element_id;

    -- Combine the two tables
    INSERT INTO metrics5m
    SELECT
        t1.element_id,
        coalesce(t2.alive, 0) as alive,
        coalesce(t2.minrtt, -1) as minrtt,
        coalesce(t2.maxrtt, -1) as maxrtt,
        coalesce(t2.avgrtt, -1) as avgrtt,
        coalesce(t2.samples, 0) as samples,
        t1.polltime
    FROM t1 left join t2 on t2.element_id = t1.element_id and t2.polltime = t1.polltime
    ORDER BY t1.polltime, t2.element_id;

END $$
DELIMITER ;
