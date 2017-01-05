select
	address, 
	min(minrtt) as minrtt, 
	max(maxrtt) as maxrtt, 
	avg(avgrtt) as straight_avg, 
	sum(avgrtt*samples)/sum(samples) as weighted_average,
	polltime, sum(samples) samples
from
	t
group by
	address,
	unix_timestamp(polltime) div 3600
order by
	polltime
