###############################################################################
#                                                                             #
#                          Bentho Data Un-fucking 2025                        #
#                                                                             #
###############################################################################
library(tidyverse)
library(magrittr)
library(stringr)

# d.order <- read.csv("Updated_Taxonomy_OrderDown.csv")
# d.phylum <- read.csv("Updated_Taxonomy_PhylumDown.csv")

d.taxa <- read.csv("Benthic infauna Summer 2022 RAW.csv")
d.biomass <- read.csv("BI_biomass_Summer2022.csv")
d.station <- read.csv("StationLog.csv")

d.biomass <- d.biomass %>% select(-X) # rm ghost column

## Optional files with taxonomy updated to conform to recognized names in 2025
# d.order <- read.csv("Updated_Taxonomy_OrderDown.csv")
# d.phylum <- read.csv("Updated_Taxonomy_PhylumDown.csv")

###############################################################################
## unify station nomenclature
d.station$station <- str_replace(d.station$station, "BI_", "") # remove dumbass prefix
(d.station$station)
d.station$station <- str_replace(d.station$station, "_", "-") # change undercore to dash 
d.biomass$Sample <- str_replace(d.biomass$Sample, "GS", "GS-") # add dash in biomass file to match others
(d.station$station)
# check for further discrepancies
(sta.list.taxa <- unique(d.taxa$Station))
(sta.list.station <- unique(d.station$station))
(sta.list.bio <- unique(d.biomass$Sample))
length(sta.list.station) #[1] 99
length(sta.list.bio) #[1] 99
length(sta.list.taxa) #[1] 99

# check for and return list of stations not present in new coordinate file
(no.match <- union(setdiff(sta.list.bio, sta.list.station),
                   setdiff(sta.list.station, sta.list.bio)))
#[1] "PSR1"  "PSR2"  "PSR3"  "PSR4"  "PSR5"  "PSR-1" "PSR-2" "PSR-3" "PSR-4" "PSR-5"
  # need to add a '-' in d.biomass
d.biomass$Sample <- str_replace(d.biomass$Sample, "PSR", "PSR-")
unique(d.biomass$Sample) #looks right
sta.list.bio <- unique(d.biomass$Sample) #update list
(no.match2 <- union(setdiff(sta.list.bio, sta.list.station),
                    setdiff(sta.list.station, sta.list.bio)))
# character(0)
(no.match3 <- union(setdiff(sta.list.taxa, sta.list.station),
                   setdiff(sta.list.station, sta.list.taxa)))
d.taxa$Station <- str_replace(d.taxa$Station, "PSR", "PSR-")
sta.list.taxa <- unique(d.taxa$Station) # update list
(no.match4 <- union(setdiff(sta.list.taxa, sta.list.station),
                    setdiff(sta.list.station, sta.list.taxa)))
# [1] "CC-N01" "CC-N02" "CC-S01" "CC-S02" "ES-N01" "ES-N02" "ES-S01" "ES-S02" "WS-N01" "WS-N02" "WS-S01" "WS-S02" "CC-SO1"
# [14] "ES-SO2" "CC-NO1" "CC-SO2" "CC-NO2" "ES-SO1" "WS-SO2" "WS-SO1" "ES-NO2" "ES-NO1" "WS-NO1" "WS-NO2"
    # someone used the letter "O" when it should be the number "0". Or vice-versa. It doesn't matter. Classic.

# replacing characters in d.taxa to match d.biomass and d.station 
d.taxa$Station <- str_replace(d.taxa$Station, "N0", "NO")
d.taxa$Station <- str_replace(d.taxa$Station, "S0", "SO")
(sta.list.taxa <- unique(d.taxa$Station)) # update list

# check again
(no.match5 <- union(setdiff(sta.list.taxa, sta.list.station),
                    setdiff(sta.list.station, sta.list.taxa)))
# character(0)
# all station names should match now

###############################################################################
## Join Coordinates to BI data

# Taxa
by1 <- join_by(x$Station == y$station)
d.taxa.coords <- full_join(d.taxa, d.station, by = by1)
#write_csv(d.taxa.coords, file = 'all_taxa_coords_ACTUAL.csv')

# Biomass
by2 <- join_by(x$Sample == y$station)
d.biomass.coords <- full_join(d.biomass, d.station, by = by2)
#write_csv(d.biomass.coords, file='BI_biomass_coords.csv')

###############################################################################
#                       DATA SUCCESSFULLY UN-FUCKED                           #
###############################################################################
