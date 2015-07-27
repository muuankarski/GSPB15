###########################################################################
## GSYB15: Plots and maps for GSPB2015
###########################################################################

# Countries with highest share of children under 5 yards of age who are underweight (percent)
library(dplyr)
library(xtable)
library(lazyeval)
library(tidyr)
library(stringr)
library(scales)
library(ggplot2)


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
                legend_lab <- c("Rural population","Urban population"),
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]] 
       ) +
         centerYear() + 
         scale_x_continuous(breaks=c(1965, 1985, 2005, 2015 ,2025)) +
         geom_vline(xintercept = 2015, linetype = "dashed") + 
         labs(y="billion people")
)

# Export plot
export_plot(placement = "tr")


## ------------------------------------------------------------------------
# Annual population growth over the last ten years

## Info
plotInfo <- plot_info(plotName = "C.P1.OVER.1.3")

df2014 <- filter(sybdata.df, Year %in% c(2004:2014)) %>% group_by(FAOST_CODE) %>% dplyr::summarise(OA.TPBS.POP.PPL.GR10 = mean(OA.TPBS.POP.PPL.GR10, na.rm=TRUE))
df2014$Year <- 2015
names(df2014) <- c("FAOST_CODE","new_var","Year") 
sybdata.df <- merge(sybdata.df,df2014,by=c("FAOST_CODE","Year"),all.x=TRUE)
sybdata.df$BOA.TPBS.POP.PPL.GR10 <- ifelse(sybdata.df$Year == 2015, sybdata.df$new_var, sybdata.df$OA.TPBS.POP.PPL.GR10)
sybdata.df$new_var <- NULL
sybdata_temp <- sybdata.df


## Create the plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(manual_text= "Population, average annual growth (2004-2014)", placement="l")
sybdata.df <- sybdata_temp


## ------------------------------------------------------------------------
# Life expectancy at birth, countries with the lowest values in 2013

## Info
plotInfo <- plot_info(plotName = "C.P1.OVER.1.4")
#plotInfo$plotYears <- c(min(plotInfo$plotYears),max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(placement="r")


## ------------------------------------------------------------------------
# Total economically active population In Asia

## Info
plotInfo <- plot_info(plotName = "C.P1.OVER.1.5")
plot.data <- sybdata.df[sybdata.df$FAOST_CODE %in% c(5301,5302,5303,5304,5305),]
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
       )
       )
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
export_plot(manual_text = "Value added in agriculture, industry and services, share of GDP (2013)", placement = "tr")


## ------------------------------------------------------------------------
# Agriculture value added per worker, countries with the highest values in 2013

## Info
plotInfo <- plot_info(plotName = "C.P1.ECON.1.3")
## Plot
tmp <- sybdata.df[sybdata.df$FAOST_CODE != 198,]
tmp$EA.PRD.AGRI.KD <- tmp$EA.PRD.AGRI.KD / 1000

assign(plotInfo$plotName, 
       
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
		                            Area %in% c(plotInfo$plotArea)")),
                data = tmp,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                #                 legend_lab = subset(meta.lst$FULL,
                #                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
       ) + scale_y_continuous(labels=french) +
         labs(y="constant 2000 thousand US$")
       
       )
rm(tmp)
## Export the plot
export_plot(placement="l")


# C.P1.ECON.1.4 -----------------------------------------------------------
# Annual value added in agriculture growth

## Info
plotInfo <- plot_info(plotName = "C.P1.ECON.1.4")

## Info
if (!("growth_NV.AGR.TOTL.KD" %in% names(sybdata.df))) {
  
  tmp <- sybdata.df[c("FAOST_CODE","Year","NV.AGR.TOTL.KD")] # Agriculture, value added (constant 2005 US$)
  tmp <- tmp[!is.na(tmp$NV.AGR.TOTL.KD),]
  tmp <- tmp[tmp$Year >= 2003 & tmp$Year <= 2013,]
  tmp <- arrange(tmp, FAOST_CODE,Year)
  library(plyr)
  d <- ddply(tmp,"FAOST_CODE",transform,
        Growth=c(NA,exp(diff(log(NV.AGR.TOTL.KD)))-1))
  dd <- d %>% group_by(FAOST_CODE) %>% dplyr::summarise(growth_NV.AGR.TOTL.KD = mean(Growth, na.rm = TRUE)*100)
  dd$Year <- 2013
  sybdata.df <- merge(sybdata.df,dd,by=c("FAOST_CODE","Year"),all.x=TRUE)
}
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(manual_text="Value added in agriculture, average annual growth (2003-2013)",placement="r")


# C.P1.ECON.1.5 -----------------------------------------------------------
# Annual value added in agriculture growth

## Info
plotInfo <- plot_info(plotName = "C.P1.ECON.1.5")


  # constant total gdp from world bank
  library(WDI)
  dat <- WDI(indicator = c("NY.GDP.MKTP.KD","iso3Code"), start=2000, end=2013)
  dl <- dat
  names(dl)[names(dl)=="year"] <- "Year"
  dl <- merge(dl,FAOcountryProfile[c("ISO2_WB_CODE","FAOST_CODE","UNSD_MACRO_REG_CODE","UNSD_SUB_REG_CODE")], by.x="iso2c",by.y="ISO2_WB_CODE",all.x=TRUE)
  
  dl <- na.omit(dl)
  
  # aggregates
  dl$UNSD_MACRO_REG_CODE[dl$UNSD_SUB_REG_CODE == 5206] <- 5205
  dl$UNSD_MACRO_REG_CODE[dl$UNSD_SUB_REG_CODE == 5207] <- 5205
  m49 <- dl %>% group_by(UNSD_MACRO_REG_CODE,Year) %>% dplyr::summarise(constant_gdp = sum(NY.GDP.MKTP.KD,na.rm=TRUE))
  names(m49) <- c("FAOST_CODE","Year","constant_gdp")
  m49world <- dl %>% group_by(Year) %>% dplyr::summarise(constant_gdp = sum(NY.GDP.MKTP.KD,na.rm=TRUE))
  names(m49world) <- c("Year","constant_gdp")
  m49world$FAOST_CODE <- 5000
  
  dl$UNSD_MACRO_REG_CODE <- NULL
  dl$UNSD_SUB_REG_CODE <- NULL
  d <- rbind(m49,m49world)
  
  # nominator from sybdata
  ff <- sybdata.df[c("FAOST_CODE","FAO_TABLE_NAME","Year","NV.AGR.TOTL.KD")]
  ff <- ff[ff$FAOST_CODE >= 5000,]
  ff <- merge(ff,d,c("FAOST_CODE","Year"))
  
  ff <- ff[ff$FAOST_CODE %in% c(5100,5300,5205,5400,5500),]
  
  
  dat <- ff %>%  group_by(FAO_TABLE_NAME,Year) %>% mutate(share = NV.AGR.TOTL.KD/constant_gdp*100)
  dat <- dat[!is.na(dat$share),]
  dat <- dat[!is.infinite(dat$share),]
    

#plotInfo$legendLabels <- c("Africa","Asia","Europe","Oceania")

## Plot
assign(plotInfo$plotName, 
       
       ggplot(data = dat, aes(x = Year, y = share,group=FAO_TABLE_NAME,color=FAO_TABLE_NAME)) +
         geom_line() +
         scale_color_manual(values = plot_colors(part = 1, 5)[["Sub"]]) +
         labs(y="percent", x="") +
         coord_cartesian(ylim=c(0,15))

       )
## Export the plot


# This is commented because I had to manually (in Inkscape) remove the 
# Americas from the legend.. june 30. 2015 - Markus
# export_plot(placement="b")

export_plot(manual_text="Value added in agriculture as share of GDP",placement="b")




## ------------------------------------------------------------------------
# MAPS

# Value added in agriculture as share of GDP

