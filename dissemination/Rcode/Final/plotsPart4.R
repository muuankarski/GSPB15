###########################################################################
## GSYB15: Plots and minitables for part 4
###########################################################################

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

