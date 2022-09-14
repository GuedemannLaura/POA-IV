#
# Results Visualization --------------------------------------------------------
#

#
# Paths ------------------------------------------------------------------------
#

setwd("")                                                                       # insert path to main folder "Code_and_Data"

folder_main_code <- "Section5_Application"                                      # name of the section folder

source("paths.R")

#
# Load required Packages -------------------------------------------------------
#

source("R_packages.R")

#
# Load data --------------------------------------------------------------------
#


load(paste0(path_results, "results.Rdata", sep = ""))



#
#  results plot -------------------------------------------------------------
#

results_percent <- results*100
attach(results_percent)


results_percent$method <- as.factor((c("CaT", "CaT with Z", "PSM", "IV", "CF", "DiD", "DiD with Z", "POA-IV", "POA-CF")))

results_percent$method <- factor(results_percent$method, levels = rev(c("CaT", "CaT with Z", "PSM", "IV", "CF", "DiD", "DiD with Z", "POA-IV", "POA-CF")))


Cairo(file = paste0(path_graphs, "point_estimates_CI.pdf"), 
      type = "pdf",
      units = "in", 
      width = 10, 
      height = 8, 
      pointsize = 12, 
      dpi = 72)


ggplot(results_percent, aes(x = estimate, y =  method)) +
  geom_point(size = 5) +
  geom_errorbarh(aes(xmin = lower_CI, xmax = upper_CI, height = 0.3), size = 0.7) +
  geom_vline(aes(xintercept = 0), colour = "lightgrey")+
  ylab("estimates") + 
  xlab("risk difference (%)") +
  theme_bw() + 
  theme(
    axis.title.x = element_text(size = 20),
    axis.text.x = element_text(size = 20),
    axis.text.y = element_text(size = 20),
    axis.title.y = element_text(size = 20))

dev.off()




























