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

# Longer time series
dat <- getFAOtoSYB(domainCode = "OA", 
                   elementCode = 551,
                   itemCode = 3010)
dat1 <- dat$aggregates
dat <- getFAOtoSYB(domainCode = "OA", 
                   elementCode = 561,
                   itemCode = 3010)
dat2 <- dat$aggregates
dat <- join(dat1,dat2)
dat <- dat[dat$FAOST_CODE == 5000,]
dat$Area <- "M49world"

plotInfo <- plot_info(plotName = "C.P1.OVER.1.2")
plotInfo$yAxis <- c(names(dat)[3],names(dat)[4])

## Create the plot
assign(plotInfo$plotName, 
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = dat,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                #legend_lab = subset(meta.lst$FULL,
                #                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                legend_lab <- c("Urban population","Rural population"),
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]] 
       ) +
         centerYear() + 
         scale_x_continuous(breaks=c(1965, 1985, 2005, 2015 ,2025)) +
         geom_vline(xintercept = 2015, linetype = "dashed")
)

# Export plot
export_plot(placement = "tr")


## ------------------------------------------------------------------------
# Annual population growth over the last ten years

## Info
plotInfo <- plot_info(plotName = "C.P1.OVER.1.3")

df2015 <- filter(sybdata.df, Year %in% c(2004:2014)) %>% group_by(FAOST_CODE) %>% dplyr::summarise(OA.TPBS.POP.PPL.GR10 = mean(OA.TPBS.POP.PPL.GR10, na.rm=TRUE))
for (i in unique(sybdata.df$FAOST_CODE)){
  sybdata.df$OA.TPBS.POP.PPL.GR10[sybdata.df$Year == 2015 & sybdata.df$FAOST_CODE == i] <- df2015[df2015$FAOST_CODE == i,]$OA.TPBS.POP.PPL.GR10
}

## Create the plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(placement="l")


## ------------------------------------------------------------------------
# Life expectancy at birth, countries with the lowest values in 2013

## Info
plotInfo <- plot_info(plotName = "C.P1.OVER.1.4")
plotInfo$plotYears <- c(min(plotInfo$plotYears),max(plotInfo$plotYears))
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
#mapInfo$mapData$OA.TPR.POP.PPL.SHP <- mapInfo$mapData$OA.TPR.POP.PPL.SHP/10000 # to get percents.....
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
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=2) )
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
## Info
plotInfo <- plot_info(plotName = "C.P1.INV.1.2")
# Feed in the data
if (!("oda_share_agriculture" %in% names(sybdata.df)) & !("share_of_agriculture_forestry_fishing" %in% names(sybdata.df))) {
  load("./database/Data/Processed/invest1.RData")
  sybdata.df <- full_join(sybdata.df,invest1)
}
plotInfo$legendLabels <- c(" agriculture and related sectors","agriculture, forestry & fishing")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = "3ml", n_colors=2) )
## Export the plot
export_plot(manual_text = "Share of ODA to Agriculture and related sectors*, 1973-2013", placement = "tr")
# 
# ## ------------------------------------------------------------------------
# # Top ten countries, credit to agriculture as a share of total credit

gg <- read.csv("./database/Data/Raw/credit_to_agriculture.csv")
gg <- gg[gg$ElementName == "Value US$",] 
gg <- gg[gg$ItemName == "Total Credit",] 

df2016 <- filter(gg, Year %in% c(1999:2001)) %>% group_by(AreaCode) %>% dplyr::summarise(value = mean(Value, na.rm=TRUE))
df2016$Year <- 2000
df2017 <- filter(gg, Year %in% c(2010:2012)) %>% group_by(AreaCode) %>% dplyr::summarise(value = mean(Value, na.rm=TRUE))
df2017$Year <- 2012

tmp <- rbind(df2016,df2017)
names(tmp) <- c("FAOST_CODE","credit_to_agriculture","Year")

sybdata.df <- merge(sybdata.df,tmp,by=c("FAOST_CODE","Year"), all.x=TRUE)

# 
## Info
plotInfo <- plot_info(plotName = "C.P1.INV.1.3")
plotInfo$plotYears <- c(min(plotInfo$plotYears),max(plotInfo$plotYears))
## Plot
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                #                 subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                #                                     Area %in% c(plotInfo$plotArea) &
                #                                     FAOST_CODE %in% c(FAOcountryProfile[FAOcountryProfile[, 'SOFI_MACRO_REG'] == 'Asia' & !is.na(FAOcountryProfile[, 'SOFI_MACRO_REG']), 'FAOST_CODE'])")),
                data = sybdata.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
