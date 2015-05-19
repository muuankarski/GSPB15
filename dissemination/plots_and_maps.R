###########################################################################
## GSYB15: Plots and maps for GSPB2015
###########################################################################

source("./dissemination/Rcode/Final/plot_functions/plot_setup.R")

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# @@@@@@@@@@@@@@@@@@@@@@@'~~~     ~~~`@@@@@@@@@@@@@@@@@@@@@@@@@
# @@@@@@@@@@@@@@@@@@'                     `@@@@@@@@@@@@@@@@@@@@
# @@@@@@@@@@@@@@@'                           `@@@@@@@@@@@@@@@@@
# @@@@@@@@@@@@@'                               `@@@@@@@@@@@@@@@
# @@@@@@@@@@@'                                   `@@@@@@@@@@@@@
# @@@@@@@@@@'                                     `@@@@@@@@@@@@
# @@@@@@@@@'                                       `@@@@@@@@@@@
# @@@@@@@@@                                         @@@@@@@@@@@
# @@@@@@@@'                      n,                 `@@@@@@@@@@
# @@@@@@@@                     _/ | _                @@@@@@@@@@
# @@@@@@@@                    /'  `'/                @@@@@@@@@@
# @@@@@@@@a                 <~    .'                a@@@@@@@@@@
# @@@@@@@@@                 .'    |                 @@@@@@@@@@@
# @@@@@@@@@a              _/      |                a@@@@@@@@@@@
# @@@@@@@@@@a           _/      `.`.              a@@@@@@@@@@@@
# @@@@@@@@@@@a     ____/ '   \__ | |______       a@@@@@@@@@@@@@
# @@@@@@@@@@@@@a__/___/      /__\ \ \     \___.a@@@@@@@@@@@@@@@
# @@@@@@@@@@@@@/  (___.'\_______)\_|_|        \@@@@@@@@@@@@@@@@
# @@@@@@@@@@@@|\________                       ~~~~~\@@@@@@@@@@

## Part 1

set_part(part=1)


###########################################################################
## POPULATION
###########################################################################


## ------------------------------------------------------------------------
# World rural and urban population

## Info
plotInfo <- plot_info(plotName = "C.P1.OVER.1.2")
## Create the plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 1, n_colors=2) )
# Export plot
export_plot(manual_text = "World rural and urban population", placement = "tr")


## ------------------------------------------------------------------------
# Annual population growth over the last ten years

## Info
plotInfo <- plot_info(plotName = "C.P1.OVER.1.3")
## Create the plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(manual_text = "Annual population growth over the last ten years", placement="l")


## ------------------------------------------------------------------------
# Life expectancy at birth, countries with the lowest values in 2013

## Info
plotInfo <- plot_info(plotName = "C.P1.OVER.1.4")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=2) )
## Export the plot
export_plot(placement="r")


## ------------------------------------------------------------------------
# Total economically active population

## Info
plotInfo <- plot_info(plotName = "C.P1.OVER.1.5")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=6) )
## Export the plot
export_plot(manual_text = "Total economically active population", placement = "b")


# MAPS -------------------------------------------------------------------
# Rural population, share of total population

## Map info
mapInfo <- map_info(mapName = "M.P1.OVER.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName,meta_plot_map() )
## export the map
export_map()




###########################################################################
## ECONOMY
###########################################################################

## ------------------------------------------------------------------------
# Value added in agriculture, industry, and services as shares of GDP

## Info
plotInfo <- plot_info(plotName = "C.P1.ECON.1.2")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=3) )
## Export the plot
export_plot(manual_text = "Value added in agriculture, industry, and services as shares of GDP", placement = "tr")


## ------------------------------------------------------------------------
# Agriculture value added per worker, countries with the highest values in 2013

## Info
plotInfo <- plot_info(plotName = "C.P1.ECON.1.3")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(manual_text = "Agriculture value added per worker, countries with the highest values in 2013", placement="l")

