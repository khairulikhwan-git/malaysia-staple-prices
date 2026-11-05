-- dashboard view 1: premise-type price gaps on the 17 like for like items,
-- with robustness scenarios (all items/without onions/without cooking oil)

drop view if exists dash_type_gap;

create view dash_type_gap as
with full_items as (
    select item, unit
    from type_gaps
    group by item, unit
    having count (*) = 5
),
base as (
    select g.premise_type, g.item, g.unit, g.gap_pct,
            case g.premise_type
                when 'Hypermarket' then 1
                when 'Pasar Raya / Supermarket' then 2
                when 'Pasar Mini' then 3
                when 'Kedai Runcit' then 4
                when 'Pasar Basah' then 5
            end as type_order
    from type_gaps g
    join full_items f on f.item = g.item and f.unit = g.unit
)
select 'All 17 items' as scenario, premise_type, type_order,
        count (*) as items, round (avg(gap_pct), 1) as avg_gap_pct
from base
group by premise_type, type_order
union all
select 'Without onions', premise_type, type_order,
        count (*), round(avg(gap_pct), 1)
from base
where item not like 'BAWANG%'
group by premise_type, type_order
union all
select 'Without cooking oil', premise_type, type_order,
        count (*), round(avg(gap_pct), 1)
from base
where item not like 'MINYAK%'
group by premise_type, type_order;

-- Dashboard view 2: state price gaps (all premises vs supermarkets only)

drop view if exists dash_state_gap;

create view dash_state_gap as
select 'All premises' as scenario, state,
       count(*) as items,
       round(avg(gap_pct), 1) as avg_gap_pct,
       round((percentile_cont(0.5) within group (order by gap_pct))::numeric, 1) as median_gap_pct,
       min(premises) as min_premises
from state_gaps
group by state
union all
select 'Supermarkets only', state,
       count(*),
       round(avg(gap_pct), 1),
       round((percentile_cont(0.5) within group (order by gap_pct))::numeric, 1),
       min(premises)
from state_gaps_supermarket
group by state;