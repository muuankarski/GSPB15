###########################################################################
## Title: Manual construction
###########################################################################

## Group needed to fill the two years hole left by the 3 year moving
## average function. This concern just the new born countries.
twoYearsHole <- 
  data.frame(FAOST_CODE = c(rep(272, 2), rep(273, 2),
                            rep(255, 2), rep(256, 2),
                            rep(167, 2), rep(199, 2),
                            rep(178, 2), rep(238, 2),
                            rep(278, 2), rep(279, 2), rep(280, 2),
                            rep(1, 2), rep(52, 2), rep(57, 2),
                            rep(63, 2), rep(73, 2), rep(108, 2),
                            rep(113, 2), rep(119, 2), rep(126, 2),
                            rep(146, 2), rep(185, 2), rep(208, 2),
                            rep(213, 2), rep(230, 2), rep(235, 2),
                            rep(276, 2), rep(277, 2),
                            rep(80, 2), rep(98, 2),
                            rep(186, 2), rep(198, 2), 
                            rep(154, 2), rep(299, 2),
                            rep(206, 2), rep(151, 2)),
             NAME = c(rep("Serbia", 2), rep("Montenegro", 2),
                      rep("Belgium", 2), rep("Luxembourg", 2),
                      rep("Czech Republic", 2), rep("Slovakia", 2),
                      rep("Eritrea", 2), rep("Ethiopia", 2),
                      rep("Bonaire", 2), rep("Curacao", 2), rep("Sint Maarten", 2),
                      rep("Armenia", 2), rep("Azerbaijan", 2), rep("Belarus", 2),
                      rep("Estonia", 2), rep("Georgia", 2), rep("Kazakistan", 2),
                      rep("Kyrghisistan", 2), rep("Latvia", 2), rep("Lithuania", 2),
                      rep("Moldova", 2), rep("Russian Federation", 2), rep("Tajikistan", 2),
                      rep("Turkmenistan", 2), rep("Ukraine", 2), rep("Uzbekistan", 2),
                      rep("Sudan", 2), rep("South Sudan", 2),
                      rep("Bosnia and Herzegovina", 2), rep("Croatia", 2),
                      rep("Serbia and Montenegro", 2), rep("Slovenia", 2),
                      rep("Macedonia", 2), rep("Occupied Palestinian Territory", 2),
                      rep("Sudan (former)", 2), rep("Netherland Antilles", 2)),
             Year = c(rep(c(2006, 2007), 2), rep(c(2000, 2001), 2),
                      rep(c(1993, 1994), 2), rep(c(1993, 1994), 2),
                      rep(c(2011, 2012), 3), rep(c(1992, 1993), 15),
                      rep(c(2012, 2013), 2), rep(c(1992, 1993), 5), 
                      rep(c(1994, 1995), 1), rep(c(2011, 2012), 2)))

# OA.TPBS.POP.P3 ----------------------------------------------------------

preAgg.df <- 
  MovingAverage(dataset = preAgg.df, origVar = "OA.TPBS.POP.P", 
                newVarName = "OA.TPBS.POP.P3")
preAgg.df <- 
  ReplaceValue(dataset = preAgg.df, fromVar = "OA.TPBS.POP.P", toVar = "OA.TPBS.POP.P3",
               countryCode = twoYearsHole[, "FAOST_CODE"], year = twoYearsHole[, "Year"])

# FBS.PCS.CRLS.KCD3 ---------------------------------------------------------

preAgg.df <- 
  MovingAverage(dataset = preAgg.df, origVar = "FBS.PCS.CRLS.KCD", 
                newVarName = "FBS.PCS.CRLS.KCD3", weightVar = "OA.TPBS.POP.P")
preAgg.df <- 
  ReplaceValue(dataset = preAgg.df, fromVar = "FBS.PCS.CRLS.KCD", toVar = "FBS.PCS.CRLS.KCD3",
               countryCode = twoYearsHole[, "FAOST_CODE"], year = twoYearsHole[, "Year"])

# FBS.PCS.CRLS.KCDI3 --------------------------------------------------------

preAgg.df <- 
  MovingAverage(dataset = preAgg.df, origVar = "FBS.PCS.CRLS.KCDI", 
                newVarName = "FBS.PCS.CRLS.KCDI3", weightVar = "OA.TPBS.POP.P")
