###########################################################################
## GSYB15: Plots and maps for GSPB2015
###########################################################################

# %
# %                         .^^^\ ../~/\       .==...==.
# %                        .^\ /\  \    ^-------^^ O    O,
# %                       / \  \/    ---         ,..++---,
# %                      / \_\-          _,v.v^V^ ,/\^^^/
# %                     | \/       /^v^V^   _,.-^^  .;+^
# %                      \-\   (   \..,+-=~^   .-+/^
# %                       \--.__________.--+'^^
# %                    ...^--.__________.---^^^^~+._
# %   _            _,=^\                            ".
# %   \'\.       .^           FFFFF                   '
# %    \-/\     /  \          F  FF           )   /    \
# %     \-/\   | -      /        FF           )^`\,... |
# %     /\-\)  | ,,../^^\        FF           /  /     \
# %    /\.-\)  |^     \  \       FF          /  (      )
# %   /\. \/   (     \/  /\      FF         /    \/_/_/
# %  /==)-/\_   \_\_\/ / |      FFFF       )|
# % (=== /. /^^^~~~~~^^\  \               ) |
# % (/:/:/ /. /  /  /   \  ^+..........,^^  /
# %  \/:/:(:.(:.(:.(  (  \,             ,.;|
# %   \$$(:(:(::(::(::(::: ^^""""""""""^  /\
# %    ^=U$$$$$Sb\;:\;:\:''"*********+++_/ \)
# %        ^"=*UUU$$$$$++ /$$$$&&PP!*=/^\ \/
# %                   |++|            \+ + \_ _
# %                  _/ . \_           \ .  ___>
# %               <(^ /  |__)>          `--.___>
# %                 \/^\/
# %

## Part 1
colPart1 <- plot_colors(part = 1, 12)
col.main1 <- colPart1[["Main"]][1]
## color for the grid
col.main2 <- colPart1[["Main"]][2]
source("./dissemination/Rcode/Final/theme_functions/theme.R")
source('./dissemination/Rcode/Final/plot_functions/plot_setup.R')

###########################################################################
#
#    _(9(9)__        __/^\/^\__
#   /o o   \/_     __\_\_/\_/_/_
#   \___,   \/_   _\.'       './_      _/\_
#   `---`\  \/_ _\/           \/_   _|.'_/
#             \  \/_\/      /      \/_  |/ /
#              \  `-'      |        ';_:' /
#              /|          \      \     .'
#             /_/   |,___.-`',    /`'---`
#           /___/`       /____/
#     
## POPULATION
###########################################################################


## ------------------------------------------------------------------------
# World rural and urban population

## Info
plotInfo <- plot_info(plotName = "C.P1.OVER.1.2")
## Create the plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 1, n_colors=2) )
# Export plot
export_plot(placement = "tr")


## ------------------------------------------------------------------------
# Annual population growth over the last ten years

## Info
plotInfo <- plot_info(plotName = "C.P1.OVER.1.3")
## Create the plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(placement="l")


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
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=6) )
## Export the plot
export_plot(placement = "b")


# MAPS -------------------------------------------------------------------
# Rural population, share of total population

## Map info
mapInfo <- map_info(mapName = "M.P1.OVER.1.6", data = sybMaps.df, mapArea = "Territory")
mapInfo$mapData$OA.TPR.POP.PPL.SHP <- mapInfo$mapData$OA.TPR.POP.PPL.SHP/10000 # to get percents.....
## Create the map
assign(mapInfo$mapName,meta_plot_map() )
## export the map
export_map()


###########################################################################
#
#    _(9(9)__        __/^\/^\__
#   /o o   \/_     __\_\_/\_/_/_
#   \___,   \/_   _\.'       './_      _/\_
#   `---`\  \/_ _\/           \/_   _|.'_/
#             \  \/_\/      /      \/_  |/ /
#              \  `-'      |        ';_:' /
#              /|          \      \     .'
#             /_/   |,___.-`',    /`'---`
#           /___/`       /____/
#     
## ECONOMY
###########################################################################

## ------------------------------------------------------------------------
# Value added in agriculture, industry, and services as shares of GDP

## Info
plotInfo <- plot_info(plotName = "C.P1.ECON.1.2")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=3) )
## Export the plot
export_plot(placement = "tr")


## ------------------------------------------------------------------------
# Agriculture value added per worker, countries with the highest values in 2013

## Info
plotInfo <- plot_info(plotName = "C.P1.ECON.1.3")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(placement="l")

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
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=6) )
## Export the plot
export_plot(placement="b")

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
#
#    _(9(9)__        __/^\/^\__
#   /o o   \/_     __\_\_/\_/_/_
#   \___,   \/_   _\.'       './_      _/\_
#   `---`\  \/_ _\/           \/_   _|.'_/
#             \  \/_\/      /      \/_  |/ /
#              \  `-'      |        ';_:' /
#              /|          \      \     .'
#             /_/   |,___.-`',    /`'---`
#           /___/`       /____/
#     
## Labour
###########################################################################