## Map info
mapInfo <- map_info(mapName = "M.P1.ECON.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName,meta_plot_map() )
## export the map
export_map(manual_text="Value added in agriculture, share of GDP (percent, 2010 to 2013*)")

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
plotInfo$legendLabels <- c(" Female employment in agriculture")
if (!("female_share_agr_empl" %in% names(sybdata.df))) {
  
  
  dat <- read.csv("./database/Data/Raw/female_male_amployment_macroregions.csv", stringsAsFactors = FALSE)
  dat <- dat[c("AreaCode","Year","ElementName","Value")] 
  dat <- na.omit(dat)
  dat <- dat[!duplicated(dat[c("AreaCode","Year","ElementName")]),]
  dat <- spread(dat , ElementName, Value)
  names(dat) <- str_replace_all(names(dat), " ", ".")
  dat$female_share <- dat$Female.economically.active.population.in.Agr / dat$Female.economically.active.population * 100
  dat$male_share <- dat$Male.economically.active.population.in.Agr / dat$Male.economically.active.population * 100
  dat <- dat[c("AreaCode","Year","male_share","female_share")]
  names(dat) <- c("FAOST_CODE","Year","male_share_agr_empl","female_share_agr_empl")
  dat$Year <- as.numeric(dat$Year)
  dat$FAOST_CODE <- as.numeric(dat$FAOST_CODE)
  sybdata.df <- merge(sybdata.df,dat,bt=c("FAOST_CODE","Year"), all.x=TRUE)
}

#plotInfo$plotYears <- c(min(plotInfo$plotYears),max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=6) )
## Export the plot
export_plot(manual_text="Female employment in agriculture, share of female employment (2000-2014)",placement = "b")


## ------------------------------------------------------------------------
# MAPS

# Value added in agriculture as share of GDP

## Map info
mapInfo <- map_info(mapName = "M.P1.LABO.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName,meta_plot_map() )
## export the map
export_map()


# mapInfo <- map_info(mapName = "M.P4.WATER.1.6", data = sybMaps.df, mapArea = "Territory")
# ## Create the map
# assign(mapInfo$mapName, meta_plot_map() )
# ## export the map
# export_map(manual_text="Freshwater resources withdrawn by agriculture (percent, 1999-2013)")






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
tmp <- sybdata.df[sybdata.df$FAOST_CODE != 200,] # singapore
tmp <- tmp[tmp$FAOST_CODE != 179,]
## Plot
assign(plotInfo$plotName, 
       
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
		                            Area %in% c(plotInfo$plotArea)")),
                data = tmp,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                #                 legend_lab = subset(meta.lst$FULL,
                #                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
       ) + scale_y_continuous(labels=french)
       
       )
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
tmp <- sybdata.df[sybdata.df$FAOST_CODE != 156,] # New Zeraland
## Plot
assign(plotInfo$plotName, 
       
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
		                            Area %in% c(plotInfo$plotArea)")),
                data = tmp,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                #                 legend_lab = subset(meta.lst$FULL,
                #                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
       ) + scale_y_continuous(labels=french)
       
       
       )
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
  invest1 <- invest1[invest1$Year >= 1995,]
  sybdata.df <- full_join(sybdata.df,invest1)
}
plotInfo$legendLabels <- c(" Agriculture, narrow","Agriculture, broad")
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
                legend_lab = plotInfo$legendLabels,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
       ) + scale_y_continuous(labels=french) +
         coord_cartesian(xlim=c(1995,2013))
       
       
       )
## Export the plot
export_plot(manual_text = "Aid flows to agriculture, share of total aid (1995-2013)", placement = "tr")
# 
# ## ------------------------------------------------------------------------
# # Top ten countries, credit to agriculture as a share of total credit

# 
## Info
plotInfo <- plot_info(plotName = "C.P1.INV.1.3")
plotInfo$plotYears <- c(min(plotInfo$plotYears),max(plotInfo$plotYears))

if (!("credit_to_agriculture" %in% names(sybdata.df))) {
  gg <- read.csv("./database/Data/Raw/credit_to_agriculture.csv")
  gg <- gg[gg$ElementName == "Value US$",] 
  gg <- gg[gg$ItemName == "Total Credit",] 
  # into millions
  gg$Value <- gg$Value / 1000000
  df2016 <- filter(gg, Year %in% c(1999:2001)) %>% group_by(AreaCode) %>% dplyr::summarise(value = mean(Value, na.rm=TRUE))
  df2016$Year <- 2000
  df2017 <- filter(gg, Year %in% c(2010:2012)) %>% group_by(AreaCode) %>% dplyr::summarise(value = mean(Value, na.rm=TRUE))
  df2017$Year <- 2012
  
  tmp <- rbind(df2016,df2017)
  names(tmp) <- c("FAOST_CODE","credit_to_agriculture","Year")
  
  sybdata.df <- merge(sybdata.df,tmp,by=c("FAOST_CODE","Year"), all.x=TRUE)  
}


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
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) + scale_y_continuous(labels=french) +
         labs(y="million US$")
       )
C.P1.INV.1.3 <- C.P1.INV.1.3 + 
  scale_fill_manual(labels = c("1999-2001", "2010-12"),
                    values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
  scale_color_manual(labels = c("1999-2001", "2010-12"),
                     values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
## Export the plot
export_plot(manual_text="Total credit to agriculture, top 20 countries in 2014 (2000 and 2012)",placement = "l")
# 
# ## ------------------------------------------------------------------------
# ## ------------------------------------------------------------------------
# # Top ten countries, credit to agriculture as a share of total credit
# 
## Info
plotInfo <- plot_info(plotName = "C.P1.INV.1.4")

if (!("agri_orientation_index" %in% names(sybdata.df))) {
  library(readxl)
  gg <- read_excel("./database/Data/Raw/investments/Lowest and Top 20 AOI GEA_final_Stat Pocketbook.xlsx")
  gg <- gg[c(3,5)]
  gg$Year <- 2010
  names(gg)[names(gg)=="AOI average (2008-2012)"] <- "agri_orientation_index"
  names(gg)[names(gg)=="countrycode"] <- "FAOST_CODE"
  sybdata.df <- merge(sybdata.df,gg,by=c("FAOST_CODE","Year"), all.x=TRUE)  
}

assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(manual_text="Agri-Orientation Index, highest and lowest values (average 2008-2012)",placement = "l")


# 
# ## ------------------------------------------------------------------------
# ODA received in agriculture, forestry and fishing sectors, share of total ODA

## Info
plotInfo <- plot_info(plotName = "C.P1.INV.1.5")
## Plot
if (!("Bilateral" %in% names(sybdata.df)) & !("Multilateral" %in% names(sybdata.df))) {
  load("./database/Data/Processed/invest2.RData")
  invest2 <- invest2[invest2$Year >= 1995,]
  sybdata.df <- full_join(sybdata.df,invest2)
}
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
                #                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
       ) + scale_y_continuous(labels=french) +   labs(y="million constant US$")
       
       
       )
## Export the plot
export_plot(manual_text = "Aid flows to agriculture, broad (1995-2013)", placement = "b")

## ------------------------------------------------------------------------
# MAPS

# df <- merge(mapInfo$mapData,FAOcountryProfile[c("FAOST_CODE","FAO_TABLE_NAME")],by.x="FAO_CODE",by.y="FAOST_CODE")
# df <- df[-4]
# df <- arrange(df, -IG.AFFH.STOCGG.USD.SH)
# write.csv(df, file="~/share_of_government_expenditure.csv", row.names=FALSE)

# Share of Government Expenditures on Agriculture (% of Total Outlays)

## Map info


if (!("IG_23101_6111_mean" %in% names(sybMaps.df))){
  
  dat <- getFAOtoSYB(domainCode = "IG", 
                     elementCode = 6111,
                     itemCode = 23101)
  dat <- dat[["entity"]]
  dat <- filter(dat, Year >= 2008)
  dat <- filter(dat, Year <= 2012)
  
  tmp1 <- dat %>% group_by(FAOST_CODE) %>%  dplyr::summarise(IG_23101_6111_mean = mean(IG_23101_6111, na.rm=TRUE))
  tmp2 <- dat %>% group_by(FAOST_CODE) %>% mutate(maxyear = max(Year))
  tmp2 <- tmp2[tmp2$Year == tmp2$maxyear,]
  tmp2$maxyear <- NULL
  tmp2$Year <- 2015
  tmp1$Year <- 2015
  
  names(tmp1)[names(tmp1)=="FAOST_CODE"] <- "FAO_CODE"
  names(tmp2)[names(tmp2)=="FAOST_CODE"] <- "FAO_CODE"
  
  sybMaps.df <- merge(sybMaps.df,tmp1,by=c("FAO_CODE","Year"),all.x=TRUE)
  sybMaps.df <- merge(sybMaps.df,tmp2,by=c("FAO_CODE","Year"),all.x=TRUE)
}

#mapInfo <- map_info(mapName = "M.P1.INV.1.6", data = sybMaps.df, mapArea = "Territory")
#mapInfo <- map_info(mapName = "M.P1.INV.1.6_1", data = sybMaps.df, mapArea = "Territory")
mapInfo <- map_info(mapName = "M.P1.INV.1.6_2", data = sybMaps.df, mapArea = "Territory")

## Create the map
assign(mapInfo$mapName,meta_plot_map() )
## export the map
export_map(manual_text="Share of government expenditure on agriculture, share of total outlays (percent,
2008 to 2012*)")


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

dat <- dat[!duplicated(dat[c("FAOST_CODE","Year")]),]

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
         labs(y="million people")
)
# Export
export_plot(manual_text= "Asian countries with the highest number of undernourished in 2014-16", placement = "l")


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
         labs(y="million people")
)
# Export
export_plot(manual_text= "African countries with the highest number of undernourished in 2014-16", placement = "l")



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
       ) + labs(y="million people") +
         scale_x_continuous(breaks = c(1991, 2000, 2005, 2010, 2015),
                            labels = c("1990-92", "1999-2001", "2004-06", "2009-11", "2014-16"))
       
)
## Export the plot
export_plot(manual_text = "Number of people undernourished", placement = "b")


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
export_map(manual_text = "Prevalence of undernourishment (percent, 2014-16)")




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
) + guides(color = guide_legend(nrow = 3)) +
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
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
       ) + scale_color_manual(labels = c("1999-2001", "2009-2011"),
                              values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
         scale_fill_manual(labels = c("1999-2001", "2009-2011"),
                           values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
)


## Export the plot
export_plot(manual_text="Energy supply derived from cereals, roots and tubers, top 20 countries in 2009-2011",placement="l")





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
       ) + scale_color_manual(labels = c("1999-2001", "2009-2011"),
                             values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
         scale_fill_manual(labels = c("1999-2001", "2009-2011"),
                            values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
       )
## Export the plot
export_plot(manual_text="Average protein supply, top 20 countries in 2009-2011",placement="r")


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
        ) + scale_x_continuous(breaks = c(1991, 2001, 2004, 2010),
                               labels = c("1990-92", "2000-02", "2003-05", "2009-11")) +
         theme(axis.text.x = element_text(angle = 45))
       )
