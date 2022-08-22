#
# Analysis of the Simulation Results -------------------------------------------
#

#
# Required information ---------------------------------------------------------
#


setwd("")                                                                       # insert path to main folder of this project

folder_main_code <- "Section3_Simulation"                                                  # insert name of the section folder


source("paths.R")

source("R_packages.R")

scenario <- 1                                                                   # for which scenario are the results plotted?

Beta     <- 0.1                                                                 # What is the true treatment effect? 

colours_dens_plot <- c("#f9bd14", "#b51d14", "#fb49b0", "#84ad75", "#34335f", "#6e6bcf")



#
# Density Plots of the estimation results --------------------------------------
#

load(paste0(path_results, "Scenario_", scenario, "/point_estimates_results_scenario_", scenario, ".Rdata", sep = ""))


Cairo(file = paste0(path_graphs, "Scenario_", scenario, "/density_plot_scenario_",scenario,".png"), 
      type = "png",
      units = "in", 
      width = 10, 
      height = 8, 
      pointsize = 12, 
      dpi = 72)

plot(density(point_estimates_results$CaT), xlab = "Distribution of Estimates", ylab = "Density", main = paste0("Scenario ", scenario, sep = ""),
     cex.main = 1.5, cex.axis = 1.5, lwd=3, cex.lab = 1.5, col = colours_dens_plot[1], xlim = c(-0.2,0.4), ylim = c(0,23)) 
lines(density(point_estimates_results$IV),col = colours_dens_plot[2],lwd = 6) 
lines(density(point_estimates_results$CF),col = colours_dens_plot[3],lwd = 3, lty = 1) 
lines(density(point_estimates_results$DiD), col = colours_dens_plot[4], lwd = 3)

abline(v = Beta, col = "black", lwd = 3)

legend("topleft", c("CaT", "IV", "CF", "DiD"),
       col = colours_dens_plot[c(1,2,3,4)], 
       bty = "n", cex = 1.5, lwd = 3, seg.len = 1, x.intersp = 0.4, y.intersp = 1.5,
lty = c(1,1,1,1))

dev.off()





