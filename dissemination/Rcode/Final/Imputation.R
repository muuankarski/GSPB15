###########################################################################
## Title: Imputation
###########################################################################

countriesTBCB <- 
  data.frame(FAOST_CODE = c(299,1,52,57,63,73,108,113,119,126,146,185,208,
                            213,230,235),
             NAME = c("Occupied Palestinian Territories", "Armenia", 
                      "Azerbaijan", "Belarus", "Estonia", 
                      "Georgia", "Kazakistan", "Kyrghisistan", "Latvia", 
                      "Lithuania",  "Moldova", "Russian Federation", 
                      "Tajikistan", "Turkmenistan", "Ukraine", 
                      "Uzbekistan"),
             REF_YEAR = c(1996, rep(1992, 15)))
countriesTBCF <- 
  data.frame(FAOST_CODE = c(151, 206),
             NAME = c("Netherland Antilles", "Sudan (former)"),
             REF_YEAR = c(2010, 2010))

# FB.PCS.CRLS.KCDI --------------------------------------------------------

## Create the imputed variable
preConstr.df[, "FBS.PCS.CRLS.KCDI"] <- preConstr.df[, "FBS.PCS.CRLS.KCD"]
## Impute the variable in order to avoid jumps in the aggregates
preConstr.df <- 
  CarryBackward(dataset = preConstr.df, varOrig = "FBS.PCS.CRLS.KCDI", 
                countriesTBCB = countriesTBCB, refYearCol = "REF_YEAR")
preConstr.df <- 
  CarryForward(dataset = preConstr.df, varOrig = "FBS.PCS.CRLS.KCDI", 
               countriesTBCF = countriesTBCF, refYearCol = "REF_YEAR")

# FB.PCS.SR.KCDI --------------------------------------------------------

## Create the imputed variable
preConstr.df[, "FBS.PCS.SR.KCDI"] <- preConstr.df[, "FBS.PCS.SR.KCD"]
## Impute the variable in order to avoid jumps in the aggregates
preConstr.df <- 
  CarryBackward(dataset = preConstr.df, varOrig = "FBS.PCS.SR.KCDI", 
                countriesTBCB = countriesTBCB, refYearCol = "REF_YEAR")
preConstr.df <- 
  CarryForward(dataset = preConstr.df, varOrig = "FBS.PCS.SR.KCDI", 
               countriesTBCF = countriesTBCF, refYearCol = "REF_YEAR")

# FB.PCS.SS.KCDI --------------------------------------------------------

## Create the imputed variable
preConstr.df[, "FBS.PCS.SS.KCDI"] <- preConstr.df[, "FBS.PCS.SS.KCD"]
## Impute the variable in order to avoid jumps in the aggregates
preConstr.df <- 
  CarryBackward(dataset = preConstr.df, varOrig = "FBS.PCS.SS.KCDI", 
                countriesTBCB = countriesTBCB, refYearCol = "REF_YEAR")
preConstr.df <- 
  CarryForward(dataset = preConstr.df, varOrig = "FBS.PCS.SS.KCDI", 
               countriesTBCF = countriesTBCF, refYearCol = "REF_YEAR")

# FB.PCS.PLS.KCDI ---------------------------------------------------------

## Create the imputed variable
preConstr.df[, "FBS.PCS.PLS.KCDI"] <- preConstr.df[, "FBS.PCS.PLS.KCD"]
## Impute the variable in order to avoid jumps in the aggregates
preConstr.df <- 
  CarryBackward(dataset = preConstr.df, varOrig = "FBS.PCS.PLS.KCDI", 
                countriesTBCB = countriesTBCB, refYearCol = "REF_YEAR")
preConstr.df <- 
  CarryForward(dataset = preConstr.df, varOrig = "FBS.PCS.PLS.KCDI", 
               countriesTBCF = countriesTBCF, refYearCol = "REF_YEAR")

# FB.PCS.TRNT.KCDI ---------------------------------------------------------

## Create the imputed variable
preConstr.df[, "FBS.PCS.TRNT.KCDI"] <- preConstr.df[, "FBS.PCS.TRNT.KCD"]
## Impute the variable in order to avoid jumps in the aggregates
preConstr.df <- 
  CarryBackward(dataset = preConstr.df, varOrig = "FBS.PCS.TRNT.KCDI", 
                countriesTBCB = countriesTBCB, refYearCol = "REF_YEAR")
preConstr.df <- 
  CarryForward(dataset = preConstr.df, varOrig = "FBS.PCS.TRNT.KCDI", 
               countriesTBCF = countriesTBCF, refYearCol = "REF_YEAR")

# FB.PCS.OCRPS.KCDI -------------------------------------------------------

