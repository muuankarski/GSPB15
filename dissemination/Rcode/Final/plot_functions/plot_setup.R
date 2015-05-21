# Colors part 1 -----------------------------------------------------------

set_part <- function(part=1) {
  
  if (part == 1) {
    
    colPart1 <- plot_colors(part = 1, 12)
    col.main1 <- colPart1[["Main"]][1]
    ## color for the grid
    col.main2 <- colPart1[["Main"]][2]
    source("./dissemination/Rcode/Final/theme_functions/theme.R")
    
  }
  
  if (part == 2) {
    
    colPart2 <- plot_colors(part = 2, 12)
    col.main2 <- colPart2[["Main"]][1]
    ## color for the grid
    col.main2 <- colPart2[["Main"]][2]
    source("./dissemination/Rcode/Final/theme_functions/theme.R")
    
  }
  
  if (part == 3) {
    
    colPart3 <- plot_colors(part = 3, 12)
    col.main3 <- colPart3[["Main"]][1]
    ## color for the grid
    col.main2 <- colPart3[["Main"]][2]
    source("./dissemination/Rcode/Final/theme_functions/theme.R")
    
  }
  
  if (part == 4) {
    
    colPart4 <- plot_colors(part = 4, 12)
    col.main4 <- colPart4[["Main"]][1]
    ## color for the grid
    col.main2 <- colPart4[["Main"]][2]
    source("./dissemination/Rcode/Final/theme_functions/theme.R")
    
  }
}


#######################################################################
# Plot plotting!



meta_plot_plot <- function(plot_type=1, n_colors=2) {

    
  if (plot_type == 1){

    # "multi_stack_line"
    
   p <-  plot_syb(x = plotInfo$xAxis,
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
             legend_lab <- c("Urban population","Rural population"),
             col_pallete = plot_colors(part = plotInfo$plotPart, n_colors)[["Sub"]] 
    ) +
     centerYear() + 
     geom_vline(xintercept = 2013, linetype = "dashed") +
     scale_x_continuous(breaks=c(1960, 1980, 2000, 2020))
  }

    if (plot_type == "1b"){

    # "multi_stack_line"
    
   p <-  plot_syb(x = plotInfo$xAxis,
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
             legend_lab <- c("Urban population","Rural population"),
             col_pallete = plot_colors(part = plotInfo$plotPart, n_colors)[["Sub"]] 
    ) # +
     # centerYear() + 
     # geom_vline(xintercept = 2013, linetype = "dashed") +
     # scale_x_continuous(breaks=c(1960, 1980, 2000, 2020))
  }
  
  if (plot_type == 2){

    # "top_bot_dot"
    # "top_dot"
    # "bot_dot"
    # "reg_uni_bar"

	 p <- plot_syb(x = plotInfo$xAxis,
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
		        col_pallete = plot_colors(part = plotInfo$plotPart, n_colors)[["Sub"]]
		        ) 
 
    
  }

  # "reg_uni_line"
  # "multi_stack_bar"
  # "multi_line"

  if (plot_type == 3){

           p <- plot_syb(x = plotInfo$xAxis,
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
                        col_pallete = plot_colors(part = plotInfo$plotPart, n_colors)[["Sub"]]
                        )

  }
  
  if (plot_type == "3_1"){
    p <-  plot_syb(x = plotInfo$xAxis,
                         y = plotInfo$yAxis,
                         group = plotInfo$group,
                         type = plotInfo$plotType,
                         subset = eval(parse(text = "Year %in% c(plotInfo$plotYears) &
                                    Area %in% c(plotInfo$plotArea)")),
                         data = sybdata.df,
                         scale = plotInfo$scaling,
                         x_lab = plotInfo$xPlotLab,
                         y_lab = expression("    thousand gigagrams CO"[2] * "eq"),
                         legend_lab = subset(meta.lst$FULL,
                                             subset = STS_ID %in% plotInfo$yAxis)[, "TITLE_STS_SHORT"],
                         col_pallete = plot_colors(part = plotInfo$plotPart, 5)[["Sub"]]
                         ) +
      theme(axis.text.x = element_blank()) + 
      guides(fill = guide_legend(nrow = 2), color = guide_legend(nrow = 2))
  }
  
  
  
  print(p)
}


# Export the plot
export_plot <- function(manual_text =  "Add something here!", placement) { 
  
  if (placement %in% c("l","r")) {
    plotWidth <- 3.2
    plotHeight <- 5.9
  }
  if (placement == "b") {
    plotWidth <- 6
    plotHeight <- 3
  }
  if (placement == "tr") {
    plotWidth <- 3
    plotHeight <- 2.5
  }
  
  pdf(file = paste(plotsOutput, plotInfo$plotName , ".pdf", sep = ""), 
      family = "PT Sans", title = NULL, width = plotWidth, height = plotHeight,
      pointsize = 10, colormodel = "cmyk", pagecentre = FALSE)
  
  print(eval(parse(text = plotInfo$plotName)))
  dev.off()
  
  ## Embed font
  embed_fonts(paste(plotsOutput, plotInfo$plotName, ".pdf", sep = ""))
  ## Caption
  captions(objectName = plotInfo$plotName, output = captionsOutput, manual = manual_text)
  
}
  

#######################################################################
# Map plotting!


source('./dissemination/Rcode/Final/plot_functions/plot_map.R', echo=TRUE)
source('./dissemination/Rcode/Final/plot_functions/exp_map.R', echo=TRUE)
source('./dissemination/Rcode/Final/plot_functions/sources.R', echo=TRUE)

meta_plot_map <- function() {
  
  p <- plot_map(shpFile = shpLocation,
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
  print(p)
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
