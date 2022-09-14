#
# Collect results --------------------------------------------------------------
# 



row_names <- c("CaT", "CaT Z", "PSM", "IV", "CF", "DiD",  "DiD Z", "POA-IV", "POA-CF")
col_names <- c("estimate", "lower_CI", "upper_CI", "se_estimates")

estimates    <- c(CaT, CaT_Z, PSM, stIV, CF, DiD, DiD_Z, POAIV, POACF)
lower_CI     <- c(lower_CaT, lower_CaT_Z, lower_PSM, lower_stIV, lower_CF, lower_DiD, lower_DiD_Z, lower_POAIV, lower_POACF)
upper_CI     <- c(upper_CaT, upper_CaT_Z, upper_PSM, upper_stIV, upper_CF, upper_DiD, upper_DiD_Z, upper_POAIV, upper_POACF)
estimates_se <- c(se_CaT, se_CaT_Z, se_PSM, se_stIV, se_CF, se_DiD, se_DiD_Z, se_POAIV, se_POACF)

results <- data.frame(cbind(estimates, lower_CI, upper_CI, estimates_se))
rownames(results) <- row_names
colnames(results) <- col_names