## ------------------------------------------------------------------------
# Labour force participation rate by gender, ages 15+

## Info
plotInfo <- plot_info(plotName = "C.P1.LABO.1.2")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=2) )
## Export the plot
export_plot(placement = "tr")

## ------------------------------------------------------------------------
# Female employment in agriculture, share of female employment

## Info
plotInfo <- plot_info(plotName = "C.P1.LABO.1.3")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=2) )
## Export the plot
export_plot(placement = "l")

## ------------------------------------------------------------------------
# Male employment in agriculture, share of male employment

## Info
plotInfo <- plot_info(plotName = "C.P1.LABO.1.4")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=2) )
## Export the plot
export_plot(placement = "r")

## ------------------------------------------------------------------------
# Children in employment, total

## Info
plotInfo <- plot_info(plotName = "C.P1.LABO.1.5")
#plotInfo$plotYears <- c(min(plotInfo$plotYears),max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(placement = "b")

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
#
#    _(9(9)__        __/^\/^\__
#   /o o   \/_     __\_\_/\_/_/_
#   \___,   \/_   _\.'       './_      _/\_
#   `---`\  \/_ _\/           \/_   _|.'_/
#             \  \/_\/      /      \/_  |/ /
#              \  `-'      |        ';_:' /
#              /|          \      \     .'
#             /_/   |,___.-`',    /`'---`
#           /___/`       /____/
#     
## Inputs
###########################################################################

## ------------------------------------------------------------------------
# Fertilizer consumption in nutrients per ha of arable land - WORLD & YEARS

## Info
plotInfo <- plot_info(plotName = "C.P1.INPU.1.2")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = "1b", n_colors=3) )
## Export the plot
export_plot(placement = "tr")

## ------------------------------------------------------------------------
# Fertilizer consumption in nutrients per ha of arable land - REGIONS

## Info
plotInfo <- plot_info(plotName = "C.P1.INPU.1.3")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(placement = "r")


# ## Info
# plotInfo <- plot_info(plotName = "C.P1.INPU.1.3")
# ## Plot
# assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=3) )
# ## Export the plot
# export_plot(manual_text = "Fertilizer consumption in nutrients per ha of arable land", placement = "l")

## ------------------------------------------------------------------------

# Fertilizer consumption in nutrients per ha of arable land - COUNTRIES

## Info
plotInfo <- plot_info(plotName = "C.P1.INPU.1.4")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(placement = "r")

## ------------------------------------------------------------------------
# Fertilizer consumption in nutrients per ha of arable land - WORLD & YEARS

## Info
plotInfo <- plot_info(plotName = "C.P1.INPU.1.5")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=3) )
## Export the plot
export_plot(placement = "b")

## ------------------------------------------------------------------------
# MAPS

# Pesticides per ha of arable land