C.P1.INV.1.3 <- C.P1.INV.1.3 + 
  scale_fill_manual(labels = c("1999-2001", "2010-12"),
                    values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
  scale_color_manual(labels = c("1999-2001", "2010-12"),
                     values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
## Export the plot
export_plot(placement = "l")
# 
# ## ------------------------------------------------------------------------
# ## ------------------------------------------------------------------------
# # Top ten countries, credit to agriculture as a share of total credit
# 
## Info
plotInfo <- plot_info(plotName = "C.P1.INV.1.4")
plotInfo$plotYears <- c(min(plotInfo$plotYears),max(plotInfo$plotYears))

# # Feed in the data
# if (!("remittances" %in% names(sybdata.df))){
#   load("./database/Data/Processed/invest3.RData")
#   sybdata.df <- full_join(sybdata.df,invest3)
# }

## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(placement = "l")

# 
# ## ------------------------------------------------------------------------
# ODA received in agriculture, forestry and fishing sectors, share of total ODA

## Info
plotInfo <- plot_info(plotName = "C.P1.INV.1.5")
## Plot
if (!("Bilateral" %in% names(sybdata.df)) & !("Multilateral" %in% names(sybdata.df))) {
  load("./database/Data/Processed/invest2.RData")
  sybdata.df <- full_join(sybdata.df,invest2)
}
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(manual_text = "ODA to Agriculture and related sectors, by bilateral/multilateral flow, 1973-2013", placement = "b")

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
## Undernourishment
###########################################################################


# New data from FIlippo on 20150602
dat <- read.csv("./database/Data/Raw/FSI2015_DisseminationDataset.csv", stringsAsFactors=FALSE)
metdat <- read.csv("./database/Data/Raw/FSI2015_DisseminationMetadata.csv", stringsAsFactors=FALSE)
dat$FAOST_CODE <- as.factor(dat$FAOST_CODE)
dat$FAOST_CODE <- as.numeric(levels(dat$FAOST_CODE))[dat$FAOST_CODE]
# SOFI to M49 conversions
# Asia
dat$FAOST_CODE[dat$FAOST_CODE == 5853] <- 5300
dat$FAOST_CODE[dat$FAOST_CODE == 5001] <- 5000

# Add Area var from sybdata.df
tmp <- sybdata.df[!duplicated(dat[c("FAOST_CODE")]),]
dat <- merge(dat,tmp[c("FAOST_CODE","Area")],by="FAOST_CODE")
dat <- merge(dat,FAOcountryProfile[c("FAOST_CODE","SHORT_NAME")],by="FAOST_CODE", all.x=TRUE)
# M49LatinAmericaAndCaribbean
dat$Area[dat$FAOST_CODE == 5205] <- "M49macroReg"
# dat$FS.OA.NOU.P3D1[dat$FS.OA.NOU.P3D1 == "<0.1"] <- 0.01
# dat$FS.OA.NOU.P3D1[dat$FS.OA.NOU.P3D1 == "ns"] <- 0
dat$FS.OA.NOU.P3D1 <- as.factor(dat$FS.OA.NOU.P3D1)
dat$FS.OA.NOU.P3D1 <- as.numeric(levels(dat$FS.OA.NOU.P3D1))[dat$FS.OA.NOU.P3D1]
dat$FS.OA.POU.PCT3D1[dat$FS.OA.POU.PCT3D1 == "<5.0"] <- 0.1
dat$FS.OA.POU.PCT3D1 <- as.factor(dat$FS.OA.POU.PCT3D1)
dat$FS.OA.POU.PCT3D1 <- as.numeric(levels(dat$FS.OA.POU.PCT3D1))[dat$FS.OA.POU.PCT3D1]
# C.P1.UNU.1.3 ------------------------------------------------------------
## Info
plotInfo <- plot_info(plotName = "C.P2.UNU.1.3")
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
plot.data <- dat[dat$FAOST_CODE %in% unique(FAOcountryProfile[FAOcountryProfile$FAO_RAP_REG == "RAPregion",]$FAOST_CODE),]



# C.P1.UNU.1.3 ------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P2.UNU.1.3")
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))

plot.data <- dat[dat$FAOST_CODE %in% unique(FAOcountryProfile[FAOcountryProfile$FAO_RAP_REG == "RAPregion",]$FAOST_CODE),]

assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
		                            Area %in% c(plotInfo$plotArea)")),
                data = plot.data,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = subset(meta.lst$FULL,
                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
       ) + scale_fill_manual(labels = c("1990-92", "2014-16"),
                             values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
         scale_color_manual(labels = c("1990-92", "2014-16"),
                            values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
         labs(y="million")
)
# Export
export_plot(manual_text= "Asian countries with the highest number of people undernourished in 2014-16 (1990-92 and 2014-16)", placement = "l")


# C.P1.UNU.1.3 ------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P2.UNU.1.4")
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))

plot.data <- dat[dat$FAOST_CODE %in% unique(FAOcountryProfile[FAOcountryProfile$FAO_RAF_REG == "RAFregion",]$FAOST_CODE),]

assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
		                            Area %in% c(plotInfo$plotArea)")),
                data = plot.data,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = subset(meta.lst$FULL,
                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
       ) + scale_fill_manual(labels = c("1990-92", "2014-16"),
                             values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
         scale_color_manual(labels = c("1990-92", "2014-16"),
                            values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
         labs(y="million")
)
# Export
export_plot(manual_text= "African countries with the highest number of people undernourished in 2014-16 (1990-92 and 2014-16)", placement = "l")




# plot.data <- plot.data[plot.data$Area == "M49macroReg",]
# arrange(as.data.frame(table(plot.data$FAO_TABLE_NAME)),-Freq)
# ----------------------------------------------------------------------- #
# Protein of animal origin, 3 year averages
plot.data <- dat
## Info
plotInfo <- plot_info(plotName = "C.P2.UNU.1.5")

## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
		                            Area %in% c(plotInfo$plotArea)")),
                data = plot.data,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                #                 legend_lab = subset(meta.lst$FULL,
                #                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 4)[["Sub"]]
       ) + scale_x_continuous(breaks = c(1991, 2001, 2006, 2013, 2015),
                              labels = c("1990-92", "2000-02", "2005-07", "2012-14", "2014-16")) +
         labs(y="million") +
         theme(axis.text.x = element_text(angle = 45))
       
)
## Export the plot
export_plot(manual_text = "Number of people undernourished (1990-92 to 2014-16)", placement = "b")


# MAPS -----------------------------------------------------
# Food net per capita production value, 3 year averages 

# Merge prevalence of undernourishment into sybMap.df

sybMaps.df2 <- merge(sybMaps.df,dat[c("Year","FAOST_CODE","FS.OA.POU.PCT3D1")],by.x=c("Year","FAO_CODE"),by.y=c("Year","FAOST_CODE"),all.x=TRUE)

#sybMaps.df2[ with(sybMaps.df2, grepl("China", FAO_TABLE_NAME)),c("FAO_CODE","Year","FAO_TABLE_NAME","FS.OA.POU.PCT3D1") ]

sybMaps.df2 <- sybMaps.df2[sybMaps.df2$FAO_CODE != 41,]
sybMaps.df2$FAO_CODE[sybMaps.df2$FAO_CODE == 351] <- 41

## Map info
mapInfo <- map_info(mapName = "M.P2.UNU.1.6", data = sybMaps.df2, mapArea = "Territory")
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
                                  Area %in% c(mapInfo$mapArea)"))
       ) 
       
       )
## export the map
export_map(manual_text = "Prevalence of undernourishment (2014-16)")




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
## Info

# Have to still think about this. The example is apparently the one in big book on page 76

plotInfo <- plot_info(plotName = "C.P2.AV.1.2")
plot.data$FAO_TABLE_NAME[plot.data$FAO_TABLE_NAME == "Latin America and the Caribbean"] <- "Latin Am. and the Carib."
## Plot
assign(plotInfo$plotName, 
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
		                            Area %in% c(plotInfo$plotArea)")),
                data = plot.data,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                #                 legend_lab = subset(meta.lst$FULL,
                #                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 6)[["Sub"]]
) + guides(fill = guide_legend(nrow = 2), color = guide_legend(nrow = 2)) +
  scale_x_continuous(breaks = c(1991, 2001, 2006, 2013, 2015),
                       labels = c("1990-92", "2000-02", "2005-07", "2012-14", "2014-16")) +
  theme(axis.text.x = element_text(angle = 45))
)       

# Export
export_plot(placement = "tr")

# ----------------------------------------------------------------------- #
# Energy supply derived from cereals, roots and tubers

## Info
plotInfo <- plot_info(plotName = "C.P2.AV.1.3")
plotInfo$plotYears <- c(min(plotInfo$plotYears),max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=2) )
## Export the plot
export_plot(placement="l")





# ----------------------------------------------------------------------- #
# Protein supply quantity, grand total, 3 year averages

## Info
plotInfo <- plot_info(plotName = "C.P2.AV.1.4")
plotInfo$plotYears <- c(min(plotInfo$plotYears),max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName, 
       
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                            Area %in% c(plotInfo$plotArea)")),
                data = plot.data,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = subset(meta.lst$FULL,
                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
       )
       )
## Export the plot
export_plot(placement="r")


# ----------------------------------------------------------------------- #
# Protein of animal origin, 3 year averages

years <- function(var){
  dx <- plot.data[,c("FAOST_CODE","Year",var)]
  dx <- dx[!is.na(dx$Year),]
  dx <- dx[!is.na(dx[[var]]),]
  summary(dx$Year)
}

years(var="QV.PCNPV.FOOD.ID3D")


