###########################################################################
## This script generates the database for the Global Statistical Pocket Book 2015
###########################################################################

# One shot commands -------------------------------------------------------

# require(devtools)
# require(packrat)
# packrat::init()

###########################################################################
## Settings
###########################################################################

# memory.limit(size = 4095)

# R version ---------------------------------------------------------------

rVersion <- R.Version()
if (rVersion$major != 3 | rVersion$minor != "2.0") {
  stop("The script is developed under the 3.2.0 R version.")
}
rm(rVersion)

# Needed libraries --------------------------------------------------------

require(devtools)
require(packrat)
if (!"FAOSTAT" %in% installed.packages()) {
  install_github(username = "mkao006", repo = "FAOSTATpackage",
                 ref = "master", subdir = "FAOSTAT")
}
require(FAOSTAT)
require(plyr)
require(zoo)
require(reshape2)
require(data.table)

# Packrat -----------------------------------------------------------------

# packrat::status()
# packrat::snapshot()
# packrat::restore()

# Source functions --------------------------------------------------------

source("./database/Rcode/Final/CarryBackward.R")
source("./database/Rcode/Final/CarryForward.R")
source("./database/Rcode/Final/MovingAverage.R")
source("./database/Rcode/Final/ReplaceValue.R")
source("./database/Rcode/Final/SetToNa.R")

source("./database/Rcode/Final/misc_functions/CheckLogical.R")
source("./database/Rcode/Final/misc_functions/CheckValues.R")
source("./database/Rcode/Final/misc_functions/Sourcehttps.R")
source("./database/Rcode/Final/misc_functions/sum2.R")
source("./database/Rcode/Final/read_functions/ReadConstruction.R")
source("./database/Rcode/Final/read_functions/ReadMetadata.R")


###########################################################################
## User inputs
###########################################################################

# Country profile ---------------------------------------------------------

FAOcountryProfile <- 
  read.csv(file = "./database/Data/Processed/FAOcountryProfile.csv", 
           header = TRUE, na.strings = "", stringsAsFactors = FALSE)

# Construction and metadata files -----------------------------------------

con.df <- ReadConstruction(file = "./database/Construction2015.csv", 
                           encoding = "UTF-8", nrows = 221)
meta.lst <- ReadMetadata(file = "./database/Metadata2015.csv", 
                         encoding = "UTF-8", nrows = 221)

# Parameters --------------------------------------------------------------

downloadFAOSTAT <- TRUE; CheckLogical(downloadFAOSTAT)
downloadWB <- TRUE; CheckLogical(downloadWB)


###########################################################################
## Data collection
###########################################################################

# Download variables from FAOSTAT -----------------------------------------

if (downloadFAOSTAT) {
  ## Download data from FAOSTAT
  FAO.lst <- with(meta.lst[["FAOSTAT"]],
                  getFAOtoSYB(name = STS_ID,
                              domainCode = SQL_DOMAIN_CODE,
                              elementCode = SQL_ELEMENT_CODE,
                              itemCode = SQL_ITEM_CODE,
                              productionDB = FALSE,
                              useCHMT = FALSE))
  FAOSTAT.df <- FAO.lst$entity; rm(downloadFAOSTAT); rm(FAO.lst)
  ## ...update list
  save(x = FAOSTAT.df, file = paste0("./database/Data/Processed/FAOSTAT", Sys.Date(), ".RData"))
} else {
  ## ...open list
  load(file = "./database/Data/Processed/FAOSTAT2015-05-04.RData")
}

# Download variables from WB ----------------------------------------------

if (downloadWB) {
  ## Download data from WDI
  WB.lst <- with(meta.lst[["WDI"]],
                 getWDItoSYB(indicator = WDINAME, name = STS_ID))
  ## ...update list
  save(x = WB.lst, file = paste0("./database/Data/Processed/WBdata", Sys.Date(), ".RData"))
} else {
  ## ...open list
  load(file = "./database/Data/Processed/WBdata2015-05-04.RData")
}
WB.df <- WB.lst$entity
WB.df <- translateCountryCode(data = WB.df, 
                              from = "ISO2_WB_CODE", to = "FAOST_CODE")
WB.df <- WB.df[, -grep("ISO2_WB_CODE|Country", colnames(WB.df))]
rm(downloadWB); rm(WB.lst)


# Manual data -------------------------------------------------------------

