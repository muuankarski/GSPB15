###########################################################################
## This script generates the ICN2 Statistical Pocketbook 2014
###########################################################################

###########################################################################
## Country profiles
###########################################################################

# Countries ---------------------------------------------------------------

M49countries <- 
  FAOcountryProfile[FAOcountryProfile[, "UNSD_WORLD_REG"] == "World", 
                    c("FAOST_CODE", "SHORT_NAME")]
M49countries <- na.omit(arrange(M49countries, SHORT_NAME))
## Sanitize the country names
M49countries[, "SHORT_NAME"] <- 
  sanitizeToLatex(M49countries[, "SHORT_NAME"])
## Remove old countries
OldCountries <- 
  data.frame(FAOST_CODE = c(15,51,62,151,164,186,228,206,247,246,248),
             COUNTRY_NAME = c("Belgium-Luxembourg", "Czechoslovakia",
                              "Ethiopia PDR", "Netherlands Antilles",
                              "Pacific Islands",
                              "Serbia and Montenegro", "Soviet Union",
                              "Sudan (former)", "Yemen (former)", 
                              "Yemen (old)", "Yugoslav SFR"),
             stringsAsFactors = FALSE)
M49countries <- 
  M49countries[!M49countries[, "FAOST_CODE"] %in% 
                 OldCountries[, "FAOST_CODE"],]
## Remove the countries we do not want to show: , 
tbr.df <-
  data.frame(COUNTRY_NAME = c("Aland Island", "American Samoa", "Andorra",
                            "Anguilla", "Antigua and Barbuda", "Aruba",
                            "Bahamas", "Bonaire", "British Virgin Islands",
                            "Cayman", "Cook Islands", "Curacao", "Dominica", 
                            "Equatorial Guinea", "Falkland Islands (Malvinas)",
                            "Faroe", "French Guiana",
                            "French Polynesia", "Gibraltar", "Greenland",
                            "Grenada", "Guadeloupe", "Guam", "Guernsey",
                            "Holy See", "Isle of Man", "Jersey",
                            "Liechtenstein", "Marshall Islands",
                            "Martinique", "Mayotte", "Micronesia", "Monaco",
                            "Montserrat", "Nauru", "New Caledonia", "Niue",
                            "Norfolk Island", "Northern Mariana Islands",
                            "Oman", "Palau", "Papua New Guinea", "Pitcairn Islands",
                            "Puerto Rico", "Qatar", "Reunion", "Saint Barthelemi",
                            "Saint Helena", "Saint Kitts", "Saint Lucia",
                            "Saint Pierre", "San Marino", "Sark", "Saint-Martin (French Part)",
                            "Sint Maarten (Dutch Part)", "Singapore",
                            "Svalbard and Jan Mayen Islands", "Tokelau",
                            "Tonga", "Turks and Caicos Islands","Tuvalu",
                            "United States Virgin Islands", "Wallis and Futuna Islands",
                            "Western Sahara"),
              FAOST_CODE = c(284,5,6,258,8,22,12,278,239,36,47,279,55,61,65,
                              64,69,70,82,85,86,87,88,274,94,264,283,125,
                              127,135,270,145,140,142,148,153,160,161,163,
                              221,180,168,172,177,179,182,282,187,188,189,
                              190,192,285,281,280,200,260,218,219,224,227,
                              240,243,205),
             stringsAsFactors = FALSE)
M49countries <- 
  M49countries[!M49countries[, "FAOST_CODE"] %in% 
                 tbr.df[, "FAOST_CODE"],]
## Occupied Palestinian Territory
M49countries[M49countries[, "FAOST_CODE"] == 299, "SHORT_NAME"] <-
  "West Bank and Gaza Strip"
## Chinas
M49countries <- 
  M49countries[!M49countries[, "FAOST_CODE"] %in% c(41,128,96,357,214),]
## Add aggregates
M49countries <- 
  rbind(data.frame(FAOST_CODE = c(5001,5852,5100,5853,5205,5500,5851),
                   SHORT_NAME = c("World", "Developing regions", 
                                      "Africa", "Asia", 
                                      "Latin America and the Caribbean",
                                      "Oceania", "Developed countries"),
                   stringsAsFactors = FALSE),
        M49countries)

# Indicators --------------------------------------------------------------

## Load the indicators we want to show
indicators.df <- 
  read.csv(file = "./Data/Processed/Indicators.csv", 
           header = TRUE, na.strings = "", stringsAsFactors = FALSE)
## Create the new .tex file
fileOut <- paste("./Outputs/CountryProfiles.tex", sep = "")
if(file.exists(fileOut)) file.remove(fileOut)
file.create(fileOut)
## Subset the dataset
CountryProfile.df <- 
  icn2.df[, colnames(icn2.df) %in% c("FAOST_CODE", "SHORT_NAME", "Year", 
                                     na.omit(indicators.df[, "INDICATOR1"]),
                                     na.omit(indicators.df[, "INDICATOR2"]),
                                     na.omit(indicators.df[, "INDICATOR3"]))]
