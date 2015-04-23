###########################################################################
## Charts ICN2 Statistical Pocketbook 2014
###########################################################################


###########################################################################
## Setting
###########################################################################

# Colors part 1 -----------------------------------------------------------

colPart1 <- plot_colors(part = 1, 12)
col.main1 <- colPart1[["Main"]][1]
## color for the grid
col.main2 <- colPart1[["Main"]][2]
source("./dissemination/Rcode/Final/theme.R")

# Export the plot

export_plot <- function() { 
  pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
      family = "PT Sans", title = NULL, width = plotWidth, height = plotHeight,
      pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
  print(eval(parse(text = plotInfo$plotName)))
  dev.off()
  ## Embed font
  embed_fonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""))
  ## Caption
  captions(objectName = plotInfo$plotName, output = captionsOutput)
  
}


# C.P1.ECON.1.2 -----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.ECON.1.2")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = subset(meta.lst$FULL,
                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 3)[["Sub"]])
       )
## Export the plot
plotWidth  <- 3
plotHeight <- 2.5
export_plot()

# C.P1.ECON.1.3 -----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.ECON.1.3")
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
       )
## Export the plot
plotWidth  <- 3.2
plotHeight <- 6.1
export_plot()

# C.P1.ECON.1.4 -----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.ECON.1.4")
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
       )
## Export the plot
plotWidth  <- 3.2
plotHeight <- 6.1
export_plot()


# C.P1.ECON.1.5 -----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.ECON.1.5")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
#                 legend_lab = subset(meta.lst$FULL,
#                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 4)[["Sub"]])
)
## Export the plot
## Export the plot
plotWidth  <- 6
plotHeight <- 2
export_plot()

# MT.P1.OVER.1.2 ----------------------------------------------------------

# ## Info
# plotInfo <- plot_info(plotName = "MT.P1.OVER.1.2")
# ## Data
# tmp.df <- 
#   icn2.df[icn2.df[, "Year"] %in% c(min(plotInfo$plotYears), max(plotInfo$plotYears)) &
#             icn2.df[, "Area"] %in% plotInfo$plotArea,
#             c("FAO_TABLE_NAME", "Year", plotInfo$yAxis)]
# ## Rounding & scaling
# tmp.df[, plotInfo$yAxis] <- 
#   round(tmp.df[, plotInfo$yAxis] * plotInfo$scaling, digits = 0)
# ## Reshape
# tmp.df <- dcast(tmp.df, FAO_TABLE_NAME ~ Year, value.var = plotInfo$yAxis)
# colnames(tmp.df)[grep("FAO_TABLE_NAME", colnames(tmp.df))] = " "
# ## Minitable
# PBminitable(output = plotsOutput, MTname = plotInfo$plotName, table = tmp.df)
# ## Caption
# captions(objectName = plotInfo$plotName, output = captionsOutput,
#          manual = "Total economically active population (million people, 1990 and 2013)")

# C.P1.OVER.1.2 -----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.OVER.1.2")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = subset(meta.lst$FULL,
                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) + 
         geom_vline(xintercept = 2010, linetype = "dashed") +
         scale_x_continuous(breaks = c(1992, 2000, 2010, 2020))
       )
## Export the plot
plotWidth  <- 3
plotHeight <- 2.5
export_plot()


# C.P1.OVER.1.3 -----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.OVER.1.3")
# plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
       )
## Export the plot
plotWidth  <- 3.2
plotHeight <- 6.1
export_plot()


# C.P1.OVER.1.4 -----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.OVER.1.4")
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
       )
## Export the plot
plotWidth  <- 3.2
plotHeight <- 6.1
export_plot()


# C.P1.OVER.1.5 -----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.OVER.1.5")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
#                 legend_lab = subset(meta.lst$FULL,
#                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 4)[["Sub"]])
)
## Export the plot
plotWidth  <- 6
plotHeight <- 2
export_plot()



# C.P1.PRICE.1.2 ----------------------------------------------------------

## Data
fpiad.df <- 
  read.csv("Data/Processed/FAOfpi.csv", header = TRUE, stringsAsFactors = FALSE)
fpiad.df <- melt(fpiad.df, id.vars = "Date")
colnames(fpiad.df) <- c("Year", "CommodityGroup", "Value")
fpiad.df[, "FAOST_CODE"] <- 5001
fpiad.df[, "Area"] <- "SOFIWorld"
## Info
plotInfo <- plot_info(plotName = "C.P1.PRICE.1.2")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = fpiad.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
#                 legend_lab = c(),
                col_pallete = plot_colors(part = plotInfo$plotPart, 6)[["Sub"]]) +
  scale_x_continuous(breaks = c(1990, 1995, 2000, 2005, 2010, 2014))
)
## Export the plot
plotWidth  <- 3
plotHeight <- 2.5
export_plot()


# C.P1.PRICE.1.3 ----------------------------------------------------------

## Data
cpi.df <- 
  read.csv("Data/Processed/FAOcpi.csv", header = TRUE, stringsAsFactors = FALSE)
cpi.df <- cpi.df[, c("FAOST_CODE", "Year", "Value")]
cpi.df <- merge(cpi.df, FAOcountryProfile[, c("FAOST_CODE", "SHORT_NAME")],
                by = "FAOST_CODE", all.x = TRUE)
cpi.df[, "Area"] <- "Territory"
cpi.df[cpi.df[, "SHORT_NAME"] == "Sao Tome and Principe" & 
          !is.na(cpi.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Sao Tome and\nPrincipe"
cpi.df[cpi.df[, "SHORT_NAME"] == "Trinidad and Tobago" & 
         !is.na(cpi.df[, "SHORT_NAME"]), "SHORT_NAME"] <-
  "Trinidad and\nTobago"
## Info
plotInfo <- plot_info(plotName = "C.P1.PRICE.1.3")
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = cpi.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
       )
## Export the plot
plotWidth  <- 3.2
plotHeight <- 6.1
export_plot()


# C.P1.PRICE.1.4 ----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.PRICE.1.4")
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
       )
