drop materialized view if exists basket_prices;

create materialized view basket_prices as 
with base as (
    select p.price_date, p.premise_code, p.item_code, p.price,
    i.item, i.unit, i.item_category,
    d.premise_type, d.state, d.district
    from prices p
    join basket_items b on b.item_code = p.item_code
    join dim_item i on i.item_code = p.item_code
    join dim_premise d on d.premise_code = p.premise_code
    where d.premise_type in ('Pasar Raya / Supermarket', 'Pasar Basah',
                            'Hypermarket', 'Pasar Mini', 'Kedai Runcit')
    ),
med as (
    select item_code,
        percentile_cont(0.5) within group (order by price) as item_median
    from base
    group by item_code
    )
select base.*,
    med.item_median,
    (base.price < 0.2 * med.item_median
    or base.price > 5 * med.item_median) as is_outlier

from base
join med on med.item_code = base.item_code;

create index idx_bp_item_date on basket_prices (item_code, price_date);
create index idx_bp_premise on basket_prices (premise_code);

