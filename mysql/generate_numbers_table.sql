DELIMITER $$
CREATE PROCEDURE generate_numbers()
BEGIN

    DECLARE c int DEFAULT 0;

    WHILE c < 1440 DO
        INSERT INTO numbers.minutes VALUES (c);
        SET c = c + 1;
    END WHILE;

END $$
DELIMITER ;