## Minimum dietary diversity and minimum meal frequency
# who.df <- read.csv("./Data/Processed/dataManuallyExtractedFromWHO.csv", 
#                    header = TRUE, stringsAsFactors = FALSE)
# who.df <- who.df[, -grep("Country", colnames(who.df))]
# 
# ## Overweight and obesity
# oo.df <- read.csv("./Data/Raw/data-coded.csv", 
#                   header = TRUE, stringsAsFactors = FALSE)
# oo.df <- 
#   oo.df[oo.df[, "GHO"] == "NCD_BMI_25C", c("GHO","YEAR", "COUNTRY", "SEX", "Display.Value")]
# oo.df[, "Display.Value"] <- 
#   sapply(strsplit(oo.df[, "Display.Value"], split = " "), "[", 1)
# oo.df[oo.df[, "Display.Value"] == "...", "Display.Value"] <- NA
# oo.df[, "Display.Value"] <- as.numeric(oo.df[, "Display.Value"])
# oo.df <- translateCountryCode(data = oo.df, from = "ISO3_CODE", 
#                               to = "FAOST_CODE", oldCode = "COUNTRY")
# oo.df <- oo.df[, -grep("ISO3_CODE", colnames(oo.df))]
# oo.df <- 
#   dcast(data = oo.df, FAOST_CODE + YEAR ~ SEX, value.var = "Display.Value")
# colnames(oo.df) <- c("FAOST_CODE", "Year", "N.A.OO.PCT", "N.A.OOFE.PCT", "N.A.OOMA.PCT")
# 
# ## Household surveys data
# hsd.df <- read.csv("./Data/Processed/HouseholdSurveys.csv", 
#                    header = TRUE, stringsAsFactors = FALSE)
# hsd.df <- dcast(hsd.df, FAOST_CODE + Year ~ Variable, value.var = "Value")
# 
# ## Share of animal protein
# sap.df <- read.csv("./Data/Processed/ShareAnimalProtein.csv", 
#                    header = TRUE, stringsAsFactors = FALSE)
# sap.df <- sap.df[, -grep("Country", colnames(sap.df))]
# 
# ## Open defecation
# od.df <- read.csv("./Data/Processed/OpenDefecation.csv", 
#                   header = TRUE, stringsAsFactors = FALSE)
# 
# ## GNP
# gnp.df <- 
#   read.csv(file = "./Data/Raw/CP.D.ATLAS.GNP.csv", 
#            header = TRUE, na.strings = "", stringsAsFactors = FALSE)
# gnp.df <- 
#   data.frame(Country.Code = rep(gnp.df$Country_Code, 16),
#              Year = rep(2000:2015, each = 210),
#              CP.D.ATLAS.GNP = rep(gnp.df$Weights, 16))
# gnp.df <- 
#   translateCountryCode(data = gnp.df, from = "ISO3_WB_CODE",
#                        to = "FAOST_CODE", oldCode = "Country.Code")
# gnp.df <- gnp.df[, c("FAOST_CODE", "Year", "CP.D.ATLAS.GNP")]

# Aquastat
load(file = "./database/Data/Processed/AquastatManualData.RData")
# 
# ## MUV
# ## data http://econ.worldbank.org/WBSITE/EXTERNAL/EXTDEC/EXTDECPROSPECTS/0,,contentMDK:20587651~menuPK:3279864~pagePK:64165401~piPK:64165026~theSitePK:476883,00.html
# MUV.df <- read.csv("./Data/Raw/MUV06-01-2014.csv", na.strings = "", 
#                    header = TRUE, stringsAsFactors = FALSE)
# codes <- subset(FAOcountryProfile, subset = M49 %in% "YES")[, "FAOST_CODE"]
# MUV.df <- data.frame(FAOST_CODE = rep(codes, times = length(unique(MUV.df$Year))),
#                      Year = rep(unique(MUV.df$Year), each = length(codes)),
#                      MUV = rep(MUV.df$MUV, each = length(codes)))
# MUV.df$MUV <- MUV.df$MUV/100

###########################################################################
## Processing
###########################################################################

# Merging -----------------------------------------------------------------

initial.df <- Reduce(function(x, y) merge(x, y, all = TRUE),
                     x = list(WB.df, 
                              #who.df, 
                              #oo.df, 
                              #hsd.df, 
                              #sap.df, 
                              #gnp.df,
                              AquastatManualData.df 
                              #MUV.df
                              ), 
                     init = FAOSTAT.df)
rm(list = c("FAOSTAT.df", "WB.df", "who.df", "oo.df", "hsd.df", "sap.df",
            "gnp.df", "AquastatManualData.df", "MUV.df"))
# set the year range
initial.df <- initial.df[initial.df[, "Year"] <= 2020 & 
                           initial.df[, "Year"] >= 1985,]

