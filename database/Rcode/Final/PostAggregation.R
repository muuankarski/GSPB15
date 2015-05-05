###########################################################################
## Title: Post aggregation
###########################################################################

## New countries: we want to show Eritrea, Ethiopia and Occupied Palestininan Territory
newCountries = 
  data.frame(NAME = c("Belgium", "Luxembourg", "Czech Republic", "Slovakia",
                      "Bonaire, Sint Eustatius and Saba",
                      "Curacao", "Sint Maarten (Dutch Part)", "Armenia",
                      "Azerbaijan", "Belarus", "Estonia", "Georgia", "Kazakistan",
                      "Kyrghisistan", "Latvia", "Lithuania", "Moldova", "Russian Federation",
                      "Tajikistan", "Turkmenistan", "Ukraine", "Uzbekistan", 
                      "Serbia e Montenegro", "Bosnia and Herzegovina", "Croatia",
                      "Slovenia", "Macedonia", "Serbia", "Montenegro", 
                      "Micronesia (Federated States of)", "the Marshall Islands",
                      "Northern Mariana Islands", "Palau"),
             FAOST_CODE = c(255,256,167,199,278,279,280,1,52,57,63,73,108,113,
                            119,126,146,185,208,213,230,235,186,80,98,198,154,272,273,
                            145,127,163,180),
             startYear = c(2000,2000,1993,1993,2011,2011,2011,rep(1992, 15),
                           rep(1992,5),2006,2006,rep(1991,4)))
## Old countries
oldCountries = 
  data.frame(NAME = c("Sudan (former)", "Netherland Antilles", "Serbia e Montenegro"),
             FAOST_CODE = c(206, 151, 186),
             endYear = c(2011, 2010, 2005))

# FBS.PCS.CRLS.KCD3D ------------------------------------------------------

## Disseminate non imputed territories and aggregates computed with imputed 
## values
icn2.df[, "FBS.PCS.CRLS.KCD3D"] <- 
  ifelse(icn2.df[, "Area"] %in% c("Territory", "Old territory"), 
         icn2.df[, "FBS.PCS.CRLS.KCD3"], 
         icn2.df[, "FBS.PCS.CRLS.KCDI3"])
# ## Remove the values for those countries with unreliable DES
# icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.CRLS.KCD3D",
#                  countryCode = unreliableDESCountries[, "FAOST_CODE"])
## Remove values for old countries
icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.CRLS.KCD3D", 
                 countryCode = oldCountries[, "FAOST_CODE"], 
                 afterYear = oldCountries[, "endYear"])
## Remove values for new born countries
icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.CRLS.KCD3D", 
                 countryCode = newCountries[, "FAOST_CODE"], 
                 beforeYear = newCountries[, "startYear"])
# ## French Polynesia and New Caledonia: we do not want to show these
# ## countries anymore because French overseas territories.
# icn2.df <- SetToNA(dataset = icn2.df, origVar = "FBS.PCS.CRLS.KCD3D",
#                   countryCode = c(70,153))
## Rounding and scaling
icn2.df[, "FBS.PCS.CRLS.KCD3D"] = 
  round(icn2.df[, "FBS.PCS.CRLS.KCD3D"], digits = 0)

# FBS.SDES.CRLS.PCT3D -----------------------------------------------------

icn2.df[, "FBS.SDES.CRLS.PCT3D"] <- 
  icn2.df[, "FBS.PCS.CRLS.KCD3D"]/icn2.df[, "AV3YDES.DISS"]*100

# FBS.PCS.SR.KCD3D --------------------------------------------------------

## Disseminate non imputed territories and aggregates computed with imputed 
## values
icn2.df[, "FBS.PCS.SR.KCD3D"] <- 
  ifelse(icn2.df[, "Area"] %in% c("Territory", "Old territory"), 
         icn2.df[, "FBS.PCS.SR.KCD3"], 
         icn2.df[, "FBS.PCS.SR.KCDI3"])
# ## Remove the values for those countries with unreliable DES
# icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.SR.KCD3D",
#                  countryCode = unreliableDESCountries[, "FAOST_CODE"])
## Remove values for old countries
icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.SR.KCD3D", 
                  countryCode = oldCountries[, "FAOST_CODE"], 
                  afterYear = oldCountries[, "endYear"])
## Remove values for new born countries
icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.SR.KCD3D", 
                  countryCode = newCountries[, "FAOST_CODE"], 
                  beforeYear = newCountries[, "startYear"])