CountryProfile.df[, "OA.TPBS.POP.P"] <- 
  CountryProfile.df[, "OA.TPBS.POP.P"]/1000000
CountryProfile.df[, "OA.TPR.POP.P"] <-
  CountryProfile.df[, "OA.TPR.POP.P"]/1000000
CountryProfile.df[, "AV3YDES.DISS"] <- 
  as.character(format(round(CountryProfile.df[, "AV3YDES.DISS"], digits = 0), nsmall = 0, big.mark = ","))
CountryProfile.df[, "AV3YADESA.DISS"] <- 
  as.character(CountryProfile.df[, "AV3YADESA.DISS"])
CountryProfile.df[, "FB.PSQ.GT.GCD.AV3Y.DISS"] <- 
  as.character(CountryProfile.df[, "FB.PSQ.GT.GCD.AV3Y.DISS"])
CountryProfile.df[, "FB.PSQ.AO.GCD.AV3Y.DISS"] <- 
  as.character(CountryProfile.df[, "FB.PSQ.AO.GCD.AV3Y.DISS"])
CountryProfile.df[, "FB.FSQ.GT.GCD.AV3Y.DISS"] <- 
  as.character(CountryProfile.df[, "FB.FSQ.GT.GCD.AV3Y.DISS"])

## PoU == "" in fsi.df for DVD. We need to replace it with "<5.0"
dvdCountries.df <- 
  subset(FAOcountryProfile, 
         SOFI_DVDDVG_REG == "Developed countries" & 
           !is.na(SOFI_DVDDVG_REG))[, c("FAOST_CODE", "FAO_TABLE_NAME")]
CountryProfile.df[CountryProfile.df[, "FAOST_CODE"] %in% 
                    dvdCountries.df[, "FAOST_CODE"], "AV3YPOU.DISS"] <- "<5.0"
CountryProfile.df[CountryProfile.df[, "FAOST_CODE"] %in% 
                    dvdCountries.df[, "FAOST_CODE"], "AV3YNOU.DISS"] <- "ns"

## Round the PoU
for (i in 1:NROW(CountryProfile.df)) {
  if (!is.na(as.numeric(CountryProfile.df[i, "AV3YPOU.DISS"]))) {
    CountryProfile.df[i, "AV3YPOU.DISS"] <- 
      as.character(format(round(as.numeric(CountryProfile.df[i, "AV3YPOU.DISS"]), digits = 1), nsmall = 1, big.mark = ","))
  }
  if (!is.na(as.numeric(CountryProfile.df[i, "AV3YNOU.DISS"]))) {
    CountryProfile.df[i, "AV3YNOU.DISS"] <- 
      as.character(format(round(as.numeric(CountryProfile.df[i, "AV3YNOU.DISS"]), digits = 1), nsmall = 1, big.mark = ","))
  }
  if (!is.na(as.numeric(CountryProfile.df[i, "AV3YDoFD.DISS"]))) {
    CountryProfile.df[i, "AV3YDoFD.DISS"] <- 
      as.character(round(as.numeric(CountryProfile.df[i, "AV3YDoFD.DISS"]), digits = 0))
  }
}
## Collaps multiple variables
CountryProfile.df[, "SH.DTH.COMM.ZS"] <- 
  paste(round(CountryProfile.df[, "SH.DTH.COMM.ZS"], digits = 0),
        round(CountryProfile.df[, "SH.DTH.NCOM.ZS"], digits = 0),
        round(CountryProfile.df[, "SH.DTH.INJR.ZS"], digits = 0), sep = "/")
CountryProfile.df[CountryProfile.df[, "SH.DTH.COMM.ZS"] == "NA/NA/NA", 
                  "SH.DTH.COMM.ZS"] <- NA
CountryProfile.df[, "SH.STA.WAST.MA.ZS"] <- 
  paste(round(CountryProfile.df[, "SH.STA.WAST.MA.ZS"], digits = 1),
        round(CountryProfile.df[, "SH.STA.WAST.FE.ZS"], digits = 1), sep = "/")
CountryProfile.df[CountryProfile.df[, "SH.STA.WAST.MA.ZS"] == "NA/NA", 
                  "SH.STA.WAST.MA.ZS"] <- NA
CountryProfile.df[, "SH.SVR.WAST.MA.ZS"] <- 
  paste(round(CountryProfile.df[, "SH.SVR.WAST.MA.ZS"], digits = 1),
        round(CountryProfile.df[, "SH.SVR.WAST.FE.ZS"], digits = 1), sep = "/")
CountryProfile.df[CountryProfile.df[, "SH.SVR.WAST.MA.ZS"] == "NA/NA", 
                  "SH.SVR.WAST.MA.ZS"] <- NA
CountryProfile.df[, "SH.STA.STNT.MA.ZS"] <- 
  paste(round(CountryProfile.df[, "SH.STA.STNT.MA.ZS"], digits = 1),
        round(CountryProfile.df[, "SH.STA.STNT.FE.ZS"], digits = 1), sep = "/")
