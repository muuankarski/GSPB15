###########################################################################
## This script generates the dataset for the Statistical Yearbooks
###########################################################################

# One shot commands -------------------------------------------------------

# require(devtools)
# require(packrat) ## devtools::install_github("rstudio/packrat")
# packrat::bootstrap()

###########################################################################
## Settings
###########################################################################

# memory.limit(size = 4095)

# R version ---------------------------------------------------------------

# rVersion <- R.Version()
# if (rVersion$major != 3 | rVersion$minor != 2.0) {
#   stop("The script is developed under the 3.2.0 R version.")
# }
# rm(rVersion)

# Needed libraries --------------------------------------------------------

require(devtools)
#require(packrat)
if (!"FAOSTAT" %in% installed.packages()) {
  install_github(username = "mkao006", repo = "FAOSTATpackage",
                 ref = "master", subdir = "FAOSTAT")
}
require(FAOSTAT)
require(plyr)
# require(sn)
# require(zoo)
# require(knitr)
# require(stringr)
# require(reshape)
require(reshape2)
require(data.table)

# Packrat -----------------------------------------------------------------

# packrat::status()
# packrat::snapshot()
# packrat::restore()

# Source functions --------------------------------------------------------
source("./database/Rcode/Final/misc_functions/CheckLogical.R")
source("./database/Rcode/Final/misc_functions/CheckValues.R")
source("./database/Rcode/Final/misc_functions/Sourcehttps.R")
source("./database/Rcode/Final/misc_functions/sum2.R")
source("./database/Rcode/Final/read_functions/ReadConstruction.R")
source("./database/Rcode/Final/read_functions/ReadMetadata.R")


## -- Sourcings FAOSYBpackage from SYBdatabase folder. These used to sourced from Filippos github repo



###########################################################################
## User inputs
###########################################################################

# Country profile ---------------------------------------------------------


FAOcountryProfile <- read.csv("./database/FAOcountryProfile.csv", header = TRUE, stringsAsFactors = FALSE, encoding="UTF-8")
save(FAOcountryProfile, file="./database/FAOcountryProfile.RData")
load("./database/FAOcountryProfile.RData")

# Construction and metadata files -----------------------------------------

con.df <- ReadConstruction(file = "./database/Construction2015.csv", 
                           encoding = "UTF-8", nrows = 657)
save(x = con.df, file = "./database/Data/Processed/Construction.RData")
meta.lst <- ReadMetadata(file = "./database/Metadata2015.csv", 
                         encoding = "UTF-8", nrows = 657)
save(x = meta.lst, file = "./database/Data/Processed/Metadata.RData")

# con.df <- ReadConstruction(file = "./database/Data/old/Construction04-2014.csv", 
#                            encoding = "UTF-8", nrows = 670)
# save(x = con.df, file = "./database/Data/Processed/Construction.RData")
# meta.lst <- ReadMetadata(file = "./database/Data//old/Metadata04-2014.csv", 
#                          encoding = "UTF-8", nrows = 670)
# save(x = meta.lst, file = "./database/Data/Processed/Metadata.RData")


# Parameters --------------------------------------------------------------

downloadWB <- TRUE; CheckLogical(downloadWB)

###########################################################################
## Data collection
###########################################################################

# Download variables from FAOSTAT, parameters -----------------------------

faostatData.df <- meta.lst[["FAOSTAT"]]
dwnldOA <- TRUE # Population
dwnldRL <- TRUE # Resources, Resources - Land
dwnldRF <- TRUE # Resources - Fertilizers
dwnldRP <- TRUE # Resources - Pesticides
dwnldCS <- TRUE # Investments - Capital stock
dwnldRM <- TRUE # Investments - Machinery
dwnldIG <- TRUE # Government expenditures
dwnldA <- TRUE # ASTI
dwnldQC <- TRUE # Production - Crops
dwnldQA <- TRUE # Production - Live animals
dwnldQD <- TRUE # Production - Crops processed
dwnldQL <- TRUE # Production - Livestock primary
dwnldQP <- TRUE # Production - Livestock processed
dwnldQV <- TRUE # Production - Value of agricultural production
dwnldQI <- TRUE # Production indices
dwnldTP <- TRUE # Trade - Crops and livestock products
dwnldTI <- TRUE # Trade - Trade indices
dwnldFO <- TRUE # Forestry
dwnldGHG <- TRUE # Greenhouse gases
dwnldFB <- TRUE # Food balance sheets

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------


# EEEEEEEEE    EEE           EEEE
# EE          EE EE        EE    EE 
# EEEEEE     EE   EE     EE        EE
# EE        EE     EE   EE          EE
# EE       EEEEEEEEEEE   EE        EE
# EE      EE         EE    EE    EE
# EE     EE           EE     EEEE


# FAOSTAT, Population - Annual population ---------------------------------

if (dwnldOA) {
  ## Download data from FAOSTAT
  FAO.lst <- with(faostatData.df[faostatData.df[, "SQL_DOMAIN_CODE"] == "OA",],
                  getFAOtoSYB(name = STS_ID,
                              domainCode = SQL_DOMAIN_CODE,
                              elementCode = SQL_ELEMENT_CODE,
                              itemCode = SQL_ITEM_CODE,
                              productionDB = FALSE,
                              useCHMT = FALSE))
  FAOoa.df <- FAO.lst$entity; rm(dwnldOA); rm(FAO.lst)
  ## ...update list
  save(x = FAOoa.df, file = paste0("./database/Data/Processed/FAOoa", Sys.Date(), ".RData"))
} else {
  ## ...open list
  load(file = "./database/Data/Processed/FAOoa2015-04-15.RData")
}

# FAOSTAT, Resources - Land -----------------------------------------------

if (dwnldRL) {
  ## Download data from FAOSTAT
  FAO.lst <- with(faostatData.df[faostatData.df[, "SQL_DOMAIN_CODE"] == "RL",],
                  getFAOtoSYB(name = STS_ID,
                              domainCode = SQL_DOMAIN_CODE,
                              elementCode = SQL_ELEMENT_CODE,
                              itemCode = SQL_ITEM_CODE,
                              productionDB = FALSE,
                              useCHMT = FALSE))
  FAOrl.df <- FAO.lst$entity; rm(dwnldRL); rm(FAO.lst)
  ## ...update list
  save(x = FAOrl.df, file = paste0("./database/Data/Processed/FAOrl", Sys.Date(), ".RData"))
} else {
  ## ...open list
  load(file = "./database/Data/Processed/FAOrl2015-04-15.RData")
}

