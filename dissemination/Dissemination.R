###########################################################################
## Dissemination ICN2 Statistical Pocketbook 2014
###########################################################################

# R version ---------------------------------------------------------------

rVersion <- R.Version()
if (rVersion$major != 3 | rVersion$minor != 2.0) {
  stop("The script is developed under the 3.2.0 R version.")
}
rm(rVersion)

# Read the dissemination file ---------------------------------------------

diss.df <- read.csv("./Data/Processed/DisseminationICN2PB14.csv",
                    stringsAsFactors = FALSE, header = TRUE, nrow = 131)

# Country profile ---------------------------------------------------------

FAOcountryProfile <- 
  read.csv(file = "./Data/Processed/FAOcountryProfile.csv", 
           header = TRUE, na.strings = "", stringsAsFactors = FALSE)

# Construction and metadata files -----------------------------------------

load(file = "./Data/Processed/Construction.RData")
load(file = "./Data/Processed/Metadata.RData")
meta.df <- meta.lst$FULL

# Load the dataset --------------------------------------------------------

load(file = "./Data/Processed/icn2.RData")
icn2Maps.df <- icn2.df
colnames(icn2Maps.df)[grep("FAOST_CODE", colnames(icn2Maps.df))] = "FAO_CODE"

## Add the short names
icn2.df <- 
  merge(icn2.df, FAOcountryProfile[, c("FAOST_CODE", "SHORT_NAME")],
        by = "FAOST_CODE", all.x = TRUE)

## Abbreviate names
icn2.df[icn2.df[, "FAO_TABLE_NAME"] == "Latin America and the Caribbean" & 
          !is.na(icn2.df[, "FAO_TABLE_NAME"]), "FAO_TABLE_NAME"] <-
  "Latin America\nand the Caribbean"
icn2.df[icn2.df[, "FAO_TABLE_NAME"] == "Developed countries" & 
          !is.na(icn2.df[, "FAO_TABLE_NAME"]), "FAO_TABLE_NAME"] <-
  "Developed\ncountries"
icn2.df[icn2.df[, "FAO_TABLE_NAME"] == "Developing countries" & 
          !is.na(icn2.df[, "FAO_TABLE_NAME"]), "FAO_TABLE_NAME"] <-
  "Developing\ncountries"