preAgg.df <- 
  ReplaceValue(dataset = preAgg.df, fromVar = "FBS.PCS.CRLS.KCDI", toVar = "FBS.PCS.CRLS.KCDI3",
               countryCode = twoYearsHole[, "FAOST_CODE"], year = twoYearsHole[, "Year"])

# FBS.PCS.SR.KCD3 ---------------------------------------------------------

preAgg.df <- 
  MovingAverage(dataset = preAgg.df, origVar = "FBS.PCS.SR.KCD", 
                newVarName = "FBS.PCS.SR.KCD3", weightVar = "OA.TPBS.POP.P")
preAgg.df <- 
  ReplaceValue(dataset = preAgg.df, fromVar = "FBS.PCS.SR.KCD", toVar = "FBS.PCS.SR.KCD3",
               countryCode = twoYearsHole[, "FAOST_CODE"], year = twoYearsHole[, "Year"])

# FBS.PCS.SR.KCDI3 --------------------------------------------------------

preAgg.df <- 
  MovingAverage(dataset = preAgg.df, origVar = "FBS.PCS.SR.KCDI", 
                newVarName = "FBS.PCS.SR.KCDI3", weightVar = "OA.TPBS.POP.P")
preAgg.df <- 
  ReplaceValue(dataset = preAgg.df, fromVar = "FBS.PCS.SR.KCDI", toVar = "FBS.PCS.SR.KCDI3",
               countryCode = twoYearsHole[, "FAOST_CODE"], year = twoYearsHole[, "Year"])

# FBS.PCS.SS.KCD3 ---------------------------------------------------------

preAgg.df <- 
  MovingAverage(dataset = preAgg.df, origVar = "FBS.PCS.SS.KCD", 
                newVarName = "FBS.PCS.SS.KCD3", weightVar = "OA.TPBS.POP.P")
preAgg.df <- 
  ReplaceValue(dataset = preAgg.df, fromVar = "FBS.PCS.SS.KCD", toVar = "FBS.PCS.SS.KCD3",
               countryCode = twoYearsHole[, "FAOST_CODE"], year = twoYearsHole[, "Year"])

# FBS.PCS.SS.KCDI3 --------------------------------------------------------

preAgg.df <- 
  MovingAverage(dataset = preAgg.df, origVar = "FBS.PCS.SS.KCDI", 
                newVarName = "FBS.PCS.SS.KCDI3", weightVar = "OA.TPBS.POP.P")
preAgg.df <- 
  ReplaceValue(dataset = preAgg.df, fromVar = "FBS.PCS.SS.KCDI", toVar = "FBS.PCS.SS.KCDI3",
               countryCode = twoYearsHole[, "FAOST_CODE"], year = twoYearsHole[, "Year"])

# FBS.PCS.PLS.KCD3 ---------------------------------------------------------

preAgg.df <- 
  MovingAverage(dataset = preAgg.df, origVar = "FBS.PCS.PLS.KCD", 
                newVarName = "FBS.PCS.PLS.KCD3", weightVar = "OA.TPBS.POP.P")
preAgg.df <- 
  ReplaceValue(dataset = preAgg.df, fromVar = "FBS.PCS.PLS.KCD", toVar = "FBS.PCS.PLS.KCD3",
               countryCode = twoYearsHole[, "FAOST_CODE"], year = twoYearsHole[, "Year"])

# FBS.PCS.PLS.KCDI3 --------------------------------------------------------

preAgg.df <- 
  MovingAverage(dataset = preAgg.df, origVar = "FBS.PCS.PLS.KCDI", 
                newVarName = "FBS.PCS.PLS.KCDI3", weightVar = "OA.TPBS.POP.P")
preAgg.df <- 
  ReplaceValue(dataset = preAgg.df, fromVar = "FBS.PCS.PLS.KCDI", toVar = "FBS.PCS.PLS.KCDI3",
               countryCode = twoYearsHole[, "FAOST_CODE"], year = twoYearsHole[, "Year"])

# FBS.PCS.TRNT.KCD3 -------------------------------------------------------

preAgg.df <- 
  MovingAverage(dataset = preAgg.df, origVar = "FBS.PCS.TRNT.KCD", 
                newVarName = "FBS.PCS.TRNT.KCD3", weightVar = "OA.TPBS.POP.P")
