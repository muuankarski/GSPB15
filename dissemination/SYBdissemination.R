###########################################################################
## This script generates the Global Statistical Pocketbook 2015
###########################################################################

setwd("~/btsync/fao_sync/pocketbooks/GSPB15")

# Set up packrat ----------------------------------------------------------

# require(devtools)
# require(packrat)
# packrat::init()
# packrat::status()

# Operating system ----------------------------------------------------------

os_name <- Sys.info()['sysname']

# Set paths for outputs (different for linux than windows) 

if (os_name == "Linux") {
  path_to_latex <- "./publication/"
} else path_to_latex <- "./publication/"


# R version ---------------------------------------------------------------

# rVersion <- R.Version()
# if (rVersion$major != 3 | rVersion$minor != 1.1) {
#   stop("The script is developed under the 3.1.1 R version.")
# }
# rm(rVersion)

# Needed libraries --------------------------------------------------------

if (os_name != "Linux") memory.limit(size = 4095) # only for Windows

require(devtools)
if (!"FAOSTAT" %in% installed.packages()) {
  install_github(username = "mkao006", repo = "FAOSTATpackage",
                 ref = "master", subdir = "FAOSTAT")
}
# if (!"FAOSYB" %in% installed.packages()) {
#   install_github(username = "mkao006", repo = "FAOSYBpackage",
#                  ref = "master", subdir = "FAOSYB")
# }
require(FAOSTAT)
#require(FAOSYB)
require(zoo)
#require(packrat)
require(grid)
require(xtable)
library(dplyr)

# install FAOSYBpackage dependencies

FAOSYBpackages <- c("ggplot2","plyr","RColorBrewer",
                    "reshape2","maptools","classInt",
                    "rgdal","sp",#"gpclib",
                    "labeling",
                    "FAOSTAT","grid","scales","gisfao")
lapply(FAOSYBpackages, require, character.only=T)
library(mapproj)

# Dissemination file ------------------------------------------------------

# load from ethercalc

#download.file("https://ethercalc.org/5btva8ngeh.csv", destfile = "./dissemination/DisseminationGSPB15_web.csv", method = "curl")


diss.df <- 
  read.csv(file = "./dissemination/DisseminationGPock2.csv", 
           header = TRUE, na.strings = "", stringsAsFactors = FALSE)



# diss.df2 <- 
#   read.csv(file = "./dissemination/DisseminationGSYB15.csv", 
#            header = TRUE, na.strings = "", stringsAsFactors = FALSE)



# Source functions --------------------------------------------------------

## -- Sourcings Complementaty scripts from database folder.

construction_functions = list.files(c("./database/Rcode/Final/construction_functions/"), pattern="*.R$", full.names=TRUE, ignore.case=TRUE)
debug_functions        = list.files(c("./dissemination/Rcode/Final/debug_functions/"), pattern="*.R$", full.names=TRUE, ignore.case=TRUE)
misc                   = list.files(c("./dissemination/Rcode/Final/misc/"), pattern="*.R$", full.names=TRUE, ignore.case=TRUE)
plot_functions         = list.files(c("./dissemination/Rcode/Final/plot_functions/"), pattern="*.R$", full.names=TRUE, ignore.case=TRUE)
table_functions        = list.files(c("./dissemination/Rcode/Final/table_functions/"), pattern="*.R$", full.names=TRUE, ignore.case=TRUE)
text_functions         = list.files(c("./dissemination/Rcode/Final/text_functions/"), pattern="*.R$", full.names=TRUE, ignore.case=TRUE)
theme_functions        = list.files(c("./dissemination/Rcode/Final/theme_functions/"), pattern="*.R$", full.names=TRUE, ignore.case=TRUE)

# Source sanitizeToLatex before
source(plot_functions[11])
source(table_functions[4])
source(theme_functions[2])
source(theme_functions[1])

scripts_to_source <- c(construction_functions,
                         debug_functions,
                         #misc,
                         plot_functions,
                         table_functions,
                         #text_functions,
                         theme_functions)

# A nested for loop for sourcing all the scripts

for (i in 1:length(scripts_to_source)){
    source(scripts_to_source[i], encoding = "UTF-8")
}


# Construction and metadata files -----------------------------------------

load(file = "./database/Data/Processed/Construction.RData")
load(file = "./database/Data/Processed/Metadata.RData")
meta.df <- meta.lst$FULL

# FAO country profile -----------------------------------------------------

