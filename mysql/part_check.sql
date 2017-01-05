DELIMITER //
DROP PROCEDURE IF EXISTS part_check;
CREATE PROCEDURE part_check(IN tName VARCHAR(64))
BEGIN
    SET @x = 0;
    CREATE TEMPORARY TABLE future_parts (
		table_schema varchar(64), 
		table_name varchar(64), 
		partition_name varchar(64)
	);
    REPEAT
        SET @x = @x + 1;
        INSERT INTO future_parts (table_schema, table_name, partition_name) 
			VALUES ('alerts', 'status', DATE_FORMAT(date_add(now(), interval @x month),'p%Y%m'));
        INSERT INTO future_parts (table_schema, table_name, partition_name) 
			VALUES ('alerts', 'details', DATE_FORMAT(date_add(now(), interval @x month),'p%Y%m'));
    UNTIL @x > 12 END REPEAT;
    SELECT
         future_parts.table_schema, 
         future_parts.table_name, 
         future_parts.partition_name, (partitions.partition_name is not null) is_present
    FROM future_parts LEFT JOIN information_schema.partitions ON 
         future_parts.partition_name = partitions.partition_name
    WHERE
         future_parts.table_name = tName
    ORDER BY 1, 2, 3;
    DROP TEMPORARY TABLE future_parts;
END;
//

DELIMITER ;
