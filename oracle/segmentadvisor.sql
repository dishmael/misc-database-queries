--
-- The segment advisor performs analysis on the fragmentation of specified 
-- tablespaces, segments or objects and makes recommendations on how space 
-- can be reclaimed.
--
DECLARE
  l_object_id  NUMBER;
BEGIN
  -- Create a segment advisor task for the SCOTT.EMP table.
  DBMS_ADVISOR.create_task (
    advisor_name      => 'Segment Advisor',
    task_name         => 'RS_SEGMENT_ADVISOR',
    task_desc         => 'Segment Advisor For REPORTER_STATUS');

  DBMS_ADVISOR.create_object (
    task_name   => 'RS_SEGMENT_ADVISOR',
    object_type => 'TABLE',
    attr1       => 'REPORTER', 
    attr2       => 'REPORTER_STATUS', 
    attr3       => NULL, 
    attr4       => 'null',
    attr5       => NULL,
    object_id   => l_object_id);

  DBMS_ADVISOR.set_task_parameter (
    task_name => 'RS_SEGMENT_ADVISOR',
    parameter => 'RECOMMEND_ALL',
    value     => 'TRUE');

  DBMS_ADVISOR.execute_task(task_name => 'RS_SEGMENT_ADVISOR');

  -- Create a segment advisor task for the USERS tablespace.
  --DBMS_ADVISOR.create_task (
  --  advisor_name      => 'Segment Advisor',
  --  task_name         => 'USERS_SEGMENT_ADVISOR',
  --  task_desc         => 'Segment Advisor For USERS');

  --DBMS_ADVISOR.create_object (
  --  task_name   => 'USERS_SEGMENT_ADVISOR',
  --  object_type => 'TABLESPACE',
  --  attr1       => 'USERS', 
  --  attr2       => NULL, 
  --  attr3       => NULL, 
  --  attr4       => 'null',
  --  attr5       => NULL,
  --  object_id   => l_object_id);

  --DBMS_ADVISOR.set_task_parameter (
  --  task_name => 'USERS_SEGMENT_ADVISOR',
  --  parameter => 'RECOMMEND_ALL',
  --  value     => 'TRUE');

  --DBMS_ADVISOR.execute_task(task_name => 'USERS_SEGMENT_ADVISOR');
END;
/ 
--
-- Display the findings.
SET LINESIZE 250
COLUMN task_name FORMAT A20
COLUMN object_type FORMAT A20
COLUMN schema FORMAT A20
COLUMN object_name FORMAT A30
COLUMN object_name FORMAT A30
COLUMN message FORMAT A40
COLUMN more_info FORMAT A40
--
SELECT f.task_name,
       f.impact,
       o.type AS object_type,
       o.attr1 AS schema,
       o.attr2 AS object_name,
       f.message,
       f.more_info
FROM   dba_advisor_findings f
       JOIN dba_advisor_objects o ON f.object_id = o.object_id AND f.task_name = o.task_name
--WHERE  f.task_name IN ('EMP_SEGMENT_ADVISOR', 'USERS_SEGMENT_ADVISOR')
WHERE  f.task_name IN ('EMP_SEGMENT_ADVISOR')
ORDER BY f.task_name, f.impact DESC;
/
--
clear col
