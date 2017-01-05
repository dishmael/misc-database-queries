DELIMITER $$
CREATE EVENT five_minute_aggregate
ON SCHEDULE EVERY 5 MINUTE STARTS '2014-07-21 00:00:00' DO
BEGIN
    -- Declare variables
    DECLARE v_startTime DATETIME;
    DECLARE v_stopTime DATETIME;

    -- Initialize the date/time boundaries
    SELECT date_sub( normalize1min( now() ), INTERVAL 5 MINUTE ) INTO v_startTime;
    SELECT normalize1min( now() ) INTO v_stopTime;

    -- Insert the averages
    INSERT INTO metrics5m
    SELECT
        element_id,
        avg( alive ) as uptime,
        coalesce( min( NULLIF(responseTime, -1) ), -1 ) as minrtt,
        coalesce( max( NULLIF(responseTime, -1) ), -1 )as maxrtt,
        coalesce( avg( NULLIF(responseTime, -1) ), -1 ) as avgrtt,
        count( element_id ) as samples,
        normalize5min( pollTime ) as pollTime,
        now() as aggTime
    FROM (
        SELECT
            filledGaps.element_id,
            coalesce(alive, 0) as alive,
            coalesce(responseTime, -1) as responseTime,
            filledGaps.pollTime
        FROM (
            SELECT
                element_id, 
                date_add( normalize5min(v_startTime), INTERVAL 1 * m MINUTE ) as pollTime
            FROM elements, numbers.minutes
            WHERE m < 5
            ORDER BY pollTime, element_id
        ) filledGaps left join rawmetrics ON 
            filledGaps.polltime = normalize1min(rawmetrics.polltime) AND 
            filledGaps.element_id = rawmetrics.element_id
        WHERE rawmetrics.pollTime BETWEEN v_startTime AND v_stopTime
    ) metrics
    GROUP BY element_id, normalize5min( pollTime )
    ORDER BY pollTime, element_id;

END $$
DELIMITER ;