# ## French Polynesia and New Caledonia: we do not want to show these
# ## countries anymore because French overseas territories.
# icn2.df <- SetToNA(dataset = icn2.df, origVar = "FBS.PCS.SR.KCD3D",
#                   countryCode = c(70,153))
## Rounding and scaling
icn2.df[, "FBS.PCS.SR.KCD3D"] = 
  round(icn2.df[, "FBS.PCS.SR.KCD3D"], digits = 0)

# FBS.SDES.SR.PCT3D -------------------------------------------------------

icn2.df[, "FBS.SDES.SR.PCT3D"] <- 
  icn2.df[, "FBS.PCS.SR.KCD3D"]/icn2.df[, "AV3YDES.DISS"]*100

# FBS.PCS.SS.KCD3D --------------------------------------------------------

## Disseminate non imputed territories and aggregates computed with imputed 
## values
icn2.df[, "FBS.PCS.SS.KCD3D"] <- 
  ifelse(icn2.df[, "Area"] %in% c("Territory", "Old territory"), 
         icn2.df[, "FBS.PCS.SS.KCD3"], 
         icn2.df[, "FBS.PCS.SS.KCDI3"])
# ## Remove the values for those countries with unreliable DES
# icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.SS.KCD3D",
#                  countryCode = unreliableDESCountries[, "FAOST_CODE"])
## Remove values for old countries
icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.SS.KCD3D", 
                  countryCode = oldCountries[, "FAOST_CODE"], 
                  afterYear = oldCountries[, "endYear"])
## Remove values for new born countries
icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.SS.KCD3D", 
                  countryCode = newCountries[, "FAOST_CODE"], 
                  beforeYear = newCountries[, "startYear"])
# ## French Polynesia and New Caledonia: we do not want to show these
# ## countries anymore because French overseas territories.
# icn2.df <- SetToNA(dataset = icn2.df, origVar = "FBS.PCS.SS.KCD3D",
#                   countryCode = c(70,153))
## Rounding and scaling
icn2.df[, "FBS.PCS.SS.KCD3D"] = 
  round(icn2.df[, "FBS.PCS.SS.KCD3D"], digits = 0)

# FBS.SDES.SS.PCT3D -------------------------------------------------------

icn2.df[, "FBS.SDES.SS.PCT3D"] <- 
  icn2.df[, "FBS.PCS.SS.KCD3D"]/icn2.df[, "AV3YDES.DISS"]*100

# FBS.PCS.PLS.KCD3D -------------------------------------------------------

## Disseminate non imputed territories and aggregates computed with imputed 
## values
icn2.df[, "FBS.PCS.PLS.KCD3D"] <- 
  ifelse(icn2.df[, "Area"] %in% c("Territory", "Old territory"), 
         icn2.df[, "FBS.PCS.PLS.KCD3"], 
         icn2.df[, "FBS.PCS.PLS.KCDI3"])
# ## Remove the values for those countries with unreliable DES
# icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.PLS.KCD3D",
#                  countryCode = unreliableDESCountries[, "FAOST_CODE"])
## Remove values for old countries
icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.PLS.KCD3D", 
                  countryCode = oldCountries[, "FAOST_CODE"], 
                  afterYear = oldCountries[, "endYear"])
## Remove values for new born countries
icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.PLS.KCD3D", 
                  countryCode = newCountries[, "FAOST_CODE"], 
                  beforeYear = newCountries[, "startYear"])
# ## French Polynesia and New Caledonia: we do not want to show these
# ## countries anymore because French overseas territories.
# icn2.df <- SetToNA(dataset = icn2.df, origVar = "FBS.PCS.PLS.KCD3D",
#                   countryCode = c(70,153))
## Rounding and scaling
icn2.df[, "FBS.PCS.PLS.KCD3D"] = 
  round(icn2.df[, "FBS.PCS.PLS.KCD3D"], digits = 0)

# FBS.SDES.PLS.PCT3D ------------------------------------------------------

icn2.df[, "FBS.SDES.PLS.PCT3D"] <- 
  icn2.df[, "FBS.PCS.PLS.KCD3D"]/icn2.df[, "AV3YDES.DISS"]*100

# FBS.PCS.TRNT.KCD3D ------------------------------------------------------