# C.P1.ECON.1.4 -----------------------------------------------------------
# Annual value added in agriculture growth

## Info
plotInfo <- plot_info(plotName = "C.P1.ECON.1.4")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(placement="r")


# C.P1.ECON.1.5 -----------------------------------------------------------
# Annual value added in agriculture growth

## Info
plotInfo <- plot_info(plotName = "C.P1.ECON.1.5")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=6) )
## Export the plot
export_plot(manual_text = "Annual value added in agriculture growth", placement="b")

## ------------------------------------------------------------------------
# MAPS

# Value added in agriculture as share of GDP

## Map info
mapInfo <- map_info(mapName = "M.P1.ECON.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName,meta_plot_map() )
## export the map
export_map()

###########################################################################
## Labour
###########################################################################

## ------------------------------------------------------------------------
# Labour force participation rate by gender, ages 15+

## Info
plotInfo <- plot_info(plotName = "C.P1.LABO.1.2")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=2) )
## Export the plot
export_plot(manual_text = "Labour force participation rate by gender, ages 15+", placement = "tr")

## ------------------------------------------------------------------------
# Female employment in agriculture, share of female employment

## Info
plotInfo <- plot_info(plotName = "C.P1.LABO.1.3")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=2) )
## Export the plot
export_plot(manual_text = "Female employment in agriculture, share of female employment", placement = "l")

## ------------------------------------------------------------------------
# Male employment in agriculture, share of male employment

## Info
plotInfo <- plot_info(plotName = "C.P1.LABO.1.4")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=2) )
## Export the plot
export_plot(manual_text = "Male employment in agriculture, share of male employment", placement = "r")

## ------------------------------------------------------------------------
# Children in employment, total

# ## Info
# plotInfo <- plot_info(plotName = "C.P1.LABO.1.5")
# ## Plot
# assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
# ## Export the plot
# export_plot(manual_text = "Children in employment, total", placement = "b")

## ------------------------------------------------------------------------
# MAPS

# Value added in agriculture as share of GDP

## Map info
mapInfo <- map_info(mapName = "M.P1.LABO.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName,meta_plot_map() )
## export the map
export_map()

###########################################################################
## Inputs
###########################################################################

## ------------------------------------------------------------------------
# Fertilizer consumption in nutrients per ha of arable land - WORLD & YEARS

## Info
plotInfo <- plot_info(plotName = "C.P1.INPU.1.2")
## Plot
# assign(plotInfo$plotName,
#        plot_syb(x = plotInfo$xAxis,
#                 y = plotInfo$yAxis,
#                 group = plotInfo$group,
#                 type = plotInfo$plotType,
#                 subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
#                                     Area %in% c(plotInfo$plotArea)")),
#                 data = gsyb15.df,
#                 scale = plotInfo$scaling,
#                 x_lab = plotInfo$xPlotLab,
#                 y_lab = plotInfo$yPlotLab,
#                 legend_lab = subset(meta.lst$FULL,
#                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
#                 col_pallete = plot_colors(part = plotInfo$plotPart, 3)[["Sub"]]
#        )
# )# +
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=3) )
## Export the plot
export_plot(manual_text = "Fertilizer consumption in nutrients per ha of arable land", placement = "tr")

## ------------------------------------------------------------------------
# Fertilizer consumption in nutrients per ha of arable land - REGIONS

## Info
plotInfo <- plot_info(plotName = "C.P1.INPU.1.3")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=3) )
## Export the plot
export_plot(manual_text = "Fertilizer consumption in nutrients per ha of arable land", placement = "l")

## ------------------------------------------------------------------------

# Fertilizer consumption in nutrients per ha of arable land - COUNTRIES

## Info
plotInfo <- plot_info(plotName = "C.P1.INPU.1.4")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(manual_text = "Fertilizer consumption in nutrients per ha of arable land", placement = "r")

