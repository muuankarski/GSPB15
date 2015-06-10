### Utilization
# Countries with highest share of children under 5 yards of age who are underweight (percent)
library(dplyr)
library(xtable)
library(lazyeval)
library(tidyr)
library(stringr)
library(scales)
library(ggplot2)


#################################################
## PART 2

# Undernourishment
# manually added "\setlength{\tabcolsep}{4pt}" before tabular in raw table!!!!!!!!!

dat <- read.csv("./database/Data/Raw/FSI2015_DisseminationDataset.csv", stringsAsFactors=FALSE)
dat <- dat[dat$FAOST_CODE %in% c(5001,5852,5851,5100,5853,5205,5500),] # World
dat <- dat[dat$Year %in% c(1991,2015),]
library(tidyr)
dat$Year <- paste0("X",dat$Year)
dat <- dat[c("Year","FAO_TABLE_NAME","FS.OA.POU.PCT3D1")]
dw <- spread(dat,
             Year,
             FS.OA.POU.PCT3D1)
dw$FAO_TABLE_NAME[dw$FAO_TABLE_NAME == "Latin America and the Caribbean"] <- "Latin Am. and the Carib."
dw$X2015[dw$X2015 == "20"] <- "20.0"
names(dw) <- c("","1990-92","2014-16")

dw <- dw[c(7,3,4,1,2,5,6),]

print.xtable(xtable(dw, caption = "Prevalence of undernourishment (percent, 1990-92 and 2014-16)", digits = c(0,0,0,0)), type = "latex", table.placement = NULL, booktabs = TRUE, include.rownames = FALSE, size = "footnotesize", caption.placement = "top", 
             file = "./publication/Tables/MT.P2.UNU.1.2.tex")

## "Countries with highest share of children under 5 years of age who are underweight

rrr <- function(varname) {
  filter(dat, Year %in% c(2006:2012)) %>% group_by_("FAOST_CODE") %>% summarise_(value = interp(~max(varname, na.rm = TRUE), varname = as.name(varname)))
}
dat <- read.csv("./database/Data/Raw/FSI2015_DisseminationDataset.csv", stringsAsFactors=FALSE)
dat$FAOST_CODE <- as.factor(dat$FAOST_CODE)
dat$FAOST_CODE <- as.numeric(levels(dat$FAOST_CODE))[dat$FAOST_CODE]

var <- "SH.STA.MALN.ZS"
tbl <- rrr(var)
tbl <- arrange(tbl, -value)[1:5,]
names(tbl) <- c("FAOST_CODE",var)
tbl <- left_join(tbl,sybdata.df[c("Year","FAOST_CODE",var)])
tbl <- left_join(tbl,FAOcountryProfile[c("FAOST_CODE","SHORT_NAME")])
tbl <- tbl[c(4,3,2)]
names(tbl) <- c("","Year","%")

print.xtable(xtable(tbl, caption = "Countries with highest share of children under 5 years of age who are underweight (percent) (2006 to 2012)", digits = c(0,0,0,1)), type = "latex", table.placement = NULL, booktabs = TRUE, include.rownames = FALSE, size = "footnotesize", caption.placement = "top", 
             file = "./publication/Tables/MT.P2.UT.1.2.tex")


######  Chart: fastest growing items between 2000-MRY

# dat <- read.csv("~/fao_temp/pocketbook_temp/Production_Crops_E_All_Data.csv")
# save(dat, file="~/fao_temp/pocketbook_temp/Production_Crops_E_All_Data.RData")
load("~/fao_temp/pocketbook_temp/Production_Crops_E_All_Data.RData")
d <- dat[dat$CountryCode == 5000,] # World
d <- d[d$Element == "Production",]
d <- d[d$Year >= 2000,]
library(tidyr)
d$Year <- paste0("X",d$Year)
d <- d[c("Item","Year","Value")]
library(plyr)
# Annual growth rate - geometric mean http://stackoverflow.com/questions/19824601/how-calculate-growth-rate-in-long-format-data-frame
d <- ddply(d,"Item",transform,
           Growth=c(NA,exp(diff(log(Value)))-1))
dd <- d %>% group_by(Item) %>% dplyr::summarise(mean_growth = mean(Growth, na.rm = TRUE)*100)
rc <- arrange(dd, -mean_growth)[1:5,c("Item","mean_growth")]
names(rc) <- c("","%")

print.xtable(xtable(rc, caption = "Fastest growing items based on production quantities (mean annual growth rate 2000 to 2013)", digits = c(0,0,0)), type = "latex", table.placement = NULL, booktabs = TRUE, include.rownames = FALSE, size = "footnotesize", caption.placement = "top", 
             file = "./publication/Tables/MT.P3.CRPRO.1.2.tex")


##########################################################################
##########################################################################

######  Chart:top five items produced in MRY vs. 2000

