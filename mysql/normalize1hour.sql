DELIMITER $$
CREATE DEFINER=`dishmael`@`localhost` FUNCTION `normalize1hour`(
    StartDate DATETIME
) RETURNS datetime
BEGIN
    DECLARE NewDate DATETIME;

    SELECT FROM_UNIXTIME(3600 * FLOOR( UNIX_TIMESTAMP(StartDate)/3600 )) INTO NewDate; 

    RETURN NewDate;

END $$
DELIMITER ;