## ------------------------------------------------------------------------
# Fertilizer consumption in nutrients per ha of arable land - WORLD & YEARS

## Info
plotInfo <- plot_info(plotName = "C.P1.INPU.1.5")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=3) )
## Export the plot
export_plot(manual_text = "Fertilizer consumption in nutrients per ha of arable land", placement = "b")

## ------------------------------------------------------------------------
# MAPS

# Value added in agriculture as share of GDP

## Map info
mapInfo <- map_info(mapName = "M.P1.INPU.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName,meta_plot_map() )
## export the map
export_map()

###########################################################################
## Investments
###########################################################################

# ## ------------------------------------------------------------------------
# # Varname
# 
# ## Info
# plotInfo <- plot_info(plotName = "C.P1.INV.1.2")
# ## Plot
# assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=3) )
# ## Export the plot
# export_plot(manual_text = "Fertilizer consumption in nutrients per ha of arable land", placement = "tr")
# 
# ## ------------------------------------------------------------------------
# # Varname
# 
# ## Info
# plotInfo <- plot_info(plotName = "C.P1.INV.1.3")
# ## Plot
# assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=3) )
# ## Export the plot
# export_plot(manual_text = "Fertilizer consumption in nutrients per ha of arable land", placement = "l")
# 
# ## ------------------------------------------------------------------------
# 
# # Varname
# 
# ## Info
# plotInfo <- plot_info(plotName = "C.P1.INV.1.4")
# ## Plot
# assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
# ## Export the plot
# export_plot(manual_text = "Fertilizer consumption in nutrients per ha of arable land", placement = "r")
# 
# ## ------------------------------------------------------------------------
# # Varname
# 
# ## Info
# plotInfo <- plot_info(plotName = "C.P1.INV.1.5")
# ## Plot
# assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=3) )
# ## Export the plot
# export_plot(manual_text = "Fertilizer consumption in nutrients per ha of arable land", placement = "b")

## ------------------------------------------------------------------------
# MAPS

# Share of Government Expenditures on Agriculture (% of Total Outlays)

## Map info
mapInfo <- map_info(mapName = "M.P1.INV.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName,meta_plot_map() )
## export the map
export_map()


# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# @@@@@@@@@@@@@@@@@@@@@@@'~~~     ~~~`@@@@@@@@@@@@@@@@@@@@@@@@@
# @@@@@@@@@@@@@@@@@@'                     `@@@@@@@@@@@@@@@@@@@@
# @@@@@@@@@@@@@@@'                           `@@@@@@@@@@@@@@@@@
# @@@@@@@@@@@@@'                               `@@@@@@@@@@@@@@@
# @@@@@@@@@@@'                                   `@@@@@@@@@@@@@
# @@@@@@@@@@'                                     `@@@@@@@@@@@@
# @@@@@@@@@'                                       `@@@@@@@@@@@
# @@@@@@@@@                                         @@@@@@@@@@@
# @@@@@@@@'                      n,                 `@@@@@@@@@@
# @@@@@@@@                     _/ | _                @@@@@@@@@@
# @@@@@@@@                    /'  `'/                @@@@@@@@@@
# @@@@@@@@a                 <~    .'                a@@@@@@@@@@
# @@@@@@@@@                 .'    |                 @@@@@@@@@@@
# @@@@@@@@@a              _/      |                a@@@@@@@@@@@
# @@@@@@@@@@a           _/      `.`.              a@@@@@@@@@@@@
# @@@@@@@@@@@a     ____/ '   \__ | |______       a@@@@@@@@@@@@@
# @@@@@@@@@@@@@a__/___/      /__\ \ \     \___.a@@@@@@@@@@@@@@@
# @@@@@@@@@@@@@/  (___.'\_______)\_|_|        \@@@@@@@@@@@@@@@@
# @@@@@@@@@@@@|\________                       ~~~~~\@@@@@@@@@@

## Part 2

source("./dissemination/Rcode/Final/plot_functions/plot_setup.R")
set_part(part=2)


###########################################################################
## AVAILABILITY
###########################################################################


# ----------------------------------------------------------------------- #
# Land area

# ## Info
# plotInfo <- plot_info(plotName = "C.P2.LAND.1.2")
# 
# ## Plot
# assign(plotInfo$plotName,
#        plot_syb(x = plotInfo$xAxis,
#                 y = plotInfo$yAxis,
#                 group = plotInfo$group,
#                 type = plotInfo$plotType,
#                 subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
#                                     Area %in% c(plotInfo$plotArea)")),
#                 data = sybdata.df,
#                 scale = plotInfo$scaling,
#                 x_lab = plotInfo$xPlotLab,
#                 y_lab = plotInfo$yPlotLab,
#                 legend_lab = subset(meta.lst$FULL,
#                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
#                 col_pallete = plot_colors(part = plotInfo$plotPart, 3)[["Sub"]]
#        )
# )
# ## Export the plot
# export_plot(manual_text = "This is LAND", placement = "tr")

# ----------------------------------------------------------------------- #
# Energy supply derived from cereals, roots and tubers

## Info
plotInfo <- plot_info(plotName = "C.P2.AV.1.3")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(manual_text = "Energy supply derived from cereals, roots and tubers",placement="l")


# ----------------------------------------------------------------------- #
# Protein supply quantity, grand total, 3 year averages

## Info
plotInfo <- plot_info(plotName = "C.P2.AV.1.4")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=2) )
## Export the plot
export_plot(manual_text = "Protein supply quantity, grand total, 3 year averages",placement="r")