## Create the imputed variable
preConstr.df[, "FBS.PCS.OCRPS.KCDI"] <- preConstr.df[, "FBS.PCS.OCRPS.KCD"]
## Impute the variable in order to avoid jumps in the aggregates
preConstr.df <- 
  CarryBackward(dataset = preConstr.df, varOrig = "FBS.PCS.OCRPS.KCDI", 
                countriesTBCB = countriesTBCB, refYearCol = "REF_YEAR")
preConstr.df <- 
  CarryForward(dataset = preConstr.df, varOrig = "FBS.PCS.OCRPS.KCDI", 
               countriesTBCF = countriesTBCF, refYearCol = "REF_YEAR")

# FB.PCS.VO.KCDI ----------------------------------------------------------

## Create the imputed variable
preConstr.df[, "FBS.PCS.VO.KCDI"] <- preConstr.df[, "FBS.PCS.VO.KCD"]
## Impute the variable in order to avoid jumps in the aggregates
preConstr.df <- 
  CarryBackward(dataset = preConstr.df, varOrig = "FBS.PCS.VO.KCDI", 
                countriesTBCB = countriesTBCB, refYearCol = "REF_YEAR")
preConstr.df <- 
  CarryForward(dataset = preConstr.df, varOrig = "FBS.PCS.VO.KCDI", 
               countriesTBCF = countriesTBCF, refYearCol = "REF_YEAR")

# FB.PCS.VGT.KCDI ---------------------------------------------------------

## Create the imputed variable
preConstr.df[, "FBS.PCS.VGT.KCDI"] <- preConstr.df[, "FBS.PCS.VGT.KCD"]
## Impute the variable in order to avoid jumps in the aggregates
preConstr.df <- 
  CarryBackward(dataset = preConstr.df, varOrig = "FBS.PCS.VGT.KCDI", 
                countriesTBCB = countriesTBCB, refYearCol = "REF_YEAR")
preConstr.df <- 
  CarryForward(dataset = preConstr.df, varOrig = "FBS.PCS.VGT.KCDI", 
               countriesTBCF = countriesTBCF, refYearCol = "REF_YEAR")

# FB.PCS.FEW.KCDI ---------------------------------------------------------

## Create the imputed variable
preConstr.df[, "FBS.PCS.FEW.KCDI"] <- preConstr.df[, "FBS.PCS.FEW.KCD"]
## Impute the variable in order to avoid jumps in the aggregates
preConstr.df <- 
  CarryBackward(dataset = preConstr.df, varOrig = "FBS.PCS.FEW.KCDI", 
                countriesTBCB = countriesTBCB, refYearCol = "REF_YEAR")
preConstr.df <- 
  CarryForward(dataset = preConstr.df, varOrig = "FBS.PCS.FEW.KCDI", 
               countriesTBCF = countriesTBCF, refYearCol = "REF_YEAR")

# FB.PCS.AB.KCDI ---------------------------------------------------------

## Create the imputed variable
preConstr.df[, "FBS.PCS.AB.KCDI"] <- preConstr.df[, "FBS.PCS.AB.KCD"]
## Impute the variable in order to avoid jumps in the aggregates
preConstr.df <- 
  CarryBackward(dataset = preConstr.df, varOrig = "FBS.PCS.AB.KCDI", 
                countriesTBCB = countriesTBCB, refYearCol = "REF_YEAR")
preConstr.df <- 
  CarryForward(dataset = preConstr.df, varOrig = "FBS.PCS.AB.KCDI", 
               countriesTBCF = countriesTBCF, refYearCol = "REF_YEAR")

# FB.PCS.STM.KCDI ---------------------------------------------------------

## Create the imputed variable
preConstr.df[, "FBS.PCS.STM.KCDI"] <- preConstr.df[, "FBS.PCS.STM.KCD"]
## Impute the variable in order to avoid jumps in the aggregates
preConstr.df <- 
  CarryBackward(dataset = preConstr.df, varOrig = "FBS.PCS.STM.KCDI", 
                countriesTBCB = countriesTBCB, refYearCol = "REF_YEAR")
preConstr.df <- 
  CarryForward(dataset = preConstr.df, varOrig = "FBS.PCS.STM.KCDI", 
               countriesTBCF = countriesTBCF, refYearCol = "REF_YEAR")

# FB.PCS.MEAT.KCDI ---------------------------------------------------------

## Create the imputed variable
preConstr.df[, "FBS.PCS.MEAT.KCDI"] <- preConstr.df[, "FBS.PCS.MEAT.KCD"]
## Impute the variable in order to avoid jumps in the aggregates
preConstr.df <- 
  CarryBackward(dataset = preConstr.df, varOrig = "FBS.PCS.MEAT.KCDI", 
                countriesTBCB = countriesTBCB, refYearCol = "REF_YEAR")
