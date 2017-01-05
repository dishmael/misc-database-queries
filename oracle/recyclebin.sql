--
-- http://www.orafaq.com/node/968
--
-- Syntax: purge <type> <name>
-- 	Example: purge table "BIN$wv8hOX0YIcrgRAAUT5BImg==$0"
--
-- Syntax: flashback <type> <name> to before drop
-- 	Example: flashback table test to before drop
--
col can_undrop heading "UND"
col can_purge heading "PUR"
--
SELECT
	object_name,
	original_name,
	type,
	can_undrop,
	can_purge,
	droptime
FROM
	recyclebin
/