# ----------------------------------------------------------------------- #
# Protein of animal origin, 3 year averages

## Info
plotInfo <- plot_info(plotName = "C.P2.AV.1.5")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(manual_text = "Protein of animal origin, 3 year averages", placement = "b")


# MAPS -----------------------------------------------------
# Food net per capita production value, 3 year averages 

## Map info
mapInfo <- map_info(mapName = "M.P2.AV.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName, meta_plot_map() )
## export the map
export_map()


###########################################################################
## ACCESS
###########################################################################

# ----------------------------------------------------------------------- #
# Depth of food decifit, 3 year averages

## Info
plotInfo <- plot_info(plotName = "C.P2.ACCESS.1.2")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=5) )
## Export the plot
export_plot(manual_text = "Depth of food decifit, 3 year averages",placement="tr")


# ----------------------------------------------------------------------- #
# Domestic food price level index 

## Info
plotInfo <- plot_info(plotName = "C.P2.ACCESS.1.3")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=5) )
## Export the plot
export_plot(manual_text = "Domestic food price level index",placement="l")

# ----------------------------------------------------------------------- #
# Prevalence of food inadequacy, 3 year averages

# FSI variable: "AV3YPoFI.DISS"

# ## Info
# plotInfo <- plot_info(plotName = "C.P2.ACCESS.1.5")
# ## Plot
# assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=3) )
# ## Export the plot
# export_plot(manual_text = "This is LAND", placement = "r")


##### -------------------------------------------------------
# MAPS

# -----------------------------------------------------------
# Road density

