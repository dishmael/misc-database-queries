DELIMITER //
CREATE PROCEDURE partition_stats()
BEGIN
  SELECT
    concat( table_schema, '.', table_name ) as table_name,
    ifnull( partition_name, 'No Partitions' ) as partition_name,
    format(table_rows, 0) as table_rows,
    update_time
  FROM
    information_schema.partitions
  WHERE
    table_schema in ( 'alerts', 'lightsquared' );
END//
DELIMITER ;
