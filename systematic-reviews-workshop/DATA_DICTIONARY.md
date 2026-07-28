# Dataset pack — data dictionary

Three datasets, chosen to be globally relevant (not rheumatology) and to
build from raw data up to real pooled analysis. Each has a matching R script
in the Exercises folder and a rendered preview PNG here.

---

## 1. `raw_zinc_diarrhoea_patient_level.csv`  — *simulated*
**Domain:** maternal & child health. **Use:** build your own meta-analysis.

Individual-child records from four (simulated) trials of zinc vs control for
childhood diarrhoea. Participants construct the 2×2 table for each trial
themselves, then pool.

| Column | Meaning |
|--------|---------|
| `trial` | Trial site (Freetown, Bo, Kenema, Makeni) |
| `child_id` | Unique child identifier |
| `arm` | `zinc` or `control` |
| `persistent_diarrhoea` | 1 = diarrhoea lasted > 7 days; 0 = resolved |

858 children. Pooled RR ≈ **0.71** (I² ≈ 21%). *Simulated for teaching.*
Script: `01_zinc_build_your_own.R` · Preview: `preview_zinc.png`

---

## 2. `bcg_tb_aggregate.csv`  — *real*
**Domain:** infectious disease / global health. **Use:** pooling, heterogeneity,
meta-regression.

Aggregate 2×2 data from 13 trials of BCG vaccine vs TB (Colditz et al., *JAMA*
1994). Identical to `metafor::dat.bcg`, so answers can be checked against the
built-in dataset.

| Column | Meaning |
|--------|---------|
| `trial` | Trial number |
| `author`, `year` | Trial identifiers |
| `tpos`, `tneg` | TB cases / non-cases among the **vaccinated** |
| `cpos`, `cneg` | TB cases / non-cases among the **controls** |
| `abs_latitude` | Absolute latitude of the trial site (degrees) |
| `allocation` | Method of treatment allocation |

Pooled RR ≈ **0.49** (I² ≈ 92%). The high heterogeneity is the teaching point:
a meta-regression on `abs_latitude` shows BCG protects more at higher latitudes
(slope ≈ −0.03 per degree). Script: `02_bcg_tb_metaregression.R` · Preview:
`preview_bcg.png`

---

## 3. `magnesium_mi_teaching.csv`  — *simulated (cautionary tale)*
**Domain:** the cautionary tale. **Use:** small-study effects, funnel plots,
why one large trial can outweigh many small ones.

Seven small trials plus one large "definitive" trial of magnesium after acute
myocardial infarction. Built to mirror the real magnesium / ISIS-4 episode.

| Column | Meaning |
|--------|---------|
| `trial` | Trial name (last row = the large definitive trial) |
| `year` | Publication year |
| `deaths_mg`, `n_mg` | Deaths / patients in the magnesium arm |
| `deaths_control`, `n_control` | Deaths / patients in the control arm |

Small trials only: RR ≈ **0.51** (looks protective). Add the large trial and it
becomes RR ≈ **0.66** with the CI crossing 1 — the "benefit" evaporates.
*Simulated for teaching, inspired by real events.* Script:
`03_magnesium_cautionary_tale.R` · Preview: `preview_magnesium.png`