## Map info
mapInfo <- map_info(mapName = "M.P2.ACCESS.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName, meta_plot_map() )
## export the map
export_map()

# ----------------------------------------------------------------------- #
# ALTERNATIVE MAP TO ROAD DENSITY
# Prevalence of undernourishment, 3 year averages


###########################################################################
## STABILITY
###########################################################################



###########################################################################
## UTILIZATION
###########################################################################







# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# @@@@@@@@@@@@@@@@@@@@@@@'~~~     ~~~`@@@@@@@@@@@@@@@@@@@@@@@@@
# @@@@@@@@@@@@@@@@@@'                     `@@@@@@@@@@@@@@@@@@@@
# @@@@@@@@@@@@@@@'                           `@@@@@@@@@@@@@@@@@
# @@@@@@@@@@@@@'                               `@@@@@@@@@@@@@@@
# @@@@@@@@@@@'                                   `@@@@@@@@@@@@@
# @@@@@@@@@@'                                     `@@@@@@@@@@@@
# @@@@@@@@@'                                       `@@@@@@@@@@@
# @@@@@@@@@                                         @@@@@@@@@@@
# @@@@@@@@'                      n,                 `@@@@@@@@@@
# @@@@@@@@                     _/ | _                @@@@@@@@@@
# @@@@@@@@                    /'  `'/                @@@@@@@@@@
# @@@@@@@@a                 <~    .'                a@@@@@@@@@@
# @@@@@@@@@                 .'    |                 @@@@@@@@@@@
# @@@@@@@@@a              _/      |                a@@@@@@@@@@@
# @@@@@@@@@@a           _/      `.`.              a@@@@@@@@@@@@
# @@@@@@@@@@@a     ____/ '   \__ | |______       a@@@@@@@@@@@@@
# @@@@@@@@@@@@@a__/___/      /__\ \ \     \___.a@@@@@@@@@@@@@@@
# @@@@@@@@@@@@@/  (___.'\_______)\_|_|        \@@@@@@@@@@@@@@@@
# @@@@@@@@@@@@|\________                       ~~~~~\@@@@@@@@@@

## Part 3

source("./dissemination/Rcode/Final/plot_functions/plot_setup.R")
set_part(part=3)

###########################################################################
## FOOD SUPPLY
###########################################################################

# Lets wait fore the FSI indicators!!!!

# 1. Text
# 2. graph: Protein and fat supply in crops primary equivalent (2000-09), world
# 3. Dietary energy supply, top 20 (2000-02 vs. 2009-11)
# 4. Dietary energy supply, bottom 20 (2000-02 vs. 2009-11)
# 5. Line graph: DES (kcal/cap/day), by region, 2000-2011
# 6. Map: DES (kcal/cap/day), 2009-11


###########################################################################
## Growth in crop production
###########################################################################

# 1. Text
# 2. Chart: fastest growing items between 2000-MRY


# 3. Top 20 crop producing countries (based on crops, gross per capita production), 2000 vs. MRY

## Info
plotInfo <- plot_info(plotName = "C.P1.OVER.1.4")
## Plot

assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = sybdata.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = subset(meta.lst$FULL,
                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
)
## Export the plot
export_plot(placement="l")


# 4. Top 20 food producing countries (based on food, gross per capita production), 2000 vs. MRY

## Info
plotInfo <- plot_info(plotName = "C.P1.OVER.1.4")
## Plot

assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = sybdata.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = subset(meta.lst$FULL,
                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
)
## Export the plot
export_plot(placement="r")

# 5. Bar chart: Growth in cereals production (production, harvested area, yield), world, 2000-MRY


# 6. Map: Crops, gross per capita production (2004-06 = 100)



###########################################################################
## Trends in the crop sector
###########################################################################

# 1. Text:
# 2. Chart: top five items produced in MRY vs. 2000
# 3. Top 20 Rice producing countries per capita, 2000 vs. MRY
# 4. Top 20 maize producing countries per capita, 2000 vs. MRY
# 5. Line chart: yield by region, 2000-MRY
# 6. Map: Cereal producing countries


###########################################################################
## Trends in the livestock sector
###########################################################################

# 1. Text
# 2. Per capita meat production (see chart 72 SYB2013)
# 3. Per capita milk production, top 10 and bottom 10        
# 4.Per capita egg production, top 10 and bottom 10
# 5. Proportional pie charts on pig production, by region, 2000 vs. MRY
# 6. Map: Cattle/buffaloes per sq km


###########################################################################
## Trends in the fisheries sector
###########################################################################

# 1. Text
# 2. Stacked area graph: aquaculture vs. capture production
# 3. 20 countries with highest value of capture production
# 4. 20 countries with highest value of aquaculture production
# 5. State of the world’s fishery stocks (see chart 79 in SYB2013)
# 6. Map: Aquaculture producing countries, MRY (see map 48, WDI)

###########################################################################
## Trade (please see ICN2 publication)
###########################################################################





# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# @@@@@@@@@@@@@@@@@@@@@@@'~~~     ~~~`@@@@@@@@@@@@@@@@@@@@@@@@@
# @@@@@@@@@@@@@@@@@@'                     `@@@@@@@@@@@@@@@@@@@@
# @@@@@@@@@@@@@@@'                           `@@@@@@@@@@@@@@@@@
# @@@@@@@@@@@@@'                               `@@@@@@@@@@@@@@@
# @@@@@@@@@@@'                                   `@@@@@@@@@@@@@
# @@@@@@@@@@'                                     `@@@@@@@@@@@@
# @@@@@@@@@'                                       `@@@@@@@@@@@
# @@@@@@@@@                                         @@@@@@@@@@@
# @@@@@@@@'                      n,                 `@@@@@@@@@@
# @@@@@@@@                     _/ | _                @@@@@@@@@@
# @@@@@@@@                    /'  `'/                @@@@@@@@@@
# @@@@@@@@a                 <~    .'                a@@@@@@@@@@
# @@@@@@@@@                 .'    |                 @@@@@@@@@@@
# @@@@@@@@@a              _/      |                a@@@@@@@@@@@
# @@@@@@@@@@a           _/      `.`.              a@@@@@@@@@@@@
# @@@@@@@@@@@a     ____/ '   \__ | |______       a@@@@@@@@@@@@@
# @@@@@@@@@@@@@a__/___/      /__\ \ \     \___.a@@@@@@@@@@@@@@@
# @@@@@@@@@@@@@/  (___.'\_______)\_|_|        \@@@@@@@@@@@@@@@@
# @@@@@@@@@@@@|\________                       ~~~~~\@@@@@@@@@@

## Part 4

source("./dissemination/Rcode/Final/plot_functions/plot_setup.R")
set_part(part=4)

###########################################################################
## LAND
###########################################################################


# ----------------------------------------------------------------------- #
# Land area

## Info
plotInfo <- plot_info(plotName = "C.P4.LAND.1.2")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=3) )
## Export the plot
export_plot(manual_text = "Land area", placement = "tr")