## Disseminate non imputed territories and aggregates computed with imputed 
## values
icn2.df[, "FBS.PCS.TRNT.KCD3D"] <- 
  ifelse(icn2.df[, "Area"] %in% c("Territory", "Old territory"), 
         icn2.df[, "FBS.PCS.TRNT.KCD3"], 
         icn2.df[, "FBS.PCS.TRNT.KCDI3"])
# ## Remove the values for those countries with unreliable DES
# icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.TRNT.KCD3D",
#                  countryCode = unreliableDESCountries[, "FAOST_CODE"])
## Remove values for old countries
icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.TRNT.KCD3D", 
                  countryCode = oldCountries[, "FAOST_CODE"], 
                  afterYear = oldCountries[, "endYear"])
## Remove values for new born countries
icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.TRNT.KCD3D", 
                  countryCode = newCountries[, "FAOST_CODE"], 
                  beforeYear = newCountries[, "startYear"])
# ## French Polynesia and New Caledonia: we do not want to show these
# ## countries anymore because French overseas territories.
# icn2.df <- SetToNA(dataset = icn2.df, origVar = "FBS.PCS.TRNT.KCD3D",
#                   countryCode = c(70,153))
## Rounding and scaling
icn2.df[, "FBS.PCS.TRNT.KCD3D"] = 
  round(icn2.df[, "FBS.PCS.TRNT.KCD3D"], digits = 0)

# FBS.SDES.TRNT.PCT3D -----------------------------------------------------

icn2.df[, "FBS.SDES.TRNT.PCT3D"] <- 
  icn2.df[, "FBS.PCS.TRNT.KCD3D"]/icn2.df[, "AV3YDES.DISS"]*100

# FBS.PCS.OCRPS.KCD3D -----------------------------------------------------

## Disseminate non imputed territories and aggregates computed with imputed 
## values
icn2.df[, "FBS.PCS.OCRPS.KCD3D"] <- 
  ifelse(icn2.df[, "Area"] %in% c("Territory", "Old territory"), 
         icn2.df[, "FBS.PCS.OCRPS.KCD3"], 
         icn2.df[, "FBS.PCS.OCRPS.KCDI3"])
# ## Remove the values for those countries with unreliable DES
# icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.OCRPS.KCD3D",
#                  countryCode = unreliableDESCountries[, "FAOST_CODE"])
## Remove values for old countries
icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.OCRPS.KCD3D", 
                  countryCode = oldCountries[, "FAOST_CODE"], 
                  afterYear = oldCountries[, "endYear"])
## Remove values for new born countries
icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.OCRPS.KCD3D", 
                  countryCode = newCountries[, "FAOST_CODE"], 
                  beforeYear = newCountries[, "startYear"])
# ## French Polynesia and New Caledonia: we do not want to show these
# ## countries anymore because French overseas territories.
# icn2.df <- SetToNA(dataset = icn2.df, origVar = "FBS.PCS.OCRPS.KCD3D",
#                   countryCode = c(70,153))
## Rounding and scaling
icn2.df[, "FBS.PCS.OCRPS.KCD3D"] = 
  round(icn2.df[, "FBS.PCS.OCRPS.KCD3D"], digits = 0)

# FBS.SDES.OCRPS.PCT3D ----------------------------------------------------

icn2.df[, "FBS.SDES.OCRPS.PCT3D"] <- 
  icn2.df[, "FBS.PCS.OCRPS.KCD3D"]/icn2.df[, "AV3YDES.DISS"]*100

# FBS.PCS.VO.KCD3D --------------------------------------------------------

## Disseminate non imputed territories and aggregates computed with imputed 
## values
icn2.df[, "FBS.PCS.VO.KCD3D"] <- 
  ifelse(icn2.df[, "Area"] %in% c("Territory", "Old territory"), 
         icn2.df[, "FBS.PCS.VO.KCD3"], 
         icn2.df[, "FBS.PCS.VO.KCDI3"])
# ## Remove the values for those countries with unreliable DES
# icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.VO.KCD3D",
#                  countryCode = unreliableDESCountries[, "FAOST_CODE"])
## Remove values for old countries
icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.VO.KCD3D", 
                  countryCode = oldCountries[, "FAOST_CODE"], 
                  afterYear = oldCountries[, "endYear"])
## Remove values for new born countries
icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.VO.KCD3D", 
                  countryCode = newCountries[, "FAOST_CODE"], 
                  beforeYear = newCountries[, "startYear"])