CountryProfile.df[CountryProfile.df[, "SH.STA.STNT.MA.ZS"] == "NA/NA", 
                  "SH.STA.STNT.MA.ZS"] <- NA
CountryProfile.df[, "SH.STA.MALN.MA.ZS"] <- 
  paste(round(CountryProfile.df[, "SH.STA.MALN.MA.ZS"], digits = 1),
        round(CountryProfile.df[, "SH.STA.MALN.FE.ZS"], digits = 1), sep = "/")
CountryProfile.df[CountryProfile.df[, "SH.STA.MALN.MA.ZS"] == "NA/NA", 
                  "SH.STA.MALN.MA.ZS"] <- NA
CountryProfile.df[, "SH.STA.OWGH.MA.ZS"] <- 
  paste(round(CountryProfile.df[, "SH.STA.OWGH.MA.ZS"], digits = 1),
        round(CountryProfile.df[, "SH.STA.OWGH.FE.ZS"], digits = 1), sep = "/")
CountryProfile.df[CountryProfile.df[, "SH.STA.OWGH.MA.ZS"] == "NA/NA", 
                  "SH.STA.OWGH.MA.ZS"] <- NA
CountryProfile.df[, "N.A.OOMA.PCT"] <- 
  paste(round(CountryProfile.df[, "N.A.OOMA.PCT"], digits = 1),
        round(CountryProfile.df[, "N.A.OOFE.PCT"], digits = 1), sep = "/")
CountryProfile.df[CountryProfile.df[, "N.A.OOMA.PCT"] == "NA/NA", 
                  "N.A.OOMA.PCT"] <- NA
CountryProfile.df[, "SH.PRG.ANEM"] <- 
  paste(round(CountryProfile.df[, "SH.PRG.ANEM"], digits = 1),
        round(CountryProfile.df[, "SH.ANM.NPRG.ZS"], digits = 1), sep = "/")
CountryProfile.df[CountryProfile.df[, "SH.PRG.ANEM"] == "NA/NA", 
                  "SH.PRG.ANEM"] <- NA
CountryProfile.df[CountryProfile.df[, "AV3YDES.DISS"] == "   NA", 
                  "AV3YDES.DISS"] <- ""

# TeX file ----------------------------------------------------------------

## Years to be shown in the country profile
year1 = 1992
year2 = 2002
year3 = 2014
## This script creates the latex file
cat("\\renewcommand{\\arraystretch}{1.1}\n",
    file = fileOut, append = TRUE)
cat("\\setlength{\\tabcolsep}{4pt}\n",
    file = fileOut, append = TRUE) ## Reduce the space between columns
cat("\\normalsize\n",
    file = fileOut, append = TRUE)