## Map info
mapInfo <- map_info(mapName = "M.P1.INPU.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName,meta_plot_map() )
## export the map
export_map()

###########################################################################
#
#    _(9(9)__        __/^\/^\__
#   /o o   \/_     __\_\_/\_/_/_
#   \___,   \/_   _\.'       './_      _/\_
#   `---`\  \/_ _\/           \/_   _|.'_/
#             \  \/_\/      /      \/_  |/ /
#              \  `-'      |        ';_:' /
#              /|          \      \     .'
#             /_/   |,___.-`',    /`'---`
#           /___/`       /____/
#     
## Investments
###########################################################################

# ## ------------------------------------------------------------------------
# # ODA received in agriculture, forestry and fishing sectors, share of total ODA
# 
# ## Info
# plotInfo <- plot_info(plotName = "C.P1.INV.1.2")
# ## Plot
# assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=3) )
# ## Export the plot
# export_plot(manual_text = "Fertilizer consumption in nutrients per ha of arable land", placement = "tr")
# 
# ## ------------------------------------------------------------------------
# # Top ten countries, credit to agriculture as a share of total credit
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
# # Top ten countries, total credit, current US$
# 
# ## Info
# plotInfo <- plot_info(plotName = "C.P1.INV.1.4")
# ## Plot
# assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
# ## Export the plot
# export_plot(manual_text = "Fertilizer consumption in nutrients per ha of arable land", placement = "r")
# 
# ## ------------------------------------------------------------------------
# # ODA received in agriculture, forestry and fishing sectors, share of total ODA
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


# %                         .^^^\ ../~/\       .==...==.
# %                        .^\ /\  \    ^-------^^ O    O,
# %                       / \  \/    ---         ,..++---,
# %                      / \_\-          _,v.v^V^ ,/\^^^/
# %                     | \/       /^v^V^   _,.-^^  .;+^
# %                      \-\   (   \..,+-=~^   .-+/^
# %                       \--.__________.--+'^^
# %                    ...^--.__________.---^^^^~+._
# %   _            _,=^\                            ".
# %   \'\.       .^              FFfffFFF             '
# %    \-/\     /  \             FF    FF     )   /    \
# %     \-/\   | -      /              FF     )^`\,... |
# %     /\-\)  | ,,../^^\             FF      /  /     \
# %    /\.-\)  |^     \  \           FF      /  (      )
# %   /\. \/   (     \/  /\        FF       /    \/_/_/
# %  /==)-/\_   \_\_\/ / |       FFFFFFF   )|
# % (=== /. /^^^~~~~~^^\  \               ) |
# % (/:/:/ /. /  /  /   \  ^+..........,^^  /
# %  \/:/:(:.(:.(:.(  (  \,             ,.;|
# %   \$$(:(:(::(::(::(::: ^^""""""""""^  /\
# %    ^=U$$$$$Sb\;:\;:\:''"*********+++_/ \)
# %        ^"=*UUU$$$$$++ /$$$$&&PP!*=/^\ \/
# %                   |++|            \+ + \_ _
# %                  _/ . \_           \ .  ___>
# %               <(^ /  |__)>          `--.___>
# %  


## Part 2

colPart2 <- plot_colors(part = 2, 12)
col.main2 <- colPart2[["Main"]][1]
## color for the grid
col.main2 <- colPart2[["Main"]][2]
source("./dissemination/Rcode/Final/theme_functions/theme.R")
source('./dissemination/Rcode/Final/plot_functions/plot_setup.R')



###########################################################################
#
#    _(9(9)__        __/^\/^\__
#   /o o   \/_     __\_\_/\_/_/_
#   \___,   \/_   _\.'       './_      _/\_
#   `---`\  \/_ _\/           \/_   _|.'_/
#             \  \/_\/      /      \/_  |/ /
#              \  `-'      |        ';_:' /
#              /|          \      \     .'
#             /_/   |,___.-`',    /`'---`
#           /___/`       /____/
#     
## AVAILABILITY
###########################################################################


# ----------------------------------------------------------------------- #
# Land area

## Info

# Have to still think about this. The example is apparently the one in big book on page 76

# plotInfo <- plot_info(plotName = "C.P2.AV.1.2")
# 
# ## Plot
# assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=3) )
# 
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
export_plot(placement="l")


# ----------------------------------------------------------------------- #
# Protein supply quantity, grand total, 3 year averages

## Info
plotInfo <- plot_info(plotName = "C.P2.AV.1.4")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(placement="r")


# ----------------------------------------------------------------------- #
# Protein of animal origin, 3 year averages

## Info
plotInfo <- plot_info(plotName = "C.P2.AV.1.5")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=6) )
## Export the plot
export_plot(placement = "b")


# MAPS -----------------------------------------------------
# Food net per capita production value, 3 year averages 

## Map info
mapInfo <- map_info(mapName = "M.P2.AV.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName, meta_plot_map() )
## export the map
export_map()


###########################################################################
#
#    _(9(9)__        __/^\/^\__
#   /o o   \/_     __\_\_/\_/_/_
#   \___,   \/_   _\.'       './_      _/\_
#   `---`\  \/_ _\/           \/_   _|.'_/
#             \  \/_\/      /      \/_  |/ /
#              \  `-'      |        ';_:' /
#              /|          \      \     .'
#             /_/   |,___.-`',    /`'---`
#           /___/`       /____/
#     
## ACCESS
###########################################################################

# ----------------------------------------------------------------------- #
# Depth of food decifit, 3 year averages

## Info
plotInfo <- plot_info(plotName = "C.P2.ACCESS.1.2")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=6) )
## Export the plot
export_plot(placement="tr")


# ----------------------------------------------------------------------- #
# Domestic food price level index 

## Info
plotInfo <- plot_info(plotName = "C.P2.ACCESS.1.3")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=6) )
## Export the plot
export_plot(placement="l")


# ----------------------------------------------------------------------- #
# Prevalence of undernourishment, 3 year averages

## Info
plotInfo <- plot_info(plotName = "C.P2.ACCESS.1.4")
plotInfo$plotYears <- c(min(plotInfo$plotYears),max(plotInfo$plotYears))

# data into numeric
sybdata.df$AV3YPOU.DISS <- as.factor(sybdata.df$AV3YPOU.DISS)
sybdata.df$AV3YPOU.DISS <- as.numeric(levels(sybdata.df$AV3YPOU.DISS))[sybdata.df$AV3YPOU.DISS]

## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=2) )
## Export the plot
export_plot(placement="r")


# ----------------------------------------------------------------------- #
# Prevalence of food inadequacy, 3 year averages

## Info
plotInfo <- plot_info(plotName = "C.P2.ACCESS.1.5")
# data into numeric
sybdata.df$AV3YPoFI.DISS <- as.factor(sybdata.df$AV3YPoFI.DISS)
sybdata.df$AV3YPoFI.DISS <- as.numeric(levels(sybdata.df$AV3YPoFI.DISS))[sybdata.df$AV3YPoFI.DISS]
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=8) )
## Export the plot
export_plot(placement = "b")


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
#
#    _(9(9)__        __/^\/^\__
#   /o o   \/_     __\_\_/\_/_/_
#   \___,   \/_   _\.'       './_      _/\_
#   `---`\  \/_ _\/           \/_   _|.'_/
#             \  \/_\/      /      \/_  |/ /
#              \  `-'      |        ';_:' /
#              /|          \      \     .'
#             /_/   |,___.-`',    /`'---`
#           /___/`       /____/
#     
## Stability
###########################################################################


# Cereal import dependency ratio
# Percent of arable land equipped for irrigation
### Value of food imports over total merchandise exports
### Political stability and absence of violence/terrorism
### Domestic food price volatility 
# Per capita food production variability
### Per capita food supply variability



# ----------------------------------------------------------------------- #
# Per capita food supply variability 

## Info
plotInfo <- plot_info(plotName = "C.P2.STB.1.3")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=6) )
## Export the plot
export_plot(placement="l")


# ----------------------------------------------------------------------- #
# Domestic food price level index volatility 

## Info
plotInfo <- plot_info(plotName = "C.P2.STB.1.4")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=6) )
## Export the plot
export_plot(placement="l")


# ----------------------------------------------------------------------- #
# Value of food imports over total merchandise exports, 3 year averages 

## Info
plotInfo <- plot_info(plotName = "C.P2.STB.1.5")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(placement = "b")


##### -------------------------------------------------------
# MAPS

# Political stability and absence of violence/terrorism

## Map info
mapInfo <- map_info(mapName = "M.P2.STB.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName, meta_plot_map() )
## export the map
export_map()



###########################################################################
#
#    _(9(9)__        __/^\/^\__
#   /o o   \/_     __\_\_/\_/_/_
#   \___,   \/_   _\.'       './_      _/\_
#   `---`\  \/_ _\/           \/_   _|.'_/
#             \  \/_\/      /      \/_  |/ /
#              \  `-'      |        ';_:' /
#              /|          \      \     .'
#             /_/   |,___.-`',    /`'---`
#           /___/`       /____/
#     
## UTILIZATION
###########################################################################


### Access to improved water sources
# Access to improved sanitation facilities
### Percentage of children under 5 years of age affected by wasting
### Percentage of children under 5 years of age who are stunted
# Percentage of children under 5 years of age who are underweight 
# Percentage of adults who are underweight 
# Prevalence of anaemia among pregnant women
### Prevalence of anaemia among children under 5 years of age
# Prevalence of vitamin A deficiency in the population
# Prevalence of iodine deficiency

#Percentage of children under 5 years of age affected by wasting


# # ----------------------------------------------------------------------- #
# # Percentage of children under 5 years of age who are stunted
# 
# ## Info
# plotInfo <- plot_info(plotName = "C.P2.UT.1.3")
# ## Plot
# assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
# ## Export the plot
# export_plot(placement="l")

# ----------------------------------------------------------------------- #
# Percentage of children under 5 years of age who are stunted

## Info
plotInfo <- plot_info(plotName = "C.P2.UT.1.3")
#plotInfo$plotYears <- c(min(plotInfo$plotYears),max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=2) )
## Export the plot
export_plot(placement="l")

# ----------------------------------------------------------------------- #
# Percentage of children under 5 years of age affected by wasting

## Info
plotInfo <- plot_info(plotName = "C.P2.UT.1.4")
#plotInfo$plotYears <- c(min(plotInfo$plotYears),max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=2) )
## Export the plot
export_plot(placement="r")

# ----------------------------------------------------------------------- #
# Access to improved water source and to improved sanitation facilities 

## Info
plotInfo <- plot_info(plotName = "C.P2.UT.1.5")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=2) )
## Export the plot
export_plot(placement = "b")


##### -------------------------------------------------------
# MAPS

# Percentage of anaemia among children <5 years of age

