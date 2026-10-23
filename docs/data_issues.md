# Data issues log (PriceCatcher, Jan-Jun 2026)
Status: all six months checked (10,160,224 rows); basket selection pending.

## 1. Item codes missing from item lookup
- 154,441 rows (1.52%), 14 codes; 1.3-1.7% in every month. Prices look normal (January median RM7.20).
- Decision: exclude from item-level analysis; report the share.

## 2. Inconsistent premise_type label
- 'Pasar Basah ' (trailing space) vs 'Pasar Basah'. Decision: strip whitespace and merge.

## 3. Placeholder rows (code -1)
- Both lookups have a -1 row (blank item/premise). No price row uses either in any month.
- Decision: keep out of dimensions.

## 4. Missing calendar days
- 167 of 181 days present; 14 missing.
- 9 match national public holidays (17-18 Feb, 21-23 Mar, 1 May, 27 May, 1 Jun, 17 Jun). 20 Mar was likely an additional declared Raya holiday (sources differ).
- Unexplained: 13 Feb, 14 Mar, 19 Mar, 20 Jun.
- 1 Jan has few rows (10,757), plausibly because it was a holiday in most states (unconfirmed).
- Decision: do not fill gaps; compare averages per premise and day, never monthly totals.

## 5. Uneven reporting volume
- Typical day about 38k rows; Monday spikes (5, 12, 19, 26 Jan) and 29 Jan reach 190k-215k, mainly Kedai Runcit, Pasar Mini and supermarkets.
- Hypothesis (unconfirmed): batch uploads.
- Decision: average per premise first, then aggregate to premise type and state.

## 6. High outliers
- 207 rows above 5x the item median (26-49 per month). Mixed pattern, scattered across premises; only about a quarter look like sen/ringgit errors.
- Decision: do not auto-correct; exclude from main analysis.

## 7. Low outliers
- 1,649 rows below 0.2x the item median (145-408 per month). January: mostly leafy vegetables and fish sold per kg; two premises supply 37 of 298. Unclear whether typos or end-of-day discounts.
- Decision: exclude rows outside 0.2x-5x of the item median; run a sensitivity check with and without the filter.

## 8. Premise types
- Retail types report at scale: Pasar Raya/Supermarket (53.7% of rows), Pasar Basah (18.2%), Hypermarket (12.6%), Pasar Mini (11.1%), Kedai Runcit (4.4%).
- Borong: 207 rows (Jan-Feb only), excluded. Restaurant types, Foodcourt, Medan Selera and Kedai Serbaneka: no prices.
- Decision: analyse the five retail types; weight premises equally within type.

## 9. Item coverage
- Only 339 of 796 lookup items have prices. Prepared-food and convenience-store groups have none. Fresh goods are 58% of rows.
- Decision: choose the basket from items present in all six months.

## 10. Date stored as text
- Decision: convert to DATE on load.

## Method notes
- Prices are comparable only within the same item (units differ).
- Data is for price surveillance, not inflation analysis.