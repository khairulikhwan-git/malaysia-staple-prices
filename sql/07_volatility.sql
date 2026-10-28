drop view if exists item_volatility;
drop materialized view if exists item_monthly;

create materialized view item_monthly as
with pm as (
    select item_code, item, unit, premise_code,
            date_trunc('month', price_date)::date as price_month,
            percentile_cont (0.5) within group (order by price) as premise_month_price
    from basket_prices
    where not is_outlier
    group by item_code, item, unit, premise_code, date_trunc('month', price_date)::date
)
select item_code, item, unit, price_month,
        count (*) as premises,
        percentile_cont (0.5) within group (order by premise_month_price) as month_price
from pm
group by item_code, item, unit, price_month
having count (*) >= 30;

create view item_volatility as
select item, unit,
        count (*) as months,
        round (min(month_price)::numeric, 2) as min_price,
        round (max(month_price)::numeric, 2) as max_price,
        round ((100 * (max(month_price) - min(month_price)) / avg (month_price))::numeric, 1) as range_pct,
        round ((100 * stddev_samp(month_price) / avg(month_price))::numeric, 1) as cv_pct
from item_monthly
group by item_code, item, unit
having count (*) = 6;

select * from item_volatility order by range_pct desc;

-- monthly prices: eggs, chicken wing, Sauh flour

select item, unit, to_char(price_month, 'YYYY-MM') as month, premises,
       round(month_price::numeric, 2) as month_price
from item_monthly
where item like 'TELUR%'
   or item like 'KEPAK AYAM%'
   or item like 'TEPUNG GANDUM NGP (BERBUNGKUS, CAP SAU%'
order by item, price_month;

-- most common prices: chicken wing and Sauh flour (no single dominant price)

with counts as (
		select item, price, count (*) as n_rows
		from basket_prices
		where item like 'KEPAK AYAM%'
			or item like 'TEPUNG GANDUM NGP (BERBUNGKUS, CAP SAU%'
		group by item, price
),
ranked as (
		select item, price, n_rows,
				sum (n_rows) over (partition by item) as total_rows,
				row_number () over (partition by item order by n_rows desc) as rnk
		from counts
)
select item, price, n_rows,
		round (100.0 * n_rows / total_rows, 1) as pct_of_rows
from ranked
where rnk <= 5
order by item, rnk;