## Info
plotInfo <- plot_info(plotName = "C.P2.AV.1.5")
## Plot
assign(plotInfo$plotName, 
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
		                            Area %in% c(plotInfo$plotArea)")),
                data = plot.data,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                #                 legend_lab = subset(meta.lst$FULL,
                #                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 5)[["Sub"]]
        ) + scale_x_continuous(breaks = c(1995, 2001, 2004, 2010),
                               labels = c("1990-92", "2000-02", "2003-05", "2009-11")) +
         theme(axis.text.x = element_text(angle = 45))
       )
## Export the plot
export_plot(placement = "b")


# MAPS -----------------------------------------------------
# Food net per capita production value, 3 year averages 

sybMaps.df2 <- merge(sybMaps.df,dat[c("Year","FAOST_CODE","QV.PCNPV.FOOD.ID3D")],by.x=c("Year","FAO_CODE"),by.y=c("Year","FAOST_CODE"),all.x=TRUE)

#sybMaps.df2[ with(sybMaps.df2, grepl("China", FAO_TABLE_NAME)),c("FAO_CODE","Year","FAO_TABLE_NAME","FS.OA.POU.PCT3D1") ]

sybMaps.df2 <- sybMaps.df2[sybMaps.df2$FAO_CODE != 41,]
sybMaps.df2$FAO_CODE[sybMaps.df2$FAO_CODE == 351] <- 41

## Map info
mapInfo <- map_info(mapName = "M.P2.AV.1.6", data = sybMaps.df2, mapArea = "Territory")
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
                # manualBreaks = c(0, 5, 15, 25, 35, 100),
                #                 countryCodeTransp = transpCountries[, "FAO_CODE"],
                subset = eval(parse(text = "Year %in% c(mapInfo$mapYear) &
                                  Area %in% c(mapInfo$mapArea)"))
       ) 
       
)
## export the map
export_map(manual_text="Average value of food production (constant 2004-2006 I$ per person) (3 year averages, 2011-13)")


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
## Plot
assign(plotInfo$plotName, 
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
		                            Area %in% c(plotInfo$plotArea)")),
                data = plot.data,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                #                 legend_lab = subset(meta.lst$FULL,
                #                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 6)[["Sub"]]
       ) + guides(fill = guide_legend(nrow = 2), color = guide_legend(nrow = 2)) +
         scale_x_continuous(breaks = c(1991, 2001, 2006, 2013, 2015),
                            labels = c("1990-92", "2000-02", "2005-07", "2012-14", "2014-16")) +
         theme(axis.text.x = element_text(angle = 45))
)       
## Export the plot
export_plot(placement="tr")


# ----------------------------------------------------------------------- #
# Domestic food price level index 

## Info
plotInfo <- plot_info(plotName = "C.P2.ACCESS.1.3")
plotInfo$plotYears <- c(min(plotInfo$plotYears),max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName, 
       
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                            Area %in% c(plotInfo$plotArea)")),
                data = plot.data,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = subset(meta.lst$FULL,
                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
       )
       )

## Export the plot
export_plot(placement="l")


# ----------------------------------------------------------------------- #
# Prevalence of undernourishment, 3 year averages

## Info
plotInfo <- plot_info(plotName = "C.P2.ACCESS.1.4")
plotInfo$plotYears <- c(min(plotInfo$plotYears),max(plotInfo$plotYears))

## Plot
assign(plotInfo$plotName, 
       
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                            Area %in% c(plotInfo$plotArea)")),
                data = plot.data,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = subset(meta.lst$FULL,
                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
       )  + scale_fill_manual(labels = c("1999-2001", "2013-15"),
                              values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
         scale_color_manual(labels = c("1999-2001", "2013-15"),
                            values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
)

## Export the plot
export_plot(manual_text="Prevalence of undernourishment (percent) (3 year averages, 1999-2001 and 2013-15)", placement="r")


# ----------------------------------------------------------------------- #
# Prevalence of food inadequacy, 3 year averages

## Info
plotInfo <- plot_info(plotName = "C.P2.ACCESS.1.5")
# data into numeric
plot.data$FS.OA.POFI.PCT3D1 <- as.factor(plot.data$FS.OA.POFI.PCT3D1)
plot.data$FS.OA.POFI.PCT3D1 <- as.numeric(levels(plot.data$FS.OA.POFI.PCT3D1))[plot.data$FS.OA.POFI.PCT3D1]
## Plot
assign(plotInfo$plotName, 
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
		                            Area %in% c(plotInfo$plotArea)")),
                data = plot.data,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                #                 legend_lab = subset(meta.lst$FULL,
                #                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 5)[["Sub"]]
       ) + scale_x_continuous(breaks = c(1991, 2001, 2004, 2010, 2015),
                              labels = c("1990-92", "2000-02", "2003-05", "2009-11", "2014-16")) +
         theme(axis.text.x = element_text(angle = 45))
)
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
# Food gross per capita production index number (2004-2006 = 100)

## Info
plotInfo <- plot_info(plotName = "C.P2.STB.1.2")
## Plot

assign(plotInfo$plotName, 
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
		                            Area %in% c(plotInfo$plotArea)")),
                data = plot.data,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                #                 legend_lab = subset(meta.lst$FULL,
                #                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 6)[["Sub"]]
       ) + guides(fill = guide_legend(nrow = 2), color = guide_legend(nrow = 2)) +
         scale_x_continuous(breaks = c(2002, 2006, 2013),
                            labels = c("2001-03", "2005-07", "2012-14")) +
         theme(axis.text.x = element_text(angle = 45))
)   
## Export the plot
export_plot(manual_text = "Per capita food production variability (constant 2004-2006 thousand int$ per capita)",placement="tr")

