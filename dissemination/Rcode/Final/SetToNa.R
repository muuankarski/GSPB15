##' Set to values to NA.
##'
##' This function set to NA the values for the specified countries and years.
##' If 'year' is not specified, it sets to NA all the values for the specified
##' countries and variable.
##'
##' @param dataset The dataset \code{dataset}.
##' @param origVar The variable for which values need to be set to NA 
##' \code{origVar}.
##' @param countryCol The column of the dataset containing the country
##' ID \code{countryCol}.
##' @param yearCol The column of the dataset containing the year
##' \code{yearCol}.
##' @param countryCode The countries for which values need to be
##' replaced \code{countryCode}.
##' @param year The year for which values need to be replaced 
##' \code{year}.
##' @param afterYear The year after which values need to be replaced 
##' \code{afterYear}.
##' @param beforeYear The year for before which values need to be replaced 
##' \code{beforeYear}.
##' 
##' @return The dataset with imputed values.
##' 
##' @export

SetToNA = function(dataset, origVar, countryCol = "FAOST_CODE", 
                   yearCol = "Year", countryCode, year = NULL,
                   afterYear = NULL, beforeYear = NULL){
  if (is.null(year)) {
    if (!is.null(afterYear)) {
      for (i in 1:length(countryCode)) {
        dataset[dataset[, countryCol] %in% countryCode[i] &
                  dataset[, yearCol] > afterYear[i], origVar] = NA
      }
    } else {
      if (!is.null(beforeYear)) {
        for (i in 1:length(countryCode)) {
          dataset[dataset[, countryCol] %in% countryCode[i] &
                    dataset[, yearCol] < beforeYear[i], origVar] = NA
        }
      } else {
        dataset[dataset[, countryCol] %in% countryCode, origVar] = NA
      }
    }
  } else {
    for (i in 1:length(countryCode)) {
      dataset[dataset[, countryCol] %in% countryCode[i] &
                dataset[, yearCol] %in% year[i], origVar] = NA
    }
  }
  dataset
}