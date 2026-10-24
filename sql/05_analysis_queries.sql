select premise_type,
		count(*) as items,
		round(avg(gap_pct), 1) as avg_gap_pct,
		round(min(gap_pct), 1) as min_gap_pct,
		round(max(gap_pct), 1) as max_gap_pct
from type_gaps
group by premise_type
order by avg_gap_pct;

select item, unit, premise_type, premises, type_price, gap_pct
from type_gaps
where item like 'TELUR%' or item like 'MINYAK%'
order by item, type_price;