# FAOSTAT, Resources - Fertilizers ----------------------------------------

if (dwnldRF) {
  ## Download data from FAOSTAT
  FAO.lst <- with(faostatData.df[faostatData.df[, "SQL_DOMAIN_CODE"] == "RF",],
                  getFAOtoSYB(name = STS_ID,
                              domainCode = SQL_DOMAIN_CODE,
                              elementCode = SQL_ELEMENT_CODE,
                              itemCode = SQL_ITEM_CODE,
                              productionDB = FALSE,
                              useCHMT = FALSE))
  FAOrf.df <- FAO.lst$entity; rm(dwnldRF); rm(FAO.lst)
  ## ...update list
  save(x = FAOrf.df, file = paste0("./database/Data/Processed/FAOrf", Sys.Date(), ".RData"))
} else {
  ## ...open list
  load(file = "./database/Data/Processed/FAOrf2015-04-15.RData")
}

# FAOSTAT, Resources - Pesticides -----------------------------------------

if (dwnldRP) {
  ## Download data from FAOSTAT
  FAO.lst <- with(faostatData.df[faostatData.df[, "SQL_DOMAIN_CODE"] == "RP",],
                  getFAOtoSYB(name = STS_ID,
                              domainCode = SQL_DOMAIN_CODE,
                              elementCode = SQL_ELEMENT_CODE,
                              itemCode = SQL_ITEM_CODE,
                              productionDB = FALSE,
                              useCHMT = FALSE))
  FAOrp.df <- FAO.lst$entity; rm(dwnldRP); rm(FAO.lst)
  ## ...update list
  save(x = FAOrp.df, file = paste0("./database/Data/Processed/FAOrp", Sys.Date(), ".RData"))
} else {
  ## ...open list
  load(file = "./database/Data/Processed/FAOrp2015-04-15.RData")
}

# FAOSTAT, Investments - Capital stock ------------------------------------

if (dwnldCS) {
  ## Download data from FAOSTAT
  FAO.lst <- with(faostatData.df[faostatData.df[, "SQL_DOMAIN_CODE"] == "CS",],
                  getFAOtoSYB(name = STS_ID,
                              domainCode = SQL_DOMAIN_CODE,
                              elementCode = SQL_ELEMENT_CODE,
                              itemCode = SQL_ITEM_CODE,
                              productionDB = FALSE,
                              useCHMT = FALSE))
  FAOcs.df <- FAO.lst$entity; rm(dwnldCS); rm(FAO.lst)
  ## ...update list
  save(x = FAOcs.df, file = paste0("./database/Data/Processed/FAOcs", Sys.Date(), ".RData"))
} else {
  ## ...open list
  load(file = "./database/Data/Processed/FAOcs2015-04-15.RData")
}

# FAOSTAT, Investments - Machinery ----------------------------------------

if (dwnldRM) {
  ## Download data from FAOSTAT
  FAO.lst <- with(faostatData.df[faostatData.df[, "SQL_DOMAIN_CODE"] == "RM",],
                  getFAOtoSYB(name = STS_ID,
                              domainCode = SQL_DOMAIN_CODE,
                              elementCode = SQL_ELEMENT_CODE,
                              itemCode = SQL_ITEM_CODE,
                              productionDB = FALSE,
                              useCHMT = FALSE))
  FAOrm.df <- FAO.lst$entity; rm(dwnldRM); rm(FAO.lst)
  ## ...update list
  save(x = FAOrm.df, file = paste0("./database/Data/Processed/FAOrm", Sys.Date(), ".RData"))
} else {
  ## ...open list
  load(file = "./database/Data/Processed/FAOrm2015-04-15.RData")
}

# FAOSTAT, Government expenditures ----------------------------------------

if (dwnldIG) {
  ## Download data from FAOSTAT
  FAO.lst <- with(faostatData.df[faostatData.df[, "SQL_DOMAIN_CODE"] == "IG",],
                  getFAOtoSYB(name = STS_ID,
                              domainCode = SQL_DOMAIN_CODE,
                              elementCode = SQL_ELEMENT_CODE,
                              itemCode = SQL_ITEM_CODE,
                              productionDB = FALSE,
                              useCHMT = FALSE))
  FAOig.df <- FAO.lst$entity; rm(dwnldIG); rm(FAO.lst)
  ## ...update list
  save(x = FAOig.df, file = paste0("./database/Data/Processed/FAOig", Sys.Date(), ".RData"))
} else {
  ## ...open list
  load(file = "./database/Data/Processed/FAOig2014-12-05.RData") # so the last time this was built succesfully
}

# FAOSTAT, ASTI -----------------------------------------------------------

if (dwnldA) {
  ## Download data from FAOSTAT
  FAO.lst <- with(faostatData.df[faostatData.df[, "SQL_DOMAIN_CODE"] %in% c("AA", "AE", "AR"),],
                  getFAOtoSYB(name = STS_ID,
                              domainCode = SQL_DOMAIN_CODE,
                              elementCode = SQL_ELEMENT_CODE,
                              itemCode = SQL_ITEM_CODE,
                              productionDB = FALSE,
                              useCHMT = FALSE))
  FAOa.df <- FAO.lst$entity; rm(dwnldA); rm(FAO.lst)
  ## ...update list
  save(x = FAOa.df, file = paste0("./database/Data/Processed/FAOa", Sys.Date(), ".RData"))
} else {
  ## ...open list
  load(file = "./database/Data/Processed/FAOa2015-04-15.RData")
}

# FAOSTAT, Production - Crops ---------------------------------------------

if (dwnldQC) {
  ## Download data from FAOSTAT
  FAO.lst <- with(faostatData.df[faostatData.df[, "SQL_DOMAIN_CODE"] == "QC",],
                  getFAOtoSYB(name = STS_ID,
                              domainCode = SQL_DOMAIN_CODE,
                              elementCode = SQL_ELEMENT_CODE,
                              itemCode = SQL_ITEM_CODE,
                              productionDB = FALSE,
                              useCHMT = FALSE))
  FAOqc.df <- FAO.lst$entity; rm(dwnldQC); rm(FAO.lst)
  ## ...update list
  save(x = FAOqc.df, file = paste0("./database/Data/Processed/FAOqc", Sys.Date(), ".RData"))
} else {
  ## ...open list
  load(file = "./database/Data/Processed/FAOqc2015-04-15.RData")
}

