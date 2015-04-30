#' Forward imputation.
#'
#' This function imputes missing values carrying forward the 
#' value corresponding to the specified year.
#'
#' @param dataset The data frame containing the data 
#' \code{dataset}.
#' @param countryCodeCol The column of the data frame containing the 
#' country code \code{countryCodeCol}.
#' @param yearCol The column of the data frame containing the 
#' year \code{yearCol}.
#' @param varOrig The variable in which the imputation is to be calculated
#' \code{varOrig}.
#' @param countriesTBCF The data frame containing: the 'year' to be taken
#' for forward imputation; the 'country code' written in strings like 
#' "255,256" indicating the countries to be imputed \code{countriesTBCF}.
#' @param refYearCol The column of the data frame containing the reference
#' year to carry forward the value \code{refYearCol}.
#' 
#' @return The original data frame containing the imputed values.
#' 
#' @export
#' 
#' @examples
#' test.df = data.frame(FAOST_CODE = rep(c(1,2,3), each = 11), 
#'                      Year = rep(2000:2010, times = 3), 
#'                      VariableTBI = rep(c(NA, NA, 1:7, NA, NA), times = 3))
#' CarryForward(dataset = test.df, countryCodeCol = "FAOST_CODE", 
#'              yearCol = "Year", varOrig = "VariableTBI")
#' countriesTBCF = 
#'   data.frame(FAOST_CODE = c(1,3), NAME = c("Country1", "Country2"),
#'              REF_YEAR = c(2002))
#' CarryForward(dataset = test.df, countryCodeCol = "FAOST_CODE", 
#'              yearCol = "Year", varOrig = "VariableTBI",
#'              countriesTBCF = countriesTBCF, refYearCol = "REF_YEAR")

CarryForward = 
  function(dataset, countryCodeCol = "FAOST_CODE", yearCol = "Year",  
           varOrig, countriesTBCF, refYearCol) {
    dataset = arrange(dataset, eval(parse(text = countryCodeCol)), 
                      eval(parse(text = yearCol)))
    if (missing(countriesTBCF)) {
      ## The countries to be carried forward have not been specified.
      my.parse <- parse(text = varOrig)
      curenv <<- environment()
      dataset = ddply(dataset, countryCodeCol, transform, 
                      new = na.locf(eval(get("my.parse", envir = curenv)), 
                                    na.rm = FALSE))
      dataset[is.na(dataset[, varOrig]), varOrig] = 
        dataset[is.na(dataset[, varOrig]), "new"]
      dataset = dataset[, -grep("new", colnames(dataset))]
    } else {
      ## The countries to be carried forward have been specified.
      for (i in 1:NROW(countriesTBCF)) {
        tmp = dataset[dataset[, yearCol] >= countriesTBCF[i, refYearCol] & 
                        dataset[, countryCodeCol] %in% countriesTBCF[i, countryCodeCol], 
                      c(countryCodeCol, yearCol, varOrig)]
        if (NROW(tmp) != 0 & NROW(na.omit(tmp)) != 0) {
          tmp = na.locf(tmp)
          colnames(tmp) = c(countryCodeCol, yearCol, "new")
          dataset = merge(dataset, tmp, by = c(countryCodeCol, yearCol), all.x = TRUE)
          dataset[is.na(dataset[, varOrig]), varOrig] = 
            dataset[is.na(dataset[, varOrig]), "new"]
          dataset = dataset[, -grep("new", colnames(dataset))]        
        }
      }
    }
    dataset
  }