## Export the plot
plotWidth  <- 3.2
plotHeight <- 6.1
export_plot()


# C.P1.PRICE.1.5 ----------------------------------------------------------

## Data
rcpi.df <- 
  read.csv("Data/Processed/RegionalCPI.csv", header = TRUE, stringsAsFactors = FALSE)
rcpi.df <- 
  rcpi.df[rcpi.df[, "Countries"] %in% 
            c("World", "Europe", "Africa", "Americas", "Asia"),]
rcpi.df <- melt(rcpi.df, id.vars = c("Country.Code", "Countries"))
rcpi.df <- rcpi.df[, c("Countries", "variable", "value")]
colnames(rcpi.df) <- c("FAO_TABLE_NAME", "Year", "Value")
rcpi.df[, "Year"] <- as.numeric(gsub("X", "", rcpi.df[, "Year"]))
rcpi.df[, "Area"] <- "M49Region"
## Info
plotInfo <- plot_info(plotName = "C.P1.PRICE.1.5")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = rcpi.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                #                 legend_lab = c(),
                col_pallete = plot_colors(part = plotInfo$plotPart, 5)[["Sub"]])
       )
## Export the plot
plotWidth  <- 6
plotHeight <- 2
export_plot()

# MT_P1.TRADE.1.2 ---------------------------------------------------------

# ## Info
# plotInfo <- plot_info(plotName = "MT.P1.TRADE.1.2")
# ## Data
# tmp.df <- 
#   icn2.df[icn2.df[, "Year"] %in% c(min(plotInfo$plotYears), max(plotInfo$plotYears)) &
#             icn2.df[, "Area"] %in% plotInfo$plotArea,
#             c("FAO_TABLE_NAME", plotInfo$yAxis)]
# ## Rounding & scaling
# tmp.df[, plotInfo$yAxis] <- 
#   round(tmp.df[, plotInfo$yAxis] * plotInfo$scaling, digits = 0)
# ## Reshape
# colnames(tmp.df) <- c(" ", "Imports", "Exports")
# ## Minitable
# PBminitable(output = plotsOutput, MTname = plotInfo$plotName, table = tmp.df)
# ## Caption
# captions(objectName = plotInfo$plotName, output = captionsOutput,
#          manual = "Imports and exports of food (billion US$, 2011)")

# C.P1.TRADE.1.3 ----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.TRADE.1.3")
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
       )
## Export the plot
plotWidth  <- 3.2
plotHeight <- 6.1
export_plot()


# C.P1.TRADE.1.4 ----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.TRADE.1.4")
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
       )
## Export the plot
plotWidth  <- 3.2
plotHeight <- 6.1
export_plot()


# C.P1.TRADE.1.5 -----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.TRADE.1.5")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
#                 legend_lab = subset(meta.lst$FULL,
#                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 4)[["Sub"]]))
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 6, height = 2,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput)

###########################################################################
## Malnutrition
###########################################################################

# Colors part 2 -----------------------------------------------------------

colPart1 <- plot_colors(part = 2, 12)
col.main1 <- colPart1[["Main"]][1]
## color for the grid
col.main2 <- colPart1[["Main"]][2]
source("./dissemination/Rcode/Final/theme.R")

# MT.P1.IAF.1.2 -----------------------------------------------------------

# ## Info
# plotInfo <- plot_info(plotName = "MT.P1.IAF.1.2")
# ## Data
# tmp.df <- 
#   icn2.df[icn2.df[, "Year"] %in% c(min(plotInfo$plotYears), max(plotInfo$plotYears)) &
#             icn2.df[, "Area"] %in% plotInfo$plotArea,
#             c("FAO_TABLE_NAME", "Year", plotInfo$yAxis)]
# ## Reshape and adjust
# tmp.df <- dcast(tmp.df, FAO_TABLE_NAME ~ Year, value.var = plotInfo$yAxis)
# tmp.df <- tmp.df[c(7,4,1,2,5,6,3),]
# colnames(tmp.df) <- c(" ", "1990-92", "2012-14")
# ## Minitable
# PBminitable(output = plotsOutput, MTname = plotInfo$plotName, table = tmp.df)
# ## Caption
# captions(objectName = plotInfo$plotName, output = captionsOutput,
#          manual = "Prevalence of undernourishment (percent, 1990-92 and 2012-14)")

# C.P1.IAF.1.3 ------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.IAF.1.3")
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea) &
                                    FAOST_CODE %in% c(FAOcountryProfile[FAOcountryProfile[, 'SOFI_MACRO_REG'] == 'Asia' & !is.na(FAOcountryProfile[, 'SOFI_MACRO_REG']), 'FAOST_CODE'])")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
       )