for (i in 1:nrow(M49countries)) {
  ## header
  cat("\\CountryData{", M49countries[i, "SHORT_NAME"], "}
      \\rowcolors{1}{FAOblue!10}{white}
      \\begin{tabular}{L{3.9cm} R{1cm} R{1cm} R{1cm}}
      \\toprule
      \\multicolumn{1}{c}{} & \\multicolumn{1}{c}{", year1, "} & \\multicolumn{1}{c}{", year2, "} & \\multicolumn{1}{c}{", year3, "} \\\\
      \\midrule\n",
      file = fileOut, append = TRUE)
  ## data
  tmp = CountryProfile.df[CountryProfile.df[, "FAOST_CODE"] == M49countries[i, "FAOST_CODE"], ]
  for (part in 1:length(unique(indicators.df[, "PART"]))) {
#     cat("\t\\multicolumn{4}{l}{\\textcolor{",paste0("part", part),"}{\\textbf{\\large{", unique(indicators.df$PART)[part], "}}}} \\\\ \n",
#         file = fileOut, append = TRUE, sep = "")
    cat("\t\\multicolumn{4}{l}{\\textcolor{FAOblue}{\\textbf{\\large{", unique(indicators.df$PART)[part], "}}}} \\\\ \n",
        file = fileOut, append = TRUE, sep = "")
    subindicators.df = indicators.df[indicators.df[, "PART"] == unique(indicators.df$PART)[part], ]
    for (j in 1:nrow(subindicators.df)) {
      y1 = tmp[tmp[, "Year"] == year1, subindicators.df[j, "INDICATOR1"]]
      if (length(y1) == 1) {
        if (!is.na(y1)) {
          if (is.numeric(y1)) {
            chunk1 = format(round(y1, digits = subindicators.df[j, "DIGITS"]), nsmall = 1, big.mark = ",")
          } else {
            chunk1 = y1
          }
        } else {
          lya = na.locf(tmp[tmp[, "Year"] %in% c((year1-2):(year1+3)), subindicators.df[j, "INDICATOR1"]], na.rm = FALSE)[6]
          if (!is.na(lya)) {
            if (is.numeric(lya)) {
              chunk1 = paste0("\\textit{", format(round(lya, digits = subindicators.df[j, "DIGITS"]), nsmall = 1, big.mark = ","), "}")
            } else {
              chunk1 = paste0("\\textit{", lya, "}")
            }
          } else {
            chunk1 = ""
          }
        }
      } else {
        chunk1 = ""
      }
      y2 = tmp[tmp[, "Year"] == year2, subindicators.df[j, "INDICATOR1"]]
      if (length(y2) == 1) {
        if (!is.na(y2)) {
          if (is.numeric(y2)) {
            chunk2 = format(round(y2, digits = subindicators.df[j, "DIGITS"]), nsmall = 1, big.mark = ",")
          } else {
            chunk2 = y2
          }
        } else {
          lya = na.locf(tmp[tmp[, "Year"] %in% c((year2-7):(year2+3)), subindicators.df[j, "INDICATOR1"]], na.rm = FALSE)[11]
          if (!is.na(lya)) {
            if (is.numeric(lya)) {
              chunk2 = paste0("\\textit{", format(round(lya, digits = subindicators.df[j, "DIGITS"]), nsmall = 1, big.mark = ","), "}")
            } else {
              chunk2 = paste0("\\textit{", lya, "}")
            }
          } else {
            chunk2 = ""
          }
        }
      } else {
        chunk2 = ""
      }
      y3 = tmp[tmp[, "Year"] == year3, subindicators.df[j, "INDICATOR1"]]
      if (length(y3) == 1) {
        if (!is.na(y3)) {
          if (is.numeric(y3)) {
            chunk3 = format(round(y3, digits = subindicators.df[j, "DIGITS"]), nsmall = 1, big.mark = ",")
          } else {
            chunk3 = y3
          }
        } else {
          lya = na.locf(tmp[tmp[, "Year"] %in% c((year3-9):(year3+2)), subindicators.df[j, "INDICATOR1"]], na.rm = FALSE)[12]
          if (!is.na(lya)) {
            if (is.numeric(lya)) {
              chunk3 = paste0("\\textit{", format(round(lya, digits = subindicators.df[j, "DIGITS"]), nsmall = 1, big.mark = ","), "}")
            } else {
              chunk3 = paste0("\\textit{", lya, "}")
            }
          } else {
            chunk3 = ""
          }
        }
      } else {
        chunk3 = ""
      }
      chunk1 <- gsub(pattern = ",", replacement = "\\\\,", x = chunk1)
      chunk2 <- gsub(pattern = ",", replacement = "\\\\,", x = chunk2)
      chunk3 <- gsub(pattern = ",", replacement = "\\\\,", x = chunk3)
      cat("\t ~ ", sanitizeToLatex(subindicators.df[j, "SERIES_NAME_SHORT"]), " & ", chunk1, " ~ \\ \\ & ", chunk2, " ~ \\ \\ & ", chunk3, " ~ \\ \\ \\\\ \n",
          file = fileOut, append = TRUE, sep = "")
      
    }
  }
  ## tail
  cat("\ \ \ \ \ \ \ \\toprule
      \\end{tabular}
      \\clearpage\n",
      file = fileOut, append = TRUE)
}

###########################################################################
## Household surveys
###########################################################################

# Surveys -----------------------------------------------------------------

surveys.df <- 
  read.csv(file = "./Data/Processed/Surveys.csv", 
           header = TRUE, na.strings = "", stringsAsFactors = FALSE)
surveys.df <- surveys.df[, -grep("FAO_TABLE_NAME", colnames(surveys.df))]
surveys.df <- 
  merge(surveys.df, FAOcountryProfile[, c("FAOST_CODE", "SHORT_NAME")],
        by = "FAOST_CODE", all.x = TRUE)
surveys.df[surveys.df[, "FAOST_CODE"] == 107, "SHORT_NAME"] <- 
  na.omit(FAOcountryProfile[FAOcountryProfile[, "FAOST_CODE"] == 107, "FAO_TABLE_NAME"])
surveys.df[, "SHORT_NAME"] <- 
  sanitizeToLatex(surveys.df[, "SHORT_NAME"])
surveys.df <- arrange(surveys.df, SHORT_NAME)

# Variables in the table --------------------------------------------------

tableVars <- c("FAOST_CODE", "Year", "HS.PCS.DEC.KCD", "HS.PCS.UDEC.KCD",
               "HS.PCS.RDEC.KCD", "HS.PCS.MDEC.KCD", "HS.PCS.FDEC.KCD",
               "HS.NCDEC.PRT.PCT", "HS.NCDEC.UPRT.PCT", "HS.NCDEC.RPRT.PCT",
               "HS.NCDEC.MPRT.PCT", "HS.NCDEC.FPRT.PCT", "HS.NCDEC.FAT.PCT",
               "HS.NCDEC.UFAT.PCT", "HS.NCDEC.RFAT.PCT", "HS.NCDEC.MFAT.PCT",
               "HS.NCDEC.FFAT.PCT", "HS.NCDEC.CRB.PCT", "HS.NCDEC.UCRB.PCT",
               "HS.NCDEC.RCRB.PCT", "HS.NCDEC.MCRB.PCT", "HS.NCDEC.FCRB.PCT",
               "HS.SPC.AP.PCT", "HS.SPC.UAP.PCT", "HS.SPC.RAP.PCT", 
               "HS.SPC.MAP.PCT", "HS.SPC.FAP.PCT")
