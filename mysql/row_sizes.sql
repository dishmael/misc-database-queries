select
  table_schema AS 'Schema', 
  table_name AS 'Table',
  table_rows AS 'Row Count', 
  sum((data_length+index_length)/1024) AS 'Table Size (KB)', 
  coalesce(sum((data_length+index_length)/1024) / table_rows, 0) AS 'Row Size (KB)'
from
  information_schema.tables 
where 
  table_schema not in ('performance_schema', 'mysql', 'information_schema') 
group by
  1, 2, 3;

