-- Raya scheme check: onion / garlic prices by premise type, all days vs without 14-28 March 2026

drop materialized view if exists premise_item_prices_excl_scheme;

create materialized view premise_item_prices_excl_scheme as
select item_code, item, unit, item_category,
        premise_code, premise_type, state,
        count (*) as n_obs,
        percentile_cont (0.5) within group (order by price) as price_median
from basket_prices
where not is_outlier
    and price_date not between '2026-03-14' and '2026-03-28'
group by item_code, item, unit, item_category, premise_code, premise_type, state;

-- side by side comparison

with a as (
    select item, unit, premise_type,
            count (*) as premises,
            percentile_cont (0.5) within group (order by price_median) as price_all
    from premise_item_prices
    where item like 'BAWANG%'
    group by item, unit, premise_type
    having count (*) >= 10
),
b as (
    select item, unit, premise_type,
            percentile_cont (0.5) within group (order by price_median) as price_excl
    from premise_item_prices_excl_scheme
    where item like 'BAWANG%'
    group by item, unit, premise_type
    having count (*) >= 10
    )
select a.item, a.premise_type, a.premises,
        round (a.price_all::numeric, 2) as price_all_days,
        round (b.price_excl::numeric, 2) as price_excl_scheme
from a
join b on b.item = a.item and b.unit = a.unit and b.premise_type = a.premise_type
order by a.item, a.premise_type;