## Rounding
icn2.df[, "HS.PCS.DEC.KCD"] <- round(icn2.df[, "HS.PCS.DEC.KCD"], digits = 0)
icn2.df[, "HS.PCS.UDEC.KCD"] <- round(icn2.df[, "HS.PCS.UDEC.KCD"], digits = 0)
icn2.df[, "HS.PCS.RDEC.KCD"] <- round(icn2.df[, "HS.PCS.RDEC.KCD"], digits = 0)
icn2.df[, "HS.PCS.MDEC.KCD"] <- round(icn2.df[, "HS.PCS.MDEC.KCD"], digits = 0)
icn2.df[, "HS.PCS.FDEC.KCD"] <- round(icn2.df[, "HS.PCS.FDEC.KCD"], digits = 0)

icn2.df[, "HS.NCDEC.PRT.PCT"] <- round(icn2.df[, "HS.NCDEC.PRT.PCT"], digits = 0)
icn2.df[, "HS.NCDEC.UPRT.PCT"] <- round(icn2.df[, "HS.NCDEC.UPRT.PCT"], digits = 0)
icn2.df[, "HS.NCDEC.RPRT.PCT"] <- round(icn2.df[, "HS.NCDEC.RPRT.PCT"], digits = 0)
icn2.df[, "HS.NCDEC.MPRT.PCT"] <- round(icn2.df[, "HS.NCDEC.MPRT.PCT"], digits = 0)
icn2.df[, "HS.NCDEC.FPRT.PCT"] <- round(icn2.df[, "HS.NCDEC.FPRT.PCT"], digits = 0)

icn2.df[, "HS.NCDEC.FAT.PCT"] <- round(icn2.df[, "HS.NCDEC.FAT.PCT"], digits = 0)
icn2.df[, "HS.NCDEC.UFAT.PCT"] <- round(icn2.df[, "HS.NCDEC.UFAT.PCT"], digits = 0)
icn2.df[, "HS.NCDEC.RFAT.PCT"] <- round(icn2.df[, "HS.NCDEC.RFAT.PCT"], digits = 0)
icn2.df[, "HS.NCDEC.MFAT.PCT"] <- round(icn2.df[, "HS.NCDEC.MFAT.PCT"], digits = 0)
icn2.df[, "HS.NCDEC.FFAT.PCT"] <- round(icn2.df[, "HS.NCDEC.FFAT.PCT"], digits = 0)

icn2.df[, "HS.NCDEC.CRB.PCT"] <- round(icn2.df[, "HS.NCDEC.CRB.PCT"], digits = 0)
icn2.df[, "HS.NCDEC.UCRB.PCT"] <- round(icn2.df[, "HS.NCDEC.UCRB.PCT"], digits = 0)
icn2.df[, "HS.NCDEC.RCRB.PCT"] <- round(icn2.df[, "HS.NCDEC.RCRB.PCT"], digits = 0)
icn2.df[, "HS.NCDEC.MCRB.PCT"] <- round(icn2.df[, "HS.NCDEC.MCRB.PCT"], digits = 0)
icn2.df[, "HS.NCDEC.FCRB.PCT"] <- round(icn2.df[, "HS.NCDEC.FCRB.PCT"], digits = 0)

icn2.df[, "HS.SPC.AP.PCT"] <- round(icn2.df[, "HS.SPC.AP.PCT"], digits = 0)
icn2.df[, "HS.SPC.UAP.PCT"] <- round(icn2.df[, "HS.SPC.UAP.PCT"], digits = 0)
icn2.df[, "HS.SPC.RAP.PCT"] <- round(icn2.df[, "HS.SPC.RAP.PCT"], digits = 0)
icn2.df[, "HS.SPC.MAP.PCT"] <- round(icn2.df[, "HS.SPC.MAP.PCT"], digits = 0)
icn2.df[, "HS.SPC.FAP.PCT"] <- round(icn2.df[, "HS.SPC.FAP.PCT"], digits = 0)

# TeX file ----------------------------------------------------------------

