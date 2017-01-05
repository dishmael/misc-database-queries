DELIMITER $$
CREATE EVENT one_hour_aggregate
ON SCHEDULE EVERY 1 HOUR STARTS '2014-07-21 13:05:00' DO
BEGIN
    -- Declare variables
    DECLARE v_startTime DATETIME;
    DECLARE v_stopTime DATETIME;

    -- Initialize the date/time boundaries
    SELECT date_sub( numbers.normalize_date( now() , 3600 ), INTERVAL 1 HOUR ) INTO v_startTime;
    SELECT numbers.normalize_date( now(), 3600 ) INTO v_stopTime;

    -- Create table of averages
    DROP TEMPORARY TABLE IF EXISTS one_hour_avg_temp;
    CREATE TEMPORARY TABLE one_hour_avg_temp ENGINE=MEMORY
    SELECT
        element_id, 
        max(alive) as alive, 
        min(minrtt) as minrtt, 
        max(maxrtt) as maxrtt, 
        sum(avgrtt * samples) / sum(samples) as avgrtt,
        sum(samples) as samples, 
        numbers.normalize_date(polltime, 3600) as polltime
    FROM metrics5m
    WHERE alive is true AND pollTime BETWEEN v_startTime and v_stopTime
    GROUP BY element_id, numbers.normalize_date(polltime, 3600)
    ORDER BY polltime, element_id;

    -- Insert the averages while filling any missing date/time gaps
    INSERT INTO metrics1h
    SELECT
        t1.element_id,
        coalesce(t2.alive, 0) as alive,
        coalesce(t2.minrtt, -1) as minrtt,
        coalesce(t2.maxrtt, -1) as maxrtt,
        coalesce(t2.avgrtt, -1) as avgrtt,
        coalesce(t2.samples, 0) as samples,
        t1.polltime,
        now()
    FROM (
        SELECT element_id, v_startTime as pollTime
        FROM elements
        ORDER BY pollTime, element_id
    ) t1 left join one_hour_avg_temp t2 
        ON t2.element_id = t1.element_id and t2.polltime = t1.polltime
    ORDER BY t1.polltime, t2.element_id;

END $$
DELIMITER ;