# ## French Polynesia and New Caledonia: we do not want to show these
# ## countries anymore because French overseas territories.
# icn2.df <- SetToNA(dataset = icn2.df, origVar = "FBS.PCS.VO.KCD3D",
#                   countryCode = c(70,153))
## Rounding and scaling
icn2.df[, "FBS.PCS.VO.KCD3D"] = 
  round(icn2.df[, "FBS.PCS.VO.KCD3D"], digits = 0)

# FBS.SDES.VO.PCT3D -------------------------------------------------------

icn2.df[, "FBS.SDES.VO.PCT3D"] <- 
  icn2.df[, "FBS.PCS.VO.KCD3D"]/icn2.df[, "AV3YDES.DISS"]*100

# FBS.PCS.VGT.KCD3D -------------------------------------------------------

## Disseminate non imputed territories and aggregates computed with imputed 
## values
icn2.df[, "FBS.PCS.VGT.KCD3D"] <- 
  ifelse(icn2.df[, "Area"] %in% c("Territory", "Old territory"), 
         icn2.df[, "FBS.PCS.VGT.KCD3"], 
         icn2.df[, "FBS.PCS.VGT.KCDI3"])
# ## Remove the values for those countries with unreliable DES
# icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.VGT.KCD3D",
#                  countryCode = unreliableDESCountries[, "FAOST_CODE"])
## Remove values for old countries
icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.VGT.KCD3D", 
                  countryCode = oldCountries[, "FAOST_CODE"], 
                  afterYear = oldCountries[, "endYear"])
## Remove values for new born countries
icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.VGT.KCD3D", 
                  countryCode = newCountries[, "FAOST_CODE"], 
                  beforeYear = newCountries[, "startYear"])
# ## French Polynesia and New Caledonia: we do not want to show these
# ## countries anymore because French overseas territories.
# icn2.df <- SetToNA(dataset = icn2.df, origVar = "FBS.PCS.VGT.KCD3D",
#                   countryCode = c(70,153))
## Rounding and scaling
icn2.df[, "FBS.PCS.VGT.KCD3D"] = 
  round(icn2.df[, "FBS.PCS.VGT.KCD3D"], digits = 0)

# FBS.SDES.VGT.PCT3D ------------------------------------------------------

icn2.df[, "FBS.SDES.VGT.PCT3D"] <- 
  icn2.df[, "FBS.PCS.VGT.KCD3D"]/icn2.df[, "AV3YDES.DISS"]*100

# FBS.PCS.FEW.KCD3D -------------------------------------------------------

## Disseminate non imputed territories and aggregates computed with imputed 
## values
icn2.df[, "FBS.PCS.FEW.KCD3D"] <- 
  ifelse(icn2.df[, "Area"] %in% c("Territory", "Old territory"), 
         icn2.df[, "FBS.PCS.FEW.KCD3"], 
         icn2.df[, "FBS.PCS.FEW.KCDI3"])
# ## Remove the values for those countries with unreliable DES
# icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.FEW.KCD3D",
#                  countryCode = unreliableDESCountries[, "FAOST_CODE"])
## Remove values for old countries
icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.FEW.KCD3D", 
                  countryCode = oldCountries[, "FAOST_CODE"], 
                  afterYear = oldCountries[, "endYear"])
## Remove values for new born countries
icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.FEW.KCD3D", 
                  countryCode = newCountries[, "FAOST_CODE"], 
                  beforeYear = newCountries[, "startYear"])
# ## French Polynesia and New Caledonia: we do not want to show these
# ## countries anymore because French overseas territories.
# icn2.df <- SetToNA(dataset = icn2.df, origVar = "FBS.PCS.FEW.KCD3D",
#                   countryCode = c(70,153))
## Rounding and scaling
icn2.df[, "FBS.PCS.FEW.KCD3D"] = 
  round(icn2.df[, "FBS.PCS.FEW.KCD3D"], digits = 0)

# FBS.SDES.FEW.PCT3D ------------------------------------------------------

icn2.df[, "FBS.SDES.FEW.PCT3D"] <- 
  icn2.df[, "FBS.PCS.FEW.KCD3D"]/icn2.df[, "AV3YDES.DISS"]*100

# FBS.PCS.AB.KCD3D --------------------------------------------------------

## Disseminate non imputed territories and aggregates computed with imputed 
## values
icn2.df[, "FBS.PCS.AB.KCD3D"] <- 
  ifelse(icn2.df[, "Area"] %in% c("Territory", "Old territory"), 
         icn2.df[, "FBS.PCS.AB.KCD3"], 
         icn2.df[, "FBS.PCS.AB.KCDI3"])
