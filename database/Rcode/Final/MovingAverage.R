##' Construct a running mean
##'
##' A function for constructing running mean variables. 
##'
##' @param dataset The data frame containing the data \code{dataset}.
##' @param origVar The variable in which the mean is to be calculated 
##' \code{origVar}.
##' @param newVarName The name assigned to the new variable \code{newVarName}.
##' @param countryCol The variable containing the country code \code{countryCol}.
##' @param k The period for the mean to be calculated \code{n}.
##' @param weightVar The weighting variable \code{weightVar}.
##' @param yearCol The column name where year is contained.
##' @param align In which year store the value (first, middel, last).
##' 
##' @return A data frame containing the computed running mean.
##' @export
##' 
##' @examples
##' test.df = data.frame(FAOST_CODE = rep(c(1, 5000), each = 10),
##'                      Year = rep(1990:1999, 2),
##'                      a = c(1:4,NA,NA,7:10,1:9,NA), 
##'                      b = c(rep(c(20,40,30,50,10), 3), NA, NA, 30,50,NA))
##' MovingAverage(dataset = test.df, origVar = "a", newVarName = "averageA", k = 1)
##' MovingAverage(dataset = test.df, origVar = "b", newVarName = "averageA", k = 2)
##' MovingAverage(dataset = test.df, origVar = "a", weightVar="b",
##'               newVarName = "averageAB", k = 2)

MovingAverage <- 
  function(dataset, countryCol = "FAOST_CODE", yearCol = "Year", origVar, newVarName, 
           weightVar = NULL, k = 3, align = c("right", "center", "left")) {
  if (missing(dataset)) stop ("Dataset is missing.")
  if (missing(origVar)) stop ("Original variable is missing.")
  if (missing(newVarName)) stop ("New variable name is missing.")
  align <- match.arg(align)
  if(!is.data.table(dataset)) dataset <- data.table(dataset)
  if (is.null(weightVar)) {
    ## Simple mean
    dataset[, eval(newVarName) := 
              rollapply(.SD, FUN = mean, width = k, align = align, fill = NA), 
            by = c(countryCol), .SDcols = c(origVar)]
  } else {
    ## Weighted mean
    dataset[, prod := 
              dataset[, eval(parse(text = origVar))] * dataset[, eval(parse(text = weightVar))]]
    dataset[, numerator := 
              rollapply(.SD, FUN = sum, width = k, align = align, fill = NA), 
            by = c(countryCol), .SDcols = c("prod")]
    dataset[, denominator := 
              rollapply(.SD, FUN = sum, width = k, align = align, fill = NA), 
            by = c(countryCol), .SDcols = c(weightVar)]
    dataset[, eval(newVarName) := numerator / denominator]
    dataset[, c("prod", "numerator", "denominator") := NULL]
  }
  data.frame(dataset)
}