# FAOSTAT, Production - Live animals --------------------------------------

if (dwnldQA) {
  ## Download data from FAOSTAT
  FAO.lst <- with(faostatData.df[faostatData.df[, "SQL_DOMAIN_CODE"] == "QA",],
                  getFAOtoSYB(name = STS_ID,
                              domainCode = SQL_DOMAIN_CODE,
                              elementCode = SQL_ELEMENT_CODE,
                              itemCode = SQL_ITEM_CODE,
                              productionDB = FALSE,
                              useCHMT = FALSE))
  FAOqa.df <- FAO.lst$entity; rm(dwnldQA); rm(FAO.lst)
  ## ...update list
  save(x = FAOqa.df, file = paste0("./database/Data/Processed/FAOqa", Sys.Date(), ".RData"))
} else {
  ## ...open list
  load(file = "./database/Data/Processed/FAOqa2015-04-15.RData")
}

# FAOSTAT, Production - Crops processed -----------------------------------

if (dwnldQD) {
  ## Download data from FAOSTAT
  FAO.lst <- with(faostatData.df[faostatData.df[, "SQL_DOMAIN_CODE"] == "QD",],
                  getFAOtoSYB(name = STS_ID,
                              domainCode = SQL_DOMAIN_CODE,
                              elementCode = SQL_ELEMENT_CODE,
                              itemCode = SQL_ITEM_CODE,
                              productionDB = FALSE,
                              useCHMT = FALSE))
  FAOqd.df <- FAO.lst$entity; rm(dwnldQD); rm(FAO.lst)
  ## ...update list
  save(x = FAOqd.df, file = paste0("./database/Data/Processed/FAOqd", Sys.Date(), ".RData"))
} else {
  ## ...open list
  load(file = "./database/Data/Processed/FAOqd2015-04-15.RData")
}

# FAOSTAT, Production - Livestock primary ---------------------------------

if (dwnldQL) {
  ## Download data from FAOSTAT
  FAO.lst <- with(faostatData.df[faostatData.df[, "SQL_DOMAIN_CODE"] == "QL",],
                  getFAOtoSYB(name = STS_ID,
                              domainCode = SQL_DOMAIN_CODE,
                              elementCode = SQL_ELEMENT_CODE,
                              itemCode = SQL_ITEM_CODE,
                              productionDB = FALSE,
                              useCHMT = FALSE))
  FAOql.df <- FAO.lst$entity; rm(dwnldQL); rm(FAO.lst)
  ## ...update list
  save(x = FAOql.df, file = paste0("./database/Data/Processed/FAOql", Sys.Date(), ".RData"))
} else {
  ## ...open list
  load(file = "./database/Data/Processed/FAOql2015-04-15.RData")
}

# FAOSTAT, Production - Livestock processed -------------------------------

if (dwnldQP) {
  ## Download data from FAOSTAT
  FAO.lst <- with(faostatData.df[faostatData.df[, "SQL_DOMAIN_CODE"] == "QP",],
                  getFAOtoSYB(name = STS_ID,
                              domainCode = SQL_DOMAIN_CODE,
                              elementCode = SQL_ELEMENT_CODE,
                              itemCode = SQL_ITEM_CODE,
                              productionDB = FALSE,
                              useCHMT = FALSE))
  FAOqp.df <- FAO.lst$entity; rm(dwnldQP); rm(FAO.lst)
  ## ...update list
  save(x = FAOqp.df, file = paste0("./database/Data/Processed/FAOqp", Sys.Date(), ".RData"))
} else {
  ## ...open list
  load(file = "./database/Data/Processed/FAOqp2015-04-15.RData")
}

# FAOSTAT, Production - Value of agricultural production ------------------

if (dwnldQV) {
  ## Download data from FAOSTAT
  FAO.lst <- with(faostatData.df[faostatData.df[, "SQL_DOMAIN_CODE"] == "QV",],
                  getFAOtoSYB(name = STS_ID,
                              domainCode = SQL_DOMAIN_CODE,
                              elementCode = SQL_ELEMENT_CODE,
                              itemCode = SQL_ITEM_CODE,
                              productionDB = FALSE,
                              useCHMT = FALSE))
  FAOqv.df <- FAO.lst$entity; rm(dwnldQV); rm(FAO.lst)
  ## ...update list
  save(x = FAOqv.df, file = paste0("./database/Data/Processed/FAOqv", Sys.Date(), ".RData"))
} else {
  ## ...open list
  load(file = "./database/Data/Processed/FAOqv2015-04-15.RData")
}

# FAOSTAT, Production - Production indices --------------------------------

if (dwnldQI) {
  ## Download data from FAOSTAT
  FAO.lst <- with(faostatData.df[faostatData.df[, "SQL_DOMAIN_CODE"] == "QI",],
                  getFAOtoSYB(name = STS_ID,
                              domainCode = SQL_DOMAIN_CODE,
                              elementCode = SQL_ELEMENT_CODE,
                              itemCode = SQL_ITEM_CODE,
                              productionDB = FALSE,
                              useCHMT = FALSE))
  FAOqi.df <- FAO.lst$entity; rm(dwnldQI); rm(FAO.lst)
  ## ...update list
  save(x = FAOqi.df, file = paste0("./database/Data/Processed/FAOqi", Sys.Date(), ".RData"))
} else {
  ## ...open list
  load(file = "./database/Data/Processed/FAOqi2015-04-15.RData")
}

# FAOSTAT, Trade - Crops and livestock products ---------------------------

if (dwnldTP) {
  ## Download data from FAOSTAT
  FAO.lst <- with(faostatData.df[faostatData.df[, "SQL_DOMAIN_CODE"] == "TP",],
                  getFAOtoSYB(name = STS_ID,
                              domainCode = SQL_DOMAIN_CODE,
                              elementCode = SQL_ELEMENT_CODE,
                              itemCode = SQL_ITEM_CODE,
                              productionDB = FALSE,
                              useCHMT = FALSE))
  FAOtp.df <- FAO.lst$entity; rm(dwnldTP); rm(FAO.lst)
  ## ...update list
  save(x = FAOtp.df, file = paste0("./database/Data/Processed/FAOtp", Sys.Date(), ".RData"))
} else {
  ## ...open list
  load(file = "./database/Data/Processed/FAOtp2015-04-15.RData")
}