tables.df <- 
  data.frame(Variable = c("Average dietary energy (available for) consumption (kcal/cap/day)", 
                          "Protein contribution to dietary energy (available for) consumption (%)",
                          "Fat contribution to dietary energy (available for) consumption (%)",
                          "Carbohydrate contribution to dietary energy (available for) consumption (%)",
                          "Share of animal protein in total protein (available for) consumption (%)"),
#              Title = c("Average dietary energy consumption", 
#                           "Protein contribution to dietary energy consumption",
#                           "Fat contribution to dietary energy consumption",
#                           "Carbohydrate contribution to dietary energy consumption",
#                           "Share of animal protein in total protein consumption"),
             National = c("HS.PCS.DEC.KCD", "HS.NCDEC.PRT.PCT", "HS.NCDEC.FAT.PCT",
                          "HS.NCDEC.CRB.PCT", "HS.SPC.AP.PCT"),
             Urban = c("HS.PCS.UDEC.KCD", "HS.NCDEC.UPRT.PCT", "HS.NCDEC.UFAT.PCT",
                       "HS.NCDEC.UCRB.PCT", "HS.SPC.UAP.PCT"),
             Rural = c("HS.PCS.RDEC.KCD", "HS.NCDEC.RPRT.PCT", "HS.NCDEC.RFAT.PCT",
                       "HS.NCDEC.RCRB.PCT", "HS.SPC.RAP.PCT"),
             Male = c("HS.PCS.MDEC.KCD", "HS.NCDEC.MPRT.PCT", "HS.NCDEC.MFAT.PCT",
                      "HS.NCDEC.MCRB.PCT", "HS.SPC.MAP.PCT"),
             Female = c("HS.PCS.FDEC.KCD", "HS.NCDEC.FPRT.PCT","HS.NCDEC.FFAT.PCT",
                        "HS.NCDEC.FCRB.PCT", "HS.SPC.FAP.PCT"),
             stringsAsFactors = FALSE)
tables.df[, "Variable"] <- sanitizeToLatex(tables.df[, "Variable"])
## Create the new .tex file
fileOut <- paste("./Outputs/HouseholdSurveys.tex", sep = "")
if(file.exists(fileOut)) file.remove(fileOut)
file.create(fileOut)
## This script creates the latex file
cat("\\renewcommand{\\arraystretch}{1.3}\n",
    file = fileOut, append = TRUE)
cat("\\footnotesize\n",
    file = fileOut, append = TRUE)
hsc <- 1
for (t in 1:NROW(tables.df)) {
#   cat("\\textbf{\\large{", paste0(tables.df[t, "Title"], " from household surveys"), "}} 
#      \\vspace{7pt}
#      \\phantomsection
#      \\addcontentsline{toc}{section}{", paste0(tables.df[t, "Title"], " from household surveys"), "}\n",
#       file = fileOut, append = TRUE)
  ## header
  cat("\\captionof{table}{", tables.df[t, "Variable"], "} \\label{tab:title} 
      \\begin{tabular}{L{2.0cm} R{0.7cm} R{0.7cm} R{0.7cm} R{0.7cm} R{0.7cm}}
      \\toprule
      Country & National & Urban & Rural & Male & Female \\\\
      \\midrule\n",
      file = fileOut, append = TRUE)
  for (cou in 1:NROW(surveys.df)) {
    national <- icn2.df[icn2.df[, "FAOST_CODE"] == surveys.df[cou, "FAOST_CODE"] &
                          icn2.df[, "Year"] == surveys.df[cou, "Year"], tables.df[t, "National"]]
    if (is.na(national)) {
      national <- ""
    } else {
      national <- format(round(national, digits = 0), nsmall = 0, big.mark = ",")
    }
    urban <- icn2.df[icn2.df[, "FAOST_CODE"] == surveys.df[cou, "FAOST_CODE"] &
                          icn2.df[, "Year"] == surveys.df[cou, "Year"], tables.df[t, "Urban"]]
    if (is.na(urban)) {
      urban <- ""
    } else {
      urban <- format(round(urban, digits = 0), nsmall = 0, big.mark = ",")
    }
    rural <- icn2.df[icn2.df[, "FAOST_CODE"] == surveys.df[cou, "FAOST_CODE"] &
                          icn2.df[, "Year"] == surveys.df[cou, "Year"], tables.df[t, "Rural"]]
    if (is.na(rural)) {
      rural <- ""
    } else {
      rural <- format(round(rural, digits = 0), nsmall = 0, big.mark = ",")
    }
    male <- icn2.df[icn2.df[, "FAOST_CODE"] == surveys.df[cou, "FAOST_CODE"] &
                          icn2.df[, "Year"] == surveys.df[cou, "Year"], tables.df[t, "Male"]]
    if (is.na(male)) {
      male <- ""
    } else {
      male <- format(round(male, digits = 0), nsmall = 0, big.mark = ",")
    }
    female <- icn2.df[icn2.df[, "FAOST_CODE"] == surveys.df[cou, "FAOST_CODE"] &
                          icn2.df[, "Year"] == surveys.df[cou, "Year"], tables.df[t, "Female"]]
    if (is.na(female)) {
      female <- ""
    } else {
      female <- format(round(female, digits = 0), nsmall = 0, big.mark = ",")
    }
    national <- gsub(pattern = ",", replacement = "\\\\,", x = national)
    urban <- gsub(pattern = ",", replacement = "\\\\,", x = urban)
    rural <- gsub(pattern = ",", replacement = "\\\\,", x = rural)
    male <- gsub(pattern = ",", replacement = "\\\\,", x = male)
    female <- gsub(pattern = ",", replacement = "\\\\,", x = female)
    ## table
    cat("\ \ \ \ \ \ \ ",
        paste0(surveys.df[cou, "SHORT_NAME"], " (", surveys.df[cou, "Survey"], ")"), 
        "&", national, "&", urban, "&", rural, "&", male, "&", female, "\\\\\n",
        file = fileOut, append = TRUE)
  }    
  ## tail
  cat("\ \ \ \ \ \ \ \\toprule
      \\end{tabular}\n",
      file = fileOut, append = TRUE)
  cat("\\clearpage\n\n",
      file = fileOut, append = TRUE)
  ## chart
  cat("\\begin{multicols}{2}\n",
      file = fileOut, append = TRUE)
  cat(paste0("\\input{./Captions/Caption_C.P1.HS.1.",hsc,".tex}\n"),
      file = fileOut, append = TRUE)
#   cat("\\vspace{-7pt}\n",
#       file = fileOut, append = TRUE)
  cat(paste0("\\IfFileExists{./Plots/C.P1.HS.1.",hsc,".pdf}{\\includegraphics[width = 4cm, height = 16cm]{{./Plots/C.P1.HS.1.",hsc,"}.pdf}}{}\n"),
      file = fileOut, append = TRUE)
  hsc <- hsc + 1
  cat(paste0("\\input{./Captions/Caption_C.P1.HS.1.",hsc,".tex}\n"),
      file = fileOut, append = TRUE)
#   cat("\\vspace{-7pt}\n",
#       file = fileOut, append = TRUE)
  cat(paste0("\\IfFileExists{./Plots/C.P1.HS.1.",hsc,".pdf}{\\includegraphics[width = 4cm, height = 16cm]{{./Plots/C.P1.HS.1.",hsc,"}.pdf}}{}\n"),
      file = fileOut, append = TRUE)
  cat("\\end{multicols}\n",
      file = fileOut, append = TRUE)
  cat("\\clearpage\n\n",
      file = fileOut, append = TRUE)
  hsc <- hsc + 1
}