preConstr.df <- 
  CarryForward(dataset = preConstr.df, varOrig = "FBS.PCS.MEAT.KCDI", 
               countriesTBCF = countriesTBCF, refYearCol = "REF_YEAR")

# FB.PCS.OFF.KCDI ---------------------------------------------------------

## Create the imputed variable
preConstr.df[, "FBS.PCS.OFF.KCDI"] <- preConstr.df[, "FBS.PCS.OFF.KCD"]
## Impute the variable in order to avoid jumps in the aggregates
preConstr.df <- 
  CarryBackward(dataset = preConstr.df, varOrig = "FBS.PCS.OFF.KCDI", 
                countriesTBCB = countriesTBCB, refYearCol = "REF_YEAR")
preConstr.df <- 
  CarryForward(dataset = preConstr.df, varOrig = "FBS.PCS.OFF.KCDI", 
               countriesTBCF = countriesTBCF, refYearCol = "REF_YEAR")

# FB.PCS.AF.KCDI ---------------------------------------------------------

## Create the imputed variable
preConstr.df[, "FBS.PCS.AF.KCDI"] <- preConstr.df[, "FBS.PCS.AF.KCD"]
## Impute the variable in order to avoid jumps in the aggregates
preConstr.df <- 
  CarryBackward(dataset = preConstr.df, varOrig = "FBS.PCS.AF.KCDI", 
                countriesTBCB = countriesTBCB, refYearCol = "REF_YEAR")
preConstr.df <- 
  CarryForward(dataset = preConstr.df, varOrig = "FBS.PCS.AF.KCDI", 
               countriesTBCF = countriesTBCF, refYearCol = "REF_YEAR")

# FB.PCS.MEB.KCDI ---------------------------------------------------------

## Create the imputed variable
preConstr.df[, "FBS.PCS.MEB.KCDI"] <- preConstr.df[, "FBS.PCS.MEB.KCD"]
## Impute the variable in order to avoid jumps in the aggregates
preConstr.df <- 
  CarryBackward(dataset = preConstr.df, varOrig = "FBS.PCS.MEB.KCDI", 
                countriesTBCB = countriesTBCB, refYearCol = "REF_YEAR")
preConstr.df <- 
  CarryForward(dataset = preConstr.df, varOrig = "FBS.PCS.MEB.KCDI", 
               countriesTBCF = countriesTBCF, refYearCol = "REF_YEAR")

# FB.PCS.EGG.KCDI ---------------------------------------------------------

## Create the imputed variable
preConstr.df[, "FBS.PCS.EGG.KCDI"] <- preConstr.df[, "FBS.PCS.EGG.KCD"]
## Impute the variable in order to avoid jumps in the aggregates
preConstr.df <- 
  CarryBackward(dataset = preConstr.df, varOrig = "FBS.PCS.EGG.KCDI", 
                countriesTBCB = countriesTBCB, refYearCol = "REF_YEAR")
preConstr.df <- 
  CarryForward(dataset = preConstr.df, varOrig = "FBS.PCS.EGG.KCDI", 
               countriesTBCF = countriesTBCF, refYearCol = "REF_YEAR")

# FB.PCS.FISH.KCDI ---------------------------------------------------------

## Create the imputed variable
preConstr.df[, "FBS.PCS.FISH.KCDI"] <- preConstr.df[, "FBS.PCS.FISH.KCD"]
## Impute the variable in order to avoid jumps in the aggregates
preConstr.df <- 
  CarryBackward(dataset = preConstr.df, varOrig = "FBS.PCS.FISH.KCDI", 
                countriesTBCB = countriesTBCB, refYearCol = "REF_YEAR")
preConstr.df <- 
  CarryForward(dataset = preConstr.df, varOrig = "FBS.PCS.FISH.KCDI", 
               countriesTBCF = countriesTBCF, refYearCol = "REF_YEAR")

# FB.PCS.AP.KCDI ---------------------------------------------------------

## Create the imputed variable
preConstr.df[, "FBS.PCS.AP.KCDI"] <- preConstr.df[, "FBS.PCS.AP.KCD"]
## Impute the variable in order to avoid jumps in the aggregates
preConstr.df <- 
  CarryBackward(dataset = preConstr.df, varOrig = "FBS.PCS.AP.KCDI", 
                countriesTBCB = countriesTBCB, refYearCol = "REF_YEAR")
preConstr.df <- 
  CarryForward(dataset = preConstr.df, varOrig = "FBS.PCS.AP.KCDI", 
               countriesTBCF = countriesTBCF, refYearCol = "REF_YEAR")