# ----------------------------------------------------------------------- #
# Per capita food supply variability 

## Info
plotInfo <- plot_info(plotName = "C.P2.STB.1.3")
plotInfo$plotYears <- c(min(plotInfo$plotYears),max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName, 
       
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                            Area %in% c(plotInfo$plotArea)")),
                data = plot.data,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = subset(meta.lst$FULL,
                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
       )
       )
## Export the plot
export_plot(placement="l")


# ----------------------------------------------------------------------- #
# Domestic food price level index volatility 

## Info
plotInfo <- plot_info(plotName = "C.P2.STB.1.4")
plotInfo$plotYears <- c(min(plotInfo$plotYears),max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName, 
       
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                            Area %in% c(plotInfo$plotArea)")),
                data = plot.data,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = subset(meta.lst$FULL,
                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
       )
)

export_plot(placement="r")


# ----------------------------------------------------------------------- #
# Value of food imports over total merchandise exports, 3 year averages 

## Info
plotInfo <- plot_info(plotName = "C.P2.STB.1.5")
## Plot
assign(plotInfo$plotName, 
       
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
		                            Area %in% c(plotInfo$plotArea)")),
                data = plot.data,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                #                 legend_lab = subset(meta.lst$FULL,
                #                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
       ) 
       
       )
## Export the plot
export_plot(placement = "b")


##### -------------------------------------------------------
# MAPS

# Political stability and absence of violence/terrorism

sybMaps.df2 <- merge(sybMaps.df,dat[c("Year","FAOST_CODE","G.GD.PSAVT.IN")],by.x=c("Year","FAO_CODE"),by.y=c("Year","FAOST_CODE"),all.x=TRUE)
## Map info
mapInfo <- map_info(mapName = "M.P2.STB.1.6", data = sybMaps.df, mapArea = "Territory")
mapInfo$mapData$FAO_CODE[mapInfo$mapData$FAO_CODE == 351] <- 41

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
df2015 <- filter(sybdata.df, Year %in% c(2006:2012)) %>% group_by(FAOST_CODE) %>% dplyr::summarise(value = mean(SH.STA.STNT.ZS, na.rm=TRUE))
for (i in unique(sybdata.df$FAOST_CODE)){
  sybdata.df$SH.STA.STNT.ZS[sybdata.df$Year == 2015 & sybdata.df$FAOST_CODE == i] <- df2015[df2015$FAOST_CODE == i,]$value
}

# df2015 <- filter(plot.data, Year %in% c(2006:2012)) %>% group_by(FAOST_CODE) %>% dplyr::summarise(value = mean(SH.STA.STNT.ZS, na.rm=TRUE))
# for (i in unique(plot.data$FAOST_CODE)){
#   plot.data$SH.STA.STNT.ZS[plot.data$Year == 2015 & plot.data$FAOST_CODE == i] <- df2015[df2015$FAOST_CODE == i,]$value
# }

## Plot
assign(plotInfo$plotName, 
       
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                            Area %in% c(plotInfo$plotArea)")),
                data = sybdata.df,
                #data = plot.data,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = subset(meta.lst$FULL,
                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 1)[["Sub"]]
       )
       
       
       )
## Export the plot
export_plot(manual_text="Percentage of children 5 years of age who are stunted, highest 20 (2006 - 2012)" ,placement="l")

# ----------------------------------------------------------------------- #
# Percentage of children under 5 years of age affected by wasting

## Info
plotInfo <- plot_info(plotName = "C.P2.UT.1.4")
df2015 <- filter(sybdata.df, Year %in% c(2006:2012)) %>% group_by(FAOST_CODE) %>% dplyr::summarise(value = mean(SH.STA.WAST.ZS, na.rm=TRUE))
for (i in unique(sybdata.df$FAOST_CODE)){
  sybdata.df$SH.STA.WAST.ZS[sybdata.df$Year == 2015 & sybdata.df$FAOST_CODE == i] <- df2015[df2015$FAOST_CODE == i,]$value
}

# df2015 <- filter(plot.data, Year %in% c(2006:2012)) %>% group_by(FAOST_CODE) %>% dplyr::summarise(value = mean(SH.STA.WAST.ZS, na.rm=TRUE))
# for (i in unique(plot.data$FAOST_CODE)){
#   plot.data$SH.STA.WAST.ZS[plot.data$Year == 2015 & plot.data$FAOST_CODE == i] <- df2015[df2015$FAOST_CODE == i,]$value
# }

