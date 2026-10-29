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
- Eggs: Grade A fell 12% from January (13.99) to May (12.25); B and C fell more (lowest in April: 10.50 and 8.25). Eggs were not on the Raya maximum-price scheme list (SHMMP, 14-28 March 2026; source: https://www.kpdn.gov.my/images/2025/pengumuman/SENARAI-BARANGAN-SHMMP-HARI-RAYA-PUASA-2026.pdf), and the largest drops came after the scheme ended, so it does not explain the fall. A reported egg supply surplus in early 2026 (source: https://www.utusan.com.my/berita/2026/04/harga-telur-ayam-jatuh-lebihan-bekalan-di-pasaran/) is consistent with the pattern but untested here.
- SHMMP also listed onions and garlic for 14-28 March, so March onion prices may have been capped. Chicken wing was controlled only in Sabah, Sarawak and Labuan, and flour was not listed.
- External chart (source: https://zscommerce.my/harga/telur-ayam-gred-a, average price per 30 eggs): RM13.48 (Mar), 12.26 (Apr, May), 13.33 (Jun), rising to 15.49 (Sep). Consistent with the April-May low here; different method, not used for results.
- The four cooking oil items sit at the maximum retail prices (RM13.30 for 2 kg, RM30.90 for 5 kg), so they are regulated.
- Shop-to-shop spread (one median per shop, outliers excluded): the middle 80% of shops price chicken wing between RM13.59 and RM17.90 (median RM15.90, 1,223 premises) and Sauh flour between RM2.90 and RM3.80 (median RM3.20, 1,853 premises); spread is about 27-28% of the median for both.

## Caveats
- 10,160,224 rows; 14 of 181 days missing (9 match public holidays, 4 unexplained); 1.52% of rows have item codes missing from the lookup.
- Price-surveillance data, not an inflation measure.

## Robustness: Raya price scheme (sql/08)
- Onion and garlic prices by premise type, all days vs excluding 14-28 March 2026 (20 item and premise-type combinations): 18 identical; two differ slightly (Bawang besar kuning/holland at Pasar Basah RM4.50 to 4.80; Bawang kecil merah biasa import (India) at Pasar Mini RM4.99 to 4.90). The large gaps between hypermarkets and wet markets/small shops are unchanged, so the scheme does not drive the premise-type result. Cause of the two small differences not investigated.
- 73 shop-item pairs reported only on scheme days and drop out of the comparison (28,597 to 28,524).
- Scheme ceilings for yellow onion, red onion, India small red onion and Chinese garlic were lowered vs 2025 (source: https://www.astroawani.com/berita-malaysia/shmmp-aidilfitri-2026-27-barangan-disenaraikan-kacang-dal-tambahan-baharu).