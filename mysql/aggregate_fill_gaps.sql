
drop table if exists t1;
create table t1 select
    element_id,
    date_add( date('2014-07-16') + interval 0 second, interval 5 * m minute ) as polltime
from 
    elements,
    numbers.minutes
where
    m < 288
order by
    polltime,
    element_id;


drop table if exists t2;
create table t2 select
    element_id,
    max(alive) as alive,
    min(responsetime) as minrtt,
    max(responsetime) as maxrtt,
    avg(responsetime) as avgrtt,
    count(element_id) as samples,
    numbers.normalize_date(polltime, 300) as polltime
from
    rawmetrics
where
    alive is true
group by
    element_id,
    numbers.normalize_date(polltime, 300)
order by
    polltime, element_id;


drop table if exists t3;
create table t3 select
    t1.element_id,
    coalesce(t2.alive, 0) as alive,
    coalesce(t2.minrtt, -1) as minrtt,
    coalesce(t2.maxrtt, -1) as maxrtt,
    coalesce(t2.avgrtt, -1) as avgrtt,
    coalesce(t2.samples, 0) as samples,
    t1.polltime
from
    t1 left join t2 on
        t2.element_id = t1.element_id and
        t2.polltime = t1.polltime
order by
    t1.polltime, t2.element_id;

