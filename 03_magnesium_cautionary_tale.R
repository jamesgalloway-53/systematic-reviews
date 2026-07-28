# ---------------------------------------------------------------
# BEFORE YOU RUN: R must look in THIS folder, where the CSV files are.
# In RStudio:  Session > Set Working Directory > To Source File Location
# (the two lines below do this automatically in RStudio).
# ---------------------------------------------------------------
if (requireNamespace("rstudioapi", quietly = TRUE) && rstudioapi::isAvailable())
  setwd(dirname(rstudioapi::getSourceEditorContext()$path))

# ============================================================
# POD: When meta-analysis misleads - a cautionary tale
# Magnesium in acute myocardial infarction
#
# SIMULATED teaching data, built to mirror a real and famous
# episode: a series of small trials suggested magnesium saved
# lives; a single very large, definitive trial (like ISIS-4,
# 1995) then found no benefit. A lesson in small-study effects
# and why one mega-trial can outweigh many small ones.
# Data: magnesium_mi_teaching.csv
#   deaths_mg / n_mg          = deaths / patients, magnesium arm
#   deaths_control / n_control = deaths / patients, control arm
# One-off setup:  install.packages("metafor")
# ============================================================
library(metafor)

dat <- read.csv("magnesium_mi_teaching.csv", stringsAsFactors = FALSE)
dat  # last row is the large definitive trial

es <- escalc(measure = "RR",
             ai = deaths_mg,      bi = n_mg      - deaths_mg,
             ci = deaths_control, di = n_control - deaths_control,
             data = dat, slab = trial)

# ---- 1. Pool the SMALL trials only -------------------------
small <- es[es$trial != "MEGA-trial (definitive)", ]
res_small <- rma(yi, vi, data = small, method = "DL", test = "knha")
predict(res_small, transf = exp, digits = 3)   # looks protective!

# ---- 2. Now add the large definitive trial -----------------
res_all <- rma(yi, vi, data = es, method = "DL", test = "knha")
predict(res_all, transf = exp, digits = 3)      # benefit disappears

# ---- 3. Forest plot (all trials) ---------------------------
forest(res_all, atransf = exp, at = log(c(0.1, 0.5, 1, 2)),
       xlab = "Risk ratio of death (magnesium vs control)",
       header = c("Trial", "RR [95% CI]"))

# ---- 4. Funnel plot + Egger's test -------------------------
# Small-study effects: do smaller trials give bigger effects?
funnel(res_small, main = "Small trials only")
regtest(res_small)     # test for funnel asymmetry

# TALKING POINTS
#  * The small trials, pooled, gave a confident 'benefit'.
#  * The large trial overturned it - reproducing the real
#    magnesium / ISIS-4 story.
#  * Small-study effects (publication bias, lower quality,
#    true heterogeneity) can manufacture a spurious result.
#  * Always look at the funnel, weight the evidence by its
#    quality and size, and stay humble.
