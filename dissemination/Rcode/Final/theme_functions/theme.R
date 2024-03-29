theme_update(
  #   line = element_line(),
  #   rect = element_rect(),
  #   text = element_text(),
  #   axis.text = element_text(),
  #   strip.text = element_text(),
  #   axis.line = element_blank(),
  axis.text.x = element_text(family = "PT Sans", face = "plain", colour = "black",
                             size = 10, hjust = 1, vjust = 1, angle = 0,
                             lineheight = 0.6),
  axis.text.y = element_text(family = "PT Sans", face = "plain", colour = "black",
                             size = 10, hjust = 1, vjust = 0.5, angle = 0,
                             lineheight = 0.6),
  axis.ticks = element_blank(),
  axis.title.x = element_text(family = "PT Sans", face = "plain", colour = "black",
                              size = 10, hjust = 0.5, vjust = 0.2, angle = 0,
                              lineheight = 0.7),
  axis.title.y = element_text(family = "PT Sans", face = "plain", colour = "black",
                              size = 10, hjust = 0.5, vjust = 0.2, angle = 90,
                              lineheight = 0.7),
  #   axis.ticks.length = ,
  #   axis.ticks.margin = ,
  legend.background = element_blank(),
  #   legend.margin = ,
  legend.key = element_rect(fill = NA, colour = NA),
  #   legend.key.size = ,
  #   legend.key.height = NULL,
  #   legend.key.width = NULL,
  legend.text = element_text(size = 10, lineheight = 0.7),
  #   legend.text.align = NULL,
  legend.title = element_blank(),
  #   legend.title.align = NULL,
  legend.position = "top",
  legend.direction = "horizontal",
  #   legend.justification = "center",
  legend.box = NULL,
#   panel.background = element_rect(fill = col.main3, colour = col.main3,
#                                   size = NULL, linetype = NULL),
  panel.background = element_blank(),
  panel.border = element_blank(),
  #panel.grid.major = element_line(colour = col.main2, size = 0.5),
  panel.grid.major = element_line(colour = "grey80", size = 0.5),
  panel.grid.minor = element_blank(),
  #   panel.margin = ,
  strip.background = element_rect(colour = "transparent", fill = "transparent",
                                  size = NULL, linetype = NULL),
  #   strip.text.x = element_text(),
  #   strip.text.y = element_text(),
#   plot.background = element_rect(fill = col.main2, colour = col.main2,
#                                  size = NULL, linetype = NULL),
    plot.background = element_blank(),
  plot.title =  element_blank(),
  plot.margin = unit(rep(0.1, 4), "line")
)

noLeg = function(x) theme(legend.position = "none")
yesTitleX = function(x) theme(axis.title.x = element_text(family = "PT Sans", face = "plain", colour = "black",
                                                          size = 10, hjust = 0.5, vjust = 0.2, angle = 0,
                                                          lineheight = 0.7))
angleText <- function(angle = 45) theme(axis.text.x = element_text(family = "PT Sans", face = "plain", colour = "black",
                                                                   size = 10, hjust = 1, vjust = 1, angle = 45,
                                                                   lineheight = 0.6))
centerYear = function(x) theme(axis.text.x = element_text(family = "", face = "plain",
        colour = "black", size = 10, hjust = 0.5, vjust = 1, angle = 0, lineheight = 0.6))
mapLegend = function(x) theme(legend.key.size = unit(2.4, "cm"),
                              legend.text = element_text(size = 32))
