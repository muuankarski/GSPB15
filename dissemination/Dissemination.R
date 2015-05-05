###########################################################################
## Dissemination Global Statistical Pocket Book 2015
###########################################################################

library(rgdal)
library(ggplot2)
library(gisfao)

# R version ---------------------------------------------------------------

rVersion <- R.Version()
if (rVersion$major != 3 | rVersion$minor != "2.0") {
  stop("The script is developed under the 3.2.0 R version.")
}
rm(rVersion)

# Read the dissemination file ---------------------------------------------

diss.df <- read.csv("./dissemination/DisseminationGSPB15.csv",
                    stringsAsFactors = FALSE, header = TRUE, nrow = 131)

# Country profile ---------------------------------------------------------

FAOcountryProfile <- 
  read.csv(file = "./database/Data/Processed/FAOcountryProfile.csv", 
           header = TRUE, na.strings = "", stringsAsFactors = FALSE)

# Construction and metadata files -----------------------------------------

load(file = "./database/Data/Processed/Construction.RData")
load(file = "./database/Data/Processed/Metadata.RData")
meta.df <- meta.lst$FULL

# Load the dataset --------------------------------------------------------

load(file = "./database/Data/Processed/PBdata.RData")
PBdataMaps.df <- PBdata.df
colnames(PBdataMaps.df)[grep("FAOST_CODE", colnames(PBdataMaps.df))] = "FAO_CODE"

## Add the short names
PBdata.df <- 
  merge(PBdata.df, FAOcountryProfile[, c("FAOST_CODE", "SHORT_NAME")],
        by = "FAOST_CODE", all.x = TRUE)

## Abbreviate names
PBdata.df[PBdata.df[, "FAO_TABLE_NAME"] == "Latin America and the Caribbean" & 
          !is.na(PBdata.df[, "FAO_TABLE_NAME"]), "FAO_TABLE_NAME"] <-
  "Latin America\nand the Caribbean"
PBdata.df[PBdata.df[, "FAO_TABLE_NAME"] == "Developed countries" & 
          !is.na(PBdata.df[, "FAO_TABLE_NAME"]), "FAO_TABLE_NAME"] <-
  "Developed\ncountries"
PBdata.df[PBdata.df[, "FAO_TABLE_NAME"] == "Developing countries" & 
          !is.na(PBdata.df[, "FAO_TABLE_NAME"]), "FAO_TABLE_NAME"] <-
  "Developing\ncountries"

