#########################################
#                                       #
#      Bentho Data Un-fucking 2025      #
#                                       #
#########################################
library(tidyverse)
library(magrittr)
library(stringr)

# d.order <- read.csv("Updated_Taxonomy_OrderDown.csv")
# d.phylum <- read.csv("Updated_Taxonomy_PhylumDown.csv")

d.all <- read.csv("Benthic infauna Summer 2022 RAW.csv")
d.biomass <- read.csv("BI_biomass_Summer2022.csv")
d.station <- read.csv("Coords_Benthic_Match_Stations_79.csv")

######
## unify station nomenclature
d.station$StationName <- str_replace(d.station$StationName, "BI_", "") # remove dumbass prefix
(d.station$StationName)
d.station$StationName <- str_replace(d.station$StationName, "_", "-") # change undercore to dash 
d.biomass$Sample <- str_replace(d.biomass$Sample, "GS", "GS-") # add dash in biomass file to match others

# check for further discrepancies
(sta.list.all <- unique(d.all$Station))

(sta.list.station <- unique(d.station$StationName))
(sta.list.bio <- unique(d.biomass$Sample))
length(sta.list.station) #[1] 79
length(sta.list.bio) #[1] 99

# return list of stations not present in new coordinate file
(no.match <- union(setdiff(sta.list.bio, sta.list.station),
                   setdiff(sta.list.station, sta.list.bio)))

# [1] "DK-CAN" "CC-SO1" "SIP5"   "WS-CAN" "ES-SO2" "CC-NO1" "CC-SO2" "CC-NO2" "ES-SO1" "WS-SO2"
# [11] "WS-SO1" "ES-NO2" "ES-NO1" "WS-NO1" "WS-NO2" "PSR1"   "PSR2"   "PSR3"   "PSR4"   "PSR5" 

######
## Prep for joining
by1 <- join_by(x$Station == y$StationName)
d.all.join <- full_join(d.all, d.station, by = by1)
write.csv(d.all.join, file = 'all_taxa_coords_081325.csv')
