##############################################################################
## GSYB15: MAPS part 2
##############################################################################

# Colors part 2 -----------------------------------------------------------


colPart2 <- plot_colors(part = 2, 12)
col.main1 <- colPart2[["Main"]][1]
## color for the grid
col.main2 <- colPart2[["Main"]][2]
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
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------


###########################################################################
## Availability
###########################################################################


# -----------------------------------------------------------
# Food net per capita production value, 3 year averages 

## Map info
mapInfo <- map_info(mapName = "M.P2.AV.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName,
       meta_plot_map()
)
## export the map
export_map()


###########################################################################
## ACCESS
###########################################################################


# -----------------------------------------------------------
# Road density

## Map info
mapInfo <- map_info(mapName = "M.P2.ACCESS.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName,
       meta_plot_map()
)
## export the map
export_map()



###########################################################################
## WATER
###########################################################################

## Map info
mapInfo <- map_info(mapName = "M.P4.WATER.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName,
       meta_plot_map()
)
## export the map
export_map(manual_text = "This is WATER")



###########################################################################
## ENERGY
###########################################################################

# ## Map info
# mapInfo <- map_info(mapName = "M.P4.ENER.1.6", data = sybMaps.df, mapArea = "Territory")
# ## Create the map
# assign(mapInfo$mapName,
#        meta_plot_map()
# )
# ## export the map
# export_map(manual_text = "This is ENERGY")


###########################################################################
## FORESTRY
###########################################################################

## Map info
mapInfo <- map_info(mapName = "M.P4.FOR.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName,
       meta_plot_map()
)
## export the map
export_map(manual_text = "This is FORESTRY")




###########################################################################
## CLIMATE CHANGE
###########################################################################


## Map info
mapInfo <- map_info(mapName = "M.P4.CC.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName,
       meta_plot_map()
)
## export the map
export_map(manual_text = "This is climate change")
