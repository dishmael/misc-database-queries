DROP FUNCTION IF EXISTS AddWorkDays;
DELIMITER $$
CREATE FUNCTION AddWorkDays
(
    StartDate DATETIME,
    WorkingDays INT
)
RETURNS DATETIME

BEGIN
    DECLARE Count INT;
    DECLARE i INT;
    DECLARE NewDate DATETIME;
    SET Count = 0;
    SET i = 1;

    WHILE (i < WorkingDays) DO
        BEGIN
            SELECT Count + 1 INTO Count;
            SELECT i + 1 INTO i;
            WHILE DAYOFWEEK(DATE_ADD(StartDate,INTERVAL Count DAY)) IN (1,7) DO
                BEGIN
                    SELECT Count + 1 INTO Count;
                END;
            END WHILE;
        END;
    END WHILE;

    SELECT DATE_ADD(StartDate,INTERVAL Count DAY) INTO NewDate;
    RETURN NewDate;

END;
$$

DELIMITER ;