## Export the plot
export_plot(manual_text="Average supply of protein of animal origin",placement = "b")


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
                manualBreaks = c(0, 100, 150, 200, 300, 2302),
                #                 countryCodeTransp = transpCountries[, "FAO_CODE"],
                subset = eval(parse(text = "Year %in% c(mapInfo$mapYear) &
                                  Area %in% c(mapInfo$mapArea)"))
       ) 
       
)
## export the map
export_map(manual_text="Average value of food production, constant 2004-2006 I$ per person (3 year average, 2011-13)")


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
       ) + guides(fill = guide_legend(nrow = 3), color = guide_legend(nrow = 3)) +
         scale_x_continuous(breaks = c(1991, 2001, 2006, 2013, 2015),
                            labels = c("1990-92", "2000-02", "2005-07", "2012-14", "2014-16")) +
         theme(axis.text.x = element_text(angle = 45))
)       
## Export the plot
export_plot(manual_text="Depth of food decifit, kcal/capita/day (3 year averages)",placement="tr")


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
export_plot(manual_text="Domestic food price level index, top 20 countries in 2014 (2000 to 2014*)",placement="l")


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
       )  + scale_fill_manual(labels = c("1999-2001", "2014-16"),
                              values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
         scale_color_manual(labels = c("1999-2001", "2014-16"),
                            values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
)

## Export the plot
export_plot(manual_text="Prevalence of undernourishment, highest 20 countries in 2014-16 (3 year averages)", placement="r")


# ----------------------------------------------------------------------- #
# Prevalence of food inadequacy, 3 year averages

## Info
plotInfo <- plot_info(plotName = "C.P2.ACCESS.1.5")
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
       ) 
)
## Export the plot
export_plot(manual_text="GDP per capita, PPP, constant 2011 international $",placement = "b")


##### -------------------------------------------------------
# MAPS

# -----------------------------------------------------------
# Road density

## Map info
mapInfo <- map_info(mapName = "M.P2.ACCESS.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName, meta_plot_map() )
## export the map
export_map(manual_text="Road density, per 100 square km of land area (2007 to 2011*)")

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
       ) + guides(fill = guide_legend(nrow = 3), color = guide_legend(nrow = 3)) +
         #scale_x_continuous(breaks = c(2002, 2006, 2013),
        #                    labels = c("2001-03", "2005-07", "2012-14")) +
         theme(axis.text.x = element_text(angle = 45))
)   
## Export the plot
export_plot(manual_text = "Per capita food production variability, constant 2004-2006 thousand international $",placement="tr")

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
export_plot(manual_text="Per capita food supply variability, top 20 countries in 2011, kcal/capita/day",placement="l")


# Checking the chart above 

ff <- plot.data[c("SHORT_NAME","Year","FS.DS.PCFSV.KCDD")]


#FS.DS.PCFSV.KCDD

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

export_plot(manual_text="Domestic food price volatility index, top 20 countries in 2014",placement="r")


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
       ) + scale_fill_manual(labels = c("1999-2001", "2009-2011"),
                             values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
         scale_color_manual(labels = c("1999-2001", "2009-2011"),
                             values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
       
       )
## Export the plot
export_plot(manual_text=" Value of food imports  as a share of total merchandise exports (3 year averages)",placement = "b")


##### -------------------------------------------------------
# MAPS

# Political stability and absence of violence/terrorism

if (!("G.GD.PSAVT.IN" %in% names(sybMaps.df))) {
  sybMaps.df <- merge(sybMaps.df,dat[c("Year","FAOST_CODE","G.GD.PSAVT.IN")],by.x=c("Year","FAO_CODE"),by.y=c("Year","FAOST_CODE"),all.x=TRUE)
}

## Map info
mapInfo <- map_info(mapName = "M.P2.STB.1.6", data = sybMaps.df, mapArea = "Territory")
mapInfo$mapData$FAO_CODE[mapInfo$mapData$FAO_CODE == 351] <- 41

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
                manualBreaks = c(-2.89, -1.3, 0, 0.4, 1, 1.92),
                #                 countryCodeTransp = transpCountries[, "FAO_CODE"],
                subset = eval(parse(text = "Year %in% c(mapInfo$mapYear) &
                                  Area %in% c(mapInfo$mapArea)"))
       ) 
       )

## export the map
export_map(manual_text="Political stability and absence of violence/terrorism, index (2013)")



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

df2014 <- filter(sybdata.df, Year %in% c(2006:2014)) %>% group_by(FAOST_CODE) %>% dplyr::summarise(value = mean(SH.STA.STNT.ZS, na.rm=TRUE))
df2014$Year <- 2015
names(df2014) <- c("FAOST_CODE","new_var","Year") 
sybdata.df <- merge(sybdata.df,df2014,by=c("FAOST_CODE","Year"),all.x=TRUE)
sybdata.df$SH.STA.STNT.ZS <- ifelse(sybdata.df$Year == 2015, sybdata.df$new_var, sybdata.df$SH.STA.STNT.ZS)
sybdata.df$new_var <- NULL

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
export_plot(manual_text="Percentage of children under 5 who are stunted, highest 20 countries (2006 - 2014*)" ,placement="l")

fileConn<-file("./publication/Captions/Caption_C.P2.UT.1.3.tex")
writeLines(c("\\caption{Percentage of children under 5 who are stunted, highest 20 countries \\hspace{10 mm} (2006 - 2014*)}"), fileConn)
close(fileConn)


# ----------------------------------------------------------------------- #
# Percentage of children under 5 years of age affected by wasting

## Info
plotInfo <- plot_info(plotName = "C.P2.UT.1.4")
df2014 <- filter(sybdata.df, Year %in% c(2006:2014)) %>% group_by(FAOST_CODE) %>% dplyr::summarise(value = mean(SH.STA.WAST.ZS, na.rm=TRUE))
df2014$Year <- 2015
names(df2014) <- c("FAOST_CODE","new_var","Year") 
sybdata.df <- merge(sybdata.df,df2014,by=c("FAOST_CODE","Year"),all.x=TRUE)
sybdata.df$SH.STA.WAST.ZS <- ifelse(sybdata.df$Year == 2015, sybdata.df$new_var, sybdata.df$SH.STA.WAST.ZS)
sybdata.df$new_var <- NULL

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
export_plot(manual_text = " Percentage of children under 5 affected by wasting, highest 20 countries (2006 - 2014*)",placement="r")

fileConn<-file("./publication/Captions/Caption_C.P2.UT.1.4.tex")
writeLines(c("\\caption{Percentage of children under 5 affected by wasting, highest 20 countries \\hspace{10 mm} (2006 - 2014*)}"), fileConn)
close(fileConn)


# ----------------------------------------------------------------------- #
# Access to improved water source and to improved sanitation facilities 

## Info
plotInfo <- plot_info(plotName = "C.P2.UT.1.5")
plotInfo$legendLabels <- c("Water source","Sanitation facilities")
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
                legend_lab = plotInfo$legendLabels,
                col_pallete = plot_colors(part = plotInfo$plotPart, 3)[["Sub"]]
       )
       
       )

## Export the plot
export_plot(manual_text="Access to improved water source and sanitation facilities",placement = "b")



##### -------------------------------------------------------
# MAPS

# Percentage of anaemia among children <5 years of age