C.P1.IAF.1.3 <- C.P1.IAF.1.3 + 
  scale_fill_manual(labels = c("1990-92", "2012-14"),
                    values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
  scale_color_manual(labels = c("1990-92", "2012-14"),
                     values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3.2, height = 6.1,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Asian countries with the highest number of people undernourished in 2012-14 (1990-92 and 2012-14)")

# C.P1.IAF.1.4 ------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.IAF.1.4")
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea) &
                                    FAOST_CODE %in% c(FAOcountryProfile[FAOcountryProfile[, 'SOFI_MACRO_REG'] == 'Africa' & !is.na(FAOcountryProfile[, 'SOFI_MACRO_REG']), 'FAOST_CODE']) &
                                    !FAOST_CODE %in% c(250,201,178,206,276,277,29)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
C.P1.IAF.1.4 <- C.P1.IAF.1.4 + 
  scale_fill_manual(labels = c("1990-92", "2012-14"),
                    values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
  scale_color_manual(labels = c("1990-92", "2012-14"),
                     values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3.2, height = 6.1,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "African countries with the highest number of people undernourished in 2012-14 (1990-92 and 2012-14)")

# C.P1.IAF.1.5 ------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.IAF.1.5")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
#                 legend_lab = subset(meta.lst$FULL,
#                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 4)[["Sub"]]))
C.P1.IAF.1.5 <- C.P1.IAF.1.5 +
  scale_x_continuous(breaks = c(1992, 2002, 2007, 2011, 2014),
                     labels = c("1990-92", "2000-02", "2005-07", "2009-11", "2012-14"))
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 6, height = 2,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Number of people undernourished (1990-92 to 2012-14)")

# MT.P1.UT.1.2 ------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "MT.P1.UT.1.2")
## Data
tmp.df <- 
  icn2.df[icn2.df[, "Year"] %in% c(min(plotInfo$plotYears): max(plotInfo$plotYears)) &
            icn2.df[, "Area"] %in% plotInfo$plotArea,
            c("FAO_TABLE_NAME", "Year", plotInfo$yAxis)]
## Reshape and adjust
tmp.df <- head(arrange(tmp.df, -eval(parse(text = plotInfo$yAxis))), 5)
colnames(tmp.df) <- c(" ", "Year", "Share")
## Minitable
PBminitable(output = plotsOutput, MTname = plotInfo$plotName, table = tmp.df)
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Countries with highest share of children under 5 years of age who are wasted (percent)")

# C.P1.UT.1.3 -------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.UT.1.3")
tmp.df <- icn2.df[icn2.df[, "Area"] == "Territory" & 
                    icn2.df[, "Year"] %in% plotInfo$plotYears, c("FAOST_CODE", "SHORT_NAME", "Year", "Area", plotInfo$xAxis)]
tmp.df <- arrange(tmp.df, FAOST_CODE, Year)
plotInfo$plotYears <- max(plotInfo$plotYears)
tmp.df <- ddply(tmp.df, .(FAOST_CODE, SHORT_NAME, Area), function(df) {numcolwise(na.locf)(df, na.rm = FALSE)})
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = tmp.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 1)[["Sub"]]))
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3.2, height = 6.1,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput)

# C.P1.UT.1.4 -------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.UT.1.4")
tmp.df <- icn2.df[icn2.df[, "Area"] == "Territory" & 
                    icn2.df[, "Year"] %in% plotInfo$plotYears, c("FAOST_CODE", "SHORT_NAME", "Year", "Area", plotInfo$xAxis)]
tmp.df <- arrange(tmp.df, FAOST_CODE, Year)
plotInfo$plotYears <- max(plotInfo$plotYears)
tmp.df <- ddply(tmp.df, .(FAOST_CODE, SHORT_NAME, Area), function(df) {numcolwise(na.locf)(df, na.rm = FALSE)})
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = tmp.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 1)[["Sub"]]))
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3.2, height = 6.1,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput)

# MT.P1.UT.1.5 ------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "MT.P1.UT.1.5")
## Data
tmp.df <- 
  icn2.df[icn2.df[, "Year"] %in% c(min(plotInfo$plotYears): max(plotInfo$plotYears)) &
            icn2.df[, "Area"] %in% plotInfo$plotArea,
          c("FAO_TABLE_NAME", "Year", plotInfo$yAxis)]
## Reshape and adjust
tmp.df <- head(arrange(tmp.df, -eval(parse(text = plotInfo$yAxis))), 5)
colnames(tmp.df) <- c(" ", "Year", "Share")
## Minitable
PBminitable(output = plotsOutput, MTname = plotInfo$plotName, table = tmp.df)
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Countries with the lowest vitamin A supplementation coverage rate among children ages 6-59 months (percent)")

# MT.P1.UT.1.6 ------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "MT.P1.UT.1.6")
## Data
tmp.df <- 
  icn2.df[icn2.df[, "Year"] %in% c(min(plotInfo$plotYears): max(plotInfo$plotYears)) &
            icn2.df[, "Area"] %in% plotInfo$plotArea,
          c("FAO_TABLE_NAME", "Year", plotInfo$yAxis)]
## Reshape and adjust
tmp.df <- head(arrange(tmp.df, -eval(parse(text = plotInfo$yAxis))), 5)
colnames(tmp.df) <- c(" ", "Year", "Share")
## Minitable
PBminitable(output = plotsOutput, MTname = plotInfo$plotName, table = tmp.df)
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Countries with the highest prevalence of iodine deficiency in children under 5 years of age (percent)")

# C.P1.OO.1.2 -------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.OO.1.2")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
#                 legend_lab = subset(meta.lst$FULL,
#                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
C.P1.OO.1.2 <- C.P1.OO.1.2 + 
  scale_fill_manual(labels = c("1990-92", "2012-14"),
                    values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
  scale_color_manual(labels = c("1990-92", "2012-14"),
                     values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3, height = 2.5,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Prevalence of over-acquisition (1990-92 and 2012-14)")

# C.P1.OO.1.3 -------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.OO.1.3")
tmp.df <- icn2.df[icn2.df[, "Area"] == "Territory" & 
                    icn2.df[, "Year"] %in% plotInfo$plotYears, c("FAOST_CODE", "SHORT_NAME", "Year", "Area", plotInfo$xAxis)]
tmp.df <- arrange(tmp.df, FAOST_CODE, Year)
plotInfo$plotYears <- max(plotInfo$plotYears)
tmp.df <- ddply(tmp.df, .(FAOST_CODE, SHORT_NAME, Area), function(df) {numcolwise(na.locf)(df, na.rm = FALSE)})
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = tmp.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 1)[["Sub"]]))
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3.2, height = 6.1,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput)

# C.P1.OO.1.4 -------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.OO.1.4")
tmp.df <- icn2.df[icn2.df[, "Area"] == "Territory" & 
                    icn2.df[, "Year"] %in% plotInfo$plotYears, c("FAOST_CODE", "SHORT_NAME", "Year", "Area", plotInfo$xAxis)]
tmp.df <- arrange(tmp.df, FAOST_CODE, Year)
plotInfo$plotYears <- max(plotInfo$plotYears)
tmp.df <- ddply(tmp.df, .(FAOST_CODE, SHORT_NAME, Area), function(df) {numcolwise(na.locf)(df, na.rm = FALSE)})
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = tmp.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 1)[["Sub"]]))
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3.2, height = 6.1,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput)

