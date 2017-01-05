--
col name  heading "Parameter"	format a40 word_wrapped
col value heading "Value"		format a60 word_wrapped
--
--break on value skip 1
--
SELECT	 name, value
FROM	 v$parameter
--WHERE	 isdefault = 'FALSE'
ORDER BY name
/