## Map info
mapInfo <- map_info(mapName = "M.P2.UT.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName, meta_plot_map() )
## export the map
export_map(manual_text="Percentage of anaemia among children under 5, percent (2011)")



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

# DES pie chart
load("../ICN2PB14/Data/Processed/icn2.RData")
## Plot
despie <- icn2.df[icn2.df$Year %in% c(2009:2011), c("FAOST_CODE","Year","FAO_TABLE_NAME","FBS.SDES.CRLS.PCT3D","FBS.SDES.SR.PCT3D","FBS.SDES.SS.PCT3D","FBS.SDES.MO.PCT3D","FBS.SDES.VOAF.PCT3D","FBS.SDES.MEB.PCT3D")]
despie <- despie[despie$FAOST_CODE %in% "5000",]

dw <- gather(despie,
             "var",
             "value",
             4:9)
d <- dw %>% group_by(var) %>% dplyr::summarise(mean = mean(value))
d <- d  %>% mutate(sum = sum(mean)) 

d$var <- as.character(d$var)
d$var[d$var == "FBS.SDES.CRLS.PCT3D"] <- "Cereals\n(excl. beer)"
d$var[d$var == "FBS.SDES.SR.PCT3D"] <- "Starchy roots"
d$var[d$var == "FBS.SDES.SS.PCT3D"] <- "Sugar and\nsweeteners"
d$var[d$var == "FBS.SDES.MO.PCT3D"] <- "Meat and offals"
d$var[d$var == "FBS.SDES.VOAF.PCT3D"] <- "Milk\n(excl. butter)"
d$var[d$var == "FBS.SDES.MEB.PCT3D"] <- "Veg. oils and\nanimal fats"

p <- ggplot(d, aes(x=sum/2, y = mean, fill = var, width = sum))
p <- p + geom_bar(position="fill", stat="identity") 
p <- p + coord_polar("y")
p <- p + theme_minimal()
p <- p + theme(legend.position = "right")
p <- p + theme(text = element_text(size=11, family="PT Sans"))
p <- p + theme(axis.text = element_blank())
p <- p + theme(axis.title = element_blank())
p <- p + theme(axis.ticks = element_blank())
p <- p + theme(panel.grid.minor = element_blank())
p <- p + theme(panel.grid.major = element_blank())
p <- p + scale_fill_manual(values=rev(colPart3$Sub))
p <- p + theme(legend.title = element_blank())
p <- p + theme(legend.key.height = unit(7, "mm"))
p <- p + theme(legend.key.width = unit(3, "mm"))
p <- p + theme(panel.grid=element_blank(), panel.border=element_blank())
p <- p + labs(x=NULL, y=NULL)
p <- p + theme(plot.margin=unit(c(0,0,0,0),"mm"))
ggsave(p, filename = "./publication/Plots/C.P3.DES.1.2.pdf", width=  3, height = 2.5)
embed_fonts("./publication/Plots/C.P3.DES.1.2.pdf")



# ----------------------------------------------------------------------- #
# Dietary energy supply, top 20 (2000-02 vs. 2009-11)

## Info
plotInfo <- plot_info(plotName = "C.P3.DES.1.3")
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
                  
       ) + scale_y_continuous(labels=french, breaks=c(2500,3000,3500))
       
       )
## Export the plot
export_plot(manual_text=" Dietary energy supply, top 20 countries in 2015", placement="l")


# ----------------------------------------------------------------------- #
# Dietary energy supply, bottom 20 (2000-02 vs. 2009-11)

## Info
plotInfo <- plot_info(plotName = "C.P3.DES.1.4")
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
       ) + scale_y_continuous(labels=french, breaks=c(1800,2000,2200))
       
       
       )
## Export the plot
export_plot(manual_text=" Dietary energy supply, bottom 20 countries in 2015",placement="r")



# ----------------------------------------------------------------------- #
# DES (kcal/cap/day)

## Info
plotInfo <- plot_info(plotName = "C.P3.DES.1.5")
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
  #              legend_lab = subset(meta.lst$FULL,
  #                                 subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 6)[["Sub"]]
       )
       
       )
## Export the plot
export_plot(manual_text = " Dietary energy supply, kcal/cap/day", placement = "b")


##### -------------------------------------------------------
# MAPS

# DES (kcal/cap/day), 2009-11

## Map info

if (!("FS.DA.ADESA.PCT3D" %in% names(sybMaps.df))) {
  
  dat <- read.csv("./database/Data/Raw/FSI2015_DisseminationDataset.csv", stringsAsFactors=FALSE)
  dat <- dat[c("FAOST_CODE","Year","FS.DA.ADESA.PCT3D")]
  dat <- dat[!is.na(dat$FS.DA.ADESA.PCT3D),]
  sybMaps.df <- merge(sybMaps.df,dat,by.x=c("FAO_CODE","Year"),by.y=c("FAOST_CODE","Year"),all.x=TRUE)
}


mapInfo <- map_info(mapName = "M.P3.DES.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName, meta_plot_map() )
## export the map
export_map(manual_text="Average dietary energy supply adequacy, percent (2014-2016)")





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
export_plot(manual_text="Top 20 crop producing countries in 2012 based on net per capita crop production value",placement="l")


# -----------------------------------------------------------
# 4. Top 20 food producing countries (based on food net per capita production value (per capita constant 2004-2006 I$)), 2000 vs. MRY

## Info
plotInfo <- plot_info(plotName = "C.P3.CRPRO.1.4")
plotInfo$plotYears <- c(min(plotInfo$plotYears),max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=2) )
## Export the plot
export_plot(manual_text="Top 20 food producing countries in 2012 based on net food per capita production value",placement="r")

# -----------------------------------------------------------
# 5. Bar chart: Growth in cereals production (production, harvested area, yield), world, 2000-MRY


## Info
if (!("change_QC.YIELD.CRLS.HG.NO" %in% names(sybdata.df))) {

  tmp <- sybdata.df[sybdata.df$FAOST_CODE %in% 5000,c("FAOST_CODE","Year","Area","QC.PRD.CRLS.TN.NO", # Cereals production (tonnes)
                                                      "QC.RHRV.CRLS.HA.NO", # Cereals harvested area (ha)
                                                      "QC.YIELD.CRLS.HG.NO")] # Cereals yield (hg/ha)
  tmp <- tmp[!is.na(tmp$Area),]
  tmp <- tmp[!is.na(tmp$QC.PRD.CRLS.TN.NO),]
  tmp <- tmp[tmp$Year >= 2000,]
  tmp <- gather(tmp,
                variable,
                value,
                4:6)
  # Annual growth rate - geometric mean http://stackoverflow.com/questions/19824601/how-calculate-growth-rate-in-long-format-data-frame
  d <- ddply(tmp,"variable",transform,
             Growth=c(NA,exp(diff(log(value)))-1))
  dd <- d %>% group_by(variable) %>% dplyr::summarise(mean_growth = mean(Growth, na.rm = TRUE)*100)
  dd$FAOST_CODE <- 5000
  tmp <- dd
  tmp$variable <- as.character(tmp$variable)
  tmp$variable <- paste0("change_",tmp$variable)
  tmp <- spread(tmp,
                variable,
                mean_growth)
  tmp$Year <- 2013
  sybdata.df <- merge(sybdata.df,tmp,by=c("FAOST_CODE","Year"),all.x=TRUE)
}

plotInfo <- plot_info(plotName = "C.P3.CRPRO.1.5")
plotInfo$legendLabels <- c("Production quantity","Harvested area","Yield")
## Plot

assign(plotInfo$plotName, meta_plot_plot(plot_type = "3ml", n_colors=3) )
## Export the plot
export_plot(manual_text = "Average annual growth in cereals production (2000-13)",placement="b")

##### -------------------------------------------------------
# MAPS

# 6. Map: Crops, gross per capita production (2004-06 = 100)

## Map info
mapInfo <- map_info(mapName = "M.P3.CRPRO.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName, meta_plot_map() )
## export the map
export_map(manual_text="Crops, gross per capita production index (2004-06 = 100, 2013)")


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
export_plot(manual_text="Top 20 rice producing countries, per capita",placement="l")


# -----------------------------------------------------------
# 4. Top 20 WHEAT producing countries per capita (Rice (paddy) production per capita (tonne/cap))

## Info
plotInfo <- plot_info(plotName = "C.P3.CRTRE.1.4")
plotInfo$plotYears <- c(min(plotInfo$plotYears),max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=2) )
## Export the plot
export_plot(manual_text="Top 20 wheat producing countries, per capita ",placement="r")

# -----------------------------------------------------------
# 5. Line chart: yield by region, 2000-MRY - This is an issue!

## Info
plotInfo <- plot_info(plotName = "C.P3.CRTRE.1.5")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=6) )
## Export the plot
export_plot(manual_text = "Cereals, yield", placement="b")


##### -------------------------------------------------------
# MAPS

# 6. Map: Cereal producing countries

## Map info
mapInfo <- map_info(mapName = "M.P3.CRTRE.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName, meta_plot_map() )
## export the map
export_map(manual_text ="Cereal production, tonnes/cap (2013)")


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
# into millions tonnes
sybdata.df$QL.PRD.MILK.TN.NO <- sybdata.df$QL.PRD.MILK.TN.NO / 1000000
#
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
                #                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
       ) + scale_y_continuous(labels=french) + labs(y="milllion tonnes")
       
       )
## Export the plot
export_plot(manual_text = "Total milk production, top and bottom 10 countries (2012)", placement="l")

# -----------------------------------------------------------
# Per capita egg production, top 10 and bottom 10

## Info
plotInfo <- plot_info(plotName = "C.P3.LIVE.1.4")
# into millions tonnes
sybdata.df$QL.PRD.EGG.TN.NO <- sybdata.df$QL.PRD.EGG.TN.NO / 1000000
#
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
                #                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
       ) + scale_y_continuous(labels=french, limits=c(0,32)) + labs(y="milllion tonnes")
         
       
)
## Export the plot
export_plot(manual_text = "Total egg production, top and bottom 10 countries (2012)", placement="r")