## Plot
assign(plotInfo$plotName, 
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                            Area %in% c(plotInfo$plotArea)")),
                data = sybdata.df,
                #data = plot.data,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = subset(meta.lst$FULL,
                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
       )
)

## Export the plot
export_plot(manual_text = "Percentage of children under 5 years of age affected by wasting, highest 20 (2006 - 2012)",placement="r")

# ----------------------------------------------------------------------- #
# Access to improved water source and to improved sanitation facilities 

## Info
plotInfo <- plot_info(plotName = "C.P2.UT.1.5")
## Plot
assign(plotInfo$plotName, 
       
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                            Area %in% c(plotInfo$plotArea)")),
                data = plot.data,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = subset(meta.lst$FULL,
                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 3)[["Sub"]]
       )
       
       )

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
## Dietary Energy Supply
###########################################################################

# Lets wait fore the FSI indicators!!!!

# 1. Text
# 2. graph: Protein and fat supply in crops primary equivalent (2000-09), world
# 3. Dietary energy supply, top 20 (2000-02 vs. 2009-11)
# 4. Dietary energy supply, bottom 20 (2000-02 vs. 2009-11)
# 5. Line graph: DES (kcal/cap/day), by region, 2000-2011
# 6. Map: DES (kcal/cap/day), 2009-11
# 
# 
# plotInfo <- plot_info(plotName = "C.P3.DES.1.2")
# load("../ICN2PB14/Data/Processed/Metadata.RData")
# labels <- subset(meta.lst$FULL,
#                  subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"]
# labels[1] <- "Cereals\n(excl. beer)"
# labels[3] <- "Sugar and\nsweeteners"
# labels[4] <- "Milk\n(excl. butter)"
# labels[6] <- "Veg. oils and\nanimal fats"
# ## Plot
# load("../ICN2PB14/Data/Processed/icn2.RData")
# assign(plotInfo$plotName,
#        plot_syb(x = plotInfo$xAxis,
#                 y = plotInfo$yAxis,
#                 group = plotInfo$group,
#                 type = plotInfo$plotType,
#                 subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
#                                     Area %in% c(plotInfo$plotArea)")),
#                 data = icn2.df,
#                 scale = plotInfo$scaling,
#                 x_lab = plotInfo$xPlotLab,
#                 y_lab = plotInfo$yPlotLab,
#                 legend_lab = labels,
#                 col_pallete = plot_colors(part = plotInfo$plotPart, 7)[["Sub"]]) +
#          guides(fill = guide_legend(nrow = 3), color = guide_legend(nrow = 3))
#        )
# export_plot(manual_text="Share of DES (2009-2011)",placement="tr")
# load(file = "./database/Data/Processed/Metadata.RData")
# meta.df <- meta.lst$FULL
# ----------------------------------------------------------------------- #
# Dietary energy supply, top 20 (2000-02 vs. 2009-11)

## Info
plotInfo <- plot_info(plotName = "C.P3.DES.1.3")
plotInfo$plotYears <- c(min(plotInfo$plotYears),max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(placement="l")


# ----------------------------------------------------------------------- #
# Dietary energy supply, bottom 20 (2000-02 vs. 2009-11)

## Info
plotInfo <- plot_info(plotName = "C.P3.DES.1.4")
plotInfo$plotYears <- c(min(plotInfo$plotYears),max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(placement="r")


# ----------------------------------------------------------------------- #
# DES (kcal/cap/day)

## Info
plotInfo <- plot_info(plotName = "C.P3.DES.1.5")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=6) )
## Export the plot
export_plot(manual_text = "DES (kcal/cap/day)", placement = "b")


##### -------------------------------------------------------
# MAPS

# DES (kcal/cap/day), 2009-11

## Map info
mapInfo <- map_info(mapName = "M.P3.DES.1.6", data = sybMaps.df, mapArea = "Territory")
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

if (!("per_capita_catch" %in% names(sybdata.df))){
  
  library(gdata)
  dat <- read.xls("./database/Data/Raw/FISH_percapita_production2015.xlsx")
  dat[[1]] <- as.character(dat[[1]])
  dat[1,] <- c("Year",1990:2013)
  names(dat) <- dat[1,]
  dat <- dat[-1,]
  dl <- gather(dat, 
               "Year1",
               "capture",
               2:25)
  dl <- spread(dl, Year, capture)
  names(dl) <- c("Year","per_capita_aquaculture","per_capita_catch")
  dl[[2]] <- factor(dl[[2]])
  dl[[3]] <- factor(dl[[3]])
  dl[[1]] <- as.numeric(levels(dl[[1]]))[dl[[1]]]
  dl[[2]] <- as.numeric(levels(dl[[2]]))[dl[[2]]]
  dl[[3]] <- as.numeric(levels(dl[[3]]))[dl[[3]]]
  dl$FAOST_CODE <- 5000
  sybdata.df <- merge(sybdata.df,dl,by=c("FAOST_CODE","Year"),all.x=TRUE)
}
## Create the plot


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
#                 legend_lab = subset(meta.lst$FULL,
#                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                legend_lab <- c("From capture fisheries","From aquaculture"),
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]] 
       )  + labs(y="kg/cap")
       
       )

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