PBdata.df[PBdata.df[, "SHORT_NAME"] == "Saint Vincent and the Grenadines" & 
          !is.na(PBdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Saint Vincent\nand the\nGrenadines"
PBdata.df[PBdata.df[, "SHORT_NAME"] == "Antigua and Barbuda" & 
          !is.na(PBdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Antigua and\nBarbuda"
PBdata.df[PBdata.df[, "SHORT_NAME"] == "Trinidad and Tobago" & 
          !is.na(PBdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Trinidad and\nTobago"
PBdata.df[PBdata.df[, "SHORT_NAME"] == "Republic of Moldova" & 
          !is.na(PBdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Republic of\nMoldova"
# PBdata.df[PBdata.df[, "SHORT_NAME"] == "Saint Helena, Ascension and Tristan da Cunha" & 
#           !is.na(PBdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
#   "Saint Helena,\nAscension and\nTristan da Cunha"
PBdata.df[PBdata.df[, "SHORT_NAME"] == "Saint Helena, Ascension and Tristan da Cunha" & 
          !is.na(PBdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Saint Helena"
PBdata.df[PBdata.df[, "SHORT_NAME"] == "Northern Mariana Islands" & 
          !is.na(PBdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "N. Mariana\nIslands"
PBdata.df[PBdata.df[, "SHORT_NAME"] == "Wallis and Futuna Islands" & 
          !is.na(PBdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Wallis and\nFutuna Is."
PBdata.df[PBdata.df[, "SHORT_NAME"] == "United Arab Emirates" & 
          !is.na(PBdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "United Arab\nEmirates"
PBdata.df[PBdata.df[, "SHORT_NAME"] == "Turks and Caicos Islands" & 
          !is.na(PBdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Turks and\nCaicos Is."
PBdata.df[PBdata.df[, "SHORT_NAME"] == "Central African Republic" & 
          !is.na(PBdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Central African\nRepublic"
PBdata.df[PBdata.df[, "SHORT_NAME"] == "Sao Tome and Principe" & 
          !is.na(PBdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Sao Tome and\nPrincipe"
PBdata.df[PBdata.df[, "SHORT_NAME"] == "United States of America" & 
          !is.na(PBdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "United States\nof America"
PBdata.df[PBdata.df[, "SHORT_NAME"] == "Iran (Islamic Republic of)" & 
          !is.na(PBdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Iran\n(Islamic Republic of)"
PBdata.df[PBdata.df[, "SHORT_NAME"] == "Bosnia and Herzegovina" & 
          !is.na(PBdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Bosnia and\nHerzegovina"
PBdata.df[PBdata.df[, "FAOST_CODE"] == "107" & 
          !is.na(PBdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Côte d'Ivoire"
PBdata.df[PBdata.df[, "SHORT_NAME"] == "Falkland Islands (Malvinas)" & 
          !is.na(PBdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Falkland Islands\n(Malvinas)"
PBdata.df[PBdata.df[, "SHORT_NAME"] == "Papua New Guinea" & 
          !is.na(PBdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Papua New\nGuinea"
PBdata.df[PBdata.df[, "SHORT_NAME"] == "American Samoa" & 
          !is.na(PBdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "American\nSamoa"
PBdata.df[PBdata.df[, "SHORT_NAME"] == "Western Sahara" & 
          !is.na(PBdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Western\nSahara"

## Chinas
PBdata.df[PBdata.df[, "FAOST_CODE"] %in% c(357), "Area"] <-
  "China 357"
PBdata.df[PBdata.df[, "FAOST_CODE"] %in% c(41), "Area"] <-
  "China 41"
PBdata.df[PBdata.df[, "FAOST_CODE"] %in% c(128), "Area"] <-
  "Macau"
PBdata.df[PBdata.df[, "FAOST_CODE"] %in% c(96), "Area"] <-
  "Hong Kong"
PBdata.df[PBdata.df[, "FAOST_CODE"] %in% c(214), "Area"] <-
  "Taiwan"
## Occupied Palestinian Territory
PBdata.df[PBdata.df[, "SHORT_NAME"] == "Occupied Palestinian Territory" & 
          !is.na(PBdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "West Bank and\nGaza Strip"
PBdata.df[PBdata.df[, "FAO_TABLE_NAME"] == "Occupied Palestinian Territory" & 
          !is.na(PBdata.df[, "FAO_TABLE_NAME"]), "FAO_TABLE_NAME"] <-
  "West Bank and Gaza Strip"

# Needed libraries --------------------------------------------------------

require(devtools)
# require(packrat)
# if (!"FAOSYB" %in% installed.packages()) {
#   install_github(username = "mkao006", repo = "FAOSYBpackage",
#                  ref = "master", subdir = "FAOSYB")
# }
require(FAOSYB)
require(plyr)
require(zoo)

# Source functions --------------------------------------------------------

# source("./dissemination/Rcode/Final/Sourcehttps.R")
# 
# Sourcehttps("https://raw.githubusercontent.com/filippogheri/ComplementaryScripts/master/plot_info.R",
#             "https://raw.githubusercontent.com/filippogheri/ComplementaryScripts/master/map_info.R",
#             "https://raw.githubusercontent.com/filippogheri/ComplementaryScripts/master/captions.R",
#             "https://raw.githubusercontent.com/filippogheri/ComplementaryScripts/master/ZsanitizeToLatex.R",
#             "https://raw.githubusercontent.com/filippogheri/ComplementaryScripts/master/exp_map.R",
#             "https://raw.githubusercontent.com/filippogheri/ComplementaryScripts/master/PBminitable.R")
# source("./dissemination/Rcode/Final/translateUnit.R")

# Source functions --------------------------------------------------------

## -- Sourcings Complementaty scripts from database folder.

debug_functions        = list.files(c("./dissemination/Rcode/Final/debug_functions/"), pattern="*.R$", full.names=TRUE, ignore.case=TRUE)
misc                   = list.files(c("./dissemination/Rcode/Final/misc/"), pattern="*.R$", full.names=TRUE, ignore.case=TRUE)
plot_functions         = list.files(c("./dissemination/Rcode/Final/plot_functions/"), pattern="*.R$", full.names=TRUE, ignore.case=TRUE)
table_functions        = list.files(c("./dissemination/Rcode/Final/table_functions/"), pattern="*.R$", full.names=TRUE, ignore.case=TRUE)
text_functions         = list.files(c("./dissemination/Rcode/Final/text_functions/"), pattern="*.R$", full.names=TRUE, ignore.case=TRUE)
theme_functions        = list.files(c("./dissemination/Rcode/Final/theme_functions/"), pattern="*.R$", full.names=TRUE, ignore.case=TRUE)

scripts_to_source <- c(debug_functions,
                       #misc,
                       plot_functions,
                       table_functions,
                       #text_functions,
                       theme_functions)

# A nested for loop for sourcing all the scripts

scripts_to_source <- scripts_to_source[-18] # exclude theme.R because:  Error in structure(list(colour = colour, size = size, linetype = linetype,  : object 'col.main2' not found 

for (i in 1:length(scripts_to_source)){
  source(scripts_to_source[i], encoding = "UTF-8")
}


# Paths -------------------------------------------------------------------

plotsOutput <- "./publication/Plots/"
mapsOutput <- "./publication/Maps/"
captionsOutput <- "./publication/Captions/"
sourcesOutput <- "./publication/Sources/"

# Maps --------------------------------------------------------------

## Font needed to embed the font in the maps
# source("../Fonts/PTsans.R")
# PTpath <- "../Fonts/PTsans/"
# PT <- PTsans(PTpath)
# if(!"PT" %in% names(pdfFonts())) pdfFonts(PT = PT)

## Font needed to embed the font in the maps
require(extrafont)
# font_import() only for once after installing the package
loadfonts()

## Ghost file needed to create the maps
# Sys.setenv(R_GSCMD='"C:/Program Files/gs/gs9.07/bin/gswin32c.exe"')
# gpclibPermit()
## Shape file needed for global map
#shpLocation <- "../../GSYB2015/shape/common/GAULRobinson2013/" # How using gisfao-package - not needed anymore 
 
## Country coding system used to fill the maps
mapCountryCode <- "FAO_CODE"
## Definition of common colors
NAdataColor <- "gray77"
classIntAlg <- "quantile"
## Width and height
mapWidth <- 15; mapHeight = 8

# transpCountries = 
#   data.frame(stringsAsFactors = FALSE,
#              Country = c("Estonia", "Lithuania", "Latvia", "Belarus",
#                          "Ukraine", "Georgia", "Armenia", "Azerbaijan",
#                          "Turkmenistan", "Kyrgyzstan", "Tajikistan"),
#              UN_CODE = c(233,440,428,112,804,268,51,31,795,417,762),
#              FAO_CODE = c(63,126,119,57,230,73,1,52,213,113,208))

## graticules
## http://rpsychologist.com/working-with-shapefiles-projections-and-world-maps-in-ggplot/
## http://www.naturalearthdata.com/downloads/110m-physical-vectors/110m-graticules/
#grat <- readOGR("../Graticules", layer = "ne_110m_graticules_15")
grat <- graticule # from gisfao-package
grat_robin <- spTransform(grat, CRS("+proj=robin"))  # reproject graticule
grat_df_robin <- fortify(grat_robin)

###########################################################################
## End
###########################################################################
