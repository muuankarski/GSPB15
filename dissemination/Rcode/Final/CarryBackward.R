#' Backward imputation.
#'
#' This function imputes missing values carrying backward the 
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
#' @param countriesTBCB The data frame containing: the 'year' to be taken
#' for backward imputation; the 'country code' written in strings like 
#' "255,256" indicating the countries to be imputed \code{countriesTBCB}.
#' @param refYearCol The column of the data frame containing the reference
#' year to carry backward the value \code{refYearCol}.
#' 
#' @return The original data frame containing the imputed values.
#' 
#' @export
#' 
#' @examples
#' test.df = data.frame(FAOST_CODE = rep(c(1,2,3), each = 11), 
#'                      Year = rep(2000:2010, times = 3), 
#'                      VariableTBI = rep(c(NA, NA, 1:7, NA, NA), times = 3))
#' CarryBackward(dataset = test.df, countryCodeCol = "FAOST_CODE", 
#'               yearCol = "Year", varOrig = "VariableTBI")
#' countriesTBCB = 
#'   data.frame(FAOST_CODE = c(1,3), NAME = c("Country1", "Country2"),
#'              REF_YEAR = c(2002))
#' CarryBackward(dataset = test.df, countryCodeCol = "FAOST_CODE", 
#'               yearCol = "Year", varOrig = "VariableTBI",
#'               countriesTBCB = countriesTBCB, refYearCol = "REF_YEAR")

CarryBackward = 
  function(dataset, countryCodeCol = "FAOST_CODE", yearCol = "Year",  
           varOrig, countriesTBCB, refYearCol) {
    dataset = arrange(dataset, eval(parse(text = countryCodeCol)), 
                      eval(parse(text = yearCol)))   
    if (missing(countriesTBCB)) {
      ## The countries to be carried backward have not been specified.
      my.parse <- parse(text = varOrig)
      curenv <<- environment()
      dataset = ddply(dataset, countryCodeCol, transform, 
                      new = na.locf(eval(get("my.parse", envir = curenv)), 
                                    fromLast = TRUE, na.rm = FALSE))
      dataset[is.na(dataset[, varOrig]), varOrig] = 
        dataset[is.na(dataset[, varOrig]), "new"]
      dataset = dataset[, -grep("new", colnames(dataset))]
    } else {
      ## The countries to be carried backward have been specified.
      for (i in 1:NROW(countriesTBCB)) {
        tmp = dataset[dataset[, yearCol] <= countriesTBCB[i, refYearCol] & 
                        dataset[, countryCodeCol] %in% countriesTBCB[i, countryCodeCol], 
                      c(countryCodeCol, yearCol, varOrig)]
        if (NROW(tmp) != 0 & NROW(na.omit(tmp)) != 0) {
          tmp = na.locf(tmp, fromLast = TRUE, na.rm = FALSE)
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