# -----------------------------------------------------------
# Proportional pie charts on pig production, by region, 2000 vs. MRY

## Piechart for livestock

load("./database/Data/Raw/Production_Livestock_E_All_Data.RData")
d <- dat[dat$CountryCode %in% c(5100,5200,5300,5400,5500),] # World
d <- d[d$Item == "Pigs",]
d <- d[d$Year %in% c(2000,2013),]
d <- d  %>% group_by(Year) %>% mutate(sum = sum(Value)) 
d$share <- round(d$Value/d$sum*100,0)
d$Country <- str_replace_all(d$Country, "\\ \\+\\ \\(Total\\)","")

colPart3 <- plot_colors(part = 3, 12)


d <- d %>% group_by(Year) %>% mutate(pos = cumsum(share)- share/2)

p <- ggplot(d, aes(x=sum/2, y = share, fill = Country, width = sum))
p <- p + geom_bar(position="fill", stat="identity") 
p <- p + facet_wrap(~Year)
p <- p + coord_polar("y")
p <- p + theme_minimal()
p <- p + theme(legend.position = "top")
p <- p + theme(text = element_text(size=11, family="PT Sans"))
p <- p + theme(axis.text = element_blank())
p <- p + theme(axis.title = element_blank())
p <- p + theme(axis.ticks = element_blank())
p <- p + theme(panel.grid.minor = element_blank())
p <- p + theme(panel.grid.major = element_blank())
p <- p + scale_fill_manual(values=rev(colPart3$Sub))
p <- p + theme(legend.title = element_blank())
p <- p + theme(legend.key.size = unit(3, "mm"))
p <- p + labs(x=NULL, y=NULL)
p <- p + theme(plot.margin=unit(c(0,0,0,0),"mm"))
ggsave(p, filename = "./publication/Plots/C.P3.LIVE.1.5.pdf", width=  6, height = 3)
embed_fonts("./publication/Plots/C.P3.LIVE.1.5.pdf")


##### -------------------------------------------------------
# MAPS
# 6. Map: Cattle/buffaloes per sq km

## Map info
mapInfo <- map_info(mapName = "M.P3.LIVE.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName, meta_plot_map() )
## export the map
export_map(manual_text="Cattle and buffaloes per ha of agricultural area, heads per ha (2012)")


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
# DATA MUNGING FROM GRAPHS AND TABLES
##########################################################################

dim(sybdata.df)
if (!("production_quantity_index" %in% names(sybdata.df))) {
 source("./dissemination/Rcode/Final/manual_data_functions/fisheries2015_pocketbook.R")
}
dim(sybdata.df)
## net_fish_trade - to be uised in country profile tables



##########################################################################







# 2. Stacked area graph: aquaculture vs. capture production

## Info
plotInfo <- plot_info(plotName = "C.P3.FISH.1.2")

if (!("per_capita_catch" %in% names(sybdata.df))){
  
  library(readxl)
  library(tidyr)
  dat <- read_excel("./database/Data/Raw/FISH_percapita_production2015.xlsx")
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
       )  + labs(y="kg/cap") + guides(fill = guide_legend(nrow = 3), color = guide_legend(nrow = 3)) +
  scale_x_continuous(breaks=c(1990,1995,2000,2005,2010,2013))
       
       )

# Export plot
export_plot(manual_text = "Per capita fish food supply", placement = "tr")

# -----------------------------------------------------------
# 20 countries with highest value of capture production

## Info
plotInfo <- plot_info(plotName = "C.P3.FISH.1.3")

plotInfo$xAxis <- "capture_fish_production"

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
                #                 legend_lab = subset(meta.lst$FULL,
                #                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
       ) + scale_y_continuous(labels=french) + labs(y="million tonnes")
       
       
       )
## Export the plot
export_plot(manual_text = "20 countries with highest value of capture production (2013)", placement="l")

# -----------------------------------------------------------
# 20 countries with highest value of aquaculture production

## Info
plotInfo <- plot_info(plotName = "C.P3.FISH.1.4")
plotInfo$xAxis <- "aquaculture_fish_production"
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
                #                 legend_lab = subset(meta.lst$FULL,
                #                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
       ) + scale_y_continuous(labels=french) + labs(y="million tonnes")
       
)
## Export the plot
export_plot(manual_text = "20 countries with highest value of aquaculture production (2013)", placement="r")

# 5. State of the world’s fishery stocks (see chart 79 in SYB2013)
# Has

plotInfo <- plot_info(plotName = "C.P3.FISH.1.5")

library(readxl)
dat <- read_excel("./database/Data/Raw/FISH_overfishing_etc2015.xlsx")
dat <- gather(dat, 
                  "X",
                  "value",
                    2:4)

dat$X <- as.character(dat$X)
dat$X[dat$X == "Underfished"] <- "Under or\nmoderately\nexploited"
dat$X[dat$X == "Fully fished"] <- "Fully\nexploited"
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


if (!("production_quantity_index" %in% names(sybMaps.df))) {
  sybMaps.df <- merge(sybMaps.df,sybdata.df[c("FAOST_CODE","production_quantity_index","Year")],by.x=c("FAO_CODE","Year"),by.y=c("FAOST_CODE","Year"), all.x=TRUE)
}


## Map info
mapInfo <- map_info(mapName = "M.P3.FISH.1.6", data = sybMaps.df, mapArea = "Territory")
# China 41 <- 351

mapInfo$mapData <- mapInfo$mapData[mapInfo$mapData$FAO_CODE != 41,]
mapInfo$mapData$FAO_CODE[mapInfo$mapData$FAO_CODE == 351] <- 41

## Create the map
assign(mapInfo$mapName, meta_plot_map() )
## export the map
export_map(manual_text="Fish production index (2004-06=100, 2013)")


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
export_plot(manual_text="Top food importing countries in 2012",placement="l")

fileConn<-file("./publication/Captions/Caption_C.P3.TRADE.1.3.tex")
writeLines(c("\\caption{Top food importing countries \\hspace{20 mm} in 2012 }"), fileConn)
close(fileConn)


# -----------------------------------------------------------
# Top food exporting countries in 2011 (UPDATE DATA)

## Info
plotInfo <- plot_info(plotName = "C.P3.TRADE.1.4")
plotInfo$plotYears <- c(min(plotInfo$plotYears),max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 3, n_colors=2) )
## Export the plot
export_plot(manual_text="Top food exporting countries in 2012",placement="r")

# -----------------------------------------------------------
# Exports of cereals (2000 to 2011)

## Info
plotInfo <- plot_info(plotName = "C.P3.TRADE.1.5")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=6) )
## Export the plot
export_plot(manual_text = "Cereal exports", placement="b")

##### -------------------------------------------------------
# MAPS

# 6. Map: Cereal producing countries

