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
source("./Rcode/Final/theme.R")
theme_update(panel.grid.major = element_blank(),## no grid
             legend.text = element_text(size = 16, lineheight = 0.7)) ## increase the text size for legend

source('~/btsync/fao_sync/GSYB2015/dissemination/Rcode/Final/plot_functions/plot_map.R', echo=TRUE)
source('~/btsync/fao_sync/GSYB2015/dissemination/Rcode/Final/plot_functions/exp_map.R', echo=TRUE)
source('~/btsync/fao_sync/GSYB2015/dissemination/Rcode/Final/plot_functions/sources.R', echo=TRUE)

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

export_map <- function() {
  exp_map(output = mapsOutput, mapName = mapInfo$mapName, # this one comes from complementary scripts
          width = mapWidth, height = mapHeight)
  ## embed font
  embed_fonts(paste(mapsOutput, mapInfo$mapName, ".pdf", sep = ""))
  
  ## caption
  captions(objectName = mapInfo$mapName, output = captionsOutput)
  ## source
  sources(output = sourcesOutput, objectName = mapInfo$mapName)
  
}



# M.P1.ECON.1.6 -----------------------------------------------------------

## Map info
mapInfo <- 
  map_info(mapName = "M.P1.ECON.1.6", data = icn2Maps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName,
       meta_plot_map()
       )
## export the map
export_map()


# M.P1.OVER.1.6 -----------------------------------------------------------

