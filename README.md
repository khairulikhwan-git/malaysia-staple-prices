# Malaysian Staple Food Prices: Where Are the Gaps?

## Business question
Where are the biggest price gaps for everyday staple items across premise types and states in Malaysia, and which items are the most volatile month to month?

## Key findings
**Price gaps by premise type.**
Across the 17 basket items sold in all five premise types (Jan-Jun 2026), hypermarkets were the cheapest, averaging 7.8% below the typical premise price, and wet markets (Pasar Basah) the most expensive, averaging 7.2% above it. The order stayed the same when onions or cooking oil were excluded, although the hypermarket-to-wet-market gap ranged from 7.6 to 19.3 points depending on which items were included. The data covers six months and only these basket items, and it compares premise types rather than measuring inflation.

**Price gaps by state.**
Measured against the national median price for each item, Sabah (+13.9%) and Sarawak (+10.1%) show the largest average gaps, every other state falls between -3.7% and +2.6%. The typical item is much closer to the national price (median gap +2.0% in Sabah, +1.6% in Sarawak): in supermarkets, the premium comes mainly from a few items — onions, standard chicken and eggs — and Sabah and Sarawak stay on top when only supermarkets are compared (+18.7% and +14.1%). Labuan, Perlis and Putrajaya have the fewest premises (15, 38 and 28), so their figures are less reliable, and the data cannot show why prices differ.

**Month-to-month movement.**
Egg prices. Between January and May 2026, median egg prices fell for all three grades: Grade A by 12% (RM13.99 to RM12.25), Grade B by 21% (RM13.50 to RM10.60) and Grade C by 26% (RM12.90 to RM9.60), with the lowest points in April and May. Eggs were not on the official Eid al-Fitr maximum-price list (KPDN, SHMMP, 27 items, 14-28 March), and the largest drops came after it ended, so the scheme does not explain the fall. An Utusan report of an egg supply surplus in early 2026 
(Harga telur ayam jatuh lebihan bekalan di pasaran, 14 Apr 2026) fits the pattern, but this data cannot test it.

Items whose prices barely moved. Onions and garlic were on the scheme list, but excluding 14-28 March changed only 2 of 20 premise-type medians, both slightly, so the scheme does not drive the results. Chicken wing and Sauh flour had the same national median in all six months (RM15.90 and RM3.20) although neither was price-controlled in Peninsular Malaysia (wing only in Sabah, Sarawak and Labuan; flour not listed); the reason is unknown.

Regulated items and shop-to-shop spread. Bottled cooking oil sits at or near the government’s maximum retail prices (RM13.30 for 2 kg, RM30.90 for 5 kg), so it shows almost no variation by design. For wing and flour, shops differ widely even though the median is stable: the middle 80% of shops charge RM13.59-17.90 for wing and RM2.90-3.80 for flour, a spread of about 27-28% of the median.

## Data
PriceCatcher dataset, published on OpenDOSM (open.dosm.gov.my) under CC BY 4.0.
Note: this data is collected for price surveillance, so this project does not make inflation claims.

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

## Tools
PostgreSQL, Python (pandas), Power BI

## Limitations

Coverage: the analysis uses 21 basket items (rice, cooking oil, eggs, chicken, onions and flour) in five retail premise types. Only 339 of the 796 items in the lookup have any price in this period, and restaurants and wholesale (Borong) are not covered.
Time: six months (Jan-Jun 2026). 14 of 181 days are missing: 9 match public holidays, 1 (20 March) was probably an additional Raya holiday, and 4 are unexplained.
Data quality: 154,441 rows (1.52%) have item codes that don’t appear in the item lookup and are excluded from item-level analysis. 159 basket rows (0.012%) were flagged as extreme prices (below 0.2× or above 5× the item median) and excluded.
Choices made after looking at the data: the 500-premise threshold for the basket, the cap of four items per category, the 10-premise minimum per group and the outlier rule. Different thresholds could change the numbers.
Interpretation: gaps are measured against the median premise price for each item. They are not shop margins, and the data is for price surveillance, so this is not an inflation measure. It also cannot explain why prices differ, such as the egg fall or the Sabah and Sarawak premium.

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

## Sources
- PriceCatcher, OpenDOSM (CC BY 4.0): https://open.dosm.gov.my/data-catalogue/pricecatcher
- KPDN, Eid al-Fitr 2026 maximum-price scheme list: (https://www.kpdn.gov.my/images/2025/pengumuman/SENARAI-BARANGAN-SHMMP-HARI-RAYA-PUASA-2026.pdf)
- Utusan Malaysia, "Harga teluar ayam jatuh lebihan bekalan di pasaran", 14 Apr 2026: (https://www.utusan.com.my/berita/2026/04/harga-telur-ayam-jatuh-lebihan-bekalan-di-pasaran/)
- Astro Awani, Eid al-Fitr 2026 scheme ceilings: (https://www.astroawani.com/berita-malaysia/shmmp-aidilfitri-2026-27-barangan-disenaraikan-kacang-dal-tambahan-baharu)
- ZS Commerce, Grade A egg price chart (average price per 30 eggs): (https://zscommerce.my/harga/telur-ayam-gred-a, average price per 30 eggs)