# FAOSTAT, Trade - Trade indices ------------------------------------------

if (dwnldTI) {
  ## Download data from FAOSTAT
  FAO.lst <- with(faostatData.df[faostatData.df[, "SQL_DOMAIN_CODE"] == "TI",],
                  getFAOtoSYB(name = STS_ID,
                              domainCode = SQL_DOMAIN_CODE,
                              elementCode = SQL_ELEMENT_CODE,
                              itemCode = SQL_ITEM_CODE,
                              productionDB = FALSE,
                              useCHMT = FALSE))
  FAOti.df <- FAO.lst$entity; rm(dwnldTI); rm(FAO.lst)
  ## ...update list
  save(x = FAOti.df, file = paste0("./database/Data/Processed/FAOti", Sys.Date(), ".RData"))
} else {
  ## ...open list
  load(file = "./database/Data/Processed/FAOti2015-04-15.RData")
}

# FAOSTAT, Forestry -------------------------------------------------------

if (dwnldFO) {
  ## Download data from FAOSTAT
  FAO.lst <- with(faostatData.df[faostatData.df[, "SQL_DOMAIN_CODE"] == "FO",],
                  getFAOtoSYB(name = STS_ID,
                              domainCode = SQL_DOMAIN_CODE,
                              elementCode = SQL_ELEMENT_CODE,
                              itemCode = SQL_ITEM_CODE,
                              productionDB = FALSE,
                              useCHMT = FALSE))
  FAOfo.df <- FAO.lst$entity; rm(dwnldFO); rm(FAO.lst)
  ## ...update list
  save(x = FAOfo.df, file = paste0("./database/Data/Processed/FAOfo", Sys.Date(), ".RData"))
} else {
  ## ...open list
  load(file = "./database/Data/Processed/FAOfo2015-04-15.RData")
}

# FAOSTAT, Greenhouse gases -----------------------------------------------

if (dwnldGHG) {
  ## Download data from FAOSTAT
  FAO.lst <- with(faostatData.df[faostatData.df[, "SQL_DOMAIN_CODE"] %in% c("GT", "GF", "GL", "GN", "GI"),],
                  getFAOtoSYB(name = STS_ID,
                              domainCode = SQL_DOMAIN_CODE,
                              elementCode = SQL_ELEMENT_CODE,
                              itemCode = SQL_ITEM_CODE,
                              productionDB = FALSE,
                              useCHMT = FALSE))
  FAOghg.df <- FAO.lst$entity; rm(dwnldGHG); rm(FAO.lst)
  for (i in 3:NCOL(FAOghg.df)) {
    FAOghg.df[, i] <- as.numeric(FAOghg.df[, i])
  }
  ## ...update list
  save(x = FAOghg.df, file = paste0("./database/Data/Processed/FAOghg", Sys.Date(), ".RData"))
} else {
  ## ...open list
  load(file = "./database/Data/Processed/FAOghg2015-04-15.RData")
}

# FAOSTAT, Food balance sheets --------------------------------------------

if (dwnldFB) {
  ## Download data from FAOSTAT
  FAO.lst <- with(faostatData.df[faostatData.df[, "SQL_DOMAIN_CODE"] %in% c("CC"),],
                  getFAOtoSYB(name = STS_ID,
                              domainCode = SQL_DOMAIN_CODE,
                              elementCode = SQL_ELEMENT_CODE,
                              itemCode = SQL_ITEM_CODE,
                              productionDB = FALSE,
                              useCHMT = FALSE))
  FAOfb.df <- FAO.lst$entity; rm(dwnldFB); rm(FAO.lst)
  for (i in 3:NCOL(FAOfb.df)) {
    FAOfb.df[, i] <- as.numeric(FAOfb.df[, i])
  }
  ## ...update list
  save(x = FAOfb.df, file = paste0("./database/Data/Processed/FAOfb", Sys.Date(), ".RData"))
} else {
  ## ...open list
  load(file = "./database/Data/Processed/FAOfb2015-04-15.RData")
}

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------

# WW                   WW  WWWWWWW
#  WW                 WW   WW    WW
#   WW               WW    WW     W
#    WW     WWW     WW     WWWWWWW     
#     WW   WW WW   WW      WW     W
#      WW WW   WW WW       WW    WW
#       WWW     WWW        WWWWWWW

# Download variables from WB ----------------------------------------------

if (downloadWB) {
  ## Download data from WDI
  WB.lst <- with(meta.lst[["WDI"]],
                 getWDItoSYB(indicator = WDINAME, name = STS_ID))
  ## ...update list
  save(x = WB.lst, file = paste0("./database/Data/Processed/WBdata", Sys.Date(), ".RData"))
} else {
  ## ...open list
  #   load(file = "./database/Data/Processed/WBdata2015-03-11.RData")
  # load(file = "./database/Data/Processed/WBdata2014-07-07.RData")
  load(file = "./database/Data/Processed/WBdata2015-04-17.RData")
}
WB.df <- WB.lst$entity
## This is a mistake in the WDI database
# WB.df[WB.df[, "Country"] == "Cabo Verde" & WB.df[, "Year"] %in% c(1960:2012), 
#       c("SP.POP.1564.FE.IN", "SP.POP.65UP.FE.IN", "SP.POP.1564.MA.IN", "SP.POP.65UP.MA.IN")] =
#   WB.df[WB.df[, "Country"] == "Cape Verde" & WB.df[, "Year"] %in% c(1960:2012), 
#         c("SP.POP.1564.FE.IN", "SP.POP.65UP.FE.IN", "SP.POP.1564.MA.IN", "SP.POP.65UP.MA.IN")]
# WB.df <- WB.df[WB.df[, "Country"] != "Cape Verde",]
WB.df <- WB.df[!duplicated(WB.df[c("ISO2_WB_CODE","Year")]),]
##
WB.df <- translateCountryCode(data = WB.df, 
                              from = "ISO2_WB_CODE", to = "FAOST_CODE")
