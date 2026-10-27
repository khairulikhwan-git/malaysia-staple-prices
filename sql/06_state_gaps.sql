-- state view (state_gaps)

drop view if exists state_gaps;
create view state_gaps as 
with state_item as (
	select item_code, item, unit, state,
			count (*) as premises,
			percentile_cont(0.5) within group (order by price_median) as state_price
	from premise_item_prices
	group by item_code, item, unit, state
	having count (*) >= 10
),
overall as (
	select item_code,
			percentile_cont(0.5) within group (order by price_median) as overall_price
	from premise_item_prices
	group by item_code
)
select s.item, s.unit, s.state, s.premises,
		round(s.state_price::numeric, 2) as state_price,
		round(o.overall_price::numeric, 2) as overall_price,
		round((100 * (s.state_price - o.overall_price) / o.overall_price)::numeric, 1) as gap_pct
from state_item s
join overall o on o.item_code = s.item_code;

-- drop if exists

drop view if exists state_gaps_supermarket;

-- state_gaps_supermarket view

create view state_gaps_supermarket as 
with state_item as (
    select item_code, item, unit, state,
            count (*) as premises,
            percentile_cont(0.5) within group (order by price_median) as state_price
    from premise_item_prices
	where premise_type = 'Pasar Raya / Supermarket'
    group by item_code, item, unit, state
    having count (*) >= 10
),
overall as (
    select item_code,
            percentile_cont(0.5) within group (order by price_median) as overall_price
    from premise_item_prices
	where premise_type = 'Pasar Raya / Supermarket'
    group by item_code
)
select s.item, s.unit, s.state, s.premises,
        round(s.state_price::numeric, 2) as state_price,
        round(o.overall_price::numeric, 2) as overall_price,
        round((100 * (s.state_price - o.overall_price) / o.overall_price)::numeric, 1) as gap_pct
from state_item s
join overall o on o.item_code = s.item_code;

-- state gaps (how many premises each state):

select state, count (distinct premise_code) as premises
from premise_item_prices
group by state
order by premises desc;

-- avg_gap_pct and min_premises for each state:

select state, count (*) as items,
        round (avg (gap_pct), 1) as avg_gap_pct,
        round ((percentile_cont (0.5) within group (order by gap_pct))::numeric, 1) as median_gap_pct,
        min (premises) as min_premises
from state_gaps
group by state
order by avg_gap_pct desc;

--check ranking for supermarket-only state:

select state, count (*) as items,
        round (avg (gap_pct), 1) as avg_gap_pct,
        round ((percentile_cont (0.5) within group (order by gap_pct))::numeric, 1) as median_gap_pct,
        min (premises) as min_premises
from state_gaps_supermarket
group by state
order by avg_gap_pct desc;

-- Sabah and Sarawak supermarkets: is the premium broad across items?

select state, item, unit, premises, state_price, overall_price, gap_pct
from state_gaps_supermarket
where state in ('Sabah', 'Sarawak')
order by state, gap_pct desc;