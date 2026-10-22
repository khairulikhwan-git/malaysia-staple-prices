# Data issues log (PriceCatcher, Jan-Jun 2026)
Status: January checked; cross-month checks pending.

## 1. Item codes missing from item lookup
- Finding: 31,242 rows (1.58%), 14 codes between 2023 and 2096. Prices look normal (median RM7.20).
- Decision: exclude from item-level analysis; report the share.
- Status: recheck other months.

## 2. Inconsistent premise_type label
- Finding: 'Pasar Basah ' (trailing space, 338 premises) vs 'Pasar Basah' (22).
- Decision: strip whitespace and merge.

## 3. Placeholder rows (code -1)
- Finding: -1 rows in both lookups (blank item, premise type and state). No January prices use them.
- Decision: no action; keep out of dimensions.

## 4. Uneven reporting volume
- Finding: typical day about 38k rows; spikes of 190k-215k on 5, 12, 19, 26 and 29 Jan; 1 Jan is low (10,757).
- Spikes come mainly from Kedai Runcit, Pasar Mini and supermarkets; wet markets are steady.
- Hypothesis (unconfirmed): batch uploads by some premises.
- Decision: average per premise first, then aggregate to premise type and state.

## 5. Extreme high prices
- Finding: 40 rows above 5x the item median (up to 150x). Mixed pattern, not one error type; scattered across many premises.
- Decision: flag and exclude from main analysis; do not auto-correct; use medians.

## 6. Extreme low prices (not yet investigated)
- Finding: 298 rows below 0.2x the item median.

## 7. Possible missing premise types (to verify)
- Finding: restaurant, food court, Medan Selera and Kedai Serbaneka types do not appear in January daily counts.

## 8. Date stored as text
- Decision: convert to DATE on load.

## Method notes
- Prices are comparable only within the same item (units differ).
- Data is for price surveillance, not inflation analysis.surveillance, not inflation analysis.