## Map info
mapInfo <- map_info(mapName = "M.P3.TRADE.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName, meta_plot_map() )
## export the map
export_map(manual_text="Import value index (2004-2006 = 100, 2011)")





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
export_plot(manual_text = "Arable land per capita, top 20 countries (2012)",placement="l")

# ----------------------------------------------------------------------- #
# Arable land per capita, bottom 20 countries
## Info
plotInfo <- plot_info(plotName = "C.P4.LAND.1.4")
## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(manual_text = "Arable land per capita, bottom 20 countries (2012)",placement="r")

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
export_map(manual_text="Cropland per capita, ha per cap (2012)")


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
## Info

# Data for plots 1.3 and 1.6

# water <- sybdata.df[c("FAO_TABLE_NAME","FAOST_CODE","Year","AQ.WAT.WATPCP.MC.NO","Area")]
# water2000 <- sybdata.df[sybdata.df$Year == 2000, c("FAO_TABLE_NAME","FAOST_CODE","Year","AQ.WAT.WATPCP.MC.NO","Area")]
# water2010 <- sybdata.df[sybdata.df$Year == 2010, c("FAO_TABLE_NAME","FAOST_CODE","Year","AQ.WAT.WATPCP.MC.NO","Area")]
# water2000 <- water2000[!is.na(water2000$AQ.WAT.WATPCP.MC.NO),]
# water2010 <- water2010[!is.na(water2010$AQ.WAT.WATPCP.MC.NO),]
# # top ten
# top_10 <- head(arrange(water2010, -AQ.WAT.WATPCP.MC.NO),10)
# top_00 <- water2000[water2000$FAOST_CODE %in% top_10$FAOST_CODE,]
# # bottom five
# bottom_5 <- tail(arrange(water2010, -AQ.WAT.WATPCP.MC.NO),5)
# bottom_00 <- water2000[water2000$FAOST_CODE %in% bottom_5$FAOST_CODE,]
# 
# topdata <- rbind(top_10,top_00)
# bottomdata <- rbind(bottom_5,bottom_00)


library(readxl)
g <- read_excel("./database/Data/Raw/UPDATEDWATER_WR_Capita_2000-2010.xlsx")
names(g) <- c("FAO_TABLE_NAME","Year2000","Year2010")
g <- gather(g, "Year", "per_capita_water_resources", 2:3)
g$Year <- as.character(g$Year)
g$Year[g$Year == "Year2000"] <- 2000
g$Year[g$Year == "Year2010"] <- 2010

g$Year <- factor(g$Year)
g$Year <- as.numeric(levels(g$Year))[g$Year]

# change country names for the merge to succeed
g$FAO_TABLE_NAME[g$FAO_TABLE_NAME == "United Arab Emirates"] <- "the United Arab Emirates"

g$FAO_TABLE_NAME[g$FAO_TABLE_NAME == "Bahamas"] <- "the Bahamas"
g$FAO_TABLE_NAME[g$FAO_TABLE_NAME == "Philippines"] <- "the Philippines"
g$FAO_TABLE_NAME[g$FAO_TABLE_NAME == "Bahamas"] <- "the Bahamas"
g$FAO_TABLE_NAME[g$FAO_TABLE_NAME == "Cape Verde"] <- "Cabo Verde"
#g$FAO_TABLE_NAME[g$FAO_TABLE_NAME == "Côte d'Ivoire"] <- "C\xf4te d'Ivoire"
g$FAO_TABLE_NAME[g$FAO_TABLE_NAME == "Comoros"] <- "the Comoros"
g$FAO_TABLE_NAME[g$FAO_TABLE_NAME == "Czech Republic"] <- "the Czech Republic"
g$FAO_TABLE_NAME[g$FAO_TABLE_NAME == "Democratic Republic of the Congo"] <- "the Democratic Republic of the Congo"
g$FAO_TABLE_NAME[g$FAO_TABLE_NAME == "Dominican Republic"] <- "the Dominican Republic"
g$FAO_TABLE_NAME[g$FAO_TABLE_NAME == "Gambia"] <- "the Gambia"
g$FAO_TABLE_NAME[g$FAO_TABLE_NAME == "Lao People's Democratic Republic"] <- "the Lao People's Democratic Republic"
g$FAO_TABLE_NAME[g$FAO_TABLE_NAME == "Netherlands"] <- "the Netherlands"
g$FAO_TABLE_NAME[g$FAO_TABLE_NAME == "Niger"] <- "the Niger"
g$FAO_TABLE_NAME[g$FAO_TABLE_NAME == "Russian Federation"] <- "the Russian Federation"
g$FAO_TABLE_NAME[g$FAO_TABLE_NAME == "Syrian Arab Republic"] <- "the Syrian Arab Republic"
g$FAO_TABLE_NAME[g$FAO_TABLE_NAME == "United Kingdom"] <- "the United Kingdom of Great Britain and Northern Ireland"
g$FAO_TABLE_NAME[g$FAO_TABLE_NAME == "United Republic of Tanzania"] <- "the United Republic of Tanzania"
g$FAO_TABLE_NAME[g$FAO_TABLE_NAME == "United States of America"] <- "the United States of America"

gg <- merge(g,FAOcountryProfile[c("FAOST_CODE","FAO_TABLE_NAME")],by="FAO_TABLE_NAME", all.x=TRUE)

# top ten
top_10 <- head(arrange(filter(gg, Year == 2010), -per_capita_water_resources),10)
top_10_00 <- gg[gg$Year == 2000 & gg$FAOST_CODE %in% unique(top_10$FAOST_CODE),]
topdata <- rbind(top_10,top_10_00)

# bottom five
bottom_5 <- head(arrange(filter(gg, Year == 2010), per_capita_water_resources),5)
bottom_5_00 <- gg[gg$Year == 2000 & gg$FAOST_CODE %in% unique(bottom_5$FAOST_CODE),]
bottomdata <- rbind(bottom_5,bottom_5_00)


#####

## Order bars
bottomdata$FAO_TABLE_NAME <- factor(bottomdata$FAO_TABLE_NAME, levels=arrange(bottomdata[bottomdata$Year == 2010,], -per_capita_water_resources)$FAO_TABLE_NAME)


plotInfo <- plot_info(plotName = "C.P4.WATER.1.2")

assign(plotInfo$plotName,
       
       ggplot(bottomdata, aes(x=FAO_TABLE_NAME,y=per_capita_water_resources,fill=factor(Year))) +
         geom_bar(stat="identity",position="dodge") +
         scale_fill_manual(values=plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
         labs(x=NULL,y=expression(m^"3"/yr/person)) +
         theme(axis.text.x = element_text(angle=45))
       
)

## Export the plot
export_plot(manual_text = "Countries with the lowest renewable water resources per capita",placement="tr")



plotInfo <- plot_info(plotName = "C.P4.WATER.1.3")

df2014 <- sybdata.df %>% group_by(FAOST_CODE) %>% dplyr::summarise(AQ.WAT.WWIND.MC.SH = mean(AQ.WAT.WWIND.MC.SH, na.rm=TRUE))
df2014$Year <- 2014
names(df2014) <- c("FAOST_CODE","new_var","Year") 
# remove NA
df2014 <- df2014[!is.na(df2014$new_var),]
# China
df2014$FAOST_CODE[df2014$FAOST_CODE == 357] <- 351
#
sybdata.df <- merge(sybdata.df,df2014,by=c("FAOST_CODE","Year"),all.x=TRUE)
sybdata.df$AQ.WAT.WWIND.MC.SH <- ifelse(sybdata.df$Year == 2014, sybdata.df$new_var, sybdata.df$AQ.WAT.WWIND.MC.SH)
sybdata.df$new_var <- NULL

## Plot
assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
export_plot(manual_text = "Freshwater withdrawal by industrial sector, share of total, highest 20 (1999 to 2013)",placement="l")

# ----------------------------------------------------------------------- #
# Freshwater withdrawal by agricultural sector, share of total, highest 20

## Info
plotInfo <- plot_info(plotName = "C.P4.WATER.1.4")

df2014 <- sybdata.df %>% group_by(FAOST_CODE) %>% dplyr::summarise(AQ.WAT.WWAGR.MC.SH = mean(AQ.WAT.WWAGR.MC.SH, na.rm=TRUE))
df2014$Year <- 2014
names(df2014) <- c("FAOST_CODE","new_var","Year") 
# remove NA
df2014 <- df2014[!is.na(df2014$new_var),]
# China
df2014$FAOST_CODE[df2014$FAOST_CODE == 357] <- 351
sybdata.df <- merge(sybdata.df,df2014,by=c("FAOST_CODE","Year"),all.x=TRUE)
sybdata.df$AQ.WAT.WWAGR.MC.SH <- ifelse(sybdata.df$Year == 2014, sybdata.df$new_var, sybdata.df$AQ.WAT.WWAGR.MC.SH)
sybdata.df$new_var <- NULL


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
                #                 legend_lab = subset(meta.lst$FULL,
                #                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
                ) + scale_y_continuous(labels=french, breaks=c(91,93,95,97,99))
       
)
## Export the plot
export_plot(manual_text = "Freshwater withdrawal by agricultural sector, share of total, highest 20 (1999 to 2013)",placement="r")

# ----------------------------------------------------------------------- #
# Let's produce a table here with top 10 countries with water resources per capita, 2000 vs. MRY

plotInfo <- plot_info(plotName = "C.P4.WATER.1.5")

topdata$FAO_TABLE_NAME <- factor(topdata$FAO_TABLE_NAME, levels=arrange(topdata[topdata$Year == 2010,], -per_capita_water_resources)$FAO_TABLE_NAME)

assign(plotInfo$plotName,
       
       ggplot(topdata, aes(x=FAO_TABLE_NAME,y=per_capita_water_resources,fill=factor(Year))) +
         geom_bar(stat="identity",position="dodge") +
         scale_fill_manual(values=plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
         labs(x=NULL,y=expression(m^"3"/yr/person)) +
         theme(axis.text.x = element_text(angle=45)) +
         scale_y_continuous(labels=french)
)


## Export the plot
export_plot(manual_text = "Countries with the highest renewable water resources per capita",placement="b")



# MAPS -----------------------------------------------------------
# Freshwater resources withdrawn by agriculture

## Map info


if (!("pooled.freshwater" %in% names(sybMaps.df))) {
  
  water <- sybMaps.df[c("FAO_CODE","Year","AQ.WAT.RFRWAGR.MC.SH")]
  water <- water[!is.na(water$AQ.WAT.RFRWAGR.MC.SH),]
  d <- water %>% group_by(FAO_CODE) %>% dplyr::summarise(pooled.freshwater = mean(AQ.WAT.RFRWAGR.MC.SH, na.rm = TRUE))
  d$Year <- 2014
  sybMaps.df <- merge(sybMaps.df,d,by=c("FAO_CODE","Year"), all.x=TRUE)
}

mapInfo <- map_info(mapName = "M.P4.WATER.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName, meta_plot_map() )
## export the map
export_map(manual_text="Freshwater resources withdrawn by agriculture (percent, 1999-2013*)")


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

if (!("total_pellets" %in% names(sybdata.df))) {
  library(gdata) # not changed into readxl
  dat <- read.xls("./database/Data/Raw//pellets/REN21_Global wood pellet production_2014 03 07.xlsx", sheet=2, skip=3)
  dat <- dat[1:7,]
  dat <- gather(dat,
                Year,
                total_pellets, 
                2:15)
  dat[[2]] <- as.character(dat[[2]])
  dat[[2]] <- str_replace_all(dat[[2]], "X", "")
  dat[[2]] <- factor(dat[[2]])
  dat[[2]] <- as.numeric(levels(dat[[2]]))[dat[[2]]]
  #
  dat[[3]] <- as.character(dat[[3]])
  dat[[3]] <- str_replace_all(dat[[3]], ",", "")
  dat[[3]] <- factor(dat[[3]])
  dat[[3]] <- as.numeric(levels(dat[[3]]))[dat[[3]]]
  dat <- dat[dat$X == "TOTAL",]
  dat$Year[is.na(dat$Year)] <- 2013
  dat$FAOST_CODE <- 5000
  dat$X <- NULL
  sybdata.df <- merge(sybdata.df,dat,by=c("FAOST_CODE","Year"),all.x=TRUE)
  }

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
                #                 legend_lab = subset(meta.lst$FULL,
                #                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 1)[["Sub"]]
       ) + scale_y_continuous(labels=french) + theme(legend.position = "none")
       
       )
