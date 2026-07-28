# Systematic Reviews Workshop 2026 — datasets & scripts

Hands-on datasets and R scripts for the one-day systematic reviews & meta-analysis
workshop (King's College London / CRIBS). Everything here is what you need to run
the live meta-analyses yourself.

## What's inside

| File | What it is |
|------|------------|
| `raw_zinc_diarrhoea_patient_level.csv` | Individual-child data for four (simulated) zinc-vs-diarrhoea trials |
| `bcg_tb_aggregate.csv` | Real aggregate data: 13 BCG-vs-TB trials (Colditz et al., 1994) |
| `magnesium_mi_teaching.csv` | Simulated cautionary-tale dataset (magnesium in acute MI) |
| `01_zinc_build_your_own.R` | Build a meta-analysis from raw data |
| `02_bcg_tb_metaregression.R` | Pooling, heterogeneity and a meta-regression on latitude |
| `03_magnesium_cautionary_tale.R` | Small-study effects, funnel plot, sensitivity analysis |
| `DATA_DICTIONARY.md` | What every column means |
| `figures/` | Preview plots of each analysis |
| `exercises/` | Task files: abstracts to screen, papers, the risk-of-bias vignette, the extraction template |
| `Delegate_Manual.pdf` | Your take-home reference — **read this before the day** |

## What you get, and when

- **Before the workshop:** this repository — the Delegate Manual (read it in
  advance) plus the datasets and scripts (so you can install R and try things).
- **After the workshop:** the slide decks will be added here, as PowerPoint and
  as a single combined PDF handout.

## How to run (5 minutes to set up)

1. Install **R** (r-project.org) and **RStudio** (posit.co) — both free.
2. Install the one package we use, once:

   ```r
   install.packages("metafor")
   ```

3. Open any `.R` script in RStudio. The scripts live **in the same folder as the
   CSV files**, so they will find the data as long as R is looking in this folder.
   Each script sets this automatically in RStudio; if in doubt, use
   **Session ▸ Set Working Directory ▸ To Source File Location**.
4. Run the script top to bottom (Ctrl/Cmd + Enter runs a line).

## The datasets, honestly labelled

- **BCG and TB** is *real* published data (Colditz et al., *JAMA* 1994) and matches
  the `dat.bcg` dataset built into `metafor`, so you can check your answers.
- **Zinc** and **magnesium** are **simulated for teaching** — realistic, but not
  real trials. They are built to illustrate specific lessons (building a pooled
  estimate; how one large trial can overturn many small ones).

## Not included

The copyrighted source papers used elsewhere in the course are **not** in this
repository. All task files here are synthetic or illustrative.

## Licence

Teaching materials released under **CC BY 4.0** (see `LICENSE`) — free to reuse
and adapt with attribution. Real trial counts are facts and not subject to
copyright.
