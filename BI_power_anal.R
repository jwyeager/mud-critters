################################################################################
#                                                                              #
#                        Yabby Biomass Power Analysis                          #
#                                                                              #
################################################################################
library(tidyverse)
library(pwr)

d <- read_csv('BI_biomass_coords.csv')
taxa <- read_csv('all_taxa_coords_Actual.csv')

x.Ann <- mean(d$Ann.g.m2)
x.Moll <- mean(d$Moll.g.m2)
x.Art <- mean(d$Art.g.m2)
x.Ech <- mean(d$Ech.g.m2)
x.Tot <- mean(d$Total.g.m2)

sd.Tot <- sd(d$Total.g.m2)
sd.Art <- sd(d$Art.g.m2)

n.rough <- ((1.96 * sd.Tot) / (0.1 * x.Tot))^2
n.Art.rough <- ((1.96 * sd.Art) / (0.1 * x.Art))^2

max.n.500m <- 42 + 79 + 71 + 52

244 / 4