plotInfo <- plot_info(plotName = "C.P3.FISH.1.5")

library(gdata)
dat <- read.xls("./database/Data/Raw/FISH_overfishing_etc2015.xlsx")
dat <- gather(dat, 
                  "X",
                  "value",
                    2:4)

dat$X <- as.character(dat$X)
dat$X[dat$X == "Underfished"] <- "Under or\nmoderately\nexploited"
dat$X[dat$X == "Fully.fished"] <- "Fully\nexploited"
dat$X[dat$X == "Overfihsed"] <- "Recovering,\ndepleted\nor overexploited"

dat$X <- factor(dat$X, levels= c("Under or\nmoderately\nexploited",
                                "Fully\nexploited",
                                "Recovering,\ndepleted\nor overexploited"))

## create the plot
assign(plotInfo$plotName,
ggplot(data = dat, aes_string(x = "Year", y = as.character("value"))) +
  geom_area(aes_string(col = "X", fill = "X"), stat="Identity",position = "stack", width = 0.6) +
  scale_fill_manual(values = plot_colors(part = 3, 3)[["Sub"]]) +
  scale_color_manual(values = plot_colors(part = 3, 3)[["Sub"]]) +
  guides(fill = guide_legend(reverse = TRUE), color = guide_legend(reverse = TRUE)) +
  #   guides(fill = guide_legend(nrow = 3), color = guide_legend(nrow = 3)) +
  theme(legend.position = "top", legend.direction = "horizontal") +
  ylab("percent")
)

## export the plot
export_plot(manual_text = "State of the world's fishery stocks (1974 - 2011)", placement="b")


##### -------------------------------------------------------
# MAPS

# 6. Map: Aquaculture producing countries, MRY (see map 48, WDI)

## Map info
mapInfo <- map_info(mapName = "M.P3.FISH.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName, meta_plot_map() )
## export the map
export_map(manual_text="Aquaculture producing countries in 2012 (tonnes)")


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

# What I do is terrible, but transparent at least.
# So for each country, I will compute the mean of 2003 to 2013 and 
# give that mean as a 2014 value

df2014 <- sybdata.df %>% group_by(FAOST_CODE) %>% dplyr::summarise(AQ.WAT.WWIND.MC.SH = mean(AQ.WAT.WWIND.MC.SH, na.rm=TRUE))
for (i in unique(sybdata.df$FAOST_CODE)){
  sybdata.df$AQ.WAT.WWIND.MC.SH[sybdata.df$Year == 2014 & sybdata.df$FAOST_CODE == i] <- df2014[df2014$FAOST_CODE == i,]$AQ.WAT.WWIND.MC.SH
}

## Info
plotInfo <- plot_info(plotName = "C.P4.WATER.1.3")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=1) )
## Export the plot
export_plot(manual_text = "Freshwater withdrawal by industrial sector, share of total, highest 20 (1999 to 2013)",placement="l")

# ----------------------------------------------------------------------- #
# Freshwater withdrawal by agricultural sector, share of total, highest 20

df2014 <- sybdata.df %>% group_by(FAOST_CODE) %>% dplyr::summarise(AQ.WAT.WWAGR.MC.SH = mean(AQ.WAT.WWAGR.MC.SH, na.rm=TRUE))
for (i in unique(sybdata.df$FAOST_CODE)){
  sybdata.df$AQ.WAT.WWAGR.MC.SH[sybdata.df$Year == 2014 & sybdata.df$FAOST_CODE == i] <- df2014[df2014$FAOST_CODE == i,]$AQ.WAT.WWAGR.MC.SH
}

## Info
plotInfo <- plot_info(plotName = "C.P4.WATER.1.4")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(manual_text = "Freshwater withdrawal by agricultural sector, share of total, highest 20 (1999 to 2013)",placement="r")

# ----------------------------------------------------------------------- #
# Let's produce a table here with top 10 countries with water resources per capita, 2000 vs. MRY

plotInfo <- plot_info(plotName = "C.P4.WATER.1.5")