# Scale data to basic unit ------------------------------------------------

meta.lst[["UNIT_MULT"]][, "UNIT_MULT"] <-
  as.numeric(translateUnit(meta.lst[["UNIT_MULT"]]$UNIT_MULT))

preConstr.df <- scaleUnit(initial.df, meta.lst[["UNIT_MULT"]])
rm(initial.df)

# The following variables are not in the data frame:
#   OA.TPBS.POP.P3
# OA.TPBS.POP.GR10
# OA.TPR.POP.ZS
# OA.TPU.POP.ZS


# Imputation --------------------------------------------------------------

source("./database/Rcode/Final/Imputation.R")

# Construction ------------------------------------------------------------

preAgg.df <- preConstr.df
## Manual
source("./database/Rcode/Final/ManualConstruction.R")
## Automatic
postConstr.lst <- with(con.df[con.df[, "CONSTRUCTION_TYPE"] %in% c("share", "growth", "change", "index"),],
                       constructSYB(data = preAgg.df,
                                    origVar1 = STS_ID_CONSTR1,
                                    origVar2 = STS_ID_CONSTR2,
                                    newVarName = STS_ID,
                                    constructType = CONSTRUCTION_TYPE,
                                    grFreq = GROWTH_RATE_FREQ,
                                    grType = GROWTH_TYPE))
preAgg.df <- postConstr.lst$data 
rm(list = c("preConstr.df", "postConstr.lst"))

# Adjustment in scaling ---------------------------------------------------

manScalVars <- 
  subset(con.df, select = c("STS_ID", "SCALING"), subset = !is.na(SCALING))
for (i in 1:NROW(manScalVars)) {
  preAgg.df[, manScalVars[i, "STS_ID"]] <- 
    preAgg.df[, manScalVars[i, "STS_ID"]] * manScalVars[i, "SCALING"]
}
rm(list = c("manScalVars", "i"))

# Aggregations ------------------------------------------------------------

## Country aggregation
source("./database/Rcode/Final/aggregate_functions/CountryAggregation.R")

## China aggregation
source("./database/Rcode/Final/aggregate_functions/ChinaAggregates.R")
## Check overlapping in old countries
country.df <- FAOcheck(var = colnames(country.df)[-grep("FAOST_CODE|Year|Area", colnames(country.df))],
                       data = country.df, type = "overlap",
                       take = "complete")
OldCountries <- 
  data.frame(FAOST_CODE = c(15,51,62,151,186,228,206,247,246,248),
             COUNTRY_NAME = c("Belgium-Luxembourg", "Czechoslovakia",
                              "Ethiopia PDR", "Netherlands Antilles",
                              "Serbia and Montenegro", "Soviet Union",
                              "Sudan (former)", "Yemen (former)", 
                              "Yemen (old)", "Yugoslav SFR"),
             stringsAsFactors = FALSE)
country.df[country.df[, "FAOST_CODE"] %in% OldCountries$FAOST_CODE, "Area"] <-
  "Old territory"
rm(OldCountries)
## Add country names
country.df <- 
  merge(country.df, FAOcountryProfile[, c("FAOST_CODE", "FAO_TABLE_NAME")], 
        by = "FAOST_CODE", all.x = TRUE)
## M49 aggregates
source("./database/Rcode/Final/aggregate_functions/M49aggregates.R")
## Removing duplicates in the aggregates sofi & M49
M49.df <- M49.df[!M49.df[, "FAOST_CODE"] %in% 
                   c(348,5100,5205,5206,5500,5303,5304), ]
## SOFI aggregates
source("./database/Rcode/Final/aggregate_functions/SofiAggregates.R")
## FAO aggregates
# Sourcehttps("https://raw.githubusercontent.com/filippogheri/ComplementaryScripts/master/FAOAggregates.R")
## Economic aggregates
# Sourcehttps("https://raw.githubusercontent.com/filippogheri/ComplementaryScripts/master/EconomicAggregates.R")
## rbind the datasets
postAgg.df <- rbind(country.df, M49.df, sofiAggs.df)
# postAgg.df <- rbind(country.df, FAOregions.df, M49.df)
# rm(list = c("country.df", "FAOregions.df", "M49.df"))

# Check for NaN, Inf, -Inf ------------------------------------------------

postAgg.df <- CheckValues(dataset = postAgg.df, columns = colnames(postAgg.df)[
  -grep("FAOST_CODE|Year|Area|POU_DISTR|FAO_TABLE_NAME", colnames(postAgg.df))])

