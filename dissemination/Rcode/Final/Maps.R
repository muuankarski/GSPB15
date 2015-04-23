###########################################################################
## Maps ICN2 Statistical Pocketbook 2014
###########################################################################

###########################################################################
## Setting
###########################################################################

# Colors part 1 -----------------------------------------------------------

colPart1 <- plot_colors(part = 1, 12)
col.main1 <- colPart1[["Main"]][1]
## color for the grid
col.main2 <- colPart1[["Main"]][2]
source("./dissemination/Rcode/Final/theme_functions/theme.R")
theme_update(panel.grid.major = element_blank(),## no grid
             legend.text = element_text(size = 16, lineheight = 0.7)) ## increase the text size for legend

source('./dissemination/Rcode/Final/plot_functions/plot_map.R', echo=TRUE)
source('./dissemination/Rcode/Final/plot_functions/exp_map.R', echo=TRUE)
source('./dissemination/Rcode/Final/plot_functions/sources.R', echo=TRUE)

meta_plot_map <- function() {
  
  plot_map(shpFile = shpLocation,
           var = mapInfo$mapVariable,
           data = mapInfo$mapData,
           countryCode = mapCountryCode,
           missCol = NAdataColor,
           scale = mapInfo$mapScaling,
           style = classIntAlg,
           col = mapInfo$mapColors,
           #                 manualBreaks = c(0, 1000, 3500, 6500, 14500, 100000),
           #                 countryCodeTransp = transpCountries[, "FAO_CODE"],
           subset = eval(parse(text = "Year %in% c(mapInfo$mapYear) &
                                    Area %in% c(mapInfo$mapArea)"))
  )
}


export_map <- function(manual_text = "Default map caption") {
  exp_map(output = mapsOutput, mapName = mapInfo$mapName, # this one comes from complementary scripts
          width = mapWidth, height = mapHeight)
  ## embed font
  embed_fonts(paste(mapsOutput, mapInfo$mapName, ".pdf", sep = ""))
  
  ## caption
  captions(objectName = mapInfo$mapName, output = captionsOutput)
  ## source
  sources(output = sourcesOutput, objectName = mapInfo$mapName, manual = manual_text)
}


# M.P1.IAF.1.6 ------------------------------------------------------------

## Map info
mapInfo <- 
  map_info(mapName = "M.P1.IAF.1.6", data = icn2Maps.df, mapArea = "Territory")
mapInfo[["mapData"]][, "AV3YPOU.DISS"] <- 
  gsub("<5.0", "0.1", mapInfo[["mapData"]][, "AV3YPOU.DISS"])
mapInfo[["mapData"]][, "AV3YPOU.DISS"] <- 
  as.numeric(mapInfo[["mapData"]][, "AV3YPOU.DISS"])
dvdCountries <-
  subset(FAOcountryProfile, 
         SOFI_DVDDVG_REG == "Developed countries" & 
           !is.na(SOFI_DVDDVG_REG))[, c("FAOST_CODE", "FAO_TABLE_NAME")]
mapInfo[["mapData"]][mapInfo[["mapData"]][, "FAO_CODE"] %in% 
                       dvdCountries[, "FAOST_CODE"], "AV3YPOU.DISS"] <- 0.1

## Create the map
assign(mapInfo$mapName,
       plot_map(shpFile = shpLocation,
                var = mapInfo$mapVariable,
                data = mapInfo$mapData,
                countryCode = mapCountryCode,
                missCol = NAdataColor,
                scale = mapInfo$mapScaling,
                style = classIntAlg,
                col = mapInfo$mapColors,
                manualBreaks = c(0, 5, 15, 25, 35, 100),
                #                 countryCodeTransp = transpCountries[, "FAO_CODE"],
                subset = eval(parse(text = "Year %in% c(mapInfo$mapYear) &
                                    Area %in% c(mapInfo$mapArea)")))
)
## export the map
export_map(manual_text = "Prevalence of people undernourished (percent, 2012-14)")


# # M.P1.IAF.1.7 ------------------------------------------------------------
# 
# ## Map info
# mapInfo <- 
#   map_info(mapName = "M.P1.IAF.1.7", data = icn2Maps.df, mapArea = "RAFterritory")
# mapInfo[["mapData"]][, "AV3YPOU.DISS"] <- 
#   gsub("<5.0", "0.1", mapInfo[["mapData"]][, "AV3YPOU.DISS"])
# mapInfo[["mapData"]][, "AV3YPOU.DISS"] <- 
#   as.numeric(mapInfo[["mapData"]][, "AV3YPOU.DISS"])
# dvdCountries <-
#   subset(FAOcountryProfile, 
#          SOFI_DVDDVG_REG == "Developed countries" & 
#            !is.na(SOFI_DVDDVG_REG))[, c("FAOST_CODE", "FAO_TABLE_NAME")]
# mapInfo[["mapData"]][mapInfo[["mapData"]][, "FAO_CODE"] %in% 
#                        dvdCountries[, "FAOST_CODE"], "AV3YPOU.DISS"] <- 0.1
# 
# ## Create the map
# assign(mapInfo$mapName,
#        plot_map(shpFile = shpLocation,
#                 var = mapInfo$mapVariable,
#                 data = mapInfo$mapData,
#                 countryCode = mapCountryCode,
#                 missCol = NAdataColor,
#                 scale = mapInfo$mapScaling,
#                 style = classIntAlg,
#                 col = mapInfo$mapColors,
#                 manualBreaks = c(0, 5, 15, 25, 35, 100),
#                 #                 countryCodeTransp = transpCountries[, "FAO_CODE"],
#                 subset = eval(parse(text = "Year %in% c(mapInfo$mapYear) &
#                                     Area %in% c(mapInfo$mapArea)")))
# )
# ## export the map
# export_map(manual_text = "Prevalence of people undernourished (percent, 2012-14)")
# 