## Map info
mapInfo <- 
  map_info(mapName = "M.P1.OVER.1.6", data = icn2Maps.df, mapArea = "Territory")
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
#                 manualBreaks = c(0, 1000, 3500, 6500, 14500, 100000),
#                 countryCodeTransp = transpCountries[, "FAO_CODE"],
                subset = eval(parse(text = "Year %in% c(mapInfo$mapYear) &
                                    Area %in% c(mapInfo$mapArea)"))) +
         geom_path(data = grat_df_robin, 
                   aes(long, lat, group = group, fill = NULL), 
                   linetype = "dashed", color = col.main2, size = 0.001))
## export the map
exp_map(output = mapsOutput, mapName = mapInfo$mapName,
        width = mapWidth, height = mapHeight)
## embed font
try(embedFonts(paste(mapsOutput, mapInfo$mapName, ".pdf", sep = ""), fontpaths = PTpath))
## caption
captions(objectName = mapInfo$mapName, output = captionsOutput)
# ## source
# sources(output = sourcesOutput, objectName = mapInfo$mapName)

# M.P1.PRICE.1.6 ----------------------------------------------------------

cpi.df <- 
  read.csv("Data/Processed/FAOcpi.csv", header = TRUE, stringsAsFactors = FALSE)
cpi.df <- cpi.df[, c("FAOST_CODE", "Year", "Value")]
cpi.df <- merge(cpi.df, FAOcountryProfile[, c("FAOST_CODE", "SHORT_NAME")],
                by = "FAOST_CODE", all.x = TRUE)
cpi.df[, "Area"] <- "Territory"
colnames(cpi.df)[1] <- "FAO_CODE"
## Map info
mapInfo <- 
  map_info(mapName = "M.P1.PRICE.1.6", data = cpi.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName,
       plot_map(shpFile = shpLocation,
                var = mapInfo$mapVariable,
                data = mapInfo$mapData,
                countryCode = mapCountryCode,
                missCol = NAdataColor,
                scale = mapInfo$mapScaling,
#                 style = cpi.df,
                col = mapInfo$mapColors,
                manualBreaks = c(100, 240, 500, 980, 6110),
#                 countryCodeTransp = transpCountries[, "FAO_CODE"],
                subset = eval(parse(text = "Year %in% c(mapInfo$mapYear) &
                                    Area %in% c(mapInfo$mapArea)"))) +
         geom_path(data = grat_df_robin, 
                   aes(long, lat, group = group, fill = NULL), 
                   linetype = "dashed", color = col.main2, size = 0.001))
## export the map
exp_map(output = mapsOutput, mapName = mapInfo$mapName,
        width = mapWidth, height = mapHeight)
## embed font
try(embedFonts(paste(mapsOutput, mapInfo$mapName, ".pdf", sep = ""), fontpaths = PTpath))
## caption
captions(objectName = mapInfo$mapName, output = captionsOutput)
# ## source
# sources(output = sourcesOutput, objectName = mapInfo$mapName)

# M.P1.TRADE.1.6 ----------------------------------------------------------

## Map info
mapInfo <- 
  map_info(mapName = "M.P1.TRADE.1.6", data = icn2Maps.df, mapArea = "Territory")
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
                #                 manualBreaks = c(0, 1000, 3500, 6500, 14500, 100000),
                #                 countryCodeTransp = transpCountries[, "FAO_CODE"],
                subset = eval(parse(text = "Year %in% c(mapInfo$mapYear) &
                                    Area %in% c(mapInfo$mapArea)"))) +
         geom_path(data = grat_df_robin, 
                   aes(long, lat, group = group, fill = NULL), 
                   linetype = "dashed", color = col.main2, size = 0.001))
## export the map
exp_map(output = mapsOutput, mapName = mapInfo$mapName,
        width = mapWidth, height = mapHeight)
## embed font
try(embedFonts(paste(mapsOutput, mapInfo$mapName, ".pdf", sep = ""), fontpaths = PTpath))
## caption
captions(objectName = mapInfo$mapName, output = captionsOutput)
# ## source
# sources(output = sourcesOutput, objectName = mapInfo$mapName)

###########################################################################
## Malnutrition
###########################################################################

# Colors part 2 -----------------------------------------------------------

colPart1 <- plot_colors(part = 2, 12)
col.main1 <- colPart1[["Main"]][1]
## color for the grid
col.main2 <- colPart1[["Main"]][2]
source("./Rcode/Final/theme.R")
theme_update(panel.grid.major = element_blank(),## no grid
             legend.text = element_text(size = 16, lineheight = 0.7)) ## increase the text size for legend

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
                                    Area %in% c(mapInfo$mapArea)"))) +
         geom_path(data = grat_df_robin, 
                   aes(long, lat, group = group, fill = NULL), 
                   linetype = "dashed", color = col.main2, size = 0.001))
## export the map
exp_map(output = mapsOutput, mapName = mapInfo$mapName,
        width = mapWidth, height = mapHeight)
## embed font
try(embedFonts(paste(mapsOutput, mapInfo$mapName, ".pdf", sep = ""), fontpaths = PTpath))
## caption
captions(objectName = mapInfo$mapName, output = captionsOutput, 
         manual = "Prevalence of people undernourished (percent, 2012-14)")
# ## source
# sources(output = sourcesOutput, objectName = mapInfo$mapName)

# M.P1.UT.1.7 -------------------------------------------------------------

## Map info
mapInfo <- 
  map_info(mapName = "M.P1.UT.1.7", data = icn2Maps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName,
       plot_map(shpFile = shpLocation,
                var = mapInfo$mapVariable,
                data = mapInfo$mapData,
                countryCode = mapCountryCode,
                missCol = NAdataColor,
                scale = mapInfo$mapScaling,
#                 style = classIntAlg,
                col = mapInfo$mapColors,
                manualBreaks = c(5, 20, 35, 45, 65, 90),
#                 countryCodeTransp = transpCountries[, "FAO_CODE"],
                subset = eval(parse(text = "Year %in% c(mapInfo$mapYear) &
                                    Area %in% c(mapInfo$mapArea)"))) +
         geom_path(data = grat_df_robin, 
                   aes(long, lat, group = group, fill = NULL), 
                   linetype = "dashed", color = col.main2, size = 0.001))
## export the map
exp_map(output = mapsOutput, mapName = mapInfo$mapName,
        width = mapWidth, height = mapHeight)
## embed font
try(embedFonts(paste(mapsOutput, mapInfo$mapName, ".pdf", sep = ""), fontpaths = PTpath))
## caption
captions(objectName = mapInfo$mapName, output = captionsOutput)
# ## source
# sources(output = sourcesOutput, objectName = mapInfo$mapName)

# M.P1.OO.1.6 -------------------------------------------------------------

## Map info
mapInfo <- 
  map_info(mapName = "M.P1.OO.1.6", data = icn2Maps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName,
       plot_map(shpFile = shpLocation,
                var = mapInfo$mapVariable,
                data = mapInfo$mapData,
                countryCode = mapCountryCode,
                missCol = NAdataColor,
                scale = mapInfo$mapScaling,
#                 style = classIntAlg,
                col = mapInfo$mapColors,
#                 manualBreaks = c(7.4, 1000, 3500, 6500, 14500, 100000),
#                 countryCodeTransp = transpCountries[, "FAO_CODE"],
                subset = eval(parse(text = "Year %in% c(mapInfo$mapYear) &
                                    Area %in% c(mapInfo$mapArea)"))) +
         geom_path(data = grat_df_robin, 
                   aes(long, lat, group = group, fill = NULL), 
                   linetype = "dashed", color = col.main2, size = 0.001))
## export the map
exp_map(output = mapsOutput, mapName = mapInfo$mapName,
        width = mapWidth, height = mapHeight)
## embed font
try(embedFonts(paste(mapsOutput, mapInfo$mapName, ".pdf", sep = ""), fontpaths = PTpath))
## caption
captions(objectName = mapInfo$mapName, output = captionsOutput)
# ## source
# sources(output = sourcesOutput, objectName = mapInfo$mapName)

###########################################################################
## Diets
###########################################################################

# Colors part 3 -----------------------------------------------------------

colPart1 <- plot_colors(part = 3, 12)
col.main1 <- colPart1[["Main"]][1]
## color for the grid
col.main2 <- colPart1[["Main"]][2]
source("./Rcode/Final/theme.R")
theme_update(panel.grid.major = element_blank(),## no grid
             legend.text = element_text(size = 16, lineheight = 0.7)) ## increase the text size for legend

# M.P1.DES.1.6 ------------------------------------------------------------

## Map info
mapInfo <- 
  map_info(mapName = "M.P1.DES.1.6", data = icn2Maps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName,
       plot_map(shpFile = shpLocation,
                var = mapInfo$mapVariable,
                data = mapInfo$mapData,
                countryCode = mapCountryCode,
                missCol = NAdataColor,
                scale = mapInfo$mapScaling,
#                 style = classIntAlg,
                col = mapInfo$mapColors,
#                 manualBreaks = c(0, 1900, 3500, 6500, 14500, 100000),
#                 countryCodeTransp = transpCountries[, "FAO_CODE"],
                subset = eval(parse(text = "Year %in% c(mapInfo$mapYear) &
                                    Area %in% c(mapInfo$mapArea)"))) +
         geom_path(data = grat_df_robin, 
                   aes(long, lat, group = group, fill = NULL), 
                   linetype = "dashed", color = col.main2, size = 0.001))
## export the map
exp_map(output = mapsOutput, mapName = mapInfo$mapName,
        width = mapWidth, height = mapHeight)
## embed font
try(embedFonts(paste(mapsOutput, mapInfo$mapName, ".pdf", sep = ""), fontpaths = PTpath))
## caption
captions(objectName = mapInfo$mapName, output = captionsOutput, 
         manual = "Dietary energy supply (kcal/cap/day, 2009-11)")
# ## source
# sources(output = sourcesOutput, objectName = mapInfo$mapName)

# M.P1.CRLS.1.6 -----------------------------------------------------------

## Map info
mapInfo <- 
  map_info(mapName = "M.P1.CRLS.1.6", data = icn2Maps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName,
       plot_map(shpFile = shpLocation,
                var = mapInfo$mapVariable,
                data = mapInfo$mapData,
                countryCode = mapCountryCode,
                missCol = NAdataColor,
                scale = mapInfo$mapScaling,
#                 style = classIntAlg,
                col = mapInfo$mapColors,
                manualBreaks = c(18, 30, 40, 51, 65, 78),
#                 countryCodeTransp = transpCountries[, "FAO_CODE"],
                subset = eval(parse(text = "Year %in% c(mapInfo$mapYear) &
                                    Area %in% c(mapInfo$mapArea)"))) +
         geom_path(data = grat_df_robin, 
                   aes(long, lat, group = group, fill = NULL), 
                   linetype = "dashed", color = col.main2, size = 0.001))
## export the map
exp_map(output = mapsOutput, mapName = mapInfo$mapName,
        width = mapWidth, height = mapHeight)
## embed font
try(embedFonts(paste(mapsOutput, mapInfo$mapName, ".pdf", sep = ""), fontpaths = PTpath))
## caption
captions(objectName = mapInfo$mapName, output = captionsOutput,
         manual = "Share of DES from cereals (percent, 2009-11)")
# ## source
# sources(output = sourcesOutput, objectName = mapInfo$mapName)

# M.P1.SR.1.6 -------------------------------------------------------------

## Map info
mapInfo <- 
  map_info(mapName = "M.P1.SR.1.6", data = icn2Maps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName,
       plot_map(shpFile = shpLocation,
                var = mapInfo$mapVariable,
                data = mapInfo$mapData,
                countryCode = mapCountryCode,
                missCol = NAdataColor,
                scale = mapInfo$mapScaling,
#                 style = classIntAlg,
                col = mapInfo$mapColors,
                manualBreaks = c(0, 4.5, 9, 17, 24, 40),
#                 countryCodeTransp = transpCountries[, "FAO_CODE"],
                subset = eval(parse(text = "Year %in% c(mapInfo$mapYear) &
                                    Area %in% c(mapInfo$mapArea)"))) +
         geom_path(data = grat_df_robin, 
                   aes(long, lat, group = group, fill = NULL), 
                   linetype = "dashed", color = col.main2, size = 0.001))
## export the map
exp_map(output = mapsOutput, mapName = mapInfo$mapName,
        width = mapWidth, height = mapHeight)
## embed font
try(embedFonts(paste(mapsOutput, mapInfo$mapName, ".pdf", sep = ""), fontpaths = PTpath))
## caption
captions(objectName = mapInfo$mapName, output = captionsOutput,
         manual = "Share of DES from starchy roots (percent, 2009-11)")
# ## source
# sources(output = sourcesOutput, objectName = mapInfo$mapName)

# M.P1.SS.1.6 -------------------------------------------------------------

## Map info
mapInfo <- 
  map_info(mapName = "M.P1.SS.1.6", data = icn2Maps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName,
       plot_map(shpFile = shpLocation,
                var = mapInfo$mapVariable,
                data = mapInfo$mapData,
                countryCode = mapCountryCode,
                missCol = NAdataColor,
                scale = mapInfo$mapScaling,
#                 style = classIntAlg,
                col = mapInfo$mapColors,
                manualBreaks = c(0, 5, 8.5, 11, 15, 21),
#                 countryCodeTransp = transpCountries[, "FAO_CODE"],
                subset = eval(parse(text = "Year %in% c(mapInfo$mapYear) &
                                    Area %in% c(mapInfo$mapArea)"))) +
         geom_path(data = grat_df_robin, 
                   aes(long, lat, group = group, fill = NULL), 
                   linetype = "dashed", color = col.main2, size = 0.001))
## export the map
exp_map(output = mapsOutput, mapName = mapInfo$mapName,
        width = mapWidth, height = mapHeight)
## embed font
try(embedFonts(paste(mapsOutput, mapInfo$mapName, ".pdf", sep = ""), fontpaths = PTpath))
## caption
captions(objectName = mapInfo$mapName, output = captionsOutput,
         manual = "Share of DES from sugar and sweeteners (percent, 2009-11)")
# ## source
# sources(output = sourcesOutput, objectName = mapInfo$mapName)

# M.P1.FV.1.6 ------------------------------------------------------------

## Map info
mapInfo <- 
  map_info(mapName = "M.P1.FV.1.6", data = icn2Maps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName,
       plot_map(shpFile = shpLocation,
                var = mapInfo$mapVariable,
                data = mapInfo$mapData,
                countryCode = mapCountryCode,
                missCol = NAdataColor,
                scale = mapInfo$mapScaling,
                #                 style = classIntAlg,
                col = mapInfo$mapColors,
                manualBreaks = c(0, 3.5, 6.5, 9, 13, 20),
                #                 countryCodeTransp = transpCountries[, "FAO_CODE"],
                subset = eval(parse(text = "Year %in% c(mapInfo$mapYear) &
                                    Area %in% c(mapInfo$mapArea)"))) +
         geom_path(data = grat_df_robin, 
                   aes(long, lat, group = group, fill = NULL), 
                   linetype = "dashed", color = col.main2, size = 0.001))
## export the map
exp_map(output = mapsOutput, mapName = mapInfo$mapName,
        width = mapWidth, height = mapHeight)
## embed font
try(embedFonts(paste(mapsOutput, mapInfo$mapName, ".pdf", sep = ""), fontpaths = PTpath))
## caption
captions(objectName = mapInfo$mapName, output = captionsOutput,
         manual = "Share of DES from fruit and vegetables (percent, 2009-11)")
# ## source
# sources(output = sourcesOutput, objectName = mapInfo$mapName)

# M.P1.MEAT.1.6 -----------------------------------------------------------

## Map info
mapInfo <- 
  map_info(mapName = "M.P1.MEAT.1.6", data = icn2Maps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName,
       plot_map(shpFile = shpLocation,
                var = mapInfo$mapVariable,
                data = mapInfo$mapData,
                countryCode = mapCountryCode,
                missCol = NAdataColor,
                scale = mapInfo$mapScaling,
#                 style = classIntAlg,
                col = mapInfo$mapColors,
                manualBreaks = c(0, 5, 10, 12, 16, 23),
#                 countryCodeTransp = transpCountries[, "FAO_CODE"],
                subset = eval(parse(text = "Year %in% c(mapInfo$mapYear) &
                                    Area %in% c(mapInfo$mapArea)"))) +
         geom_path(data = grat_df_robin, 
                   aes(long, lat, group = group, fill = NULL), 
                   linetype = "dashed", color = col.main2, size = 0.001))
## export the map
exp_map(output = mapsOutput, mapName = mapInfo$mapName,
        width = mapWidth, height = mapHeight)
## embed font
try(embedFonts(paste(mapsOutput, mapInfo$mapName, ".pdf", sep = ""), fontpaths = PTpath))
## caption
captions(objectName = mapInfo$mapName, output = captionsOutput,
         manual = "Share of DES from meat (percent, 2009-11)")
# ## source
# sources(output = sourcesOutput, objectName = mapInfo$mapName)

# M.P1.OCRPS.1.6 ----------------------------------------------------------

## Map info
mapInfo <- 
  map_info(mapName = "M.P1.OCRPS.1.6", data = icn2Maps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName,
       plot_map(shpFile = shpLocation,
                var = mapInfo$mapVariable,
                data = mapInfo$mapData,
                countryCode = mapCountryCode,
                missCol = NAdataColor,
                scale = mapInfo$mapScaling,
#                 style = classIntAlg,
                col = mapInfo$mapColors,
                manualBreaks = c(0, 1, 3.5, 7.7, 13, 21),
#                 countryCodeTransp = transpCountries[, "FAO_CODE"],
                subset = eval(parse(text = "Year %in% c(mapInfo$mapYear) &
                                    Area %in% c(mapInfo$mapArea)"))) +
         geom_path(data = grat_df_robin, 
                   aes(long, lat, group = group, fill = NULL), 
                   linetype = "dashed", color = col.main2, size = 0.001))
## export the map
exp_map(output = mapsOutput, mapName = mapInfo$mapName,
        width = mapWidth, height = mapHeight)
## embed font
try(embedFonts(paste(mapsOutput, mapInfo$mapName, ".pdf", sep = ""), fontpaths = PTpath))
## caption
captions(objectName = mapInfo$mapName, output = captionsOutput,
         manual = "Share of DES from oilcrops (percent, 2009-11)")
# ## source
# sources(output = sourcesOutput, objectName = mapInfo$mapName)

# M.P1.FISH.1.6 -----------------------------------------------------------

## Map info
mapInfo <- 
  map_info(mapName = "M.P1.FISH.1.6", data = icn2Maps.df, mapArea = "Territory")
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
                manualBreaks = c(0, 1, 2, 3.5, 5, 13),
#                 countryCodeTransp = transpCountries[, "FAO_CODE"],
                subset = eval(parse(text = "Year %in% c(mapInfo$mapYear) &
                                    Area %in% c(mapInfo$mapArea)"))) +
         geom_path(data = grat_df_robin, 
                   aes(long, lat, group = group, fill = NULL), 
                   linetype = "dashed", color = col.main2, size = 0.001))
## export the map
exp_map(output = mapsOutput, mapName = mapInfo$mapName,
        width = mapWidth, height = mapHeight)
## embed font
try(embedFonts(paste(mapsOutput, mapInfo$mapName, ".pdf", sep = ""), fontpaths = PTpath))
## caption
captions(objectName = mapInfo$mapName, output = captionsOutput,
         manual = "Share of DES from fish (percent, 2009-11)")
# ## source
# sources(output = sourcesOutput, objectName = mapInfo$mapName)

# M.P1.MEB.1.6 ------------------------------------------------------------

## Map info
mapInfo <- 
  map_info(mapName = "M.P1.MEB.1.6", data = icn2Maps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName,
       plot_map(shpFile = shpLocation,
                var = mapInfo$mapVariable,
                data = mapInfo$mapData,
                countryCode = mapCountryCode,
                missCol = NAdataColor,
                scale = mapInfo$mapScaling,
#                 style = classIntAlg,
                col = mapInfo$mapColors,
                 manualBreaks = c(0, 1, 3, 6, 8.5, 18),
#                 countryCodeTransp = transpCountries[, "FAO_CODE"],
                subset = eval(parse(text = "Year %in% c(mapInfo$mapYear) &
                                    Area %in% c(mapInfo$mapArea)"))) +
         geom_path(data = grat_df_robin, 
                   aes(long, lat, group = group, fill = NULL), 
                   linetype = "dashed", color = col.main2, size = 0.001))
## export the map
exp_map(output = mapsOutput, mapName = mapInfo$mapName,
        width = mapWidth, height = mapHeight)
## embed font
try(embedFonts(paste(mapsOutput, mapInfo$mapName, ".pdf", sep = ""), fontpaths = PTpath))
## caption
captions(objectName = mapInfo$mapName, output = captionsOutput,
         manual = "Share of DES from milk (percent, 2009-11)")
# ## source
# sources(output = sourcesOutput, objectName = mapInfo$mapName)

###########################################################################
## Sustainability
###########################################################################

# Colors part 4 -----------------------------------------------------------

colPart1 <- plot_colors(part = 4, 12)
col.main1 <- colPart1[["Main"]][1]
## color for the grid
col.main2 <- colPart1[["Main"]][2]
source("./Rcode/Final/theme.R")
theme_update(panel.grid.major = element_blank(),## no grid
             legend.text = element_text(size = 16, lineheight = 0.7)) ## increase the text size for legend

# M.P1.WATER.1.6 ----------------------------------------------------------

## Map info
mapInfo <- 
  map_info(mapName = "M.P1.WATER.1.6", data = icn2Maps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName,
       plot_map(shpFile = shpLocation,
                var = mapInfo$mapVariable,
                data = mapInfo$mapData,
                countryCode = mapCountryCode,
                missCol = NAdataColor,
                scale = mapInfo$mapScaling,
#                 style = classIntAlg,
                col = mapInfo$mapColors,
                manualBreaks = c(0, 50, 150, 500, 900, 2500),
#                 countryCodeTransp = transpCountries[, "FAO_CODE"],
                subset = eval(parse(text = "Year %in% c(mapInfo$mapYear) &
                                    Area %in% c(mapInfo$mapArea)"))) +
         geom_path(data = grat_df_robin, 
                   aes(long, lat, group = group, fill = NULL), 
                   linetype = "dashed", color = col.main2, size = 0.001))
## export the map
exp_map(output = mapsOutput, mapName = mapInfo$mapName,
        width = mapWidth, height = mapHeight)
## embed font
try(embedFonts(paste(mapsOutput, mapInfo$mapName, ".pdf", sep = ""), fontpaths = PTpath))
## caption
captions(objectName = mapInfo$mapName, output = captionsOutput)
# ## source
# sources(output = sourcesOutput, objectName = mapInfo$mapName)

# M.P1.GGE.1.6 ------------------------------------------------------------

## Map info
mapInfo <- 
  map_info(mapName = "M.P1.GGE.1.6", data = icn2Maps.df, mapArea = "Territory")
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
                manualBreaks = c(-112, 0, 250, 500, 750, 1375),
#                 countryCodeTransp = transpCountries[, "FAO_CODE"],
                subset = eval(parse(text = "Year %in% c(mapInfo$mapYear) &
                                    Area %in% c(mapInfo$mapArea)"))) +
         geom_path(data = grat_df_robin, 
                   aes(long, lat, group = group, fill = NULL), 
                   linetype = "dashed", color = col.main2, size = 0.001))
## export the map
exp_map(output = mapsOutput, mapName = mapInfo$mapName,
        width = mapWidth, height = mapHeight)
## embed font
try(embedFonts(paste(mapsOutput, mapInfo$mapName, ".pdf", sep = ""), fontpaths = PTpath))
## caption
captions(objectName = mapInfo$mapName, output = captionsOutput)
# ## source
# sources(output = sourcesOutput, objectName = mapInfo$mapName)

# M.P1.ORG.1.6 ------------------------------------------------------------

## Map info
mapInfo <- 
  map_info(mapName = "M.P1.ORG.1.6", data = icn2Maps.df, mapArea = "Territory")
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
                manualBreaks = c(0, 1, 5, 10, 50, 100),
#                 countryCodeTransp = transpCountries[, "FAO_CODE"],
                subset = eval(parse(text = "Year %in% c(mapInfo$mapYear) &
                                    Area %in% c(mapInfo$mapArea)"))) +
         geom_path(data = grat_df_robin, 
                   aes(long, lat, group = group, fill = NULL), 
                   linetype = "dashed", color = col.main2, size = 0.001))
## export the map
exp_map(output = mapsOutput, mapName = mapInfo$mapName,
        width = mapWidth, height = mapHeight)
## embed font
try(embedFonts(paste(mapsOutput, mapInfo$mapName, ".pdf", sep = ""), fontpaths = PTpath))
## caption
captions(objectName = mapInfo$mapName, output = captionsOutput)
# ## source
# sources(output = sourcesOutput, objectName = mapInfo$mapName)
