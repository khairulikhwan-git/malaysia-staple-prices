-- dimension tables

create table dim_item (
    item_code     INTEGER PRIMARY KEY,
    item          TEXT,
    unit          TEXT,
    item_group    TEXT,
    item_category TEXT
);

create table dim_premise (
    premise_code  INTEGER PRIMARY KEY,
    premise       TEXT,
    address       TEXT,
    premise type  TEXT,
    state         TEXT,
    district      TEXT
);

--staple basket (selection rule in the README)

create table basket_items (
    item_code INTEGER PRIMARY KEY REFERENCES dim_item (item_code)
);

-- daily prices (primary key and indexes are added after loading)

create table prices (
    price_date   DATE NOT NULL,
    premise_code INTEGER NOT NULL,
    item_code    INTEGER NOT NULL,
    price        NUMERIC(10,2) NOT NULL
);