# ## Remove the values for those countries with unreliable DES
# icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.AB.KCD3D",
#                  countryCode = unreliableDESCountries[, "FAOST_CODE"])
## Remove values for old countries
icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.AB.KCD3D", 
                  countryCode = oldCountries[, "FAOST_CODE"], 
                  afterYear = oldCountries[, "endYear"])
## Remove values for new born countries
icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.AB.KCD3D", 
                  countryCode = newCountries[, "FAOST_CODE"], 
                  beforeYear = newCountries[, "startYear"])
# ## French Polynesia and New Caledonia: we do not want to show these
# ## countries anymore because French overseas territories.
# icn2.df <- SetToNA(dataset = icn2.df, origVar = "FBS.PCS.AB.KCD3D",
#                   countryCode = c(70,153))
## Rounding and scaling
icn2.df[, "FBS.PCS.AB.KCD3D"] = 
  round(icn2.df[, "FBS.PCS.AB.KCD3D"], digits = 0)

# FBS.SDES.AB.PCT3D -------------------------------------------------------

icn2.df[, "FBS.SDES.AB.PCT3D"] <- 
  icn2.df[, "FBS.PCS.AB.KCD3D"]/icn2.df[, "AV3YDES.DISS"]*100

# FBS.PCS.STM.KCD3D -------------------------------------------------------

## Disseminate non imputed territories and aggregates computed with imputed 
## values
icn2.df[, "FBS.PCS.STM.KCD3D"] <- 
  ifelse(icn2.df[, "Area"] %in% c("Territory", "Old territory"), 
         icn2.df[, "FBS.PCS.STM.KCD3"], 
         icn2.df[, "FBS.PCS.STM.KCDI3"])
# ## Remove the values for those countries with unreliable DES
# icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.AB.KCD3D",
#                  countryCode = unreliableDESCountries[, "FAOST_CODE"])
## Remove values for old countries
icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.STM.KCD3D", 
                  countryCode = oldCountries[, "FAOST_CODE"], 
                  afterYear = oldCountries[, "endYear"])
## Remove values for new born countries
icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.STM.KCD3D", 
                  countryCode = newCountries[, "FAOST_CODE"], 
                  beforeYear = newCountries[, "startYear"])
# ## French Polynesia and New Caledonia: we do not want to show these
# ## countries anymore because French overseas territories.
# icn2.df <- SetToNA(dataset = icn2.df, origVar = "FBS.PCS.AB.KCD3D",
#                   countryCode = c(70,153))
## Rounding and scaling
icn2.df[, "FBS.PCS.STM.KCD3D"] = 
  round(icn2.df[, "FBS.PCS.STM.KCD3D"], digits = 0)

# FBS.SDES.STM.PCT3D ------------------------------------------------------

icn2.df[, "FBS.SDES.STM.PCT3D"] <- 
  icn2.df[, "FBS.PCS.STM.KCD3D"]/icn2.df[, "AV3YDES.DISS"]*100

# FBS.PCS.MEAT.KCD3D ------------------------------------------------------

## Disseminate non imputed territories and aggregates computed with imputed 
## values
icn2.df[, "FBS.PCS.MEAT.KCD3D"] <- 
  ifelse(icn2.df[, "Area"] %in% c("Territory", "Old territory"), 
         icn2.df[, "FBS.PCS.MEAT.KCD3"], 
         icn2.df[, "FBS.PCS.MEAT.KCDI3"])
# ## Remove the values for those countries with unreliable DES
# icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.MEAT.KCD3D",
#                  countryCode = unreliableDESCountries[, "FAOST_CODE"])
## Remove values for old countries
icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.MEAT.KCD3D", 
                  countryCode = oldCountries[, "FAOST_CODE"], 
                  afterYear = oldCountries[, "endYear"])
## Remove values for new born countries
icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.MEAT.KCD3D", 
                  countryCode = newCountries[, "FAOST_CODE"], 
                  beforeYear = newCountries[, "startYear"])
# ## French Polynesia and New Caledonia: we do not want to show these
# ## countries anymore because French overseas territories.
# icn2.df <- SetToNA(dataset = icn2.df, origVar = "FBS.PCS.MEAT.KCD3D",
#                   countryCode = c(70,153))
## Rounding and scaling
icn2.df[, "FBS.PCS.MEAT.KCD3D"] = 
  round(icn2.df[, "FBS.PCS.MEAT.KCD3D"], digits = 0)

