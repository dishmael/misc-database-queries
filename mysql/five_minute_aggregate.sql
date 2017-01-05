select
    e.element_id, 
    e.address, 
    max(m.alive) as alive,
    min(m.responsetime) as minrtt, 
    max(m.responsetime) as maxrtt, 
    avg(m.responsetime) as avgrtt, 
    --date_format(m.polltime, '%Y-%m-%d %H:%i:00') as polltime, 
	FROM_UNIXTIME(300 * FLOOR( UNIX_TIMESTAMP(polltime)/300)) as polltime,
    count(m.responsetime) as samples
from 
    rawmetrics m left join elements e 
        on m.element_id = e.element_id 
where 
    --m.alive is true and 
    --e.address = '10.1.3.75' and
    m.responsetime >= 0
group by 
    e.element_id, unix_timestamp(m.polltime) div 300
order by
    m.polltime