# ## Create the new .tex file
# fileOut <- paste("./Outputs/HouseholdSurveys.tex", sep = "")
# if(file.exists(fileOut)) file.remove(fileOut)
# file.create(fileOut)
# ## This script creates the latex file
# cat("\\renewcommand{\\arraystretch}{1}\n",
#     file = fileOut, append = TRUE)
# cat("\\footnotesize\n",
#     file = fileOut, append = TRUE)
# # \\rowcolors{1}{FAOblue!10}{white}
# for (i in 1:nrow(surveys.df)) {
#   ## header
#   cat("\\captionof{table}{", paste0(surveys.df[i, "SHORT_NAME"], ", ", surveys.df[i, "Survey"]), "} \\label{tab:title} 
#       \\begin{tabular}{L{2.4cm} R{0.9cm} R{0.5cm} R{0.5cm} R{0.5cm} R{0.9cm}}
#       \\toprule
#       & \\multicolumn{1}{C{0.9cm}}{Average dietary energy consumption (kcal/cap/day)} &  \\multicolumn{3}{C{2.3cm}}{Nutrient contribution to dietary energy consumption (\\%)} & \\multicolumn{1}{C{0.9cm}}{Share of animal protein in total protein consumption (\\%)} \\\\
#       \\cmidrule(r){3-5}
#        & & Protein & Fat & Carbohydrates & \\\\
#       \\midrule\n",
#       file = fileOut, append = TRUE)
#   ## data
#   tmp.df <- 
#     icn2.df[icn2.df[, "FAOST_CODE"] == surveys.df[i, "FAOST_CODE"] & 
#               icn2.df[, "Year"] == surveys.df[i, "Year"], tableVars] 
#   ## table
#   cat("\\textbf{National} & ", tmp.df[, "HS.PCS.DEC.KCD"], " & ",
#       tmp.df[, "HS.NCDEC.PRT.PCT"], " & ", tmp.df[, "HS.NCDEC.FAT.PCT"], " & ",
#       tmp.df[, "HS.NCDEC.CRB.PCT"], " & ", tmp.df[, "HS.SPC.AP.PCT"], "\\\\\n",
#       file = fileOut, append = TRUE)
#   cat("\\textbf{Area of residence} & & & & & \\\\\n",
#       file = fileOut, append = TRUE)
#   cat("\t ~ \\ Urban & ", tmp.df[, "HS.PCS.UDEC.KCD"], " & ",
#       tmp.df[, "HS.NCDEC.UPRT.PCT"], " & ", tmp.df[, "HS.NCDEC.UFAT.PCT"], " & ",
#       tmp.df[, "HS.NCDEC.UCRB.PCT"], " & ", tmp.df[, "HS.SPC.UAP.PCT"], "\\\\\n",
#       file = fileOut, append = TRUE)
#   cat("\t ~ \\ Rural & ", tmp.df[i, "HS.PCS.RDEC.KCD"], " & ",
#       tmp.df[, "HS.NCDEC.RPRT.PCT"], " & ", tmp.df[, "HS.NCDEC.RFAT.PCT"], " & ",
#       tmp.df[, "HS.NCDEC.RCRB.PCT"], " & ", tmp.df[, "HS.SPC.RAP.PCT"], "\\\\\n",
#       file = fileOut, append = TRUE)
#   cat("\\textbf{Gender of the head of the household} & & & & & \\\\\n",
#       file = fileOut, append = TRUE)
#   cat("\t ~ \\ Male & ", tmp.df[, "HS.PCS.MDEC.KCD"], " & ",
#       tmp.df[, "HS.NCDEC.MPRT.PCT"], " & ", tmp.df[, "HS.NCDEC.MFAT.PCT"], " & ",
#       tmp.df[, "HS.NCDEC.MCRB.PCT"], " & ", tmp.df[, "HS.SPC.MAP.PCT"], "\\\\\n",
#       file = fileOut, append = TRUE)
#   cat("\t ~ \\ Female & ", tmp.df[, "HS.PCS.FDEC.KCD"], " & ",
#       tmp.df[, "HS.NCDEC.FPRT.PCT"], " & ", tmp.df[, "HS.NCDEC.FFAT.PCT"], " & ",
#       tmp.df[, "HS.NCDEC.FCRB.PCT"], " & ", tmp.df[, "HS.SPC.FAP.PCT"], "\\\\\n",
#       file = fileOut, append = TRUE)
#   cat("\\textbf{The five most consumed food products} & & & & & \\\\\n",
#       file = fileOut, append = TRUE)
#   cat("\t ~ \\", "Product 1", " & & & & & \\\\\n",
#       file = fileOut, append = TRUE)
#   cat("\t ~ \\", "Product 2", " & & & & & \\\\\n",
#       file = fileOut, append = TRUE)
#   cat("\t ~ \\", "Product 3", " & & & & & \\\\\n",
#       file = fileOut, append = TRUE)
#   cat("\t ~ \\", "Product 4", " & & & & & \\\\\n",
#       file = fileOut, append = TRUE)
#   cat("\t ~ \\", "Product 5", " & & & & & \\\\\n",
#       file = fileOut, append = TRUE)
#   ## tail
#   cat("\ \ \ \ \ \ \ \\toprule
#       \\end{tabular}\n\n",
#       file = fileOut, append = TRUE)
#   ## spacing
#   cat("\\vspace{50pt}",
#       file = fileOut, append = TRUE)
#   ## clearpage
#   if (i %% 2 == 0) {
#     cat("\\clearpage",
#         file = fileOut, append = TRUE)
#   }
# }