icn2.df[icn2.df[, "SHORT_NAME"] == "Saint Vincent and the Grenadines" & 
          !is.na(icn2.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Saint Vincent\nand the\nGrenadines"
icn2.df[icn2.df[, "SHORT_NAME"] == "Antigua and Barbuda" & 
          !is.na(icn2.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Antigua and\nBarbuda"
icn2.df[icn2.df[, "SHORT_NAME"] == "Trinidad and Tobago" & 
          !is.na(icn2.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Trinidad and\nTobago"
icn2.df[icn2.df[, "SHORT_NAME"] == "Republic of Moldova" & 
          !is.na(icn2.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Republic of\nMoldova"
# icn2.df[icn2.df[, "SHORT_NAME"] == "Saint Helena, Ascension and Tristan da Cunha" & 
#           !is.na(icn2.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
#   "Saint Helena,\nAscension and\nTristan da Cunha"
icn2.df[icn2.df[, "SHORT_NAME"] == "Saint Helena, Ascension and Tristan da Cunha" & 
          !is.na(icn2.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Saint Helena"
icn2.df[icn2.df[, "SHORT_NAME"] == "Northern Mariana Islands" & 
          !is.na(icn2.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "N. Mariana\nIslands"
icn2.df[icn2.df[, "SHORT_NAME"] == "Wallis and Futuna Islands" & 
          !is.na(icn2.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Wallis and\nFutuna Is."
icn2.df[icn2.df[, "SHORT_NAME"] == "United Arab Emirates" & 
          !is.na(icn2.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "United Arab\nEmirates"
icn2.df[icn2.df[, "SHORT_NAME"] == "Turks and Caicos Islands" & 
          !is.na(icn2.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Turks and\nCaicos Is."
icn2.df[icn2.df[, "SHORT_NAME"] == "Central African Republic" & 
          !is.na(icn2.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Central African\nRepublic"
icn2.df[icn2.df[, "SHORT_NAME"] == "Sao Tome and Principe" & 
          !is.na(icn2.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Sao Tome and\nPrincipe"
icn2.df[icn2.df[, "SHORT_NAME"] == "United States of America" & 
          !is.na(icn2.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "United States\nof America"
icn2.df[icn2.df[, "SHORT_NAME"] == "Iran (Islamic Republic of)" & 
          !is.na(icn2.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Iran\n(Islamic Republic of)"
icn2.df[icn2.df[, "SHORT_NAME"] == "Bosnia and Herzegovina" & 
          !is.na(icn2.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Bosnia and\nHerzegovina"
icn2.df[icn2.df[, "FAOST_CODE"] == "107" & 
          !is.na(icn2.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Côte d'Ivoire"
icn2.df[icn2.df[, "SHORT_NAME"] == "Falkland Islands (Malvinas)" & 
          !is.na(icn2.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Falkland Islands\n(Malvinas)"
icn2.df[icn2.df[, "SHORT_NAME"] == "Papua New Guinea" & 
          !is.na(icn2.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Papua New\nGuinea"
icn2.df[icn2.df[, "SHORT_NAME"] == "American Samoa" & 
          !is.na(icn2.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "American\nSamoa"
icn2.df[icn2.df[, "SHORT_NAME"] == "Western Sahara" & 
          !is.na(icn2.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Western\nSahara"

## Chinas
icn2.df[icn2.df[, "FAOST_CODE"] %in% c(357), "Area"] <-
  "China 357"
icn2.df[icn2.df[, "FAOST_CODE"] %in% c(41), "Area"] <-
  "China 41"
icn2.df[icn2.df[, "FAOST_CODE"] %in% c(128), "Area"] <-
  "Macau"
icn2.df[icn2.df[, "FAOST_CODE"] %in% c(96), "Area"] <-
  "Hong Kong"
icn2.df[icn2.df[, "FAOST_CODE"] %in% c(214), "Area"] <-
  "Taiwan"
## Occupied Palestinian Territory
icn2.df[icn2.df[, "SHORT_NAME"] == "Occupied Palestinian Territory" & 
          !is.na(icn2.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "West Bank and\nGaza Strip"
icn2.df[icn2.df[, "FAO_TABLE_NAME"] == "Occupied Palestinian Territory" & 
          !is.na(icn2.df[, "FAO_TABLE_NAME"]), "FAO_TABLE_NAME"] <-
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

source("./Rcode/Final/Sourcehttps.R")




Sourcehttps("https://raw.githubusercontent.com/filippogheri/ComplementaryScripts/master/plot_info.R",
            "https://raw.githubusercontent.com/filippogheri/ComplementaryScripts/master/map_info.R",
            "https://raw.githubusercontent.com/filippogheri/ComplementaryScripts/master/captions.R",
            "https://raw.githubusercontent.com/filippogheri/ComplementaryScripts/master/ZsanitizeToLatex.R",
            "https://raw.githubusercontent.com/filippogheri/ComplementaryScripts/master/exp_map.R",
            "https://raw.githubusercontent.com/filippogheri/ComplementaryScripts/master/PBminitable.R")
source("./Rcode/Final/translateUnit.R")

# Paths -------------------------------------------------------------------

plotsOutput <- "./Outputs/Plots/"
mapsOutput <- "./Outputs/Maps/"
captionsOutput <- "./Outputs/Captions/"
sourcesOutput <- "./Outputs/Sources/"

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
shpLocation <- "../GAULRobinson2013/WorldMap_Robin_g2013_S2"
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
grat <- readOGR("../Graticules", layer = "ne_110m_graticules_15")
grat_robin <- spTransform(grat, CRS("+proj=robin"))  # reproject graticule
grat_df_robin <- fortify(grat_robin)

###########################################################################
## End
###########################################################################
