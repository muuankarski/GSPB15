#' # Data manipulation for fisheries data
#'
#' This doc downloads and munges the fisheries data for SYB process
#'
#' ## Fish production
#+ echo=FALSE, message=FALSE

# the setup
knitr::opts_chunk$set(list(echo=TRUE,eval=TRUE,cache=FALSE,warning=FALSE,message=FALSE, fig.height=15,fig.height=12))
knitr::opts_knit$set(root.dir = "~/btsync/fao_sync/pocketbooks/GSPB15/")
# libraries
library(FAOSTAT)
library(dplyr)
library(ggplot2)
library(knitr)
library(readxl)
library(tidyr)
library(DT)

#' ## Download and munge the raw data
#' Before downloading I saved the sheet `Final table` into a csv-file as the excel formattings were too compilicated for R to digest correctly

# load key data sets
#load(file = "./database/Data/Processed/SYB.RData")
#sybdata.df <- SYB.df; rm(SYB.df)
load("./database/Data/Processed/FAOcountryProfile.RData")
# download the .csv data
#at <- read.csv("./database/Data/Raw/fishery2015/YB_ESS_2015_FishProductionTABLE.csv", stringsAsFactors = FALSE, header=TRUE)


kable(head(dat))

dat2 <- dat[-1:-2,c(7,11,17)]
names(dat2) <- c("UNcode","cap2013","aquacul2013")

# replace empty cells with NA
dat2[[1]][dat2[[1]] == ""] <- NA
dat2[[2]][dat2[[2]] == ""] <- NA
dat2[[3]][dat2[[3]] == ""] <- NA
# remove NA cells
dat2 <- dat2[!is.na(dat2[[1]]),]
dat2 <- dat2[!is.na(dat2[[2]]),]
dat2 <- dat2[!is.na(dat2[[3]]),]
# Convert both value columns into numeric format
dat2[[1]] <- factor(dat2[[1]])
dat2[[1]] <- as.numeric(levels(dat2[[1]]))[dat2[[1]]]
dat2[[2]] <- factor(dat2[[2]])
dat2[[2]] <- as.numeric(levels(dat2[[2]]))[dat2[[2]]]
dat2[[3]] <- factor(dat2[[3]])
dat2[[3]] <- as.numeric(levels(dat2[[3]]))[dat2[[3]]]

# print head of intermediate data
kable(head(dat2))

# Convert uncodes into FAOSTAT we use


dat2 <- merge(dat2,FAOcountryProfile[c("FAOST_CODE","UN_CODE")],by.x="UNcode",by.y="UN_CODE")

kable(head(dat2))

# compute the aggregates for China
tmp <- dat2 %>% filter(UNcode %in% c(156, # China
                                     344, # China, Hong Kong SAR
                                     446, # China, Macao SAR
                                     214 # Taiwan, Province of China
                                     )) %>% dplyr::summarise(cap2013 = sum(cap2013),
                                                             aquacul2013 = sum(aquacul2013))


tmp$FAOST_CODE <- 351
tmp$UNcode <- NA

datatable(tmp)

# Add the China aggregates to the data
dat2 <- rbind(dat2,tmp)
# Remove the individual components
dat2 <- dat2[!(dat2$UNcode %in% c(156,344,446,214)),]
dat2$UNcode <- NULL
dat2 <- dat2[!is.na(dat2$FAOST_CODE),]
dat2$Year <- 2013

names(dat2) <- c("FI.PRD.CAPT.TN.NO","FI.PRD.AQ.TN.NO","FAOST_CODE","Year")
d2013 <- dat2
# rescale into million tons
d2013$FI.PRD.CAPT.TN.NO <- d2013$FI.PRD.CAPT.TN.NO / 1000
d2013$FI.PRD.AQ.TN.NO <- d2013$FI.PRD.AQ.TN.NO / 1000

kable(head(d2013))

for (i in names(d2013)[!(names(d2013) %in% c("FAOST_CODE","Year") )]){
  d <- merge(d2013,FAOcountryProfile[c("FAOST_CODE","FAO_TABLE_NAME")],by="FAOST_CODE")
  d <- d[c("FAO_TABLE_NAME",i)]
  names(d) <- c("FAO_TABLE_NAME","var")
  print(
    ggplot(d, aes(x=reorder(FAO_TABLE_NAME,var),y=var)) +
      geom_bar(stat="identity") + labs(y="million tons",title=i) +
      coord_flip()
  )
}
  