preAgg.df <- 
  ReplaceValue(dataset = preAgg.df, fromVar = "FBS.PCS.TRNT.KCD", toVar = "FBS.PCS.TRNT.KCD3",
               countryCode = twoYearsHole[, "FAOST_CODE"], year = twoYearsHole[, "Year"])

# FBS.PCS.TRNT.KCDI3 ------------------------------------------------------

preAgg.df <- 
  MovingAverage(dataset = preAgg.df, origVar = "FBS.PCS.TRNT.KCDI", 
                newVarName = "FBS.PCS.TRNT.KCDI3", weightVar = "OA.TPBS.POP.P")
preAgg.df <- 
  ReplaceValue(dataset = preAgg.df, fromVar = "FBS.PCS.TRNT.KCDI", toVar = "FBS.PCS.TRNT.KCDI3",
               countryCode = twoYearsHole[, "FAOST_CODE"], year = twoYearsHole[, "Year"])

# FBS.PCS.OCRPS.KCD3 -------------------------------------------------------

preAgg.df <- 
  MovingAverage(dataset = preAgg.df, origVar = "FBS.PCS.OCRPS.KCD", 
                newVarName = "FBS.PCS.OCRPS.KCD3", weightVar = "OA.TPBS.POP.P")
preAgg.df <- 
  ReplaceValue(dataset = preAgg.df, fromVar = "FBS.PCS.OCRPS.KCD", toVar = "FBS.PCS.OCRPS.KCD3",
               countryCode = twoYearsHole[, "FAOST_CODE"], year = twoYearsHole[, "Year"])

# FBS.PCS.OCRPS.KCDI3 ------------------------------------------------------

preAgg.df <- 
  MovingAverage(dataset = preAgg.df, origVar = "FBS.PCS.OCRPS.KCDI", 
                newVarName = "FBS.PCS.OCRPS.KCDI3", weightVar = "OA.TPBS.POP.P")
preAgg.df <- 
  ReplaceValue(dataset = preAgg.df, fromVar = "FBS.PCS.OCRPS.KCDI", toVar = "FBS.PCS.OCRPS.KCDI3",
               countryCode = twoYearsHole[, "FAOST_CODE"], year = twoYearsHole[, "Year"])

# FBS.PCS.VO.KCD3 ---------------------------------------------------------

preAgg.df <- 
  MovingAverage(dataset = preAgg.df, origVar = "FBS.PCS.VO.KCD", 
                newVarName = "FBS.PCS.VO.KCD3", weightVar = "OA.TPBS.POP.P")
preAgg.df <- 
  ReplaceValue(dataset = preAgg.df, fromVar = "FBS.PCS.VO.KCD", toVar = "FBS.PCS.VO.KCD3",
               countryCode = twoYearsHole[, "FAOST_CODE"], year = twoYearsHole[, "Year"])

# FBS.PCS.VO.KCDI3 --------------------------------------------------------

preAgg.df <- 
  MovingAverage(dataset = preAgg.df, origVar = "FBS.PCS.VO.KCDI", 
                newVarName = "FBS.PCS.VO.KCDI3", weightVar = "OA.TPBS.POP.P")
preAgg.df <- 
  ReplaceValue(dataset = preAgg.df, fromVar = "FBS.PCS.VO.KCDI", toVar = "FBS.PCS.VO.KCDI3",
               countryCode = twoYearsHole[, "FAOST_CODE"], year = twoYearsHole[, "Year"])

# FBS.PCS.VGT.KCD3 ---------------------------------------------------------

preAgg.df <- 
  MovingAverage(dataset = preAgg.df, origVar = "FBS.PCS.VGT.KCD", 
                newVarName = "FBS.PCS.VGT.KCD3", weightVar = "OA.TPBS.POP.P")
preAgg.df <- 
  ReplaceValue(dataset = preAgg.df, fromVar = "FBS.PCS.VGT.KCD", toVar = "FBS.PCS.VGT.KCD3",
               countryCode = twoYearsHole[, "FAOST_CODE"], year = twoYearsHole[, "Year"])

# FBS.PCS.VGT.KCDI3 --------------------------------------------------------

preAgg.df <- 
  MovingAverage(dataset = preAgg.df, origVar = "FBS.PCS.VGT.KCDI", 
                newVarName = "FBS.PCS.VGT.KCDI3", weightVar = "OA.TPBS.POP.P")