# FBS.SDES.MEAT.PCT3D -----------------------------------------------------

icn2.df[, "FBS.SDES.MEAT.PCT3D"] <- 
  icn2.df[, "FBS.PCS.MEAT.KCD3D"]/icn2.df[, "AV3YDES.DISS"]*100

# FBS.PCS.OFF.KCD3D -------------------------------------------------------

## Disseminate non imputed territories and aggregates computed with imputed 
## values
icn2.df[, "FBS.PCS.OFF.KCD3D"] <- 
  ifelse(icn2.df[, "Area"] %in% c("Territory", "Old territory"), 
         icn2.df[, "FBS.PCS.OFF.KCD3"], 
         icn2.df[, "FBS.PCS.OFF.KCDI3"])
# ## Remove the values for those countries with unreliable DES
# icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.OFF.KCD3D",
#                  countryCode = unreliableDESCountries[, "FAOST_CODE"])
## Remove values for old countries
icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.OFF.KCD3D", 
                  countryCode = oldCountries[, "FAOST_CODE"], 
                  afterYear = oldCountries[, "endYear"])
## Remove values for new born countries
icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.OFF.KCD3D", 
                  countryCode = newCountries[, "FAOST_CODE"], 
                  beforeYear = newCountries[, "startYear"])
# ## French Polynesia and New Caledonia: we do not want to show these
# ## countries anymore because French overseas territories.
# icn2.df <- SetToNA(dataset = icn2.df, origVar = "FBS.PCS.OFF.KCD3D",
#                   countryCode = c(70,153))
## Rounding and scaling
icn2.df[, "FBS.PCS.OFF.KCD3D"] = 
  round(icn2.df[, "FBS.PCS.OFF.KCD3D"], digits = 0)

# FBS.SDES.OFF.PCT3D ------------------------------------------------------

icn2.df[, "FBS.SDES.OFF.PCT3D"] <- 
  icn2.df[, "FBS.PCS.OFF.KCD3D"]/icn2.df[, "AV3YDES.DISS"]*100

# FBS.PCS.AF.KCD3D --------------------------------------------------------

## Disseminate non imputed territories and aggregates computed with imputed 
## values
icn2.df[, "FBS.PCS.AF.KCD3D"] <- 
  ifelse(icn2.df[, "Area"] %in% c("Territory", "Old territory"), 
         icn2.df[, "FBS.PCS.AF.KCD3"], 
         icn2.df[, "FBS.PCS.AF.KCDI3"])
# ## Remove the values for those countries with unreliable DES
# icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.AF.KCD3D",
#                  countryCode = unreliableDESCountries[, "FAOST_CODE"])
## Remove values for old countries
icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.AF.KCD3D", 
                  countryCode = oldCountries[, "FAOST_CODE"], 
                  afterYear = oldCountries[, "endYear"])
## Remove values for new born countries
icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.AF.KCD3D", 
                  countryCode = newCountries[, "FAOST_CODE"], 
                  beforeYear = newCountries[, "startYear"])
# ## French Polynesia and New Caledonia: we do not want to show these
# ## countries anymore because French overseas territories.
# icn2.df <- SetToNA(dataset = icn2.df, origVar = "FBS.PCS.AF.KCD3D",
#                   countryCode = c(70,153))
## Rounding and scaling
icn2.df[, "FBS.PCS.AF.KCD3D"] = 
  round(icn2.df[, "FBS.PCS.AF.KCD3D"], digits = 0)

# FBS.SDES.AF.PCT3D -------------------------------------------------------

icn2.df[, "FBS.SDES.AF.PCT3D"] <- 
  icn2.df[, "FBS.PCS.AF.KCD3D"]/icn2.df[, "AV3YDES.DISS"]*100

# FBS.PCS.MEB.KCD3D -------------------------------------------------------

## Disseminate non imputed territories and aggregates computed with imputed 
## values
icn2.df[, "FBS.PCS.MEB.KCD3D"] <- 
  ifelse(icn2.df[, "Area"] %in% c("Territory", "Old territory"), 
         icn2.df[, "FBS.PCS.MEB.KCD3"], 
         icn2.df[, "FBS.PCS.MEB.KCDI3"])
