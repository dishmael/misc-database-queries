--
-- View running sessions
--
SELECT oracle_username || ' (' || s.osuser || ')' username,
         s.sid || ',' || s.serial# sess_id,
         owner || '.' || object_name object,
         object_type,
         DECODE (l.block, 0, 'Not Blocking', 1, 'Blocking', 2, 'Global') STATUS,
         DECODE (v.locked_mode,
                 0, 'None',
                 1, 'Null',
                 2, 'Row-S (SS)',
                 3, 'Row-X (SX)',
                 4, 'Share',
                 5, 'S/Row-X (SSX)',
                 6, 'Exclusive',
                 TO_CHAR (lmode))
            mode_held
    FROM v$locked_object v,
         dba_objects d,
         v$lock l,
         v$session s
   WHERE     v.object_id = d.object_id
         AND v.object_id = l.id1
         AND v.session_id = s.sid
ORDER BY oracle_username, session_id;
