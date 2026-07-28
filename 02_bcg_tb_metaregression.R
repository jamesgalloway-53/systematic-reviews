# ---------------------------------------------------------------
# BEFORE YOU RUN: R must look in THIS folder, where the CSV files are.
# In RStudio:  Session > Set Working Directory > To Source File Location
# (the two lines below do this automatically in RStudio).
# ---------------------------------------------------------------
if (requireNamespace("rstudioapi", quietly = TRUE) && rstudioapi::isAvailable())
  setwd(dirname(rstudioapi::getSourceEditorContext()$path))

# ============================================================
# POD: A real meta-analysis, and a twist
# BCG vaccine and tuberculosis (Colditz et al., JAMA 1994)
#
# REAL aggregate data - identical to metafor's built-in dat.bcg,
# so you can check your answer against data(dat.bcg).
# Data: bcg_tb_aggregate.csv
#   tpos/tneg = TB cases / non-cases among VACCINATED
#   cpos/cneg = TB cases / non-cases among CONTROLS
#   abs_latitude = absolute latitude of the trial site (degrees)
# One-off setup:  install.packages("metafor")
# ============================================================
library(metafor)

dat <- read.csv("bcg_tb_aggregate.csv", stringsAsFactors = FALSE)

# ---- 1. Effect sizes (risk ratio of TB) --------------------
es <- escalc(measure = "RR",
             ai = tpos, bi = tneg, ci = cpos, di = cneg,
             data = dat, slab = author)

# ---- 2. Overall random-effects model -----------------------
res <- rma(yi, vi, data = es, method = "REML")
predict(res, transf = exp, digits = 3)   # pooled RR ~ 0.49
res                                        # note the very high I^2

# ---- 3. Forest plot ----------------------------------------
forest(res, atransf = exp, at = log(c(0.1, 0.25, 1, 4)),
       xlab = "Risk ratio of TB (vaccinated vs control)",
       header = c("Trial", "RR [95% CI]"))

# ---- 4. THE TWIST: why is heterogeneity so high? -----------
# Hypothesis: BCG works better further from the equator.
# Meta-regression of log risk ratio on absolute latitude.
res_lat <- rma(yi, vi, mods = ~ abs_latitude, data = es, method = "REML")
res_lat                                    # significant negative slope
# how much heterogeneity does latitude explain?
cat("R^2 (heterogeneity explained by latitude):",
    round(res_lat$R2, 1), "%\n")

# Bubble plot: fitted line + study points sized by precision
regplot(res_lat, xlab = "Absolute latitude (degrees)",
        atransf = exp, las = 1, digits = 1, bty = "l",
        main = "BCG efficacy by latitude")

# TALKING POINTS
#  * A single number (pooled RR) hid the real story. The
#    heterogeneity WAS the finding: protection increases with
#    latitude.
#  * This is why you interpret I^2 before you trust a pooled
#    estimate - and why pre-specified moderators matter.
