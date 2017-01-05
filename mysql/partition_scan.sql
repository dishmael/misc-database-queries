DELIMITER $$
DROP PROCEDURE IF EXISTS partition_scan$$
CREATE PROCEDURE partition_scan(IN node varchar(64))
BEGIN
  DECLARE hasMore boolean;
  DECLARE pName varchar(64);

  DECLARE curs CURSOR FOR (
    SELECT partition_name 
    FROM information_schema.partitions 
    WHERE
      table_schema = 'alerts' and 
      table_name = 'status' and 
      partition_name != 'pMAXVAL' and 
      table_rows > 0
  );

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET hasMore = false;

  CREATE TEMPORARY TABLE IF NOT EXISTS found_nodes (
    Node varchar(64),
    Tally int,
    FirstOccurrence datetime,
    LastOccurrence datetime,
    PartitionName varchar(64)
  );

  OPEN curs;

  SET hasMore = true;
  WHILE hasMore DO
    FETCH curs INTO pName;

    IF hasMore THEN
      SET @query = CONCAT('
        INSERT INTO found_nodes (
          SELECT
            IFNULL(Node, \'', node, '\'), 
            COUNT(*) AS Tally, 
            MIN(FirstOccurrence) AS FirstOccurrence, 
            MAX(LastOccurrence) AS LastOccurrence, 
            \'', pName, '\' AS PartitionName
          FROM alerts.status PARTITION( ', pName, ') 
          WHERE Node = \'', node, '\' AND ActionCode = \'I\'
        );'
      );

      PREPARE stmt FROM @query;
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;

    END IF;

  END WHILE;

  SELECT * FROM found_nodes;
  DROP TEMPORARY TABLE found_nodes;

END$$

DELIMITER ;
