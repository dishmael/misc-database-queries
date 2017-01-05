create table t as (
  select
    eventid,
    source,
    if (severity = 'Discard', true, false) as isDiscarded,
    if (severity = 'Default', true, false) as useDefaults,
    case severity
      when 'Default' then 1
      when 'Discard' then 1
      else severity
    end as severity,
    type,
    suppress_escl,
    expiretime,
    threshold,
    reason,
    action,
    updated
  from
    advisor
);