WB.df <- WB.df[, -grep("ISO2_WB_CODE|Country", colnames(WB.df))]
#rm(downloadWB); rm(WB.lst)

#WB.df <- WB.df[!duplicated(WB.df[c("FAOST_CODE","Year")]),]

## -----------------------------------------------------------------------
## -----------------------------------------------------------------------


# MMMM     MMMM
# MM MM   MM MM
# MM  MM MM  MM
# MM   MMM   MM
# MM         MM
# MM         MM
# MM         MM

# Manual data -------------------------------------------------------------

load("./database/Data/Processed/wbManualData.RData")
load("./database/Data/Processed/AquastatManualData.RData")
load("./database/Data/Processed/GlobalForestResourceAssessment.RData")
load("./database/Data/Processed/BiofuelProduction.RData")
load("./database/Data/Processed/Fishery.RData")
load("./database/Data/Processed/UNPopManualData.RData")


###########################################################################
## Processing
###########################################################################

# Merging -----------------------------------------------------------------

initial.df = Reduce(function(x, y) merge(x, y, all = TRUE),
                    x = list(FAOoa.df, # FAOSTAT, Population - Annual population
                             FAOrl.df, # FAOSTAT, Resources - Land
                             FAOrf.df, # FAOSTAT, Resources - Fertilizers
                             FAOrp.df, # FAOSTAT, Resources - Pesticides
                             FAOcs.df, # FAOSTAT, Investments - Capital stock
                             FAOrm.df, # FAOSTAT, Investments - Machinery
                             #FAOig.df, # FAOSTAT, Government expenditures - not in the FAOSTAT anymore
                             FAOa.df, # FAOSTAT, ASTI
                             FAOqc.df, # FAOSTAT, Production - Crops
                             FAOqa.df, # FAOSTAT, Production - Live animals
                             FAOqd.df, # FAOSTAT, Production - Crops processed
                             FAOql.df, # FAOSTAT, Production - Livestock primary
                             FAOqp.df, # FAOSTAT, Production - Livestock processed
                             FAOqv.df, # FAOSTAT, Production - Value of agricultural production
                             FAOqi.df, # FAOSTAT, Production - Production indices
                             FAOtp.df, # FAOSTAT, Trade - Crops and livestock products
                             FAOti.df, # FAOSTAT, Trade - Trade indices
                             FAOfo.df, # FAOSTAT, Forestry
                             FAOghg.df,# FAOSTAT, Greenhouse gases
                             FAOfb.df#, # FAOSTAT, Food balance sheets
                             #WBManualData.df, # not_update
                             #AquastatManualData.df, # updated 2015
                             #gfra.df, # not updated
                             #BiofuelProduction.df, # not update
                             #Fishery.df, # not updated  
                             #UNPopManualData.df, # added by Markus 20150401
                             ), 
                    init = WB.df) # Download variables from WB
# rm(list = c("dwnldA", "dwnldCS", "dwnldFB", "dwnldFO", "dwnldGHG", "dwnldIG",
#             "dwnldOA", "dwnldQA", "dwnldQC", "dwnldQD", "dwnldQI", "dwnldQL",
#             "dwnldQP", "dwnldQV", "dwnldRF", "dwnldRL", "dwnldRM", "dwnldRP",
#             "dwnldTI", "dwnldTP"))
# rm(list = c("FAOoa.df", "FAOrl.df", "FAOrf.df", "FAOrp.df", "FAOcs.df", "FAOrm.df", 
#             "FAOig.df", "FAOa.df", "FAOqc.df", "FAOqa.df", "FAOqd.df", "FAOql.df", 
#             "FAOqp.df", "FAOqv.df", "FAOqi.df", "FAOtp.df", "FAOti.df", "FAOfo.df", 
#             "FAOghg.df", "WBManualData.df", "WB.df", "faostatData.df", "FAOfb.df",
#             "AquastatManualData.df", "gfra.df", "BiofuelProduction.df",
#             "Fishery.df"))
initial.df <- initial.df[initial.df[, "Year"] <= 2020,]

# Scale data to basic unit ------------------------------------------------
## -- Convert the characters formats as "thousand" into 1000

meta.lst[["UNIT_MULT"]][, "UNIT_MULT"] <- as.numeric(translateUnit(meta.lst[["UNIT_MULT"]]$UNIT_MULT))

preConstr.df <- scaleUnit(df=initial.df, multiplier=meta.lst[["UNIT_MULT"]])
#rm(initial.df)

# remove duplicates
# preConstr.df <- preConstr.df[!duplicated(preConstr.df[c("FAOST_CODE","Year")]),]

##################################3

#pre1 <- preConstr.df

# Imputation --------------------------------------------------------------

# Construction ------------------------------------------------------------

## Manual
#source("./database/Rcode/Final/ManualConstruction.R")



###########################################################################
## This script is used to manually construct some variables
###########################################################################

# MORTWEIGHT --------------------------------------------------------------

preConstr.df[, "MORTWEIGHT"] <- 
  preConstr.df[, "SP.DYN.CBRT.IN"] * preConstr.df[, "OA.TPBS.POP.PPL.NO"] / 1000

# # LABPARTFEWEIGHT ---------------------------------------------------------
# 
# preConstr.df[, "LABPARTFEWEIGHT"] <- 
#   preConstr.df[, "SP.POP.1564.FE.IN"] + preConstr.df[, "SP.POP.65UP.FE.IN"]
# 
# # LABPARTMAWEIGHT ---------------------------------------------------------
# 
# preConstr.df[, "LABPARTMAWEIGHT"] <- 
#   preConstr.df[, "SP.POP.1564.MA.IN"] + preConstr.df[, "SP.POP.65UP.MA.IN"]

# RF.FERT.NIPH.TN.NO ------------------------------------------------------

preConstr.df[, "RF.FERT.NIPH.TN.NO"] <- 
  preConstr.df[, "RF.FERT.NI.TN.NO"] + preConstr.df[, "RF.FERT.PH.TN.NO"]

# RP.PEST.TOT.TN.NO -------------------------------------------------------
## NOTE (FILIPPO): we cannot do a simple sum of vector with the operator "+"
##                 because "+" as the function "sum" doesn't treat NA properly
RP.PEST.TOT.TN.NO.df <- 
  apply(preConstr.df[, c("RP.PEST.INS.TN.NO", "RP.PEST.MO.TN.NO",
                         "RP.PEST.HE.TN.NO", "RP.PEST.FB.TN.NO",
                         "RP.PEST.STF.TN.NO", "RP.PEST.STI.TN.NO")],
        MARGIN = 1, FUN = sum2)
