# Findings draft (not final; every number checked against SQL output)

## Premise types (17 items sold in all five types; sql/05)
- Gap vs typical premise price: Hypermarket -7.8%, Supermarket -4.2%, Pasar Mini +2.3%, Kedai Runcit +5.4%, Pasar Basah +7.2%.
- Without onions: -3.0, -0.8, +0.3, +2.2, +4.6. Without cooking oil (13 items): -9.9, -5.5, +3.0, +7.0, +9.4.
- Same ordering in every version; spread between hypermarkets and wet markets 7.6-19.3 points.

## States (sql/06)
- All premises, average gap: Sabah +13.9, Sarawak +10.1, other states within about +/-4. Medians: Sabah +2.0, Sarawak +1.6.
- Supermarkets only: Sabah +18.7 avg / +3.8 median, Sarawak +14.1 / +3.6, KL +5.1 / +3.1.
- A few items drive the averages (small onions, eggs, standard chicken). Labuan, Perlis and Putrajaya rest on thin data.

## Month to month (sql/07)
- Eggs fell from January to April/May: Grade A 13.99 to 12.25, B 13.50 to 10.50, C 12.90 to 8.25, with a partial June recovery. No festive-season rise visible. Cause unknown.
- Chicken wing (RM15.90) and Sauh flour (RM3.20): identical all six months. Reason not checked.
- The four cooking oil items sit at the maximum retail prices (RM13.30 for 2 kg, RM30.90 for 5 kg), so they are regulated.

## Caveats
- 10,160,224 rows; 14 of 181 days missing (9 match public holidays, 4 unexplained); 1.52% of rows have item codes missing from the lookup.
- Price-surveillance data, not an inflation measure.