PBdata.df <- postAgg.df
save(x = PBdata.df, file = "./database/Data/Processed/postAgg.RData")
load(file = "./database/Data/Processed/postAgg.RData")

# Merge the FSI dataset ---------------------------------------------------

## Merge the dataset
# load(file = "./database/Data/Processed/fsi.RData")
# fsiVar <- c("FAOST_CODE", "Year",
#             "AV3YADESA.DISS", "QV.NPV.FOOD.ID.AV3YSHP.DISS", "FB.SDES.CRLSSR.KCD.AV3Y.DISS",
#             "FB.PSQ.GT.GCD.AV3Y.DISS", "FB.PSQ.AO.GCD.AV3Y.DISS", "FB.FSQ.GT.GCD.AV3Y.DISS",
#             "IS.ROD.PAVE.ZS.DISS", "IS.ROD.DNST.K2.DISS", "IS.RRS.DNST.K2.DISS",
#             "DFPLI.IN.NO.DISS", "SH.H2O.SAFE.ZS", "SH.STA.ACSN",
#             "FB.CIDR.CRLS.TN.AV3Y.DISS", "RL.AREA.EQIRR.HA.SHLAV3Y.DISS",
#             "TI.IV.FEFTMT.USD.AV3Y.DISS", "SFEP.NO", "WGI.PSAVT.IN.NO",  
#             "PCFPV.IN.NO.DISS", "PCFSV.IN.NO.DISS", "DFPLIV.IN.NO.DISS",
#             "SH.ANM.CHLD.ZS", "VITAMINA", "IODINE",
#             "SH.STA.WAST.ZS", "SH.STA.STNT.ZS", "SH.STA.MALN.ZS", "SH.STA.AMALN.ZS",
#             "AV3YMDER_1.55.DISS", "AV3YADER_1.85.DISS", "AV3YMDER_1.75.DISS", "CV.DISS", "SK.DISS",
#             "LOSS.DISS", "AV3YDES.DISS", "AV3YPOU.DISS", "AV3YNOU.DISS", 
#             "AV3YPOU", "AV3YNOU", "AV3YDoFD.DISS", "AV3YPoFI.DISS", "AV3YPOP", 
#             "AV3YPCO.DISS", "AV3YNCO.DISS", "NY.GDP.PCAP.PP.KD", "AV3YDES")
# fsi.df <- fsi.df[, fsiVar]
# ## We need to add the DES for developed countries
# dvdCountries.df <- 
#   subset(FAOcountryProfile, 
#          SOFI_DVDDVG_REG == "Developed countries" & 
#            !is.na(SOFI_DVDDVG_REG))[, c("FAOST_CODE", "FAO_TABLE_NAME")]
# fsi.df[fsi.df[, "FAOST_CODE"] %in% dvdCountries.df[, "FAOST_CODE"], 
#        "AV3YDES.DISS"] <- 
#   fsi.df[fsi.df[, "FAOST_CODE"] %in% dvdCountries.df[, "FAOST_CODE"], 
#          "AV3YDES"]
# icn2.df <- 
#   merge(icn2.df, fsi.df, all = TRUE, by = c("FAOST_CODE", "Year"))
# rm(fsi.df)
save(x = PBdata.df, file = "./Data/Processed/PBdata.df.RData")

## Merge metadata and construction file
# fsicon.df <- ReadConstruction(file = "./database/Data/Processed/FSIconstruction14.csv", 
#                               encoding = "UTF-8", nrows = 287)
# fsimeta.lst <- ReadMetadata(file = "./database/Data/Processed/FSImetadata14.csv", 
#                             encoding = "UTF-8", nrows = 287)
# fsimeta.df <- fsimeta.lst[["FULL"]]

# fsicon.df <- fsicon.df[fsicon.df[, "STS_ID"] %in% fsiVar,]
# fsimeta.df <- fsimeta.df[fsimeta.df[, "STS_ID"] %in% fsiVar,]
# 
# meta.lst[["FULL"]] <- rbind(meta.lst[["FULL"]], fsimeta.df)
# con.df <- rbind(con.df, 
#                 fsicon.df[, -grep("MODULE_FSI|MODULE_POU|MODULE_DES|THRESHOLD_COUNTRIES", 
#                                   colnames(fsicon.df))])

save(x = con.df, file = "./database/Data/Processed/Construction.RData")
save(x = meta.lst, file = "./database/Data/Processed/Metadata.RData")

# Post aggregation calculations -------------------------------------------

source("./database/Rcode/Final/PostAggregation.R")
save(x = PBdata.df, file = "./database/Data/Processed/PBdata.RData")

###########################################################################
## End
###########################################################################