preConstr.df[, "RP.PEST.TOT.TN.NO"] <- RP.PEST.TOT.TN.NO.df
rm(RP.PEST.TOT.TN.NO.df)

# QC.PRD.FRUNOGR.TN.NO ----------------------------------------------------

preConstr.df[, "QC.PRD.FRUNOGR.TN.NO"] <- 
  preConstr.df[, "QC.PRD.FRU.TN.NO"] - preConstr.df[, "QD.PRD.WINE.TN.NO"]

# QC.RHRV.FRUNOGR.HA.NO ---------------------------------------------------

preConstr.df[, "QC.RHRV.FRUNOGR.HA.NO"] <- 
  preConstr.df[, "QC.RHRV.FRU.HA.NO"] - preConstr.df[, "QD.RHRV.VINE.HA.NO"]

# POP.TOT.BASE.0406 -------------------------------------------------------

base = ddply(subset(preConstr.df, 
                    subset = Year %in% c(2004,2005,2006),
                    select = c("FAOST_CODE", "Year", "OA.TPBS.POP.PPL.NO")),
             .(FAOST_CODE), numcolwise(mean), na.rm = TRUE)
colnames(base)[3] = "POP.TOT.BASE.0406"
base = base[, c("FAOST_CODE", "POP.TOT.BASE.0406")]
preConstr.df = merge(preConstr.df, base, by = "FAOST_CODE", all.x = TRUE)

# QV.GPV.FOOD.BASE.0406 ---------------------------------------------------

base = ddply(subset(preConstr.df, 
                    subset = Year %in% c(2004,2005,2006),
                    select = c("FAOST_CODE", "Year", "QV.GPV.FOOD.ID.NO")),
             .(FAOST_CODE), numcolwise(mean), na.rm = TRUE)
colnames(base)[3] = "QV.GPV.FOOD.BASE.0406"
base = base[, c("FAOST_CODE", "QV.GPV.FOOD.BASE.0406")]
preConstr.df = merge(preConstr.df, base, by="FAOST_CODE", all.x=TRUE)

# QV.NPV.FOOD.BASE.0406 ---------------------------------------------------

base = ddply(subset(preConstr.df, 
                    subset = Year %in% c(2004,2005,2006),
                    select = c("FAOST_CODE", "Year", "QV.NPV.FOOD.ID.NO")),
             .(FAOST_CODE), numcolwise(mean), na.rm = TRUE)
colnames(base)[3] = "QV.NPV.FOOD.BASE.0406"
base = base[, c("FAOST_CODE", "QV.NPV.FOOD.BASE.0406")]
preConstr.df = merge(preConstr.df, base, by="FAOST_CODE", all.x=TRUE)

# QV.NPV.CRPS.BASE.0406 ---------------------------------------------------

base = ddply(subset(preConstr.df, 
                    subset = Year %in% c(2004,2005,2006),
                    select = c("FAOST_CODE", "Year", "QV.NPV.CRPS.ID.NO")),
             .(FAOST_CODE), numcolwise(mean), na.rm = TRUE)
colnames(base)[3] = "QV.NPV.CRPS.BASE.0406"
base = base[, c("FAOST_CODE", "QV.NPV.CRPS.BASE.0406")]
preConstr.df = merge(preConstr.df, base, by="FAOST_CODE", all.x=TRUE)

# QV.GPV.AGR.BASE.0406 ----------------------------------------------------

base = ddply(subset(preConstr.df, 
                    subset = Year %in% c(2004,2005,2006),
                    select = c("FAOST_CODE", "Year", "QV.GPV.AGR.ID.NO")),
             .(FAOST_CODE), numcolwise(mean), na.rm = TRUE)
colnames(base)[3] = "QV.GPV.AGR.BASE.0406"
base = base[, c("FAOST_CODE", "QV.GPV.AGR.BASE.0406")]
preConstr.df = merge(preConstr.df, base, by="FAOST_CODE", all.x=TRUE)

# QV.NPV.AGR.BASE.0406 ----------------------------------------------------

base = ddply(subset(preConstr.df, 
                    subset = Year %in% c(2004,2005,2006),
                    select = c("FAOST_CODE", "Year", "QV.NPV.AGR.ID.NO")),
             .(FAOST_CODE), numcolwise(mean), na.rm = TRUE)
colnames(base)[3] = "QV.NPV.AGR.BASE.0406"
base = base[, c("FAOST_CODE", "QV.NPV.AGR.BASE.0406")]
preConstr.df = merge(preConstr.df, base, by="FAOST_CODE", all.x=TRUE)

# QV.NPV.CRLS.BASE.0406 ---------------------------------------------------

base = ddply(subset(preConstr.df, 
                    subset = Year %in% c(2004,2005,2006),
                    select = c("FAOST_CODE", "Year", "QV.NPV.CRLS.ID.NO")),
             .(FAOST_CODE), numcolwise(mean), na.rm = TRUE)
colnames(base)[3] = "QV.NPV.CRLS.BASE.0406"
base = base[, c("FAOST_CODE", "QV.NPV.CRLS.BASE.0406")]
preConstr.df = merge(preConstr.df, base, by="FAOST_CODE", all.x=TRUE)

# QV.NPV.LVSTCK.BASE.0406 -------------------------------------------------

base = ddply(subset(preConstr.df, 
                    subset = Year %in% c(2004,2005,2006),
                    select = c("FAOST_CODE", "Year", "QV.NPV.LVSTCK.ID.NO")),
             .(FAOST_CODE), numcolwise(mean), na.rm = TRUE)
colnames(base)[3] = "QV.NPV.LVSTCK.BASE.0406"
base = base[, c("FAOST_CODE", "QV.NPV.LVSTCK.BASE.0406")]
preConstr.df = merge(preConstr.df, base, by="FAOST_CODE", all.x=TRUE)

# QV.NPV.NNFOOD.BASE.0406 -------------------------------------------------

base = ddply(subset(preConstr.df, 
                    subset = Year %in% c(2004,2005,2006),
                    select = c("FAOST_CODE", "Year", "QV.NPV.NNFOOD.ID.NO")),
             .(FAOST_CODE), numcolwise(mean), na.rm = TRUE)