load("./database/FAOcountryProfile.RData")

# Load the dataset --------------------------------------------------------

load(file = "./database/Data/Processed/SYB.RData")
sybdata.df <- SYB.df; rm(SYB.df)
## NOTE (FILIPPO): I still need to address the issue of Sudan
sybMaps.df <- sybdata.df
names(sybMaps.df)[names(sybMaps.df)=="FAOST_CODE"] <- "FAO_CODE"

## Add the short names
sybdata.df <- 
  merge(sybdata.df, FAOcountryProfile[, c("FAOST_CODE", "SHORT_NAME")],
        by = "FAOST_CODE", all.x = TRUE)

## Abbreviate names
sybdata.df[sybdata.df[, "FAO_TABLE_NAME"] == "Latin America and the Caribbean" & 
            !is.na(sybdata.df[, "FAO_TABLE_NAME"]), "FAO_TABLE_NAME"] <-
  "Latin America\nand the Caribbean"
sybdata.df[sybdata.df[, "FAO_TABLE_NAME"] == "Developed countries" & 
            !is.na(sybdata.df[, "FAO_TABLE_NAME"]), "FAO_TABLE_NAME"] <-
  "Developed\ncountries"
sybdata.df[sybdata.df[, "FAO_TABLE_NAME"] == "Developing countries" & 
            !is.na(sybdata.df[, "FAO_TABLE_NAME"]), "FAO_TABLE_NAME"] <-
  "Developing\ncountries"