## Map info
mapInfo <- map_info(mapName = "M.P2.UT.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName, meta_plot_map() )
## export the map
export_map()



# %
# %                         .^^^\ ../~/\       .==...==.
# %                        .^\ /\  \    ^-------^^ O    O,
# %                       / \  \/    ---         ,..++---,
# %                      / \_\-          _,v.v^V^ ,/\^^^/
# %                     | \/       /^v^V^   _,.-^^  .;+^
# %                      \-\   (   \..,+-=~^   .-+/^
# %                       \--.__________.--+'^^
# %                    ...^--.__________.---^^^^~+._
# %   _            _,=^\                            ".
# %   \'\.       .^             FFFffffF              '
# %    \-/\     /  \                   FF     )   /    \
# %     \-/\   | -      /              FF      )^`\,... |
# %     /\-\)  | ,,../^^\        FFffFF       /  /     \
# %    /\.-\)  |^     \  \            FF     /  (      )
# %   /\. \/   (     \/  /\           FF    /    \/_/_/
# %  /==)-/\_   \_\_\/ / |      FFFFFFF    )|
# % (=== /. /^^^~~~~~^^\  \               ) |
# % (/:/:/ /. /  /  /   \  ^+..........,^^  /
# %  \/:/:(:.(:.(:.(  (  \,             ,.;|
# %   \$$(:(:(::(::(::(::: ^^""""""""""^  /\
# %    ^=U$$$$$Sb\;:\;:\:''"*********+++_/ \)
# %        ^"=*UUU$$$$$++ /$$$$&&PP!*=/^\ \/
# %                   |++|            \+ + \_ _
# %                  _/ . \_           \ .  ___>
# %               <(^ /  |__)>          `--.___>
# %                 \/^\/
# %



## Part 3

colPart3 <- plot_colors(part = 3, 12)
col.main3 <- colPart3[["Main"]][1]
## color for the grid
col.main2 <- colPart3[["Main"]][2]
source("./dissemination/Rcode/Final/theme_functions/theme.R")
source('./dissemination/Rcode/Final/plot_functions/plot_setup.R')

###########################################################################
#
#    _(9(9)__        __/^\/^\__
#   /o o   \/_     __\_\_/\_/_/_
#   \___,   \/_   _\.'       './_      _/\_
#   `---`\  \/_ _\/           \/_   _|.'_/
#             \  \/_\/      /      \/_  |/ /
#              \  `-'      |        ';_:' /
#              /|          \      \     .'
#             /_/   |,___.-`',    /`'---`
#           /___/`       /____/
#     
## Food supply
###########################################################################

# Lets wait fore the FSI indicators!!!!

# 1. Text
# 2. graph: Protein and fat supply in crops primary equivalent (2000-09), world
# 3. Dietary energy supply, top 20 (2000-02 vs. 2009-11)
# 4. Dietary energy supply, bottom 20 (2000-02 vs. 2009-11)
# 5. Line graph: DES (kcal/cap/day), by region, 2000-2011
# 6. Map: DES (kcal/cap/day), 2009-11


# ----------------------------------------------------------------------- #
# Dietary energy supply, top 20 (2000-02 vs. 2009-11)


## Info
plotInfo <- plot_info(plotName = "C.P3.SUP.1.3")
plotInfo$plotYears <- c(min(plotInfo$plotYears),max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(placement="l")


# ----------------------------------------------------------------------- #
# Dietary energy supply, bottom 20 (2000-02 vs. 2009-11)

## Info
plotInfo <- plot_info(plotName = "C.P3.SUP.1.4")
plotInfo$plotYears <- c(min(plotInfo$plotYears),max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(placement="r")


# ----------------------------------------------------------------------- #
# DES (kcal/cap/day)

## Info
plotInfo <- plot_info(plotName = "C.P3.SUP.1.5")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=6) )
## Export the plot
export_plot(manual_text = "DES (kcal/cap/day)", placement = "b")


##### -------------------------------------------------------
# MAPS

# DES (kcal/cap/day), 2009-11

## Map info
mapInfo <- map_info(mapName = "M.P3.SUP.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName, meta_plot_map() )
## export the map
export_map()



###########################################################################
#
#    _(9(9)__        __/^\/^\__
#   /o o   \/_     __\_\_/\_/_/_
#   \___,   \/_   _\.'       './_      _/\_
#   `---`\  \/_ _\/           \/_   _|.'_/
#             \  \/_\/      /      \/_  |/ /
#              \  `-'      |        ';_:' /
#              /|          \      \     .'
#             /_/   |,___.-`',    /`'---`
#           /___/`       /____/
#     
## Growth in crop production
###########################################################################

# 2. Chart: fastest growing items between 2000-MRY

# -----------------------------------------------------------
# 3. Top 20 crop producing countries (based on crops net per capita production index number (2004-2006 = 100))

## Info
plotInfo <- plot_info(plotName = "C.P3.CRPRO.1.3")
plotInfo$plotYears <- c(min(plotInfo$plotYears),max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=2) )
## Export the plot
export_plot(manual_text="Top 20 crop producing countries (based on Crops net per capita production value (per capita constant 2004-2006 I$))",placement="l")


# -----------------------------------------------------------
# 4. Top 20 food producing countries (based on food net per capita production value (per capita constant 2004-2006 I$)), 2000 vs. MRY

## Info
plotInfo <- plot_info(plotName = "C.P3.CRPRO.1.4")
plotInfo$plotYears <- c(min(plotInfo$plotYears),max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=2) )
## Export the plot
export_plot(manual_text="Top 20 food producing countries (based on food net per capita production value (per capita constant 2004-2006 I$))",placement="r")