colnames(base)[3] = "QV.NPV.NNFOOD.BASE.0406"
base = base[, c("FAOST_CODE", "QV.NPV.NNFOOD.BASE.0406")]
preConstr.df = merge(preConstr.df, base, by="FAOST_CODE", all.x=TRUE)

# TP.NETVAL.CRLSPREP.USD.NO -----------------------------------------------

preConstr.df$TP.NETVAL.CRLSPREP.USD.NO = preConstr.df$TP.EXVAL.CRLSPREP.USD.NO - 
  preConstr.df$TP.IMVAL.CRLSPREP.USD.NO

# TP.NETVAL.MEATPREP.USD.NO -----------------------------------------------

preConstr.df$TP.NETVAL.MEATPREP.USD.NO = preConstr.df$TP.EXVAL.MEATPREP.USD.NO - 
  preConstr.df$TP.IMVAL.MEATPREP.USD.NO

# TP.NETVAL.FV.USD.NO -----------------------------------------------------

preConstr.df$TP.NETVAL.FV.USD.NO = preConstr.df$TP.EXVAL.FV.USD.NO - 
  preConstr.df$TP.IMVAL.FV.USD.NO

# TP.NETVAL.MILKEQ.USD.NO -------------------------------------------------

preConstr.df$TP.NETVAL.MILKEQ.USD.NO = preConstr.df$TP.EXVAL.MILKEQ.USD.NO - 
  preConstr.df$TP.IMVAL.MILKEQ.USD.NO

# TP.NETVAL.AFOVO.USD.NO --------------------------------------------------

preConstr.df$TP.NETVAL.AFOVO.USD.NO = preConstr.df$TP.EXVAL.ANFATS.USD.NO + 
  preConstr.df$TP.EXVAL.OILSEEDS.USD.NO + preConstr.df$TP.EXVAL.VEGOIL.USD.NO -
  preConstr.df$TP.IMVAL.ANFATS.USD.NO + preConstr.df$TP.IMVAL.OILSEEDS.USD.NO -
  preConstr.df$TP.IMVAL.VEGOIL.USD.NO

# TP.NETVAL.BEV.USD.NO ----------------------------------------------------

preConstr.df$TP.NETVAL.BEV.USD.NO = preConstr.df$TP.EXVAL.BEV.USD.NO - 
  preConstr.df$TP.IMVAL.BEV.USD.NO

# TP.NETVAL.CTCS.USD.NO ---------------------------------------------------

preConstr.df$TP.NETVAL.CTCS.USD.NO = preConstr.df$TP.EXVAL.CTCS.USD.NO - 
  preConstr.df$TP.IMVAL.CTCS.USD.NO

# TP.NETVAL.SUGHON.USD.NO -------------------------------------------------

preConstr.df$TP.NETVAL.SUGHON.USD.NO = preConstr.df$TP.EXVAL.SUGHON.USD.NO - 
  preConstr.df$TP.IMVAL.SUGHON.USD.NO

# GLI.CHPF.TOT.ECO2EQ.NO --------------------------------------------------

preConstr.df$GLI.CHPF.TOT.ECO2EQ.NO = preConstr.df$GL.CL.TOT.NERCO2EQ.NO + 
  preConstr.df$GL.GL.TOT.NERCO2EQ.NO

# GHG.AFOLU.TOT.ECO2EQ.NO -------------------------------------------------

preConstr.df$GHG.AFOLU.TOT.ECO2EQ.NO = preConstr.df$GHG.TOT.ALL.GG.NO + 
  preConstr.df$GL.LU.TOT.NERCO2EQ.NO

# GN.UI.EA.TJPIN.NO -------------------------------------------------------

preConstr.df[, "GN.UI.EA.TJPIN.NO"] <- 
  preConstr.df[, "GN.TE.CIA.TJ.NO"]/preConstr.df[, "QV.GPV.AGR.ID.NO"]*1000000

# FI.PRD.TOT.TN.NO --------------------------------------------------------

preConstr.df$FI.PRD.TOT.TN.NO = preConstr.df$FI.PRD.AQ.TN.NO + 
  preConstr.df$FI.PRD.CAPT.TN.NO

#######################################################################

#   ,-(|)--(|)-.
#   \_   ..   _/
#     \______/
#       V  V                                  ____
#       `.^^`.                               /^,--`
#         \^^^\                             (^^\
#         |^^^|                  _,-._       \^^\
#        (^^^^\      __      _,-'^^^^^`.    _,'^^)
#         \^^^^`._,-'^^`-._.'^^^^__^^^^ `--'^^^_/
#          \^^^^^ ^^^_^^^^^^^_,-'  `.^^^^^^^^_/ 
#           `.____,-' `-.__.'        `-.___.'   

# PROBLEMS start --------------------------------


# FI.NETVAL.FISH.USD.NO ---------------------------------------------------

preConstr.df$FI.NETVAL.FISH.USD.NO = preConstr.df$FI.EXVAL.FISH.USD.NO - 
  preConstr.df$FI.IMVAL.FISH.USD.NO

# TP.EXVAL.FOODWF.USD.NO --------------------------------------------------

preConstr.df$TP.EXVAL.FOODWF.USD.NO = preConstr.df$TP.EXVAL.FOOD.USD.NO + 
  preConstr.df$FI.EXVAL.FISH.USD.NO

# TP.IMVAL.FOODWF.USD.NO --------------------------------------------------

preConstr.df$TP.IMVAL.FOODWF.USD.NO = preConstr.df$TP.IMVAL.FOOD.USD.NO + 
  preConstr.df$FI.IMVAL.FISH.USD.NO

# PROBLEMS end --------------------------------

# Clean the environment ---------------------------------------------------

rm(list = "base")


## Automatic
postConstr.lst <- with(con.df[con.df[, "CONSTRUCTION_TYPE"] %in% c("share", "growth", "change", "index"),], # leave the manual construction outside
                       constructSYB(data = preConstr.df,
                                    origVar1 = STS_ID_CONSTR1,
                                    origVar2 = STS_ID_CONSTR2,
                                    newVarName = STS_ID,
                                    constructType = CONSTRUCTION_TYPE,
                                    grFreq = GROWTH_RATE_FREQ,
                                    grType = GROWTH_TYPE, 
                                    baseYear = 2000))