preAgg.df <- 
  ReplaceValue(dataset = preAgg.df, fromVar = "FBS.PCS.VGT.KCDI", toVar = "FBS.PCS.VGT.KCDI3",
               countryCode = twoYearsHole[, "FAOST_CODE"], year = twoYearsHole[, "Year"])

# FBS.PCS.FEW.KCD3 ---------------------------------------------------------

preAgg.df <- 
  MovingAverage(dataset = preAgg.df, origVar = "FBS.PCS.FEW.KCD", 
                newVarName = "FBS.PCS.FEW.KCD3", weightVar = "OA.TPBS.POP.P")
preAgg.df <- 
  ReplaceValue(dataset = preAgg.df, fromVar = "FBS.PCS.FEW.KCD", toVar = "FBS.PCS.FEW.KCD3",
               countryCode = twoYearsHole[, "FAOST_CODE"], year = twoYearsHole[, "Year"])

# FBS.PCS.FEW.KCDI3 --------------------------------------------------------

preAgg.df <- 
  MovingAverage(dataset = preAgg.df, origVar = "FBS.PCS.FEW.KCDI", 
                newVarName = "FBS.PCS.FEW.KCDI3", weightVar = "OA.TPBS.POP.P")
preAgg.df <- 
  ReplaceValue(dataset = preAgg.df, fromVar = "FBS.PCS.FEW.KCDI", toVar = "FBS.PCS.FEW.KCDI3",
               countryCode = twoYearsHole[, "FAOST_CODE"], year = twoYearsHole[, "Year"])

# FBS.PCS.AB.KCD3 ---------------------------------------------------------

preAgg.df <- 
  MovingAverage(dataset = preAgg.df, origVar = "FBS.PCS.AB.KCD", 
                newVarName = "FBS.PCS.AB.KCD3", weightVar = "OA.TPBS.POP.P")
preAgg.df <- 
  ReplaceValue(dataset = preAgg.df, fromVar = "FBS.PCS.AB.KCD", toVar = "FBS.PCS.AB.KCD3",
               countryCode = twoYearsHole[, "FAOST_CODE"], year = twoYearsHole[, "Year"])

# FBS.PCS.AB.KCDI3 --------------------------------------------------------

preAgg.df <- 
  MovingAverage(dataset = preAgg.df, origVar = "FBS.PCS.AB.KCDI", 
                newVarName = "FBS.PCS.AB.KCDI3", weightVar = "OA.TPBS.POP.P")
preAgg.df <- 
  ReplaceValue(dataset = preAgg.df, fromVar = "FBS.PCS.AB.KCDI", toVar = "FBS.PCS.AB.KCDI3",
               countryCode = twoYearsHole[, "FAOST_CODE"], year = twoYearsHole[, "Year"])

# FBS.PCS.STM.KCD3 ---------------------------------------------------------

preAgg.df <- 
  MovingAverage(dataset = preAgg.df, origVar = "FBS.PCS.STM.KCD", 
                newVarName = "FBS.PCS.STM.KCD3", weightVar = "OA.TPBS.POP.P")
preAgg.df <- 
  ReplaceValue(dataset = preAgg.df, fromVar = "FBS.PCS.STM.KCD", toVar = "FBS.PCS.STM.KCD3",
               countryCode = twoYearsHole[, "FAOST_CODE"], year = twoYearsHole[, "Year"])

# FBS.PCS.STM.KCDI3 --------------------------------------------------------

preAgg.df <- 
  MovingAverage(dataset = preAgg.df, origVar = "FBS.PCS.STM.KCDI", 
                newVarName = "FBS.PCS.STM.KCDI3", weightVar = "OA.TPBS.POP.P")
preAgg.df <- 
  ReplaceValue(dataset = preAgg.df, fromVar = "FBS.PCS.STM.KCDI", toVar = "FBS.PCS.STM.KCDI3",
               countryCode = twoYearsHole[, "FAOST_CODE"], year = twoYearsHole[, "Year"])

# FBS.PCS.MEAT.KCD3 -------------------------------------------------------

preAgg.df <- 
  MovingAverage(dataset = preAgg.df, origVar = "FBS.PCS.MEAT.KCD", 
                newVarName = "FBS.PCS.MEAT.KCD3", weightVar = "OA.TPBS.POP.P")
preAgg.df <- 
  ReplaceValue(dataset = preAgg.df, fromVar = "FBS.PCS.MEAT.KCD", toVar = "FBS.PCS.MEAT.KCD3",
               countryCode = twoYearsHole[, "FAOST_CODE"], year = twoYearsHole[, "Year"])