# -----------------------------------------------------------
# 5. Bar chart: Growth in cereals production (production, harvested area, yield), world, 2000-MRY

## Info
plotInfo <- plot_info(plotName = "C.P3.CRPRO.1.5")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=3) )
## Export the plot
export_plot(manual_text = "Growth in cereals production (production, harvested area, yield), world, 2000-MRY",placement="b")

##### -------------------------------------------------------
# MAPS

# 6. Map: Crops, gross per capita production (2004-06 = 100)

## Map info
mapInfo <- map_info(mapName = "M.P3.CRPRO.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName, meta_plot_map() )
## export the map
export_map()


###########################################################################
#
#    _(9(9)__        __/^\/^\__
#   /o o   \/_     __\_\_/\_/_/_
#   \___,   \/_   _\.'       './_      _/\_
#   `---`\  \/_ _\/           \/_   _|.'_/
#             \  \/_\/      /      \/_  |/ /
#              \  `-'      |        ';_:' /
#              /|          \      \     .'
#             /_/   |,___.-`',    /`'---`
#           /___/`       /____/
#     
## Trends in the crop sector
###########################################################################

# 1. Text:
# 2. Chart: top five items produced in MRY vs. 2000

# -----------------------------------------------------------
# # 3. Top 20 Rice producing countries per capita (Rice (paddy) production per capita (tonne/cap))

## Info
plotInfo <- plot_info(plotName = "C.P3.CRTRE.1.3")
plotInfo$plotYears <- c(min(plotInfo$plotYears),max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=2) )
## Export the plot
export_plot(manual_text="Top 20 Rice producing countries per capita (Rice (paddy) production per capita (tonne/cap))",placement="l")


# -----------------------------------------------------------
# 4. Top 20 WHEAT producing countries per capita (Rice (paddy) production per capita (tonne/cap))

## Info
plotInfo <- plot_info(plotName = "C.P3.CRTRE.1.4")
plotInfo$plotYears <- c(min(plotInfo$plotYears),max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=2) )
## Export the plot
export_plot(manual_text="Top 20 Wheat producing countries per capita (Rice (paddy) production per capita (tonne/cap))",placement="r")

# -----------------------------------------------------------
# 5. Line chart: yield by region, 2000-MRY - This is an issue!

## Info
plotInfo <- plot_info(plotName = "C.P3.CRTRE.1.5")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=6) )
## Export the plot
export_plot(manual_text = "Cereals yield (hg/ha)", placement="b")


##### -------------------------------------------------------
# MAPS

# 6. Map: Cereal producing countries