# ----------------------------------------------------------------------- #
# Arable land per capita, top 20 countries

## Info
plotInfo <- plot_info(plotName = "C.P4.LAND.1.3")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(manual_text = "Arable land per capita, top 20 countries",placement="l")

# ----------------------------------------------------------------------- #
# Arable land per capita, bottom 20 countries
## Info
plotInfo <- plot_info(plotName = "C.P4.LAND.1.4")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(manual_text = "Arable land per capita, bottom 20 countries",placement="r")

# ----------------------------------------------------------------------- #
# Agricultural area

## Info
plotInfo <- plot_info(plotName = "C.P4.LAND.1.5")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=3) )
## Export the plot
export_plot(manual_text = "Agricultural area", placement = "b")


# MAPS -----------------------------------------------------------
# Cropland per capita

## Map info
mapInfo <- map_info(mapName = "M.P4.LAND.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName, meta_plot_map() )
## export the map
export_map()


###########################################################################
## WATER
###########################################################################

# ----------------------------------------------------------------------- #
# Total water withdrawal per capita, highest 20

## Info
plotInfo <- plot_info(plotName = "C.P4.WATER.1.3")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(manual_text = "Total water withdrawal per capita, highest 20",placement="l")

# ----------------------------------------------------------------------- #
# Freshwater withdrawal by agricultural sector, share of total, highest 20

## Info
plotInfo <- plot_info(plotName = "C.P4.WATER.1.4")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(manual_text = "Freshwater withdrawal by agricultural sector, share of total, highest 20",placement="r")

# ----------------------------------------------------------------------- #
# Saline soils ????

# ## Info
# plotInfo <- plot_info(plotName = "C.P4.LAND.1.5")
# ## Plot
# assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=3) )
# ## Export the plot
# export_plot(manual_text = "Saline soils ????", placement = "b")


# MAPS -----------------------------------------------------------
# Freshwater resources withdrawn by agriculture

## Map info
mapInfo <- map_info(mapName = "M.P4.WATER.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName, meta_plot_map() )
## export the map
export_map()


###########################################################################
## ENERGY
###########################################################################

# WAITING FOR THE DATA

# ----------------------------------------------------------------------- #
# Land area
# 
# ## Info
# plotInfo <- plot_info(plotName = "C.P4.ENER.1.2")
# ## Plot
# 
# 
# ## Export the plot
# export_plot(manual_text = "This is ENER", placement = "tr")

# ----------------------------------------------------------------------- #
# Top 20 biofuel producing countries

# ## Info
# plotInfo <- plot_info(plotName = "C.P4.LAND.1.3")
# ## Plot
# 
# ## Export the plot
# export_plot(manual_text = "This is LAND",placement="l")



###########################################################################
## FORESTRY
###########################################################################

# ----------------------------------------------------------------------- #
# production of select forest product

## Info
plotInfo <- plot_info(plotName = "C.P4.FOR.1.2")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=5) )
## Export the plot
export_plot(manual_text = "production of select forest product", placement = "tr")

