plot.map2=function (shpFile, var, data, countryCode = "FAOST_CODE", n = 5, 
                    style = "jenks", manualBreaks, col = c("#F5F5F5", "#C8E2DE", 
                                                           "#9CCFC7", "#70BCB0", "#44AA99"), missCol = "#8B8878", 
                    countryCodeTransp = NULL, missLabel = "N/A", 
                    subset = TRUE, scale = 1, shpProj = "+proj=robin +ellps=WGS84", 
                    outProj = "+proj=robin") 
{
  if (!missing(shpFile)) {
    llCRS = CRS(projargs = shpProj)
    projCRS = CRS(outProj)
    raw.sp = readShapePoly(shpFile, proj4string = llCRS)
    transformed.sp = raw.sp # spTransform(raw.sp, CRSobj = projCRS)
    transformed.df = fortify(transformed.sp, region = countryCode)
    transformed.df$id = as.numeric(transformed.df$id)
  }
  else {
    transformed.sp = spTransform(GAULspatialPolygon, CRSobj = CRS(proj4string(GAULspatialPolygon)))
    transformed.df = fortify(transformed.sp, region = countryCode)
    transformed.df$id = as.numeric(transformed.df$id)
    cat("\nNOTE: GAUL border used as default\n")
  }
  transformed.df$order = 1:NROW(transformed.df$order)
  subset = substitute(subset)
  sub_data = subset.data.frame(data, subset = eval(subset), 
                               select = c(countryCode, var))
  sub_data[, var] = sub_data[, var] * scale
  sub_data = unique(sub_data)
  if (missing(manualBreaks)) {
    brks = map_breaks(sub_data[, var], n = n, style = style)
  }
  else {
    brks = manualBreaks
  }
  sub_data$fillColor = as.character(findInterval(sub_data[, 
                                                          var], brks, rightmost.closed = TRUE))
  final.df = merge(sub_data, transformed.df, by.x = countryCode, 
                   by.y = "id", all = TRUE)
  final.df = arrange(final.df, order)
  final.df[is.na(final.df[, var]) & !final.df[, countryCode] %in% 
             countryCodeTransp, "fillColor"] = "0"
  if (any(is.na(final.df[, var]) & !final.df[, countryCode] %in% 
            countryCodeTransp)) {
    uVal = c(sort(unique(final.df$fillColor)))
    uCol = c(missCol, col[sort(as.numeric(unique(final.df$fillColor)))])
    uBrks = c(missLabel, formatC(brks[sort(as.numeric(unique(final.df$fillColor))) + 
                                        1], format = "fg", big.mark = " "))
    nBrks = length(uBrks)
    endMar = rep(0, nBrks)
    endMar[3:(nBrks - 1)] = ifelse(uBrks[3:(nBrks - 1)] >= 
                                     10, 1, 0.01)
    legendLab = paste(c(uBrks[-nBrks]), c("", rep(" ~ < ", 
                                                  nBrks - 3), " ~ "), c("", uBrks[3:nBrks]), sep = "")
  }
  else {
    uVal = sort(unique(final.df$fillColor))
    uCol = col[sort(as.numeric(unique(final.df$fillColor)))]
    uBrks = formatC(brks[c(sort(as.numeric(unique(final.df$fillColor))), 
                           length(brks))], format = "fg", big.mark = " ")
    nBrks = length(uBrks)
    endMar = rep(0, nBrks)
    endMar[3:(nBrks - 1)] = ifelse(uBrks[3:(nBrks - 1)] >= 
                                     10, 1, 0.01)
    legendLab = paste(c(uBrks[-nBrks]), c(rep(" ~ < ", nBrks - 
                                                2), " ~ "), c(uBrks[2:nBrks]), sep = "")
  }
  if (!is.null(countryCodeTransp)) {
    final.df[final.df[, countryCode] %in% countryCodeTransp, 
             "fillColor"] = "transparent"
  }
  map = ggplot(data = final.df, aes(x = long, y = lat, group = group)) + 
    geom_polygon(aes(fill = fillColor)) + 
    geom_path(color = "white", size=.1) + 
    coord_equal() + theme(legend.position = c(0.07,0.05), 
                          legend.justification=c(0,0),
                          legend.key.height=unit(1,'cm'), 
                          legend.key.width=unit(1,'cm'),
                          legend.direction = "vertical",
                          legend.background=element_rect(colour='transparent', fill='transparent'),
                          legend.text=element_text(size=14), 
                          panel.background = element_blank(), 
                          plot.background = element_blank(), 
                          axis.text = element_blank(), 
                          axis.ticks = element_blank(), 
                          legend.title = element_blank(), 
                          plot.margin = unit(c(0,0, 0, 0), "lines")) + 
                    xlab(NULL) + 
                    ylab(NULL)
  if (!is.null(countryCodeTransp)) {
    map = map + scale_fill_manual(labels = c(legendLab, ""), 
                                  values = c(uCol, "transparent"), breaks = c(uVal, 
                                                                              "transparent"))
  }
  else {
    map = map + scale_fill_manual(labels = legendLab, values = uCol, 
                                  breaks = uVal)
  }
  map
}