# FBS.PCS.MEAT.KCDI3 ------------------------------------------------------

preAgg.df <- 
  MovingAverage(dataset = preAgg.df, origVar = "FBS.PCS.MEAT.KCDI", 
                newVarName = "FBS.PCS.MEAT.KCDI3", weightVar = "OA.TPBS.POP.P")
preAgg.df <- 
  ReplaceValue(dataset = preAgg.df, fromVar = "FBS.PCS.MEAT.KCDI", toVar = "FBS.PCS.MEAT.KCDI3",
               countryCode = twoYearsHole[, "FAOST_CODE"], year = twoYearsHole[, "Year"])

# FBS.PCS.OFF.KCD3 -------------------------------------------------------

preAgg.df <- 
  MovingAverage(dataset = preAgg.df, origVar = "FBS.PCS.OFF.KCD", 
                newVarName = "FBS.PCS.OFF.KCD3", weightVar = "OA.TPBS.POP.P")
preAgg.df <- 
  ReplaceValue(dataset = preAgg.df, fromVar = "FBS.PCS.OFF.KCD", toVar = "FBS.PCS.OFF.KCD3",
               countryCode = twoYearsHole[, "FAOST_CODE"], year = twoYearsHole[, "Year"])

# FBS.PCS.OFF.KCDI3 ------------------------------------------------------

preAgg.df <- 
  MovingAverage(dataset = preAgg.df, origVar = "FBS.PCS.OFF.KCDI", 
                newVarName = "FBS.PCS.OFF.KCDI3", weightVar = "OA.TPBS.POP.P")
preAgg.df <- 
  ReplaceValue(dataset = preAgg.df, fromVar = "FBS.PCS.OFF.KCDI", toVar = "FBS.PCS.OFF.KCDI3",
               countryCode = twoYearsHole[, "FAOST_CODE"], year = twoYearsHole[, "Year"])

# FBS.PCS.AF.KCD3 ----------------------------------------------------------

preAgg.df <- 
  MovingAverage(dataset = preAgg.df, origVar = "FBS.PCS.AF.KCD", 
                newVarName = "FBS.PCS.AF.KCD3", weightVar = "OA.TPBS.POP.P")
preAgg.df <- 
  ReplaceValue(dataset = preAgg.df, fromVar = "FBS.PCS.AF.KCD", toVar = "FBS.PCS.AF.KCD3",
               countryCode = twoYearsHole[, "FAOST_CODE"], year = twoYearsHole[, "Year"])

# FBS.PCS.AF.KCDI3 ---------------------------------------------------------

preAgg.df <- 
  MovingAverage(dataset = preAgg.df, origVar = "FBS.PCS.AF.KCDI", 
                newVarName = "FBS.PCS.AF.KCDI3", weightVar = "OA.TPBS.POP.P")
preAgg.df <- 
  ReplaceValue(dataset = preAgg.df, fromVar = "FBS.PCS.AF.KCDI", toVar = "FBS.PCS.AF.KCDI3",
               countryCode = twoYearsHole[, "FAOST_CODE"], year = twoYearsHole[, "Year"])

# FBS.PCS.MEB.KCD3 --------------------------------------------------------

preAgg.df <- 
  MovingAverage(dataset = preAgg.df, origVar = "FBS.PCS.MEB.KCD", 
                newVarName = "FBS.PCS.MEB.KCD3", weightVar = "OA.TPBS.POP.P")
preAgg.df <- 
  ReplaceValue(dataset = preAgg.df, fromVar = "FBS.PCS.MEB.KCD", toVar = "FBS.PCS.MEB.KCD3",
               countryCode = twoYearsHole[, "FAOST_CODE"], year = twoYearsHole[, "Year"])

# FBS.PCS.MEB.KCDI3 -------------------------------------------------------

preAgg.df <- 
  MovingAverage(dataset = preAgg.df, origVar = "FBS.PCS.MEB.KCDI", 
                newVarName = "FBS.PCS.MEB.KCDI3", weightVar = "OA.TPBS.POP.P")
preAgg.df <- 
  ReplaceValue(dataset = preAgg.df, fromVar = "FBS.PCS.MEB.KCDI", toVar = "FBS.PCS.MEB.KCDI3",
               countryCode = twoYearsHole[, "FAOST_CODE"], year = twoYearsHole[, "Year"])