## Export the plot
export_plot(manual_text="Global wood pellet production",placement = "tr")

# ----------------------------------------------------------------------- #
# Top 20 biofuel producing countries

## Info

## Plot

## Info
plotInfo <- plot_info(plotName = "C.P4.ENER.1.3")
## Plot

if (!("total_energy_in_argiculture" %in% names(sybdata.df))) {
  #codes_vs_names <- read.xls("./database/Data/Raw/pellets/Data_for_ESS.xlsx", sheet=1)
  codes_vs_names <- read_excel("./database/Data/Raw/pellets/Data_for_ESS.xlsx", sheet=1)
  codes_vs_names <- codes_vs_names[c("FAO Country code","Country")]
  codes_vs_names <- codes_vs_names[!duplicated(codes_vs_names[c("FAO Country code","Country")]),]
  names(codes_vs_names) <- c("FAOST_CODE","Country")
  codes_vs_names$Country <- as.character(codes_vs_names$Country)
  # reading the data
  #dat <- read.xls("./database/Data/Raw/pellets/Data_for_ESS.xlsx", sheet=2, skip=2, stringsAsFactors=TRUE)
  dat <- read_excel("./database/Data/Raw/pellets/Data_for_ESS.xlsx", sheet=2, skip=2)
  d <- dat[1:2]
  names(d) <- c("Country","total_energy_in_argiculture")
  d$total_energy_in_argiculture <- d$total_energy_in_argiculture / 1000 # into PJ
  d2 <- merge(d,codes_vs_names, by="Country",all.x=TRUE)
  d2$Country <- NULL
  d2$Year <- 2012
  d2 <- d2[!is.na(d2$total_energy_in_argiculture),]
  # China
  d2$FAOST_CODE[d2$FAOST_CODE == 41] <- 351
  sybdata.df <- merge(sybdata.df,d2,by=c("FAOST_CODE","Year"),all.x=TRUE)
  }

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
                #                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 1)[["Sub"]]
       ) + scale_y_continuous(labels=french) + labs(y="PJ")
       
       )
## Export the plot
export_plot(manual_text = "Total energy consumption in agriculture, top 20 countries (2012)",placement="l")


## Info
plotInfo <- plot_info(plotName = "C.P4.ENER.1.4")
## Plot

if (!("total_bioenergy_consumption" %in% names(sybdata.df))) {
  codes_vs_names <- read_excel("./database/Data/Raw/pellets/Data_for_ESS.xlsx", sheet=1)
  codes_vs_names <- codes_vs_names[c("FAO Country code","Country")]
  codes_vs_names <- codes_vs_names[!duplicated(codes_vs_names[c("FAO Country code","Country")]),]
  names(codes_vs_names) <- c("FAOST_CODE","Country")
  codes_vs_names$Country <- as.character(codes_vs_names$Country)
  # reading the data
  d <- read_excel("./database/Data/Raw/pellets/Data_for_ESS_1 AF_fixed.xlsx", sheet=3, skip=2)
  names(d) <- c("Country","total_bioenergy_consumption")
  d$total_bioenergy_consumption <- factor(d$total_bioenergy_consumption)
  d$total_bioenergy_consumption <- as.numeric(levels(d$total_bioenergy_consumption))[d$total_bioenergy_consumption]
  d2 <- merge(d,codes_vs_names, by="Country",all.x=TRUE)

  # Alessandros list of "selected countries"
  d2 <- d2[d2$Country %in% c("Algeria","Indonesia","Nicaragua","United States","Viet Nam","Italy",
                             "Australia","Germany","People's Republic of China","Brazil","Argentina",
                             "Dominican Republic","Cambodia","Japan","Kenya","Senegal",
                             "Turkey","Jamaica","Iraq","United Arab Emirates"),]
  d2$FAOST_CODE[d2$Country == "People's Republic of China"] <- 351
  d2$FAOST_CODE[d2$Country == "Cambodia"] <- 115
  d2$FAOST_CODE[d2$Country == "Italy"] <- 106
  d2$total_bioenergy_consumption <- d2$total_bioenergy_consumption * 100
  d2$Country <- NULL
  d2$Year <- 2012
  d2 <- d2[!is.na(d2$total_bioenergy_consumption),]
  sybdata.df <- merge(sybdata.df,d2,by=c("FAOST_CODE","Year"),all.x=TRUE)
}

assign(plotInfo$plotName, meta_plot_plot(plot_type = 2, n_colors=2) )
## Export the plot
#export_plot(manual_text = "Total bioenergy consumption in agriculture, top 20 countries (2012)", placement="r")
export_plot(manual_text = "Bioenergy as a % of total renewable energy, selected countries (2012)", placement="r")

# -----------------------------------------------------------
# Exports of cereals (2000 to 2011)

## Info
plotInfo <- plot_info(plotName = "C.P4.ENER.1.5")


if (!("biogases" %in% names(sybdata.df))) {
  library(gdata)
  # reading the data
#   dat <- read.xls("~/fao_temp/pocketbook_temp/pellets/Data_for_ESS.xlsx", sheet=4, skip=2)
#   dat <- gather(dat,
#                 "Year",
#                 "value",
#                 2:15)
#   dat$Year <- as.character(dat$Year)
#   dat$Year <- str_replace_all(dat$Year, "X", "")
#   dat$Year <- as.factor(dat$Year)
#   dat$Year <- as.numeric(levels(dat$Year))[dat$Year]
#   dat$Row.Labels <- as.character(dat$Row.Labels)
#   dat <- spread(dat, Row.Labels, value)
#   names(dat) <- tolower(names(dat))
#   names(dat) <- str_replace_all(names(dat), " ", ".")
#   dat$grand.total <- NULL
#   names(dat)[names(dat)=="year"] <- "Year"
#   dat$FAOST_CODE <- 5000
#   dat$Year[is.na(dat$Year)] <- 2013
#   sybdata.df <- merge(sybdata.df,dat,by=c("FAOST_CODE","Year"),all.x=TRUE)
  # R cant read the file, have to feed it in by hand
  
  dat <- read.csv("./database/Data/Raw/pellets/Data_for_ESS_1 AF_fixed_sheet.csv", stringsAsFactors = FALSE)
  dat <- gather(dat,
                "Year",
                "value",
                2:14)
  dat$Year <- as.character(dat$Year)
  dat$Year <- str_replace_all(dat$Year, "X", "")
  dat$Year <- as.factor(dat$Year)
  dat$Year <- as.numeric(levels(dat$Year))[dat$Year]
  dat$X <- as.character(dat$X)
  dat <- spread(dat, X, value)
  names(dat) <- tolower(names(dat))
  names(dat) <- str_replace_all(names(dat), " ", ".")
  names(dat)[names(dat)=="year"] <- "Year"
  dat$FAOST_CODE <- 5000
  dat$Year[is.na(dat$Year)] <- 2013
  sybdata.df <- merge(sybdata.df,dat,by=c("FAOST_CODE","Year"),all.x=TRUE)
}

plotInfo$legendLabels <- c("Biodiesel","Biogases","Biogasoline","Other liquid biofuels")

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
                legend_lab = plotInfo$legendLabels,
                col_pallete = plot_colors(part = plotInfo$plotPart, 4)[["Sub"]]
       )
       
       
       )
## Export the plot
export_plot(manual_text = "Biodiesel, biogas, biogasoline and other bio-oil consumption ",placement="b")

##### -------------------------------------------------------
# MAPS

# 6. Map: Cereal producing countries

if (!("energy.for.power.irrigation" %in% names(sybMaps.df))) {
  library(gdata)
  dat <- read.csv("./database/Data/Raw/pellets/energy_consumption_for_power_irrigation.csv", stringsAsFactors = FALSE)
  dat <- dat[c("AreaCode","Year","Value")]
  names(dat) <- c("FAOST_CODE","Year","energy.for.power.irrigation")
  
  sybMaps.df <- merge(sybMaps.df,dat,by.x=c("Year","FAO_CODE"),by.y=c("Year","FAOST_CODE"),all.x=TRUE)
}


