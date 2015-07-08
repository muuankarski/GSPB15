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
#dw$FAO_TABLE_NAME[dw$FAO_TABLE_NAME == "Latin America and the Caribbean"] <- "Latin Am. and the Carib."
dw$FAO_TABLE_NAME[dw$FAO_TABLE_NAME == "Latin America and the Caribbean"] <- "Latin America and \n the Caribbean"
dw$X2015[dw$X2015 == "20"] <- "20.0"
names(dw) <- c("","1990-92","2014-16")

dw <- dw[c(7,3,4,1,2,5,6),]

# Chiaras comments
print.xtable(xtable(dw, caption = " Prevalence of undernourishment (percent)", digits = c(0,0,0,0),
                    align= "l{\raggedright\arraybackslash}p{1.7cm}rr"),
             type = "latex", table.placement = NULL, 
             booktabs = TRUE, include.rownames = FALSE, size = "footnotesize", caption.placement = "top", 
             file = "./publication/Tables/MT.P2.UNU.1.2.tex")
# run this in shell!!! without "system"
# sed -i 's#\\end{table}#2014-16 estimates are projections.\n\\end{table}#' ./publication/Tables/MT.P2.UNU.1.2.tex


## "Countries with highest share of children under 5 years of age who are underweight

dat <- read.csv("./database/Data/Raw/FSI2015_DisseminationDataset.csv", stringsAsFactors=FALSE)
dat$FAOST_CODE <- as.factor(dat$FAOST_CODE)
dat$FAOST_CODE <- as.numeric(levels(dat$FAOST_CODE))[dat$FAOST_CODE]

ff <- dat[c("Year","FAOST_CODE","SH.STA.MALN.ZS")]
ff <- ff[!is.na(ff$SH.STA.MALN.ZS),]
ff <- filter(ff, Year >= 2008)

maxyear <- ff %>% group_by(FAOST_CODE) %>% dplyr::summarise(Year = max(Year))
dat <- merge(maxyear,ff,by=c("Year","FAOST_CODE"),all.x=TRUE)
tbl <- arrange(dat, -SH.STA.MALN.ZS)[1:5,]
tbl <- left_join(tbl,FAOcountryProfile[c("FAOST_CODE","SHORT_NAME")])
tbl <- tbl[c(4,1,3)]
names(tbl) <- c("","Year","%")

print.xtable(xtable(tbl, caption = "Countries with highest share of children under 5 who are underweight, percent", digits = c(0,0,0,1),
                    align= "l{\raggedright\arraybackslash}p{1.6cm}rr"),
             type = "latex", table.placement = NULL, booktabs = TRUE, include.rownames = FALSE, size = "footnotesize", caption.placement = "top", 
             file = "./publication/Tables/MT.P2.UT.1.2.tex")


######  Chart: fastest growing items between 2000-MRY

# dat <- read.csv("~/fao_temp/pocketbook_temp/Production_Crops_E_All_Data.csv")
# save(dat, file="~/fao_temp/pocketbook_temp/Production_Crops_E_All_Data.RData")
load("./database/Data/Raw/Production_Crops_E_All_Data.RData")
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

print.xtable(xtable(rc, caption = "Fastest growing products based on quantities (average anual growth rate, 2000 to 2013)", digits = c(0,0,0),
                    align= "l{\raggedright\arraybackslash}p{2.2cm}r"), 
             type = "latex", table.placement = NULL, booktabs = TRUE, include.rownames = FALSE, size = "footnotesize", caption.placement = "top", 
             file = "./publication/Tables/MT.P3.CRPRO.1.2.tex")


##########################################################################
##########################################################################

######  Chart:top five items produced in MRY vs. 2000

# dat <- read.csv("~/fao_temp/pocketbook_temp/Production_Crops_E_All_Data.csv")
# save(dat, file="~/fao_temp/pocketbook_temp/Production_Crops_E_All_Data.RData")
load("./database/Data/Raw/Production_Crops_E_All_Data.RData")
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


print(xtable(gg, caption = "Top five items produced in 2013, thousand tonnes", digits = c(0,0,0,0),
             align= "l{\raggedright\arraybackslash}p{1.0cm}rr"),
      type = "latex", table.placement = NULL, 
      booktabs = TRUE, include.rownames = FALSE, 
      size = "footnotesize", caption.placement = "top", 
      file = "./publication/Tables/MT.P3.CRTRE.1.2.tex")



##########################################################################
##########################################################################
######  Chart:top five live animals stock in 2013 vs. 2000

# dat <- read.csv("~/fao_temp/pocketbook_temp/Production_Livestock_E_All_Data.csv")
# save(dat, file="~/fao_temp/pocketbook_temp/Production_Livestock_E_All_Data.RData")
load("./database/Data/Raw/Production_Livestock_E_All_Data.RData")
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

print.xtable(xtable(gg, caption = "Live animal production, top 5 in 2013 (thousand heads)", digits = c(0,0,0,0),
                    align= "l{\raggedright\arraybackslash}p{1.0cm}rr"),
             type = "latex", table.placement = NULL, booktabs = TRUE, include.rownames = FALSE, size = "footnotesize", caption.placement = "top", 
             file = "./publication/Tables/MT.P3.LIVE.1.2.tex")

##########################################################################
##########################################################################
## Trends in agricultural trade

dat <- read.csv("./database/Data/Raw/food_export_import.csv")
d <- dat[!(dat$AreaCode %in% 5000),] # World
d <- d[d$ItemName == "Food and Animals",]
dd <- d[c("AreaName","ElementName","Value")]
dw <- spread(dd, key = ElementName, value = Value)
names(dw) <- str_replace_all(names(dw), " ", ".")
dw[[2]] <- dw[[2]]/1000000
dw[[3]] <- dw[[3]]/1000000
dw <- arrange(dw, -Import.Value)
names(dw) <- c("","Export value", "Import Value")

print.xtable(xtable(dw, caption = " Exports and Imports of food, million US\\$ (2012)", digits = c(0,0,0,0),
                    align= "l{\raggedright\arraybackslash}p{1.0cm}rr"),
             type = "latex", table.placement = NULL, booktabs = TRUE, include.rownames = FALSE, size = "footnotesize", caption.placement = "top", 
             file = "./publication/Tables/MT.P3.TRADE.1.3.tex")