# ----------------------------------------------------------------------- #
# Top and bottom 10 exporters of forest products

## Info
plotInfo <- plot_info(plotName = "C.P4.FOR.1.3")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(manual_text = "Top and bottom 10 exporters of forest products",placement="l")


# ----------------------------------------------------------------------- #
# Top and bottom 10 importers of forest products

## Info
plotInfo <- plot_info(plotName = "C.P4.FOR.1.4")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(manual_text = "Top and bottom 10 importers of forest products",placement="r")


# ----------------------------------------------------------------------- #
# Forest characteristics (planted forest, primary forest, and other naturally regenerated forest)

# DATA MISSING!!

# ## Info
# plotInfo <- plot_info(plotName = "C.P4.FOR.1.5")
# ## Plot
# assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=5) )
# ## Export the plot
# export_plot(manual_text = "Forest characteristics (planted forest, primary forest, and other naturally regenerated forest)", placement = "b")

# MAPS  ----------------------------------------------------------------- #
# Forest characteristics (planted forest, primary forest, and other naturally regenerated forest)

## Map info
mapInfo <- map_info(mapName = "M.P4.FOR.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName, meta_plot_map() )
## export the map
export_map()


###########################################################################
## CLIMATE CHANGE
###########################################################################

# ----------------------------------------------------------------------- #
# Greehouse gas emissions, highest in 2012

## Info
plotInfo <- plot_info(plotName = "C.P4.CC.1.3")
# Subset the years manually!!
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(manual_text = "Greehouse gas emissions, highest in 2012",placement="l")


# ----------------------------------------------------------------------- #
# Land use total emissions, highest 20 in 2012

## Info
plotInfo <- plot_info(plotName = "C.P4.CC.1.4")
# Subset the years manually!!
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(manual_text = "Land use total emissions, highest 20 in 2012",placement="l")

# ----------------------------------------------------------------------- #
# Emissions by subsectors

## Info
plotInfo <- plot_info(plotName = "C.P4.CC.1.5")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = "3_1", n_colors=5) )
## Export the plot
export_plot(manual_text = "Emissions by subsectors", placement = "b")

# MAPS ----------------------------------------------------------------- #
# Total greenhouse gas emissions

## Map info
mapInfo <- map_info(mapName = "M.P4.CC.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName, meta_plot_map() )
## export the map
export_map()

