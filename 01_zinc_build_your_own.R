# ---------------------------------------------------------------
# BEFORE YOU RUN: R must look in THIS folder, where the CSV files are.
# In RStudio:  Session > Set Working Directory > To Source File Location
# (the two lines below do this automatically in RStudio).
# ---------------------------------------------------------------
if (requireNamespace("rstudioapi", quietly = TRUE) && rstudioapi::isAvailable())
  setwd(dirname(rstudioapi::getSourceEditorContext()$path))

# ============================================================
# POD: Build your own meta-analysis
# Zinc for childhood diarrhoea (SIMULATED teaching data)
#
# You start from RAW, patient-level trial data, build the 2x2
# table for each trial yourself, then pool across trials.
# Data: raw_zinc_diarrhoea_patient_level.csv
#   columns: trial, child_id, arm ("zinc"/"control"),
#            persistent_diarrhoea (1 = lasted > 7 days)
# One-off setup:  install.packages("metafor")
# ============================================================
library(metafor)

raw <- read.csv("raw_zinc_diarrhoea_patient_level.csv", stringsAsFactors = FALSE)
head(raw)

# ---- 1. Build the 2x2 counts for every trial ---------------
# events = children whose diarrhoea persisted; n = arm size
library(stats)
agg <- aggregate(persistent_diarrhoea ~ trial + arm, data = raw,
                 FUN = function(x) c(events = sum(x), n = length(x)))
agg <- do.call(data.frame, agg)          # flatten the matrix column
names(agg) <- c("trial", "arm", "events", "n")

# reshape to one row per trial: zinc vs control
wide <- reshape(agg, idvar = "trial", timevar = "arm", direction = "wide")
# wide has events.zinc, n.zinc, events.control, n.control
print(wide)

# ---- 2. Effect sizes (risk ratio) --------------------------
es <- escalc(measure = "RR",
             ai = events.zinc,    bi = n.zinc    - events.zinc,
             ci = events.control, di = n.control - events.control,
             data = wide, slab = trial)

# ---- 3. Pool (random effects) ------------------------------
res <- rma(yi, vi, data = es, method = "DL", test = "knha")
summary(res)
predict(res, transf = exp, digits = 3)

# ---- 4. Forest plot ----------------------------------------
forest(res, atransf = exp, at = log(c(0.25, 0.5, 1, 2)),
       xlab = "Risk ratio (zinc vs control)",
       header = c("Trial", "RR [95% CI]"))

# TALKING POINTS
#  * You built this meta-analysis from raw data - nothing was
#    pre-digested. That is exactly the chain of custody a real
#    review needs.
#  * Notice the between-trial spread (heterogeneity): real data
#    are noisy. Interpret the pooled estimate with that in mind.