# dat <- read.csv("~/fao_temp/pocketbook_temp/Production_Crops_E_All_Data.csv")
# save(dat, file="~/fao_temp/pocketbook_temp/Production_Crops_E_All_Data.RData")
load("~/fao_temp/pocketbook_temp/Production_Crops_E_All_Data.RData")
d <- dat[dat$CountryCode == 5000,] # World
d <- d[d$Element == "Production",]
d <- d[d$Year == 2013,]
dd <- d[ with(d, !grepl("Total", Item)), ]
v2013 <- arrange(dd, -Value)[1:5,c("Item","Value")]
# Year 2000 equivalent
d <- dat[dat$CountryCode == 5000,] # World
d <- d[d$Element == "Production",]
d <- d[d$Year == 2000,]
d <- d[d$Item %in% c("Sugar cane", "Maize", "Rice, paddy", "Wheat", "Potatoes"),]
v2000 <- d[c("Item","Value")]
gg <- merge(v2000,v2013,by="Item")
gg$Value.x <- gg$Value.x/1000
gg$Value.y <- gg$Value.y/1000
gg <- arrange(gg, -gg$Value.y)
names(gg) <- c("","2000", "2013")
gg[[2]] <- round(gg[[2]],0)
gg[[3]] <- round(gg[[3]],0)
gg[[2]]<- prettyNum(gg[[2]], big.mark=" ")
gg[[3]]<- prettyNum(gg[[3]], big.mark=" ")

print.xtable(xtable(gg, caption = "Top five items produced in 2013 vs. 2000 (thousand tonnes)", digits = c(0,0,0,0)), type = "latex", table.placement = NULL, booktabs = TRUE, include.rownames = FALSE, size = "footnotesize", caption.placement = "top", 
             file = "./publication/Tables/MT.P3.CRTRE.1.2.tex")


##########################################################################
##########################################################################
######  Chart:top five live animals stock in 2013 vs. 2000

# dat <- read.csv("~/fao_temp/pocketbook_temp/Production_Livestock_E_All_Data.csv")
# save(dat, file="~/fao_temp/pocketbook_temp/Production_Livestock_E_All_Data.RData")
load("~/fao_temp/pocketbook_temp/Production_Livestock_E_All_Data.RData")
d <- dat[dat$CountryCode == 5000,] # World
#d <- d[d$Element == "Production",]
d <- d[d$Year == 2013,]
dd <- d
dd <- d[ with(d, !grepl("Total", Item)), ]
v2013 <- arrange(dd, -Value)[1:5,c("Item","Value")]
# cat(paste(shQuote(v2013$Item, type="cmd"), collapse=", "))
# Year 2000 equivalent
d <- dat[dat$CountryCode == 5000,] # World
d <- d[d$Year == 2000,]
d <- d[d$Item %in% c("Cattle", "Sheep", "Goats", "Pigs", "Buffaloes"),]
v2000 <- d[c("Item","Value")]
gg <- merge(v2000,v2013,by="Item")
gg$Value.x <- gg$Value.x/1000
gg$Value.y <- gg$Value.y/1000
gg <- arrange(gg, -Value.y)
names(gg) <- c("","2000", "2013")
gg[[2]] <- round(gg[[2]],0)
gg[[3]] <- round(gg[[3]],0)
gg[[2]]<- prettyNum(gg[[2]], big.mark=" ")
gg[[3]]<- prettyNum(gg[[3]], big.mark=" ")

print.xtable(xtable(gg, caption = "Top five live animal stock in 2013 vs. 2000 (thousand heads)", digits = c(0,0,0,0)), type = "latex", table.placement = NULL, booktabs = TRUE, include.rownames = FALSE, size = "footnotesize", caption.placement = "top", 
             file = "./publication/Tables/MT.P3.LIVE.1.2.tex")

##########################################################################
##########################################################################
## Trends in agricultural trade

dat <- read.csv("~/fao_temp/pocketbook_temp/food_export_import.csv")
d <- dat[!(dat$AreaCode %in% 5000),] # World
d <- d[d$ItemName == "Food and Animals",]
dd <- d[c("AreaName","ElementName","Value")]
dw <- spread(dd, key = ElementName, value = Value)
names(dw) <- str_replace_all(names(dw), " ", ".")
dw[[2]] <- dw[[2]]/1000000
dw[[3]] <- dw[[3]]/1000000
dw <- arrange(dw, -Import.Value)
names(dw) <- c("","Export value", "Import Value")

print.xtable(xtable(dw, caption = "Exports and Imports of food (million US\\$ 2012)", digits = c(0,0,0,0)), type = "latex", table.placement = NULL, booktabs = TRUE, include.rownames = FALSE, size = "footnotesize", caption.placement = "top", 
             file = "./publication/Tables/MT.P3.TRADE.1.3.tex")


##########################################################################
##########################################################################
##########################################################################
##########################################################################
##########################################################################
##########################################################################
##########################################################################
##########################################################################
######## Pie charts


## Piechart for livestock

load("~/fao_temp/pocketbook_temp/Production_Livestock_E_All_Data.RData")
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
d$var[d$var == "FBS.SDES.VOAF.PCT3D"] <- "VMilk\n(excl. butter)"
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