# C.P1.OO.1.5 -------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.OO.1.5")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
#                 legend_lab = subset(meta.lst$FULL,
#                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 4)[["Sub"]]))
C.P1.OO.1.5 <- C.P1.OO.1.5 +
  scale_x_continuous(breaks = c(1992, 2002, 2007, 2011, 2014),
                     labels = c("1990-92", "2000-02", "2005-07", "2009-11", "2012-14"))
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 6, height = 2,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Prevalence of over-acquisition (1990-92 to 2012-14)")

###########################################################################
## Diets
###########################################################################

# Colors part 3 -----------------------------------------------------------

colPart1 <- plot_colors(part = 3, 12)
col.main1 <- colPart1[["Main"]][1]
## color for the grid
col.main2 <- colPart1[["Main"]][2]
source("./Rcode/Final/theme.R")

# C.P1.DES.1.2 ------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.DES.1.2")
labels <- subset(meta.lst$FULL,
                 subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"]
labels[1] <- "Cereals\n(excl. beer)"
labels[3] <- "Sugar and\nsweeteners"
labels[4] <- "Milk\n(excl. butter)"
labels[6] <- "Veg. oils and\nanimal fats"
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = labels,
                col_pallete = plot_colors(part = plotInfo$plotPart, 7)[["Sub"]]) +
         guides(fill = guide_legend(nrow = 3), color = guide_legend(nrow = 3)))
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3, height = 2.5,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Share of DES (2009-11)")