###########################################################################
## Metadata
###########################################################################

# # Definitions -------------------------------------------------------------
# 
# definitions.df <- 
#   read.csv(file = "./Data/Processed/Definitions.csv", , nrows = 71,
#            header = TRUE, na.strings = "", stringsAsFactors = FALSE)
# definitions.df<- arrange(definitions.df, LABEL)
# definitions.df[, "LABEL"] <- 
#   sanitizeToLatex(definitions.df[, "LABEL"])
# definitions.df[, "DEFINITION"] <- 
#   sanitizeToLatex(definitions.df[, "DEFINITION"])
# 
# # TeX file ----------------------------------------------------------------
# 
# ## Create the new .tex file
# fileOut <- paste("./Outputs/Metadata.tex", sep = "")
# if(file.exists(fileOut)) file.remove(fileOut)
# file.create(fileOut)
# ## This script creates the latex file
# # cat("\\renewcommand{\\arraystretch}{1}\n",
# #     file = fileOut, append = TRUE)
# cat("\\begin{MetadataCollection}\n\n",
#     file = fileOut, append = TRUE)
# cat("\\twocolumn\n\n",
#     file = fileOut, append = TRUE)
# cat("\\LARGE\n\n",
#     file = fileOut, append = TRUE)
# cat("\\textbf{Definitions}\n\n",
#     file = fileOut, append = TRUE)
# cat("\\footnotesize\n\n",
#     file = fileOut, append = TRUE)
# for (i in 1:NROW(definitions.df)) {
#   cat("\\begin{metadata}{", definitions.df[i, "LABEL"], "}{", definitions.df[i, "STS_ID"], "}\n",
#       file = fileOut, append = TRUE)
#   cat(definitions.df[i, "DEFINITION"], "\n",
#       file = fileOut, append = TRUE)
#   cat("\\source{", sanitizeToLatex(meta.df[meta.df[, "STS_ID"] == definitions.df[i, "STS_ID"], "SOURCE"]), "}\n",
#       file = fileOut, append = TRUE)
#   cat("\\owner{", sanitizeToLatex(meta.df[meta.df[, "STS_ID"] == definitions.df[i, "STS_ID"], "OWNER"]), "}\n",
#       file = fileOut, append = TRUE)
#   cat("\\end{metadata}\n\n",
#       file = fileOut, append = TRUE)
# }
# cat("\\end{MetadataCollection}\n",
#     file = fileOut, append = TRUE)
# 
###########################################################################
## End
###########################################################################