#' ## m49 macro aggregates

# get unique FAOST_CODE and equivalaent m49 region codes
M49macroReg <- unique(na.omit(FAOcountryProfile[, c("FAOST_CODE", "UNSD_MACRO_REG_CODE","UNSD_SUB_REG_CODE")]))

# add those to 2013 data
d2013 <- merge(d2013,M49macroReg,by="FAOST_CODE",all.x=TRUE)

# recode caribbean and latin american countries to belong into same group
d2013$UNSD_MACRO_REG_CODE[d2013$UNSD_SUB_REG_CODE == 5206] <- 5205
d2013$UNSD_MACRO_REG_CODE[d2013$UNSD_SUB_REG_CODE == 5207] <- 5205
# Compute the regional sums
m49 <- d2013 %>% group_by(UNSD_MACRO_REG_CODE,Year) %>% dplyr::summarise(FI.PRD.CAPT.TN.NO = sum(FI.PRD.CAPT.TN.NO,na.rm=TRUE),
                                                                         FI.PRD.AQ.TN.NO = sum(FI.PRD.AQ.TN.NO,na.rm=TRUE))
names(m49)[names(m49)=="UNSD_MACRO_REG_CODE"] <- "FAOST_CODE"
kable(head(m49))

#' ## m49world macro aggregates

m49world <- d2013 %>% group_by(Year) %>% dplyr::summarise(FI.PRD.CAPT.TN.NO = sum(FI.PRD.CAPT.TN.NO,na.rm=TRUE),
                                                          FI.PRD.AQ.TN.NO = sum(FI.PRD.AQ.TN.NO,na.rm=TRUE))
m49world$FAOST_CODE <- 5000
kable(head(m49world))


#' pile up the country level, region level and world level data

d2013$UNSD_MACRO_REG_CODE <- NULL
d2013$UNSD_SUB_REG_CODE <- NULL

d2013 <- rbind(d2013,m49)
d2013 <- rbind(d2013,m49world)


#' # subset on AQUACULT & CAPTURE prior to 2013 from FAOSTAT 
#' probably should have taken also years 2011 and 2012 also from your excel


pre2013 <- sybdata.df[c("FAOST_CODE","Year","FI.PRD.CAPT.TN.NO","FI.PRD.AQ.TN.NO")]
pre2013 <- filter(pre2013, Year <= 2012)

pre2013$FI.PRD.CAPT.TN.NO <- pre2013$FI.PRD.CAPT.TN.NO / 1000000
pre2013$FI.PRD.AQ.TN.NO <- pre2013$FI.PRD.AQ.TN.NO / 1000000

#' pile-up the pre 2013 data and the processed 2013 data

dat <- rbind(pre2013,d2013)

dat <- dat[!duplicated(dat[c("FAOST_CODE","Year")]),]

#' ## Compute the production quantity index

# total production
dat$total_prod <- rowSums(dat[3:4], na.rm = TRUE)
# compute the 2004-2006 avg
prod04_06 <- dat %>% filter(Year %in% c(2004,2005,2006)) %>% group_by(FAOST_CODE) %>% dplyr::summarise(prod_100 = mean(total_prod, na.rm=TRUE))
dat <- merge(dat,prod04_06,by="FAOST_CODE",all.x=TRUE)
# compute the index
dat$production_quantity_index <- dat$total_prod / dat$prod_100 * 100
dat <- dat[!is.infinite(dat$production_quantity_index),]

dat$prod_100 <- NULL

datatable(dat)

#' line plot the index

d <- merge(dat,FAOcountryProfile[c("FAOST_CODE","FAO_TABLE_NAME")],by="FAOST_CODE")
# no limit
ggplot(d, aes(x=Year,y=production_quantity_index,color=FAO_TABLE_NAME)) +
  geom_point() + geom_line() +
  coord_cartesian(xlim=c(1985,2016)) +
  geom_text(data=d[d$Year == 2013,], aes(x=Year, y = production_quantity_index, label=FAO_TABLE_NAME), hjust=-0.5,vjust=-1,size=3) +
  theme(legend.position="none")