preAgg.df <- postConstr.lst$data 
rm(list = c("preConstr.df", "postConstr.lst"))

# Adjustment in scaling ---------------------------------------------------

manScalVars <- subset(con.df, select = c("STS_ID", "SCALING"), subset = !is.na(SCALING))
#manScalVars <- con.df[!(is.na(con.df[["SCALING"]])), c("STS_ID", "SCALING")] # Markus fix

for (i in 1:NROW(manScalVars)) {
  preAgg.df[, manScalVars[i, "STS_ID"]] <- preAgg.df[, manScalVars[i, "STS_ID"]] * manScalVars[i, "SCALING"]
}
rm(list = c("manScalVars", "i"))

# Aggregations ------------------------------------------------------------
# source("./Rcode/Final/aggregate_functions/EconomicAggregates.R")
# source("./Rcode/Final/aggregate_functions/FAOAggregates.R")
# source("./Rcode/Final/aggregate_functions/SofiAggregates.R")

## Country aggregation
source("./Rcode/Final/aggregate_functions/CountryAggregation.R")

## China aggregation
source("./Rcode/Final/aggregate_functions/ChinaAggregates.R")

## Check overlapping in old countries
FAOchecked.df <- FAOcheck(var = colnames(country.df)[-grep("FAOST_CODE|Year|Area", colnames(country.df))],
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
country.df[country.df[, "FAOST_CODE"] %in% OldCountries$FAOST_CODE, "Area"] =
  "Old territory"
rm(OldCountries)
## Add country names
country.df <- merge(country.df, FAOcountryProfile[, c("FAOST_CODE", "FAO_TABLE_NAME")], 
        by = "FAOST_CODE", all.x = FALSE)
## M49 aggregates
do49aggr <- TRUE
if (do49aggr) {
  source("./Rcode/Final/aggregate_functions/M49aggregates.R")
} else load()

## FAO aggregates
# Sourcehttps(source("./Rcode/Final/ComplementaryScripts/FAOAggregates.R")
## Economic aggregates
# Sourcehttps(source("./Rcode/Final/ComplementaryScripts/EconomicAggregates.R")
## rbind the datasets
postAgg.df <- rbind(country.df, M49.df)
# postAgg.df <- rbind(country.df, M49.df)
# rm(list = c("country.df", "M49.df")) # because M49.df takes a loooooong time to run

# Check for NaN, Inf, -Inf ------------------------------------------------

postAgg.df <- CheckValues(dataset = postAgg.df, columns = colnames(postAgg.df)[
  -grep("FAOST_CODE|Year|Area|POU_DISTR|FAO_TABLE_NAME", colnames(postAgg.df))])

SYB.df <- postAgg.df
save(x = SYB.df, file = "./database/Data/Processed/SYB.RData")
load(file = "./database/Data/Processed/SYB.RData")

# Merge the FSI dataset ---------------------------------------------------

## Merge the dataset
load(file = "./database/Data/Processed/fsi.RData")
fsiVar <- c("FAOST_CODE", "Year",
            "AV3YADESA.DISS", "QV.NPV.FOOD.ID.AV3YSHP.DISS", "FB.SDES.CRLSSR.KCD.AV3Y.DISS",
            "FB.PSQ.GT.GCD.AV3Y.DISS", "FB.PSQ.AO.GCD.AV3Y.DISS", "FB.FSQ.GT.GCD.AV3Y.DISS",
            "IS.ROD.PAVE.ZS.DISS", "IS.ROD.DNST.K2.DISS", "IS.RRS.DNST.K2.DISS",
            "DFPLI.IN.NO.DISS", "SH.H2O.SAFE.ZS", "SH.STA.ACSN",
            "FB.CIDR.CRLS.TN.AV3Y.DISS", "RL.AREA.EQIRR.HA.SHLAV3Y.DISS",
            "TI.IV.FEFTMT.USD.AV3Y.DISS", "SFEP.NO", "WGI.PSAVT.IN.NO",  
            "PCFPV.IN.NO.DISS", "PCFSV.IN.NO.DISS", "DFPLIV.IN.NO.DISS",
            "SH.ANM.CHLD.ZS", "VITAMINA", "IODINE", "SH.PRG.ANEM",
            "SH.STA.WAST.ZS", "SH.STA.STNT.ZS", "SH.STA.MALN.ZS", "SH.STA.AMALN.ZS",
            "AV3YMDER_1.55.DISS", "AV3YADER_1.85.DISS", "AV3YMDER_1.75.DISS", "CV.DISS", "SK.DISS",
            "LOSS.DISS", "AV3YDES.DISS", "AV3YPOU.DISS", "AV3YNOU.DISS", 
            "AV3YPOU", "AV3YNOU", "AV3YDoFD.DISS", "AV3YPoFI.DISS", "AV3YPOP")
fsi.df <- fsi.df[, fsiVar]
SYB.df <- merge(SYB.df, fsi.df, all = FALSE, by = c("FAOST_CODE", "Year"))
rm(fsi.df)
save(x = SYB.df, file = "./database/Data/Processed/SYB.RData")

## Merge metadata and construction file
fsicon.df <- ReadConstruction(file = "FSIconstruction15.csv", 
                              encoding = "UTF-8", nrows = 287)
fsimeta.lst <- ReadMetadata(file = "FSImetadata15.csv", 
                            encoding = "UTF-8", nrows = 287)
fsimeta.df <- fsimeta.lst[["FULL"]]

fsicon.df <- fsicon.df[fsicon.df[, "STS_ID"] %in% fsiVar,]
fsimeta.df <- fsimeta.df[fsimeta.df[, "STS_ID"] %in% fsiVar,]

meta.lst[["FULL"]][["X"]] <- NULL
meta.lst[["FULL"]] <- rbind(meta.lst[["FULL"]], fsimeta.df)
con.df <- rbind(con.df, 
                fsicon.df[, -grep("MODULE_FSI|MODULE_POU|MODULE_DES", 
                                  colnames(fsicon.df))])

save(x = con.df, file = "./database/Data/Processed/Construction.RData")
save(x = meta.lst, file = "./database/Data/Processed/Metadata.RData")

###########################################################################
## End
###########################################################################
