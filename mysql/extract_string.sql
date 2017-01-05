select
  lower(trim(substring(summary, locate('for', summary) + 4, locate(' (', summary) - locate('for', summary) - 3))) as node,
  eventid,
  count(*) as tally
from
  alerts.status partition( p201508 )
where
  eventid like '%watchdog%'
group by
  node, eventid