# ## Remove the values for those countries with unreliable DES
# icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.MEB.KCD3D",
#                  countryCode = unreliableDESCountries[, "FAOST_CODE"])
## Remove values for old countries
icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.MEB.KCD3D", 
                  countryCode = oldCountries[, "FAOST_CODE"], 
                  afterYear = oldCountries[, "endYear"])
## Remove values for new born countries
icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.MEB.KCD3D", 
                  countryCode = newCountries[, "FAOST_CODE"], 
                  beforeYear = newCountries[, "startYear"])
# ## French Polynesia and New Caledonia: we do not want to show these
# ## countries anymore because French overseas territories.
# icn2.df <- SetToNA(dataset = icn2.df, origVar = "FBS.PCS.MEB.KCD3D",
#                   countryCode = c(70,153))
## Rounding and scaling
icn2.df[, "FBS.PCS.MEB.KCD3D"] = 
  round(icn2.df[, "FBS.PCS.MEB.KCD3D"], digits = 0)

# FBS.SDES.MEB.PCT3D ------------------------------------------------------

icn2.df[, "FBS.SDES.MEB.PCT3D"] <- 
  icn2.df[, "FBS.PCS.MEB.KCD3D"]/icn2.df[, "AV3YDES.DISS"]*100

# FBS.PCS.EGG.KCD3D -------------------------------------------------------

## Disseminate non imputed territories and aggregates computed with imputed 
## values
icn2.df[, "FBS.PCS.EGG.KCD3D"] <- 
  ifelse(icn2.df[, "Area"] %in% c("Territory", "Old territory"), 
         icn2.df[, "FBS.PCS.EGG.KCD3"], 
         icn2.df[, "FBS.PCS.EGG.KCDI3"])
# ## Remove the values for those countries with unreliable DES
# icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.EGG.KCD3D",
#                  countryCode = unreliableDESCountries[, "FAOST_CODE"])
## Remove values for old countries
icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.EGG.KCD3D", 
                  countryCode = oldCountries[, "FAOST_CODE"], 
                  afterYear = oldCountries[, "endYear"])
## Remove values for new born countries
icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.EGG.KCD3D", 
                  countryCode = newCountries[, "FAOST_CODE"], 
                  beforeYear = newCountries[, "startYear"])
# ## French Polynesia and New Caledonia: we do not want to show these
# ## countries anymore because French overseas territories.
# icn2.df <- SetToNA(dataset = icn2.df, origVar = "FBS.PCS.EGG.KCD3D",
#                   countryCode = c(70,153))
## Rounding and scaling
icn2.df[, "FBS.PCS.EGG.KCD3D"] = 
  round(icn2.df[, "FBS.PCS.EGG.KCD3D"], digits = 0)

# FBS.SDES.EGG.PCT3D ------------------------------------------------------

icn2.df[, "FBS.SDES.EGG.PCT3D"] <- 
  icn2.df[, "FBS.PCS.EGG.KCD3D"]/icn2.df[, "AV3YDES.DISS"]*100

# FBS.PCS.FISH.KCD3D ------------------------------------------------------

## Disseminate non imputed territories and aggregates computed with imputed 
## values
icn2.df[, "FBS.PCS.FISH.KCD3D"] <- 
  ifelse(icn2.df[, "Area"] %in% c("Territory", "Old territory"), 
         icn2.df[, "FBS.PCS.FISH.KCD3"], 
         icn2.df[, "FBS.PCS.FISH.KCDI3"])
# ## Remove the values for those countries with unreliable DES
# icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.FISH.KCD3D",
#                  countryCode = unreliableDESCountries[, "FAOST_CODE"])
## Remove values for old countries
icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.FISH.KCD3D", 
                  countryCode = oldCountries[, "FAOST_CODE"], 
                  afterYear = oldCountries[, "endYear"])
## Remove values for new born countries
icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.FISH.KCD3D", 
                  countryCode = newCountries[, "FAOST_CODE"], 
                  beforeYear = newCountries[, "startYear"])
# ## French Polynesia and New Caledonia: we do not want to show these
# ## countries anymore because French overseas territories.
# icn2.df <- SetToNA(dataset = icn2.df, origVar = "FBS.PCS.FISH.KCD3D",
#                   countryCode = c(70,153))
## Rounding and scaling
icn2.df[, "FBS.PCS.FISH.KCD3D"] = 
  round(icn2.df[, "FBS.PCS.FISH.KCD3D"], digits = 0)

