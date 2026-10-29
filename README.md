# Malaysian Staple Food Prices: Where Are the Gaps?

## Business question
Where are the biggest price gaps for everyday staple items across premise types and states in Malaysia, and which items are the most volatile month to month?

## Key findings
(to be written)

## Data
PriceCatcher dataset, published on OpenDOSM (open.dosm.gov.my) under CC BY 4.0.

## Staple basket (selection rule)
Categories were chosen before looking at prices: rice, cooking oil, eggs,
chicken, onions, flour and meat. An item enters the basket if it:
1. has prices in all six months (Jan-Jun 2026);
2. is reported by at least 500 distinct premises (about a quarter of the
   roughly 2,130 premises that report);
3. ranks in the top 4 of its category by number of reporting premises.

Prices are only compared within the same item, because pack sizes differ.
The final list is in docs/basket_items.csv.

Limitations
- The 500-premise threshold and the cap of 4 per category were set after
  inspecting coverage.
- Meat is excluded: no meat item reaches 500 premises.
- Rice coverage is limited to imported brands.
- Only 30-egg trays qualify for eggs.

Note: this data is collected for price surveillance, so this project does not make inflation claims.

## Tools
PostgreSQL, Python (pandas), Power BI

## Limitations
(to be written)

## How to reproduce
1. Install PostgreSQL and create a database named `malaysia_staple_prices`.
2. Run `notebooks/01_explore.ipynb`: it downloads the PriceCatcher files (Jan-Jun 2026) into `data/raw` and builds `docs/basket_items.csv`.
3. Run `sql/01_schema.sql` in pgAdmin to create the tables.
4. Run `notebooks/02_load_postgres.ipynb`. Edit the port in its first cell if yours differs; it asks for your PostgreSQL password when you run it.
5. Run `sql/02_constraints.sql` to `sql/08_scheme_check.sql`, in numeric order.

## Status
- [x] Load and clean data
- [x] SQL analysis
- [ ] Power BI dashboard
- [ ] Findings and recommendations

