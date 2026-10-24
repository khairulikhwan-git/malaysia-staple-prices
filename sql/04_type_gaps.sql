-- Per-premise median prices and premise-type price gaps (basket items, outliers excluded)

drop view if exists type_gaps;
drop view if exists state_gaps_supermarket;
drop materialized view if exists premise_item_prices;

-- price gaps by premise type

create materialized view premise_item_prices as
select item_code, item, unit, item_category,
        premise_code, premise_type, state,
        count (*) as n_obs,
        percentile_cont(0.5) within group (order by price) as price_median
from basket_prices
    where not is_outlier
group by item_code, item, unit, item_category, premise_code, premise_type, state;

-- gap view

create view type_gaps as
with type_item as (
	select item_code, item, unit, premise_type,
			count(*) as premises,
			percentile_cont(0.5) within group (order by price_median) as type_price
	from premise_item_prices
	group by item_code, item, unit, premise_type
	having count(*) >= 10
),
overall as (
		select item_code,
				percentile_cont(0.5) within group (order by price_median) as overall_price
		from premise_item_prices
		group by item_code
)
select t.item, t.unit, t.premise_type, t.premises,
		round(t.type_price::numeric, 2) as type_price,
		round(o.overall_price::numeric, 2) as overall_price,
		round((100 * (t.type_price - o.overall_price) / o.overall_price)::numeric, 1) as gap_pct
from type_item t
join overall o on o.item_code = t.item_code;

-- state view (state_gaps)

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

-- temp view for supermarket-only state:

create temp view state_gaps_supermarket as 
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