ggplot(d, aes(x=Year,y=production_quantity_index,color=FAO_TABLE_NAME)) +
  geom_point() + geom_line() +
  coord_cartesian(ylim=c(0,1000),xlim=c(1985,2016)) +
  geom_text(data=d[d$Year == 2013,], aes(x=Year, y = production_quantity_index, label=FAO_TABLE_NAME), hjust=-0.5,vjust=-1,size=3) +
  theme(legend.position="none")



sybdata.df$FI.PRD.CAPT.TN.NO <- NULL
sybdata.df$FI.PRD.AQ.TN.NO <- NULL

sybdata.df <- merge(sybdata.df,dat,by=c("FAOST_CODE","Year"), all.x=TRUE)

#' # Net fish trade


library(gdata)
dat <- read.xls("./database/Data/Raw/Trade1990_2012_ESSJun2015.xlsx", sheet=1, skip=1)
dat <- read_excel("./database/Data/Raw/Trade1990_2012_ESSJun2015.xlsx", sheet=1, skip = 1)
kable(head(dat))
  
# select vars to drop
drops <- names(dat)[grepl("^Symbol", names(dat))]
dat <- dat[,!(names(dat) %in% drops)]
# Convert into long
dl <- gather(dat, 
               "Year",
               "net_fish_trade",
               6:28)
# keep selected columns
dl <- dl[c(-3,-4,-5)]
names(dl)[names(dl)=="UN code"] <- "UN_CODE"
dl$Year <- factor(dl$Year)
dl$Year <- as.numeric(levels(dl$Year))[dl$Year]
  
# Recode into FAOST_CODE
dl <- merge(dl,FAOcountryProfile[c("FAOST_CODE","UN_CODE")],by="UN_CODE")
  
# Aggregate China
tmp <- dl %>% filter(UN_CODE %in% c(156, # China
                                      344, # China, Hong Kong SAR
                                      446, # China, Macao SAR
                                      214  # Taiwan, Province of China
                                      )) %>%  group_by(Year) %>% dplyr::summarise(net_fish_trade = sum(net_fish_trade))
tmp$FAOST_CODE <- 351
tmp$UN_CODE <- NA
tmp$Country <- "China"
  
kable(head(tmp))
  
# pile up new China with rest of the data and remove the components of China 
dl <- rbind(dl,tmp)
dl <- dl[!(dl$UN_CODE %in% c(156,344,446,214)),]
  
dl$UN_CODE <- NULL
dl$Country <- NULL
  
  
  
#' ### m49 macro aggregates
M49macroReg <- unique(na.omit(FAOcountryProfile[, c("FAOST_CODE", "UNSD_MACRO_REG_CODE","UNSD_SUB_REG_CODE")]))
dl <- merge(dl,M49macroReg,by="FAOST_CODE",all.x=TRUE)

dl$UNSD_MACRO_REG_CODE[dl$UNSD_SUB_REG_CODE == 5206] <- 5205
dl$UNSD_MACRO_REG_CODE[dl$UNSD_SUB_REG_CODE == 5207] <- 5205

#' ### m49 macro aggregates
m49 <- dl %>% group_by(UNSD_MACRO_REG_CODE,Year) %>% dplyr::summarise(net_fish_trade = sum(net_fish_trade,na.rm=TRUE))
names(m49) <- c("FAOST_CODE","Year","net_fish_trade")

kable(head(m49))

m49world <- dl %>% group_by(Year) %>% dplyr::summarise(net_fish_trade = sum(net_fish_trade,na.rm=TRUE))
names(m49world) <- c("Year","net_fish_trade")
m49world$FAOST_CODE <- 5000

kable(head(m49))
  
dl$UNSD_MACRO_REG_CODE <- NULL
dl$UNSD_SUB_REG_CODE <- NULL
dl <- rbind(dl,m49)
dl <- rbind(dl,m49world)

datatable(dl)


sybdata.df <- merge(sybdata.df,dl,by=c("FAOST_CODE","Year"), all.x=TRUE)