# FBS.PCS.EGG.KCD3 --------------------------------------------------------

preAgg.df <- 
  MovingAverage(dataset = preAgg.df, origVar = "FBS.PCS.EGG.KCD", 
                newVarName = "FBS.PCS.EGG.KCD3", weightVar = "OA.TPBS.POP.P")
preAgg.df <- 
  ReplaceValue(dataset = preAgg.df, fromVar = "FBS.PCS.EGG.KCD", toVar = "FBS.PCS.EGG.KCD3",
               countryCode = twoYearsHole[, "FAOST_CODE"], year = twoYearsHole[, "Year"])

# FBS.PCS.EGG.KCDI3 -------------------------------------------------------

preAgg.df <- 
  MovingAverage(dataset = preAgg.df, origVar = "FBS.PCS.EGG.KCDI", 
                newVarName = "FBS.PCS.EGG.KCDI3", weightVar = "OA.TPBS.POP.P")
preAgg.df <- 
  ReplaceValue(dataset = preAgg.df, fromVar = "FBS.PCS.EGG.KCDI", toVar = "FBS.PCS.EGG.KCDI3",
               countryCode = twoYearsHole[, "FAOST_CODE"], year = twoYearsHole[, "Year"])

# FBS.PCS.FISH.KCD3 --------------------------------------------------------

preAgg.df <- 
  MovingAverage(dataset = preAgg.df, origVar = "FBS.PCS.FISH.KCD", 
                newVarName = "FBS.PCS.FISH.KCD3", weightVar = "OA.TPBS.POP.P")
preAgg.df <- 
  ReplaceValue(dataset = preAgg.df, fromVar = "FBS.PCS.FISH.KCD", toVar = "FBS.PCS.FISH.KCD3",
               countryCode = twoYearsHole[, "FAOST_CODE"], year = twoYearsHole[, "Year"])

# FBS.PCS.FISH.KCDI3 -------------------------------------------------------

preAgg.df <- 
  MovingAverage(dataset = preAgg.df, origVar = "FBS.PCS.FISH.KCDI", 
                newVarName = "FBS.PCS.FISH.KCDI3", weightVar = "OA.TPBS.POP.P")
preAgg.df <- 
  ReplaceValue(dataset = preAgg.df, fromVar = "FBS.PCS.FISH.KCDI", toVar = "FBS.PCS.FISH.KCDI3",
               countryCode = twoYearsHole[, "FAOST_CODE"], year = twoYearsHole[, "Year"])

# FBS.PCS.AP.KCD3 --------------------------------------------------------

preAgg.df <- 
  MovingAverage(dataset = preAgg.df, origVar = "FBS.PCS.AP.KCD", 
                newVarName = "FBS.PCS.AP.KCD3", weightVar = "OA.TPBS.POP.P")
preAgg.df <- 
  ReplaceValue(dataset = preAgg.df, fromVar = "FBS.PCS.AP.KCD", toVar = "FBS.PCS.AP.KCD3",
               countryCode = twoYearsHole[, "FAOST_CODE"], year = twoYearsHole[, "Year"])

# FBS.PCS.AP.KCDI3 -------------------------------------------------------

preAgg.df <- 
  MovingAverage(dataset = preAgg.df, origVar = "FBS.PCS.AP.KCDI", 
                newVarName = "FBS.PCS.AP.KCDI3", weightVar = "OA.TPBS.POP.P")
preAgg.df <- 
  ReplaceValue(dataset = preAgg.df, fromVar = "FBS.PCS.AP.KCDI", toVar = "FBS.PCS.AP.KCDI3",
               countryCode = twoYearsHole[, "FAOST_CODE"], year = twoYearsHole[, "Year"])

# GHG.AFOLU.TOT.ECO2EQ.NO -------------------------------------------------

preAgg.df$GHG.AFOLU.TOT.ECO2EQ.NO <- preAgg.df$GHG.TOT.ALL.GG.NO + 
  preAgg.df$GL.LU.TOT.NERCO2EQ.NO

# GLI.CHPF.TOT.ECO2EQ.NO --------------------------------------------------

preAgg.df$GLI.CHPF.TOT.ECO2EQ.NO <- preAgg.df$GL.CL.TOT.NERCO2EQ.NO + 
  preAgg.df$GL.GL.TOT.NERCO2EQ.NO