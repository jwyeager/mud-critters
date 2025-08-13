#########################################
#                                       #
#      Bentho Data Un-fucking 2025      #
#                                       #
#########################################
library(tidyverse)
library(magrittr)
library(stringr)

d.order <- read.csv("Updated_Taxonomy_OrderDown.csv")
d.phylum <- read.csv("Updated_Taxonomy_PhylumDown.csv")

d.all <- read.csv("Benthic infauna Summer 2022 RAW.csv")

d.station <- read.csv("RecHist.csv")

######
## unify station nomenclature
d.station$sta <- str_replace(d.station$Station, "BI_", "") # remove dumbass prefix
(sta.list <- unique(d.all$Station)) # list of stations where BI sampled

d.station.sub <- d.station %>% subset(sta %in% sta.list) #subset for stations sampled
(ballsack <- unique(d.station.sub$sta)) # for comparison