if (!("AQ.WAT.WATPCP.MC.NO.2" %in% names(sybdata.df))) {
  
  water <- sybdata.df[c("FAOST_CODE","Year","AQ.WAT.WATPCP.MC.NO")]
  water2000 <- sybdata.df[sybdata.df$Year == 2000, c("FAOST_CODE","Year","AQ.WAT.WATPCP.MC.NO")]
  water2010 <- sybdata.df[sybdata.df$Year == 2010, c("FAOST_CODE","Year","AQ.WAT.WATPCP.MC.NO")]
  water2000 <- water2000[!is.na(water2000$AQ.WAT.WATPCP.MC.NO),]
  water2010 <- water2010[!is.na(water2010$AQ.WAT.WATPCP.MC.NO),]
  top_10 <- head(arrange(water2010, -AQ.WAT.WATPCP.MC.NO),10)
  top_00 <- water2000[water2000$FAOST_CODE %in% top_10$FAOST_CODE,]
  
  names(top_10)[names(top_10)=="AQ.WAT.WATPCP.MC.NO"] <- "AQ.WAT.WATPCP.MC.NO.2"
  names(top_00)[names(top_00)=="AQ.WAT.WATPCP.MC.NO"] <- "AQ.WAT.WATPCP.MC.NO.2"
  
  topdata <- rbind(top_10,top_00)
  
  sybdata.df <- merge(sybdata.df,topdata,by=c("FAOST_CODE","Year"), all.x=TRUE)
}

plot.data <- sybdata.df[!is.na(sybdata.df$AQ.WAT.WATPCP.MC.NO.2),]

# order.data <- plot.data[plot.data$Year == 2010,]
# order.data <- arrange(order.data, -AQ.WAT.WATPCP.MC.NO.2)
# plot.data$SHORT_NAME <- factor(plot.data$SHORT_NAME, levels=order.data$SHORT_NAME)

#cat(paste(shQuote(unique(plot.data$SHORT_NAME), type="cmd"), collapse=", "))

assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
              y = plotInfo$yAxis,
              group = plotInfo$group,
              type = plotInfo$plotType,
              subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
		                            Area %in% c(plotInfo$plotArea)")),
              data = plot.data,
              scale = plotInfo$scaling,
              x_lab = plotInfo$xPlotLab,
              y_lab = plotInfo$yPlotLab,
              #                 legend_lab = subset(meta.lst$FULL,
              #                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
              col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
              ) 
)
## Export the plot
export_plot(manual_text = "top 10 countries with water resources per capita, 2000 and 2010",placement="b")



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
#Land area

## Info
plotInfo <- plot_info(plotName = "C.P4.ENER.1.2")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=1) )
## Export the plot
export_plot(placement = "tr")

# ----------------------------------------------------------------------- #
# Top 20 biofuel producing countries

## Info

## Plot

## Info
plotInfo <- plot_info(plotName = "C.P4.ENER.1.3")
## Plot
#BP.TP.GP.TJ.NO

# g <- sybdata.df %>% group_by(Year) %>% dplyr::summarise(n = n_distinct(BP.TP.GP.TJ.NO))

df2014 <- sybdata.df %>% group_by(FAOST_CODE) %>% dplyr::summarise(BP.TP.GP.TJ.NO = mean(BP.TP.GP.TJ.NO, na.rm=TRUE))
for (i in unique(sybdata.df$FAOST_CODE)){
  sybdata.df$BP.TP.GP.TJ.NO[sybdata.df$Year == 2014 & sybdata.df$FAOST_CODE == i] <- df2014[df2014$FAOST_CODE == i,]$BP.TP.GP.TJ.NO
}
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(manual_text = "Total renewable energy fix this title!!",placement="l")


## Info
plotInfo <- plot_info(plotName = "C.P4.ENER.1.4")
## Plot

df2014 <- sybdata.df %>% group_by(FAOST_CODE) %>% dplyr::summarise(BP.AP.GP.TJ.NO = mean(BP.AP.GP.TJ.NO, na.rm=TRUE))
for (i in unique(sybdata.df$FAOST_CODE)){
  sybdata.df$BP.AP.GP.TJ.NO[sybdata.df$Year == 2014 & sybdata.df$FAOST_CODE == i] <- df2014[df2014$FAOST_CODE == i,]$BP.AP.GP.TJ.NO
}
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(manual_text = "Pooled energy fix title",placement="l")


# -----------------------------------------------------------
# Exports of cereals (2000 to 2011)

## Info
plotInfo <- plot_info(plotName = "C.P4.ENER.1.5")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=3) )
## Export the plot
export_plot(manual_text = "Biodiesel production", placement="b")

##### -------------------------------------------------------
# MAPS

# 6. Map: Cereal producing countries

## Map info
mapInfo <- map_info(mapName = "M.P4.ENER.1.6", data = sybMaps.df, mapArea = "Territory")
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

## Info
plotInfo <- plot_info(plotName = "C.P4.FOR.1.5")
plotInfo$legendLabels <- c("primary forest","planted forest","other naturally regenerated forest")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = "3ml", n_colors=3) )
## Export the plot
export_plot(placement = "b")

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

