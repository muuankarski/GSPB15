##############################################################################
## GSYB15: MAPS part 4
##############################################################################

# Colors part 4 -----------------------------------------------------------


colPart4 <- plot_colors(part = 4, 12)
col.main1 <- colPart4[["Main"]][1]
## color for the grid
col.main2 <- colPart4[["Main"]][2]
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
## LAND
###########################################################################


# M.P4.LAND.1.6 -----------------------------------------------------------
# Rural population, share of total population

## Map info
mapInfo <- map_info(mapName = "M.P4.LAND.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName,
       meta_plot_map()
)
## export the map
export_map(manual_text = "This is LAND")


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
