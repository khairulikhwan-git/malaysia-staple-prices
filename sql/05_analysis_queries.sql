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

select item, unit, premise_type, premises, type_price, gap_pct
from type_gaps
where gap_pct <= -20 or gap_pct >= 20
order by gap_pct;

with full_items as (
    select item
    from type_gaps
    group by item
    having count (*) = 5
)
select premise_type, count (*) as items, round(avg(gap_pct), 1) as avg_gap_pct
from type_gaps
where item in (select item from full_items)
group by premise_type
order by avg_gap_pct;