## Map info
mapInfo <- map_info(mapName = "M.P4.ENER.1.6", data = sybMaps.df, mapArea = "Territory")
#mapInfo$mapData$FAO_CODE[mapInfo$mapData$FAO_CODE == 351] <- 41

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
                #manualBreaks = c(-2.89, -1.3, 0, 0.4, 1, 1.92),
                #                 countryCodeTransp = transpCountries[, "FAO_CODE"],
                subset = eval(parse(text = "Year %in% c(mapInfo$mapYear) &
                                  Area %in% c(mapInfo$mapArea)"))
       ) 
)

## export the map
export_map(manual_text = "Energy consumption for power irrigation, million kWh (2011)")


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

sybdata.df$FO.PRD.RP.M3.NO.bill <- sybdata.df$FO.PRD.RP.M3.NO / 1000000
sybdata.df$FO.PRD.WP.M3.NO.bill <- sybdata.df$FO.PRD.WP.M3.NO / 1000000
sybdata.df$FO.PRD.PPB.M3.NO.bill <- sybdata.df$FO.PRD.PPB.M3.NO / 1000000

plotInfo$legendLabels <- c(" Recovered paper","Wood pulp","Paper and paperboard")

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
                legend_lab = plotInfo$legendLabels,
                #y_lab = expression("    thousand gigagrams CO"[2] * "eq"),
                #legend_lab = subset(meta.lst$FULL,
                #                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 3)[["Sub"]]
       ) +
         scale_y_continuous(labels=french) +
         guides(fill = guide_legend(nrow = 3), color = guide_legend(nrow = 3)) +
         labs(y="million tonnes")
       
       )
## Export the plot
export_plot(manual_text = "Production of selected forest products", placement = "tr")

# ----------------------------------------------------------------------- #
# Top and bottom 10 exporters of forest products

## Info
plotInfo <- plot_info(plotName = "C.P4.FOR.1.3")

sybdata.df$FO.EXVAL.TOT.USD.NO.million <- sybdata.df$FO.EXVAL.TOT.USD.NO / 1000000

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
                #                 legend_lab = subset(meta.lst$FULL,
                #                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
       ) + scale_y_continuous(labels=french) +
         guides(fill = guide_legend(nrow = 2), color = guide_legend(nrow = 2)) +
         labs(y="billion US$") +
         theme(axis.text.x =element_text(angle = 45))
       
       )
## Export the plot
export_plot(manual_text = "Top 20 exporters of forest products (2012)",placement="l")


# ----------------------------------------------------------------------- #
# Top and bottom 10 importers of forest products

## Info
plotInfo <- plot_info(plotName = "C.P4.FOR.1.4")
sybdata.df$FO.IMVAL.TOT.USD.NO.million <- sybdata.df$FO.IMVAL.TOT.USD.NO / 1000000

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
                #                 legend_lab = subset(meta.lst$FULL,
                #                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
       ) + scale_y_continuous(labels=french, breaks=c(10000,20000,30000)) +
         labs(y="billion US$") +
         theme(axis.text.x =element_text(angle = 45))
)
## Export the plot
export_plot(manual_text = "Top 20 importers of forest products (2012)",placement="r")


# ----------------------------------------------------------------------- #
# Forest characteristics (planted forest, primary forest, and other naturally regenerated forest)

## Info
plotInfo <- plot_info(plotName = "C.P4.FOR.1.5")

sybdata.df$GFRA.TOT.PF.HA.NO.mill   <- sybdata.df$GFRA.TOT.PF.HA.NO   / 1000000
sybdata.df$GFRA.TOT.PLF.HA.NO.mill  <- sybdata.df$GFRA.TOT.PLF.HA.NO  / 1000000
sybdata.df$GFRA.TOT.ONRF.HA.NO.mill <- sybdata.df$GFRA.TOT.ONRF.HA.NO / 1000000

plotInfo$legendLabels <- c("primary forest","planted forest","other naturally regenerated forest")
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
                legend_lab = plotInfo$legendLabels,
                col_pallete = plot_colors(part = plotInfo$plotPart, 3)[["Sub"]]
       ) + scale_y_continuous(labels=french) +
         labs(y="million ha")
       
       )
## Export the plot
export_plot(manual_text="Forest characteristics (2010)",placement = "b")

# MAPS  ----------------------------------------------------------------- #
# Forest characteristics (planted forest, primary forest, and other naturally regenerated forest)

## Map info
mapInfo <- map_info(mapName = "M.P4.FOR.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName, meta_plot_map() )
## export the map
export_map(manual_text="Forest area as share of total land area, percent (2012)")


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
#plotInfo$plotYears <- c(2010,2011,2012)
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
                    y_lab = expression("    thousand gigagrams CO"[2] * "eq"),
                     #                 legend_lab = subset(meta.lst$FULL,
                     #                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                     col_pallete = plot_colors(part = plotInfo$plotPart, 6)[["Sub"]]
       ) + guides(fill = guide_legend(nrow = 2), color = guide_legend(nrow = 2)) 
       
       )



## Export the plot
export_plot(manual_text="Greenhouse gas emissions in agriculture",placement="tr")

# ----------------------------------------------------------------------- #
# Greehouse gas emissions, highest in 2012

## Info
plotInfo <- plot_info(plotName = "C.P4.CC.1.3")
# Subset the years manually!!
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))

# to match the ICN2 output  
sybdata.df$GHG.TOT.ALL.GG.NO.thou <- sybdata.df$GHG.TOT.ALL.GG.NO/ 1000

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
                #                 legend_lab = subset(meta.lst$FULL,
                #                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
       ) + scale_y_continuous(labels=french) +
         labs(y=expression("Mt CO"[2] * "eq"))
       
       
       )
## Export the plot
export_plot(manual_text = "Greehouse gas emissions in agriculture, highest 20 countries in 2012",placement="l")


# ----------------------------------------------------------------------- #
# Land use total emissions, highest 20 in 2012

## Info
plotInfo <- plot_info(plotName = "C.P4.CC.1.4")
# Subset the years manually!!
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))

# to match the ICN2 output  
sybdata.df$GL.LU.TOT.NERCO2EQ.NO.thou <- sybdata.df$GL.LU.TOT.NERCO2EQ.NO/ 1000
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
                #                 legend_lab = subset(meta.lst$FULL,
                #                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]
       ) + scale_y_continuous(labels=french) +
         labs(y=expression("Mt CO"[2] * "eq"))
       
       )
## Export the plot
export_plot(manual_text = "Land use total emissions, highest 20 countries in 2012",placement="l")

# ----------------------------------------------------------------------- #
# Emissions by subsectors

## Info
plotInfo <- plot_info(plotName = "C.P4.CC.1.5")
## Plot
plotInfo$legendLabels <- c("All GHG agricultural sectors", "Net forest conversion", "Cultivation histoils and peat fires", "Burning savanna", "Forest")

# to match the ICN2 output  
sybdata.df$GHG.TOT.ALL.GG.NO.thou <- sybdata.df$GHG.TOT.ALL.GG.NO/ 1000
sybdata.df$GL.FL.NFC.NERCO2EQ.NO.thou <- sybdata.df$GL.FL.NFC.NERCO2EQ.NO / 1000
sybdata.df$GLI.CHPF.TOT.ECO2EQ.NO.thou <- sybdata.df$GLI.CHPF.TOT.ECO2EQ.NO / 1000
sybdata.df$GHG.BS.TECO2EQ.GG.NO.thou <- sybdata.df$GHG.BS.TECO2EQ.GG.NO / 1000
sybdata.df$GL.FL.F.NERCO2EQ.NO.thou <- sybdata.df$GL.FL.F.NERCO2EQ.NO / 1000


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
                y_lab = expression("    thousand gigagrams CO"[2] * "eq"),
#                 legend_lab = subset(meta.lst$FULL,
#                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                legend_lab = plotInfo$legendLabels,
                col_pallete = plot_colors(part = plotInfo$plotPart, 6)[["Sub"]]
       ) +
         theme(axis.text.x = element_blank()) + 
         guides(fill = guide_legend(nrow = 2), color = guide_legend(nrow = 2)) +
        scale_y_continuous(labels=french)
       
       )
## Export the plot
export_plot(manual_text = "Emissions by subsectors in 2012", placement = "b")


#sybdata.df[sybdata.df$FAOST_CODE == 5000 & sybdata.df$Year == 2012, c("GHG.TOT.ALL.GG.NO","GL.FL.NFC.NERCO2EQ.NO","GLI.CHPF.TOT.ECO2EQ.NO","GHG.BS.TECO2EQ.GG.NO","GL.FL.F.NERCO2EQ.NO")]




# MAPS ----------------------------------------------------------------- #
# Total greenhouse gas emissions

## Map info
mapInfo <- map_info(mapName = "M.P4.CC.1.6", data = sybMaps.df, mapArea = "Territory")
## Create the map
assign(mapInfo$mapName, meta_plot_map() )
## export the map
export_map(manual_text="Total greenhouse gas emissions from agriculture, forestry and other land use, gigagrams CO2 eq (2012)")