sybdata.df[sybdata.df[, "SHORT_NAME"] == "Saint Vincent and the Grenadines" & 
            !is.na(sybdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Saint Vincent\nand the\nGrenadines"
sybdata.df[sybdata.df[, "SHORT_NAME"] == "Antigua and Barbuda" & 
            !is.na(sybdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Antigua and\nBarbuda"
sybdata.df[sybdata.df[, "SHORT_NAME"] == "Trinidad and Tobago" & 
            !is.na(sybdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Trinidad and\nTobago"
sybdata.df[sybdata.df[, "SHORT_NAME"] == "Republic of Moldova" & 
            !is.na(sybdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Republic of\nMoldova"
# sybdata.df[sybdata.df[, "SHORT_NAME"] == "Saint Helena, Ascension and Tristan da Cunha" & 
#           !is.na(sybdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
#   "Saint Helena,\nAscension and\nTristan da Cunha"
sybdata.df[sybdata.df[, "SHORT_NAME"] == "Saint Helena, Ascension and Tristan da Cunha" & 
            !is.na(sybdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Saint Helena"
sybdata.df[sybdata.df[, "SHORT_NAME"] == "Northern Mariana Islands" & 
            !is.na(sybdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "N. Mariana\nIslands"
sybdata.df[sybdata.df[, "SHORT_NAME"] == "Wallis and Futuna Islands" & 
            !is.na(sybdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Wallis and\nFutuna Is."
sybdata.df[sybdata.df[, "SHORT_NAME"] == "United Arab Emirates" & 
            !is.na(sybdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "United Arab\nEmirates"
sybdata.df[sybdata.df[, "SHORT_NAME"] == "Turks and Caicos Islands" & 
            !is.na(sybdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Turks and\nCaicos Is."
sybdata.df[sybdata.df[, "SHORT_NAME"] == "Central African Republic" & 
            !is.na(sybdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Central African\nRepublic"
sybdata.df[sybdata.df[, "SHORT_NAME"] == "Sao Tome and Principe" & 
            !is.na(sybdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Sao Tome and\nPrincipe"
sybdata.df[sybdata.df[, "SHORT_NAME"] == "United States of America" & 
            !is.na(sybdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "United States\nof America"
sybdata.df[sybdata.df[, "SHORT_NAME"] == "Iran (Islamic Republic of)" & 
            !is.na(sybdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Iran\n(Islamic Republic of)"
sybdata.df[sybdata.df[, "SHORT_NAME"] == "Bosnia and Herzegovina" & 
            !is.na(sybdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Bosnia and\nHerzegovina"
sybdata.df[sybdata.df[, "FAOST_CODE"] == "107" & 
            !is.na(sybdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Côte d'Ivoire"
sybdata.df[sybdata.df[, "SHORT_NAME"] == "Falkland Islands (Malvinas)" & 
            !is.na(sybdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Falkland Islands\n(Malvinas)"
sybdata.df[sybdata.df[, "SHORT_NAME"] == "Papua New Guinea" & 
            !is.na(sybdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Papua New\nGuinea"
sybdata.df[sybdata.df[, "SHORT_NAME"] == "American Samoa" & 
            !is.na(sybdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "American\nSamoa"
sybdata.df[sybdata.df[, "SHORT_NAME"] == "Western Sahara" & 
            !is.na(sybdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Western\nSahara"

## Chinas
sybdata.df[sybdata.df[, "FAOST_CODE"] %in% c(357), "Area"] <-
  "China 357"
sybdata.df[sybdata.df[, "FAOST_CODE"] %in% c(41), "Area"] <-
  "China 41"
sybdata.df[sybdata.df[, "FAOST_CODE"] %in% c(128), "Area"] <-
  "Macau"
sybdata.df[sybdata.df[, "FAOST_CODE"] %in% c(96), "Area"] <-
  "Hong Kong"
sybdata.df[sybdata.df[, "FAOST_CODE"] %in% c(214), "Area"] <-
  "Taiwan"
## Occupied Palestinian Territory
sybdata.df[sybdata.df[, "SHORT_NAME"] == "Occupied Palestinian Territory" & 
            !is.na(sybdata.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "West Bank and\nGaza Strip"
sybdata.df[sybdata.df[, "FAO_TABLE_NAME"] == "Occupied Palestinian Territory" & 
            !is.na(sybdata.df[, "FAO_TABLE_NAME"]), "FAO_TABLE_NAME"] <-
  "West Bank and Gaza Strip"






# Plots -------------------------------------------------------------


plotsOutput <- paste0(path_to_latex,"Plots/")
plotWidth <- 4; plotHeight <- 4
plotWidthPng <- 450; plotHeightPng <- 450
pngPlotsOutput <- "./draft/pngPlots/"


# Maps --------------------------------------------------------------

## Font needed to embed the font in the maps

#if (os_name == "Linux") {
  library(extrafont)
  # font_import() only for once after installing the package
  loadfonts()
#  PT <- "PTsans"
# #} else{
#   source("../../Common/Fonts/PTsans.R")
#   PTpath <- "../../Common/Fonts/PTsans/"
#   PT <- PTsans(PTpath)
#   if(!"PT" %in% names(pdfFonts())) pdfFonts(PT = PT)
# }


## Ghost file needed to create the maps

if (os_name == "Linux") {
  library(rgeos)
  #gpclibPermit()
} else{
  library(rgeos)
  Sys.setenv(R_GSCMD = "C:/Program Files (x86)/gs/gs9.15/bin/gswin32c.exe")
  #gpclibPermit()
}


## Shape file needed for global map
#shpLocation <- "../shape/Common/GAULRobinson2013/WorldMap_Robin_g2013_S2" # Now using gisfao-package - not needed anymore 
## Country coding system used to fill the maps
mapCountryCode <- "FAO_CODE"
## Definition of common colors
NAdataColor <- "gray77"
classIntAlg <- "quantile"
## Map output
mapsOutput <- paste0(path_to_latex,"Maps/")
## Width and height
mapWidth <- 15; mapHeight <- 8
## Draft maps
mapWidthPng <- 1500; mapHeightPng <- 800
pngMapsOutput <- "./draft/pngMaps/"


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
library(rgdal)
library(ggplot2)
library(gisfao)
grat <- graticule # from gisfao-package
grat_robin <- spTransform(grat, CRS("+proj=robin"))  # reproject graticule
grat_df_robin <- fortify(grat_robin)

# Tables ------------------------------------------------------------

tablesOutput <- paste0(path_to_latex,"Tables/")

# Captions ----------------------------------------------------------

captionsOutput <- paste0(path_to_latex,"Captions/")

# Sources -----------------------------------------------------------

sourcesOutput <- paste0(path_to_latex,"Sources/")

# Texts -----------------------------------------------------------

textsOutput <- paste0(path_to_latex,"Text/")

# Extract texts from the dissemination file
text.df <- diss.df[diss.df[["OBJECT_TYPE"]] == "TEXT",]

# Extract the text from the TEXT column in dissemination file and write into .tex file
for (r in 1:nrow(text.df)){
  file_name <- text.df[r,"OBJECT_NAME"]
  content <- text.df[r,"TEXT"]
  writeLines(content, con = paste0(textsOutput,file_name,".tex"), sep = "\n", useBytes = FALSE)
}


###########################################################################
## End
###########################################################################