## Map info
mapInfo <- map_info(mapName = "M.P3.CRTRE.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName, meta_plot_map() )
## export the map
export_map()


###########################################################################
#
#    _(9(9)__        __/^\/^\__
#   /o o   \/_     __\_\_/\_/_/_
#   \___,   \/_   _\.'       './_      _/\_
#   `---`\  \/_ _\/           \/_   _|.'_/
#             \  \/_\/      /      \/_  |/ /
#              \  `-'      |        ';_:' /
#              /|          \      \     .'
#             /_/   |,___.-`',    /`'---`
#           /___/`       /____/
#     
## Trends in the livestock sector
###########################################################################

# 1. Text
# 2. Per capita meat production (see chart 72 SYB2013)

# Not able to reproduce it..

# ## Info
# plotInfo <- plot_info(plotName = "C.P3.LIVE.1.2")
# ## Plot
# assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
# ## Export the plot
# export_plot(manual_text = "Depth of food decifit, 3 year averages",placement="tr")

## create the plot - Taken from GSYB13
# assign(plotInfo$plotName,
#        plot_syb(x = plotInfo$xAxis,
#                 y = plotInfo$yAxis,
#                 group = plotInfo$group,
#                 type = plotInfo$plotType,
#                 subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
#                        Area %in% c(plotInfo$plotArea)")),
#                 data = sybdata.df,
#                 scale = plotInfo$scaling,
#                 x_lab = plotInfo$xPlotLab,
#                 y_lab = plotInfo$yPlotLab,
#                 col_pallete = plot_colors(part = plotInfo$plotPart, 6)[["Sub"]])
#        )

# -----------------------------------------------------------
# Per capita milk production, top 10 and bottom 10

## Info
plotInfo <- plot_info(plotName = "C.P3.LIVE.1.3")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(manual_text = "(Per capita) TOTAL milk production, top 10 and bottom 10", placement="l")

# -----------------------------------------------------------
# Per capita egg production, top 10 and bottom 10

## Info
plotInfo <- plot_info(plotName = "C.P3.LIVE.1.4")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(manual_text = "(Per capita) TOTAL egg production, top 10 and bottom 10", placement="r")


# -----------------------------------------------------------
# Proportional pie charts on pig production, by region, 2000 vs. MRY

## Info
# plotInfo <- plot_info(plotName = "C.P3.LIVE.1.5")
# ## Plot
# assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
# ## Export the plot
# export_plot(manual_text = "(Per capita) TOTAL egg production, top 10 and bottom 10", placement="r")

##### -------------------------------------------------------
# MAPS
# 6. Map: Cattle/buffaloes per sq km

## Map info
mapInfo <- map_info(mapName = "M.P3.LIVE.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName, meta_plot_map() )
## export the map
export_map()


###########################################################################
#
#    _(9(9)__        __/^\/^\__
#   /o o   \/_     __\_\_/\_/_/_
#   \___,   \/_   _\.'       './_      _/\_
#   `---`\  \/_ _\/           \/_   _|.'_/
#             \  \/_\/      /      \/_  |/ /
#              \  `-'      |        ';_:' /
#              /|          \      \     .'
#             /_/   |,___.-`',    /`'---`
#           /___/`       /____/
#     
## Trends in the fisheries sector
###########################################################################

# 2. Stacked area graph: aquaculture vs. capture production

## Info
plotInfo <- plot_info(plotName = "C.P3.FISH.1.2")
## Create the plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = "1b", n_colors=2) )
# Export plot
export_plot(manual_text = "Aquaculture vs. capture production", placement = "tr")

# -----------------------------------------------------------
# 20 countries with highest value of capture production

## Info
plotInfo <- plot_info(plotName = "C.P3.FISH.1.3")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(manual_text = "20 countries with highest value of capture production", placement="l")

# -----------------------------------------------------------
# 20 countries with highest value of aquaculture production

## Info
plotInfo <- plot_info(plotName = "C.P3.FISH.1.4")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(manual_text = "20 countries with highest value of aquaculture production", placement="r")

# 5. State of the world’s fishery stocks (see chart 79 in SYB2013)
# Has


##### -------------------------------------------------------
# MAPS

# 6. Map: Aquaculture producing countries, MRY (see map 48, WDI)

## Map info
mapInfo <- map_info(mapName = "M.P3.FISH.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName, meta_plot_map() )
## export the map
export_map()


###########################################################################
#
#    _(9(9)__        __/^\/^\__
#   /o o   \/_     __\_\_/\_/_/_
#   \___,   \/_   _\.'       './_      _/\_
#   `---`\  \/_ _\/           \/_   _|.'_/
#             \  \/_\/      /      \/_  |/ /
#              \  `-'      |        ';_:' /
#              /|          \      \     .'
#             /_/   |,___.-`',    /`'---`
#           /___/`       /____/
#     
## Trade (please see ICN2 publication)
###########################################################################


# -----------------------------------------------------------
# Top food importing countries in 2012

## Info
plotInfo <- plot_info(plotName = "C.P3.TRADE.1.3")
plotInfo$plotYears <- c(min(plotInfo$plotYears),max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=2) )
## Export the plot
export_plot(placement="l")


# -----------------------------------------------------------
# Top food exporting countries in 2011 (UPDATE DATA)

## Info
plotInfo <- plot_info(plotName = "C.P3.TRADE.1.4")
plotInfo$plotYears <- c(min(plotInfo$plotYears),max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=2) )
## Export the plot
export_plot(placement="r")

# -----------------------------------------------------------
# Exports of cereals (2000 to 2011)

## Info
plotInfo <- plot_info(plotName = "C.P3.TRADE.1.5")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=6) )
## Export the plot
export_plot(manual_text = "Exports of cereals", placement="b")

##### -------------------------------------------------------
# MAPS

# 6. Map: Cereal producing countries

