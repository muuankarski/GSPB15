PACKAGES <- c("knitr","Rcpp","ggplot2","devtools",
              "tidyr","dplyr","knitr","reshape2","data.table",
              "rgdal","zoo","plyr","scales","sp","maptools",
              "extrafont","xtable","mapproj","rgeos")
#  Install packages
inst <- match(PACKAGES, .packages(all=TRUE))
need <- which(is.na(inst))
if (length(need) > 0) install.packages(PACKAGES[need])
# Load packages
lapply(PACKAGES, require, character.only=T)

if (!"FAOSTAT" %in% installed.packages()) {
  install_github(username = "mkao006", repo = "FAOSTATpackage",
                 ref = "master", subdir = "FAOSTAT")
}
if (!"gisfao" %in% installed.packages()) {
  devtools::install_github('UNFAOstatistics/gisfao')
}
