--
-- This only works on MariaDB, MySQL does not have sequence capabilities
-- Sequence of time every 5 minutes for a day
--
--SELECT CAST('00:00:00' AS TIME) + INTERVAL (5 * s.seq) MINUTE AS t 
SELECT (DATE(NOW()) + INTERVAL 0 SECOND) + INTERVAL (5 * s.seq) MINUTE AS t 
FROM (SELECT seq FROM seq_0_to_287) s;