## Map info
mapInfo <- map_info(mapName = "M.P3.TRADE.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName, meta_plot_map() )
## export the map
export_map()





# %                         .^^^\ ../~/\       .==...==.
# %                        .^\ /\  \    ^-------^^ O    O,
# %                       / \  \/    ---         ,..++---,
# %                      / \_\-          _,v.v^V^ ,/\^^^/
# %                     | \/       /^v^V^   _,.-^^  .;+^
# %                      \-\   (   \..,+-=~^   .-+/^
# %                       \--.__________.--+'^^
# %                    ...^--.__________.---^^^^~+._
# %   _            _,=^\                            ".
# %   \'\.       .^               FFFFF                 '
# %    \-/\     /  \             FF  FF         )   /    \
# %     \-/\   | -      /       FF   FF         )^`\,... |
# %     /\-\)  | ,,../^^\      FF    FF        /  /     \
# %    /\.-\)  |^     \  \     FFFFFFFFF      /  (      )
# %   /\. \/   (     \/  /\         FF       /    \/_/_/
# %  /==)-/\_   \_\_\/ / |          FF     )|
# % (=== /. /^^^~~~~~^^\  \         FF    ) |
# % (/:/:/ /. /  /  /   \  ^+..........,^^  /
# %  \/:/:(:.(:.(:.(  (  \,             ,.;|
# %   \$$(:(:(::(::(::(::: ^^""""""""""^  /\
# %    ^=U$$$$$Sb\;:\;:\:''"*********+++_/ \)
# %        ^"=*UUU$$$$$++ /$$$$&&PP!*=/^\ \/
# %                   |++|            \+ + \_ _
# %                  _/ . \_           \ .  ___>
# %               <(^ /  |__)>          `--.___>
# %  

## Part 4
colPart4 <- plot_colors(part = 4, 12)
col.main4 <- colPart4[["Main"]][1]
## color for the grid
col.main2 <- colPart4[["Main"]][2]
source("./dissemination/Rcode/Final/theme_functions/theme.R")
source('./dissemination/Rcode/Final/plot_functions/plot_setup.R')


###########################################################################
#
#    _(9(9)__        __/^\/^\__
#   /o o   \/_     __\_\_/\_/_/_
#   \___,   \/_   _\.'       './_      _/\_
#   `---`\  \/_ _\/           \/_   _|.'_/
#             \  \/_\/      /      \/_  |/ /
#              \  `-'      |        ';_:' /
#              /|          \      \     .'
#             /_/   |,___.-`',    /`'---`
#           /___/`       /____/
#     
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
#
#    _(9(9)__        __/^\/^\__
#   /o o   \/_     __\_\_/\_/_/_
#   \___,   \/_   _\.'       './_      _/\_
#   `---`\  \/_ _\/           \/_   _|.'_/
#             \  \/_\/      /      \/_  |/ /
#              \  `-'      |        ';_:' /
#              /|          \      \     .'
#             /_/   |,___.-`',    /`'---`
#           /___/`       /____/
#     
## WATER
###########################################################################

# ----------------------------------------------------------------------- #
# Total water withdrawal per capita, highest 20

## Info
plotInfo <- plot_info(plotName = "C.P4.WATER.1.3")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=1) )
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
#
#    _(9(9)__        __/^\/^\__
#   /o o   \/_     __\_\_/\_/_/_
#   \___,   \/_   _\.'       './_      _/\_
#   `---`\  \/_ _\/           \/_   _|.'_/
#             \  \/_\/      /      \/_  |/ /
#              \  `-'      |        ';_:' /
#              /|          \      \     .'
#             /_/   |,___.-`',    /`'---`
#           /___/`       /____/
#     
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
#
#    _(9(9)__        __/^\/^\__
#   /o o   \/_     __\_\_/\_/_/_
#   \___,   \/_   _\.'       './_      _/\_
#   `---`\  \/_ _\/           \/_   _|.'_/
#             \  \/_\/      /      \/_  |/ /
#              \  `-'      |        ';_:' /
#              /|          \      \     .'
#             /_/   |,___.-`',    /`'---`
#           /___/`       /____/
#     
## FORESTRY
###########################################################################

# ----------------------------------------------------------------------- #
# production of select forest product

## Info
plotInfo <- plot_info(plotName = "C.P4.FOR.1.2")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=6) )
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
# assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=6) )
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
#
#    _(9(9)__        __/^\/^\__
#   /o o   \/_     __\_\_/\_/_/_
#   \___,   \/_   _\.'       './_      _/\_
#   `---`\  \/_ _\/           \/_   _|.'_/
#             \  \/_\/      /      \/_  |/ /
#              \  `-'      |        ';_:' /
#              /|          \      \     .'
#             /_/   |,___.-`',    /`'---`
#           /___/`       /____/
#     
## CLIMATE CHANGE
###########################################################################

# ----------------------------------------------------------------------- #
# Greenhouse gas emissions in agriculture

## Info
plotInfo <- plot_info(plotName = "C.P4.CC.1.2")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(manual_text = "Greenhouse gas emissions in agriculture",placement="tr")

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
assign(plotInfo$plotName, meta_plot_plot(plot_type = "3_1", n_colors=6) )
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

