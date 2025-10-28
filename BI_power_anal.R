################################################################################
#                                                                              #
#                        Yabby Biomass Power Analysis                          #
#                                                                              #
################################################################################
library(tidyverse)
library(pwr)

d <- read_csv('BI_biomass_coords.csv')
taxa <- read_csv('all_taxa_coords_Actual.csv')
sites <- read_csv('Shoreline_Points_500m.csv')

x.Ann <- mean(d$Ann.g.m2)
x.Moll <- mean(d$Moll.g.m2)
x.Art <- mean(d$Art.g.m2)
x.Ech <- mean(d$Ech.g.m2)
x.Tot <- mean(d$Total.g.m2)

sd.Tot <- sd(d$Total.g.m2)
sd.Art <- sd(d$Art.g.m2)

n.rough <- ((1.96 * sd.Tot) / (0.1 * x.Tot))^2
n.Art.rough <- ((1.96 * sd.Art) / (0.1 * x.Art))^2

N <- as.numeric(length(sites$OBJECTID))
N.rmDeer <- N - 40
N.rmNPS <- N - 79 - 42 

(n.adj <- (n.rough / (1 + (n.rough-1) / N))) # [1] 153.0341
(n.adj.rmDeer <- (n.rough / (1 + (n.rough-1) / N.rmDeer))) #[1] 140.6474
(n.adj.rmNPS <- (n.rough / (1 + (n.rough-1) / N.rmNPS))) #[1] 109.404