# C.P1.DES.1.3 ------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.DES.1.3")
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = c("1990-92", "2009-11"),
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
C.P1.DES.1.3 <- C.P1.DES.1.3 + 
  scale_fill_manual(labels = c("1990-92", "2009-11"),
                    values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
  scale_color_manual(labels = c("1990-92", "2009-11"),
                     values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3.2, height = 6.1,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput, 
         manual = "Dietary energy supply, top 20 in 2009-11 (1990-92 and 2009-11)")

# C.P1.DES.1.4 ------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.DES.1.4")
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
C.P1.DES.1.4 <- C.P1.DES.1.4 + 
  scale_fill_manual(labels = c("1990-92", "2009-11"),
                    values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
  scale_color_manual(labels = c("1990-92", "2009-11"),
                     values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3.2, height = 6.1,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput, 
         manual = "Dietary energy supply, bottom 20 in 2009-11 (1990-92 and 2009-11)")

# C.P1.DES.1.5 ------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.DES.1.5")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 4)[["Sub"]]))
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 6, height = 2,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput, 
         manual = "Dietary energy supply (1990-92 to 2009-11)")

# C.P1.CRLS.1.2 -----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.CRLS.1.2")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
#                 legend_lab = subset(meta.lst$FULL,
#                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
C.P1.CRLS.1.2 <- C.P1.CRLS.1.2 + 
  scale_fill_manual(labels = c("1990-92", "2009-11"),
                    values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
  scale_color_manual(labels = c("1990-92", "2009-11"),
                     values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3, height = 2.5,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Food supply of cereals (1990-92 and 2009-11)")

# C.P1.CRLS.1.3 -----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.CRLS.1.3")
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
C.P1.CRLS.1.3 <- C.P1.CRLS.1.3 + 
  scale_fill_manual(labels = c("1990-92", "2009-11"),
                    values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
  scale_color_manual(labels = c("1990-92", "2009-11"),
                     values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
  scale_y_continuous(breaks = c(1500, 1800, 2100))
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3.2, height = 6.1,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Food supply of cereals, top 20 in 2009-11 (1990-92 and 2009-11)")

# C.P1.CRLS.1.4 -----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.CRLS.1.4")
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
C.P1.CRLS.1.4 <- C.P1.CRLS.1.4 + 
  scale_fill_manual(labels = c("1990-92", "2009-11"),
                    values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
  scale_color_manual(labels = c("1990-92", "2009-11"),
                     values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3.2, height = 6.1,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Food supply of cereals, bottom 20 in 2009-11 (1990-92 and 2009-11)")

# C.P1.CRLS.1.5 -----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.CRLS.1.5")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 4)[["Sub"]]))
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 6, height = 2,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Food supply of cereals (1990-92 to 2009-11)")

# C.P1.SR.1.2 -------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.SR.1.2")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                #                 legend_lab = subset(meta.lst$FULL,
                #                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
C.P1.SR.1.2 <- C.P1.SR.1.2 + 
  scale_fill_manual(labels = c("1990-92", "2009-11"),
                    values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
  scale_color_manual(labels = c("1990-92", "2009-11"),
                     values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3, height = 2.5,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Food supply of starchy roots (1990-92 and 2009-11)")

# C.P1.SR.1.3 -------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.SR.1.3")
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
C.P1.SR.1.3 <- C.P1.SR.1.3 + 
  scale_fill_manual(labels = c("1990-92", "2009-11"),
                    values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
  scale_color_manual(labels = c("1990-92", "2009-11"),
                     values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
  scale_y_continuous(breaks = c(200, 500, 800, 1100))
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3.2, height = 6.1,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Food supply of starchy roots, top 20 in 2009-11 (1990-92 and 2009-11)")

# C.P1.SR.1.4 -------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.SR.1.4")
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
C.P1.SR.1.4 <- C.P1.SR.1.4 + 
  scale_fill_manual(labels = c("1990-92", "2009-11"),
                    values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
  scale_color_manual(labels = c("1990-92", "2009-11"),
                     values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3.2, height = 6.1,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Food supply of starchy roots, bottom 20 in 2009-11 (1990-92 and 2009-11)")

# C.P1.SR.1.5 -------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.SR.1.5")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 4)[["Sub"]]))
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 6, height = 2,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Food supply of starchy roots (1990-92 to 2009-11)")

# C.P1.SS.1.2 -------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.SS.1.2")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                #                 legend_lab = subset(meta.lst$FULL,
                #                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
C.P1.SS.1.2 <- C.P1.SS.1.2 + 
  scale_fill_manual(labels = c("1990-92", "2009-11"),
                    values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
  scale_color_manual(labels = c("1990-92", "2009-11"),
                     values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3, height = 2.5,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Food supply of sugar and sweeteners (1990-92 and 2009-11)")

# C.P1.SS.1.3 -------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.SS.1.3")
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
C.P1.SS.1.3 <- C.P1.SS.1.3 + 
  scale_fill_manual(labels = c("1990-92", "2009-11"),
                    values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
  scale_color_manual(labels = c("1990-92", "2009-11"),
                     values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3.2, height = 6.1,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Food supply of sugar and sweeteners, top 20 in 2009-11 (1990-92 and 2009-11)")

# C.P1.SS.1.4 -------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.SS.1.4")
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
C.P1.SS.1.4 <- C.P1.SS.1.4 + 
  scale_fill_manual(labels = c("1990-92", "2009-11"),
                    values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
  scale_color_manual(labels = c("1990-92", "2009-11"),
                     values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3.2, height = 6.1,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Food supply of sugar and sweeteners, bottom 20 in 2009-11 (1990-92 and 2009-11)")

# C.P1.SS.1.5 -------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.SS.1.5")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 4)[["Sub"]]))
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 6, height = 2,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Food supply of sugar and sweeteners (1990-92 to 2009-11)")

# C.P1.FV.1.2 ------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.FV.1.2")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                #                 legend_lab = subset(meta.lst$FULL,
                #                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
C.P1.FV.1.2 <- C.P1.FV.1.2 + 
  scale_fill_manual(labels = c("1990-92", "2009-11"),
                    values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
  scale_color_manual(labels = c("1990-92", "2009-11"),
                     values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3, height = 2.5,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Food supply of fruit and vegetables (1990-92 and 2009-11)")

# C.P1.FV.1.3 ------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.FV.1.3")
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
C.P1.FV.1.3 <- C.P1.FV.1.3 + 
  scale_fill_manual(labels = c("1990-92", "2009-11"),
                    values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
  scale_color_manual(labels = c("1990-92", "2009-11"),
                     values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3.2, height = 6.1,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Food supply of fruit and vegetables, top 20 in 2009-11 (1990-92 and 2009-11)")

# C.P1.FV.1.4 ------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.FV.1.4")
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
C.P1.FV.1.4 <- C.P1.FV.1.4 + 
  scale_fill_manual(labels = c("1990-92", "2009-11"),
                    values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
  scale_color_manual(labels = c("1990-92", "2009-11"),
                     values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3.2, height = 6.1,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Food supply of fruit and vegetables, bottom 20 in 2009-11 (1990-92 and 2009-11)")

# C.P1.FV.1.5 ------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.FV.1.5")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 4)[["Sub"]]))
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 6, height = 2,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Food supply of fruit and vegetables (1990-92 to 2009-11)")

# C.P1.MEAT.1.2 -----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.MEAT.1.2")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                #                 legend_lab = subset(meta.lst$FULL,
                #                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
C.P1.MEAT.1.2 <- C.P1.MEAT.1.2 + 
  scale_fill_manual(labels = c("1990-92", "2009-11"),
                    values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
  scale_color_manual(labels = c("1990-92", "2009-11"),
                     values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3, height = 2.5,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Food supply of meat (1990-92 and 2009-11)")

# C.P1.MEAT.1.3 -----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.MEAT.1.3")
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
C.P1.MEAT.1.3 <- C.P1.MEAT.1.3 + 
  scale_fill_manual(labels = c("1990-92", "2009-11"),
                    values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
  scale_color_manual(labels = c("1990-92", "2009-11"),
                     values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3.2, height = 6.1,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Food supply of meat, top 20 in 2009-11 (1990-92 and 2009-11)")

# C.P1.MEAT.1.4 -----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.MEAT.1.4")
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
C.P1.MEAT.1.4 <- C.P1.MEAT.1.4 + 
  scale_fill_manual(labels = c("1990-92", "2009-11"),
                    values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
  scale_color_manual(labels = c("1990-92", "2009-11"),
                     values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3.2, height = 6.1,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Food supply of meat, bottom 20 in 2009-11 (1990-92 and 2009-11)")

# C.P1.MEAT.1.5 -----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.MEAT.1.5")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 4)[["Sub"]]))
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 6, height = 2,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Food supply of meat (1990-92 to 2009-11)")

# C.P1.OCRPS.1.2 ----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.OCRPS.1.2")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                #                 legend_lab = subset(meta.lst$FULL,
                #                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
C.P1.OCRPS.1.2 <- C.P1.OCRPS.1.2 + 
  scale_fill_manual(labels = c("1990-92", "2009-11"),
                    values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
  scale_color_manual(labels = c("1990-92", "2009-11"),
                     values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3, height = 2.5,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Food supply of oilcrops (1990-92 and 2009-11)")

# C.P1.OCRPS.1.3 ----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.OCRPS.1.3")
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
C.P1.OCRPS.1.3 <- C.P1.OCRPS.1.3 + 
  scale_fill_manual(labels = c("1990-92", "2009-11"),
                    values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
  scale_color_manual(labels = c("1990-92", "2009-11"),
                     values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3.2, height = 6.1,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Food supply of oilcrops, top 20 in 2009-11 (1990-92 and 2009-11)")

# C.P1.OCRPS.1.4 ----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.OCRPS.1.4")
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
C.P1.OCRPS.1.4 <- C.P1.OCRPS.1.4 + 
  scale_fill_manual(labels = c("1990-92", "2009-11"),
                    values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
  scale_color_manual(labels = c("1990-92", "2009-11"),
                     values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3.2, height = 6.1,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Food supply of oilcrops, bottom 20 in 2009-11 (1990-92 and 2009-11)")

# C.P1.OCRPS.1.5 ----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.OCRPS.1.5")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 4)[["Sub"]]))
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 6, height = 2,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Food supply of oilcrops (1990-92 to 2009-11)")

# C.P1.FISH.1.2 -----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.FISH.1.2")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                #                 legend_lab = subset(meta.lst$FULL,
                #                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
C.P1.FISH.1.2 <- C.P1.FISH.1.2 + 
  scale_fill_manual(labels = c("1990-92", "2009-11"),
                    values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
  scale_color_manual(labels = c("1990-92", "2009-11"),
                     values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3, height = 2.5,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Food supply of fish (1990-92 and 2009-11)")

# C.P1.FISH.1.3 -----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.FISH.1.3")
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
C.P1.FISH.1.3 <- C.P1.FISH.1.3 + 
  scale_fill_manual(labels = c("1990-92", "2009-11"),
                    values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
  scale_color_manual(labels = c("1990-92", "2009-11"),
                     values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3.2, height = 6.1,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Food supply of fish, top 20 in 2009-11 (1990-92 and 2009-11)")

# C.P1.FISH.1.4 -----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.FISH.1.4")
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
C.P1.FISH.1.4 <- C.P1.FISH.1.4 + 
  scale_fill_manual(labels = c("1990-92", "2009-11"),
                    values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
  scale_color_manual(labels = c("1990-92", "2009-11"),
                     values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3.2, height = 6.1,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Food supply of fish, bottom 20 in 2009-11 (1990-92 and 2009-11)")

# C.P1.FISH.1.5 -----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.FISH.1.5")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 4)[["Sub"]]))
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 6, height = 2,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Food supply of fish (1990-92 to 2009-11)")

# C.P1.MEB.1.2 ------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.MEB.1.2")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                #                 legend_lab = subset(meta.lst$FULL,
                #                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
C.P1.MEB.1.2 <- C.P1.MEB.1.2 + 
  scale_fill_manual(labels = c("1990-92", "2009-11"),
                    values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
  scale_color_manual(labels = c("1990-92", "2009-11"),
                     values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3, height = 2.5,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Food supply of milk (1990-92 and 2009-11)")

# C.P1.MEB.1.3 ------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.MEB.1.3")
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
C.P1.MEB.1.3 <- C.P1.MEB.1.3 + 
  scale_fill_manual(labels = c("1990-92", "2009-11"),
                    values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
  scale_color_manual(labels = c("1990-92", "2009-11"),
                     values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3.2, height = 6.1,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Food supply of milk, top 20 in 2009-11 (1990-92 and 2009-11)")

# C.P1.MEB.1.4 ------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.MEB.1.4")
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
C.P1.MEB.1.4 <- C.P1.MEB.1.4 + 
  scale_fill_manual(labels = c("1990-92", "2009-11"),
                    values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
  scale_color_manual(labels = c("1990-92", "2009-11"),
                     values = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]])
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3.2, height = 6.1,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Food supply of milk, bottom 20 in 2009-11 (1990-92 and 2009-11)")

# C.P1.MEB.1.5 ------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.MEB.1.5")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 4)[["Sub"]]))
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 6, height = 2,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Food supply of milk (1990-92 to 2009-11)")

###########################################################################
## Household surveys
###########################################################################

# C.P1.HS.1.1 -------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.HS.1.1")
tmp.df <- icn2.df[icn2.df[, "Area"] == "Territory" & 
                    icn2.df[, "Year"] %in% plotInfo$plotYears, c("FAOST_CODE", "SHORT_NAME", "Year", "Area", plotInfo$xAxis)]
tmp.df <- arrange(tmp.df, FAOST_CODE, Year)
plotInfo$plotYears <- max(plotInfo$plotYears)
tmp.df <- ddply(tmp.df, .(FAOST_CODE, SHORT_NAME, Area), function(df) {numcolwise(na.locf)(df, na.rm = FALSE)})
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
#                 group = plotInfo$group,
                nCnty = 47,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = tmp.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = plotInfo$legendLabels,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
  scale_y_continuous(breaks = c(1.5, 2.0, 2.5, 3.0, 3.5)))
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 2.5, height = 10,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
# captions(objectName = plotInfo$plotName, output = captionsOutput)

# C.P1.HS.1.2 -------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.HS.1.2")
tmp.df <- icn2.df[icn2.df[, "Area"] == "Territory" & 
                    icn2.df[, "Year"] %in% plotInfo$plotYears, c("FAOST_CODE", "SHORT_NAME", "Year", "Area", plotInfo$xAxis)]
tmp.df <- arrange(tmp.df, FAOST_CODE, Year)
plotInfo$plotYears <- max(plotInfo$plotYears)
tmp.df <- ddply(tmp.df, .(FAOST_CODE, SHORT_NAME, Area), function(df) {numcolwise(na.locf)(df, na.rm = FALSE)})
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                #                 group = plotInfo$group,
                nCnty = 47,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = tmp.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = plotInfo$legendLabels,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]) +
         scale_y_continuous(breaks = c(1.5, 2.0, 2.5, 3.0, 3.5)))
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 2.5, height = 10,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
# captions(objectName = plotInfo$plotName, output = captionsOutput)

# C.P1.HS.1.3 -------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.HS.1.3")
tmp.df <- icn2.df[icn2.df[, "Area"] == "Territory" & 
                    icn2.df[, "Year"] %in% plotInfo$plotYears, c("FAOST_CODE", "SHORT_NAME", "Year", "Area", plotInfo$xAxis)]
tmp.df <- arrange(tmp.df, FAOST_CODE, Year)
plotInfo$plotYears <- max(plotInfo$plotYears)
tmp.df <- ddply(tmp.df, .(FAOST_CODE, SHORT_NAME, Area), function(df) {numcolwise(na.locf)(df, na.rm = FALSE)})
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                #                 group = plotInfo$group,
                nCnty = 47,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = tmp.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = plotInfo$legendLabels,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 2.5, height = 10,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
# captions(objectName = plotInfo$plotName, output = captionsOutput)

# C.P1.HS.1.4 -------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.HS.1.4")
tmp.df <- icn2.df[icn2.df[, "Area"] == "Territory" & 
                    icn2.df[, "Year"] %in% plotInfo$plotYears, c("FAOST_CODE", "SHORT_NAME", "Year", "Area", plotInfo$xAxis)]
tmp.df <- arrange(tmp.df, FAOST_CODE, Year)
plotInfo$plotYears <- max(plotInfo$plotYears)
tmp.df <- ddply(tmp.df, .(FAOST_CODE, SHORT_NAME, Area), function(df) {numcolwise(na.locf)(df, na.rm = FALSE)})
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                #                 group = plotInfo$group,
                nCnty = 47,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = tmp.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = plotInfo$legendLabels,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 2.5, height = 10,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
# captions(objectName = plotInfo$plotName, output = captionsOutput)

# C.P1.HS.1.5 -------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.HS.1.5")
tmp.df <- icn2.df[icn2.df[, "Area"] == "Territory" & 
                    icn2.df[, "Year"] %in% plotInfo$plotYears, c("FAOST_CODE", "SHORT_NAME", "Year", "Area", plotInfo$xAxis)]
tmp.df <- arrange(tmp.df, FAOST_CODE, Year)
plotInfo$plotYears <- max(plotInfo$plotYears)
tmp.df <- ddply(tmp.df, .(FAOST_CODE, SHORT_NAME, Area), function(df) {numcolwise(na.locf)(df, na.rm = FALSE)})
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                #                 group = plotInfo$group,
                nCnty = 47,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = tmp.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = plotInfo$legendLabels,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 2.5, height = 10,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
# captions(objectName = plotInfo$plotName, output = captionsOutput)

# C.P1.HS.1.6 -------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.HS.1.6")
tmp.df <- icn2.df[icn2.df[, "Area"] == "Territory" & 
                    icn2.df[, "Year"] %in% plotInfo$plotYears, c("FAOST_CODE", "SHORT_NAME", "Year", "Area", plotInfo$xAxis)]
tmp.df <- arrange(tmp.df, FAOST_CODE, Year)
plotInfo$plotYears <- max(plotInfo$plotYears)
tmp.df <- ddply(tmp.df, .(FAOST_CODE, SHORT_NAME, Area), function(df) {numcolwise(na.locf)(df, na.rm = FALSE)})
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                #                 group = plotInfo$group,
                nCnty = 47,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = tmp.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = plotInfo$legendLabels,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 2.5, height = 10,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
# captions(objectName = plotInfo$plotName, output = captionsOutput)

# C.P1.HS.1.7 -------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.HS.1.7")
tmp.df <- icn2.df[icn2.df[, "Area"] == "Territory" & 
                    icn2.df[, "Year"] %in% plotInfo$plotYears, c("FAOST_CODE", "SHORT_NAME", "Year", "Area", plotInfo$xAxis)]
tmp.df <- arrange(tmp.df, FAOST_CODE, Year)
plotInfo$plotYears <- max(plotInfo$plotYears)
tmp.df <- ddply(tmp.df, .(FAOST_CODE, SHORT_NAME, Area), function(df) {numcolwise(na.locf)(df, na.rm = FALSE)})
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                #                 group = plotInfo$group,
                nCnty = 47,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = tmp.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = plotInfo$legendLabels,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 2.5, height = 10,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
# captions(objectName = plotInfo$plotName, output = captionsOutput)

# C.P1.HS.1.8 -------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.HS.1.8")
tmp.df <- icn2.df[icn2.df[, "Area"] == "Territory" & 
                    icn2.df[, "Year"] %in% plotInfo$plotYears, c("FAOST_CODE", "SHORT_NAME", "Year", "Area", plotInfo$xAxis)]
tmp.df <- arrange(tmp.df, FAOST_CODE, Year)
plotInfo$plotYears <- max(plotInfo$plotYears)
tmp.df <- ddply(tmp.df, .(FAOST_CODE, SHORT_NAME, Area), function(df) {numcolwise(na.locf)(df, na.rm = FALSE)})
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                #                 group = plotInfo$group,
                nCnty = 47,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = tmp.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = plotInfo$legendLabels,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 2.5, height = 10,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
# captions(objectName = plotInfo$plotName, output = captionsOutput)

# C.P1.HS.1.9 -------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.HS.1.9")
tmp.df <- icn2.df[icn2.df[, "Area"] == "Territory" & 
                    icn2.df[, "Year"] %in% plotInfo$plotYears, c("FAOST_CODE", "SHORT_NAME", "Year", "Area", plotInfo$xAxis)]
tmp.df <- arrange(tmp.df, FAOST_CODE, Year)
plotInfo$plotYears <- max(plotInfo$plotYears)
tmp.df <- ddply(tmp.df, .(FAOST_CODE, SHORT_NAME, Area), function(df) {numcolwise(na.locf)(df, na.rm = FALSE)})
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                #                 group = plotInfo$group,
                nCnty = 47,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = tmp.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = plotInfo$legendLabels,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 2.5, height = 10,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
# captions(objectName = plotInfo$plotName, output = captionsOutput)

# C.P1.HS.1.10 ------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.HS.1.10")
tmp.df <- icn2.df[icn2.df[, "Area"] == "Territory" & 
                    icn2.df[, "Year"] %in% plotInfo$plotYears, c("FAOST_CODE", "SHORT_NAME", "Year", "Area", plotInfo$xAxis)]
tmp.df <- arrange(tmp.df, FAOST_CODE, Year)
plotInfo$plotYears <- max(plotInfo$plotYears)
tmp.df <- ddply(tmp.df, .(FAOST_CODE, SHORT_NAME, Area), function(df) {numcolwise(na.locf)(df, na.rm = FALSE)})
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                #                 group = plotInfo$group,
                nCnty = 47,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = tmp.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                legend_lab = plotInfo$legendLabels,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 2.5, height = 10,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
# captions(objectName = plotInfo$plotName, output = captionsOutput)

###########################################################################
## Sustainability
###########################################################################

# Colors part 4 -----------------------------------------------------------

colPart1 <- plot_colors(part = 4, 12)
col.main1 <- colPart1[["Main"]][1]
## color for the grid
col.main2 <- colPart1[["Main"]][2]
source("./Rcode/Final/theme.R")

# MT.P1.WATER.1.2 ---------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "MT.P1.WATER.1.2")
## Data
tmp.df <- 
  icn2.df[icn2.df[, "Year"] %in% c(min(plotInfo$plotYears): max(plotInfo$plotYears)) &
            icn2.df[, "Area"] %in% plotInfo$plotArea,
            c("FAO_TABLE_NAME", "Year", plotInfo$yAxis)]
## Reshape and adjust
tmp.df <- na.omit(tmp.df)
tmp.df <- head(arrange(tmp.df, -eval(parse(text = plotInfo$yAxis))), 5)
tmp.df[, plotInfo$yAxis] <- round(tmp.df[, plotInfo$yAxis], digits = 1)
colnames(tmp.df) <- c(" ", "Year", "%")
## Minitable
PBminitable(output = plotsOutput, MTname = plotInfo$plotName, table = tmp.df)
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput,
         manual = "Countries with highest percentage of freshwater resources withdrawn by agriculture (percent, 2000-2010)")

# C.P1.WATER.1.3 ----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.WATER.1.3")
tmp.df <- icn2.df[icn2.df[, "Area"] == "Territory" & 
                    icn2.df[, "Year"] %in% plotInfo$plotYears, c("FAOST_CODE", "SHORT_NAME", "Year", "Area", plotInfo$xAxis)]
tmp.df <- arrange(tmp.df, FAOST_CODE, Year)
plotInfo$plotYears <- max(plotInfo$plotYears)
tmp.df <- ddply(tmp.df, .(FAOST_CODE, SHORT_NAME, Area), function(df) {numcolwise(na.locf)(df, na.rm = FALSE)})
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = tmp.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3.2, height = 6.1,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput)

# C.P1.WATER.1.4 ----------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.WATER.1.4")
tmp.df <- icn2.df[icn2.df[, "Area"] == "Territory" & 
                    icn2.df[, "Year"] %in% plotInfo$plotYears, c("FAOST_CODE", "SHORT_NAME", "Year", "Area", plotInfo$xAxis)]
tmp.df <- arrange(tmp.df, FAOST_CODE, Year)
plotInfo$plotYears <- max(plotInfo$plotYears)
tmp.df <- ddply(tmp.df, .(FAOST_CODE, SHORT_NAME, Area), function(df) {numcolwise(na.locf)(df, na.rm = FALSE)})
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = tmp.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3.2, height = 6.1,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput)

# C.P1.WATER.1.5 ----------------------------------------------------------

## Info
plotInfo = plot_info(plotName = "C.P1.WATER.1.5")
## Data
tmp = data.frame(FAO_TABLE_NAME = c("Africa", "Developed", 
                                    "North Africa and\nCentral Asia", 
                                    "Latin America and\nthe Caribbean", 
                                    "South and\nEast Asia"),
                 SALINESSOIL = c(48.574, 19.000, 46.895, 24.344, 48.512),
                 stringsAsFactors = TRUE)
## Plot
assign(plotInfo$plotName,
       ggplot(data = tmp, aes_string(x = plotInfo$xAxis, y = "SALINESSOIL")) +
         geom_bar(aes_string(col = "FAO_TABLE_NAME", fill = "FAO_TABLE_NAME"), 
                  position = "dodge", stat = "identity") +
         scale_fill_manual(values = plot_colors(part = plotInfo$plotPart, 5)[["Sub"]]) +
         scale_color_manual(values = plot_colors(part = plotInfo$plotPart, 5)[["Sub"]]) +
         ylab(plotInfo$yPlotLab) +xlab(plotInfo$xPlotLab) +
         theme(axis.text.x = element_text(angle = 45)) + 
         noLeg())
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 6, height = 2,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput)

# C.P1.GGE.1.2 ------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.GGE.1.2")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = expression("thousand gigagrams CO"[2] * "eq"),
                legend_lab = subset(meta.lst$FULL,
                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 1)[["Sub"]]) +
         noLeg())
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3, height = 2.5,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput)

# C.P1.GGE.1.3 ------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.GGE.1.3")
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3.2, height = 6.1,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput)

# C.P1.GGE.1.4 ------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.GGE.1.4")
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 2)[["Sub"]]))
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3.2, height = 6.1,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput)

# C.P1.GGE.1.5 ------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.GGE.1.5")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = expression("    thousand gigagrams CO"[2] * "eq"),
                legend_lab = subset(meta.lst$FULL,
                                    subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 5)[["Sub"]]) +
         theme(axis.text.x = element_blank()) + 
         guides(fill = guide_legend(nrow = 2), color = guide_legend(nrow = 2)))
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 6, height = 2.2,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput)

# C.P1.ORG.1.2 ------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.ORG.1.2")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
#                 legend_lab = subset(meta.lst$FULL,
#                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 3)[["Sub"]]))
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3, height = 2.5,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput)

# C.P1.ORG.1.3 ------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.ORG.1.3")
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 1)[["Sub"]]))
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3.2, height = 6.1,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput)

# C.P1.ORG.1.4 ------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.ORG.1.4")
plotInfo$plotYears <- c(min(plotInfo$plotYears), max(plotInfo$plotYears))
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
                col_pallete = plot_colors(part = plotInfo$plotPart, 1)[["Sub"]]))
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 3.2, height = 6.1,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput)

# C.P1.ORG.1.5 ------------------------------------------------------------

## Info
plotInfo <- plot_info(plotName = "C.P1.ORG.1.5")
## Plot
assign(plotInfo$plotName,
       plot_syb(x = plotInfo$xAxis,
                y = plotInfo$yAxis,
                group = plotInfo$group,
                type = plotInfo$plotType,
                subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                data = icn2.df,
                scale = plotInfo$scaling,
                x_lab = plotInfo$xPlotLab,
                y_lab = plotInfo$yPlotLab,
#                 legend_lab = subset(meta.lst$FULL,
#                                     subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                col_pallete = plot_colors(part = plotInfo$plotPart, 4)[["Sub"]]))
## Export the plot
pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
    family = "PT", title = NULL, width = 6, height = 2,
    pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
print(eval(parse(text = plotInfo$plotName)))
dev.off()
## Embed font
try(embedFonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""), fontpaths = PTpath))
## Caption
captions(objectName = plotInfo$plotName, output = captionsOutput)
