-- one price per premise, item and day

alter table prices
    add constraint prices_pk primary key (price_date, premise_code, item_code);

-- everyy price row belongs to a known premise

alter table prices
    add constraint prices_premise_fk
    foreign key (premise_code) references dim_premise (premise_code);

-- speed up per item time series and premise joins

create index idx_prices_item_date on prices (item_code, price_date);
create index idx_prices_premise on prices (premise_code);

analyze prices;