# FBS.SDES.FISH.PCT3D -----------------------------------------------------

icn2.df[, "FBS.SDES.FISH.PCT3D"] <- 
  icn2.df[, "FBS.PCS.FISH.KCD3D"]/icn2.df[, "AV3YDES.DISS"]*100

# FBS.PCS.AP.KCD3D ------------------------------------------------------

## Disseminate non imputed territories and aggregates computed with imputed 
## values
icn2.df[, "FBS.PCS.AP.KCD3D"] <- 
  ifelse(icn2.df[, "Area"] %in% c("Territory", "Old territory"), 
         icn2.df[, "FBS.PCS.AP.KCD3"], 
         icn2.df[, "FBS.PCS.AP.KCDI3"])
# ## Remove the values for those countries with unreliable DES
# icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.AP.KCD3D",
#                  countryCode = unreliableDESCountries[, "FAOST_CODE"])
## Remove values for old countries
icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.AP.KCD3D", 
                  countryCode = oldCountries[, "FAOST_CODE"], 
                  afterYear = oldCountries[, "endYear"])
## Remove values for new born countries
icn2.df = SetToNA(dataset = icn2.df, origVar = "FBS.PCS.AP.KCD3D", 
                  countryCode = newCountries[, "FAOST_CODE"], 
                  beforeYear = newCountries[, "startYear"])
# ## French Polynesia and New Caledonia: we do not want to show these
# ## countries anymore because French overseas territories.
# icn2.df <- SetToNA(dataset = icn2.df, origVar = "FBS.PCS.AP.KCD3D",
#                   countryCode = c(70,153))
## Rounding and scaling
icn2.df[, "FBS.PCS.AP.KCD3D"] = 
  round(icn2.df[, "FBS.PCS.AP.KCD3D"], digits = 0)

# FBS.SDES.AP.PCT3D -----------------------------------------------------

icn2.df[, "FBS.SDES.AP.PCT3D"] <- 
  icn2.df[, "FBS.PCS.AP.KCD3D"]/icn2.df[, "AV3YDES.DISS"]*100

# FBS.PCS.MO.KCD3D --------------------------------------------------------

icn2.df[, "FBS.PCS.MO.KCD3D"] <- 
  icn2.df[, "FBS.PCS.MEAT.KCD3D"] + icn2.df[, "FBS.PCS.OFF.KCD3D"]

# FBS.SDES.MO.PCT3D -------------------------------------------------------

icn2.df[, "FBS.SDES.MO.PCT3D"] <- 
  icn2.df[, "FBS.PCS.MO.KCD3D"]/icn2.df[, "AV3YDES.DISS"]*100

# FBS.PCS.FISHAP.KCD3D ----------------------------------------------------

icn2.df[, "FBS.PCS.FISHAP.KCD3D"] <- 
  icn2.df[, "FBS.PCS.FISH.KCD3D"] + icn2.df[, "FBS.PCS.AP.KCD3D"]

# FBS.SDES.FISHAP.PCT3D ---------------------------------------------------

icn2.df[, "FBS.SDES.FISHAP.PCT3D"] <- 
  icn2.df[, "FBS.PCS.FISHAP.KCD3D"]/icn2.df[, "AV3YDES.DISS"]*100

# FBS.PCS.VOAF.KCD3D ------------------------------------------------------

icn2.df[, "FBS.PCS.VOAF.KCD3D"] <- 
  icn2.df[, "FBS.PCS.VO.KCD3D"] + icn2.df[, "FBS.PCS.AF.KCD3D"]

# FBS.SDES.VOAF.PCT3D -----------------------------------------------------

icn2.df[, "FBS.SDES.VOAF.PCT3D"] <- 
  icn2.df[, "FBS.PCS.VOAF.KCD3D"]/icn2.df[, "AV3YDES.DISS"]*100

# FBS.PCS.FV.KCD3D --------------------------------------------------------

icn2.df[, "FBS.PCS.FV.KCD3D"] <- 
  icn2.df[, "FBS.PCS.FEW.KCD3D"] + icn2.df[, "FBS.PCS.VGT.KCD3D"]

# FBS.SDES.FV.PCT3D -------------------------------------------------------

icn2.df[, "FBS.SDES.FV.PCT3D"] <- 
  icn2.df[, "FBS.PCS.FV.KCD3D"]/icn2.df[, "AV3YDES.DISS"]*100
