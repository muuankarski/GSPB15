##' Fill a two year hole left by the moving average function.
##'
##' When a moving average is computed a problem arises with those countries
##' that changed the composition over the years. For example, usually we have
##' data for Serbia and Montenegro together up to 2005, then we have data for
##' these two countries separated. When we compute a moving average (let's 
##' take for example a three years moving average) we will have data up to 
##' 2005 for Serbia and Montenegro, then a two years hole (the result of an
##' average with NA values is NA), then again data for the two countries. 
##' This problem does not concern the dissemination side, keep the two years
##' hole would be correct. The problem is on the aggregation side. If we
##' do not fill this hole there would be a jump in the aggregates. Therefore,
##' we absolutely need to fill this hole. Then, if we do not want to
##' disseminate the imputed values, we can always remove them after the 
##' aggregation step.
##' 
##' The imputation is quite simple. The values of the original variable are
##' used to replace the NA values of the moving avererage variable. In the
##' previous example, 2005 and 2006 for Serbia and for Montenegro for the
##' moving average variable are imputed using 2005 and 2006 for Serbia and
##' for Montenegro of the non-moving average variable.
##'
##' @param dataset The dataset \code{dataset}.
##' @param fromVar The variable from which values need to be taken 
##' \code{fromVar}.
##' @param toVar The variable to which values need to be assigned 
##' \code{toVar}.
##' @param countryCol The column of the dataset containing the country
##' ID \code{countryCol}.
##' @param yearCol The column of the dataset containing the year
##' \code{yearCol}.
##' @param countryCode The countries for which values need to be
##' replaced \code{countryCode}.
##' @param year The year for which values need to be replaced 
##' \code{year}.
##' 
##' @return The dataset with imputed values.
##' 
##' @export

ReplaceValue = function(dataset, fromVar, toVar, countryCol = "FAOST_CODE", 
                      yearCol = "Year", countryCode, year){
  for (i in 1:length(countryCode)) {
    dataset[dataset[, countryCol] %in% countryCode[i] &
              dataset[, yearCol] %in% year[i], toVar] =
      dataset[dataset[, countryCol] %in% countryCode[i] &
                dataset[, yearCol] %in% year[i], fromVar]
  }
  dataset
}