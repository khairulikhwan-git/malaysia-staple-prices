-- sanity check:

select count(*) as basket_rows,
		sum(is_outlier::int) as outliers,
		round(100.0 * avg(is_outlier::int), 3) as outlier_pct
from basket_prices;
--
select premise_type,
		count(distinct premise_code) as premises,
		count(*) as n_rows
from basket_prices
group by premise_type
order by n_rows desc;
--
select item, unit, count(*) as n_rows,
	sum(is_outlier::int) as outliers
from basket_prices
group by item, unit
order by outliers desc;
--
select count (*) as premise_item_pairs,
       count(distinct premise_code) as premises,
       sum(n_obs) as rows_used
from premise_item_prices;

-- exploratory: item sets differ by premise type (not comparable); use the 17-item version below
-- output check (headline by premise type):

select premise_type,
		count(*) as items,
		round(avg(gap_pct), 1) as avg_gap_pct,
		round(min(gap_pct), 1) as min_gap_pct,
		round(max(gap_pct), 1) as max_gap_pct
from type_gaps
group by premise_type
order by avg_gap_pct;

-- output check (inspect oil and eggs):

select item, unit, premise_type, premises, type_price, gap_pct
from type_gaps
where item like 'TELUR%' or item like 'MINYAK%'
order by item, type_price;

-- short queries, items and premises with a gap of +- 20% or more either way:

select item, unit, premise_type, premises, type_price, gap_pct
from type_gaps
where gap_pct <= -20 or gap_pct >= 20
order by gap_pct;

-- same, but using the items that appear in all five types of premises:

with full_items as (
    select item, unit
    from type_gaps
    group by item, unit
    having count (*) = 5
)
select g.premise_type, count (*) as items, round(avg(gap_pct), 1) as avg_gap_pct
from type_gaps g
join full_items f on f.item = g.item and f.unit = g.unit
group by g.premise_type
order by avg_gap_pct;

-- robustness: the same 17 items, without onions

with full_items as (
    select item, unit
    from type_gaps
    group by item, unit
    having count (*) = 5
)
select g.premise_type, count (*) as items, round(avg(gap_pct), 1) as avg_gap_pct
from type_gaps g
join full_items f on f.item = g.item and f.unit = g.unit
where g.item not like 'BAWANG%'
group by g.premise_type
order by avg_gap_pct;

-- robustness: the same 17 items, without cooking oil

with full_items as (
    select item, unit
    from type_gaps
    group by item, unit
    having count (*) = 5
)
select g.premise_type, count (*) as items, round(avg(gap_pct), 1) as avg_gap_pct
from type_gaps g
join full_items f on f.item = g.item and f.unit = g.unit
where g.item not like 'MINYAK%'
group by g.premise_type
order by avg_gap_pct;