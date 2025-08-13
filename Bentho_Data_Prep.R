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

d.station <- read.csv("EMEL_StationName_log_20221207_MJA.csv")
