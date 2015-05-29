### Utilization
# Countries with highest share of children under 5 yards of age who are underweight (percent)
library(dplyr)
library(xtable)
library(lazyeval)

rrr <- function(varname) {
  filter(sybdata.df, Year %in% c(2006:2012)) %>% group_by_("FAOST_CODE") %>% summarise_(value = interp(~max(varname, na.rm = TRUE), varname = as.name(varname)))
}

var <- "SH.STA.MALN.ZS"
tbl <- rrr(var)
tbl <- arrange(tbl, -value)[1:5,]
names(tbl) <- c("FAOST_CODE",var)
tbl <- left_join(tbl,sybdata.df[c("Year","FAOST_CODE",var)])
tbl <- left_join(tbl,FAOcountryProfile[c("FAOST_CODE","SHORT_NAME")])
tbl <- tbl[c(4,3,2)]
names(tbl) <- c("","Year","%")

print.xtable(xtable(tbl, caption = "Countries with highest share of children under 5 yards of age who are underweight (percent) (2006 to 2012)", digits = c(0,0,0,1)), type = "latex", table.placement = NULL, booktabs = TRUE, include.rownames = FALSE, size = "footnotesize", caption.placement = "top", 
             file = "./publication/Tables/MT.P2.UT.1.2.tex")


######

dat <- sybdata.df[sybdata.df$Year %in% c(2006:2012) & sybdata.df$FAOST_CODE == 5000,c()]


rrr <- function(varname) {
  filter(sybdata.df, Year %in% c(2006:2012)) %>% group_by_("FAOST_CODE") %>% summarise_(value = interp(~max(varname, na.rm = TRUE), varname = as.name(varname)))
}


filter(sybdata.df, Year %in% c(2006:2012), FAOST_CODE == 5000) %>% summarise_(value = interp(~max(varname, na.rm = TRUE), varname = as.name(varname)))

var <- "SH.STA.MALN.ZS"
tbl <- rrr(var)
tbl <- arrange(tbl, -value)[1:5,]
names(tbl) <- c("FAOST_CODE",var)
tbl <- left_join(tbl,sybdata.df[c("Year","FAOST_CODE",var)])
tbl <- left_join(tbl,FAOcountryProfile[c("FAOST_CODE","SHORT_NAME")])
tbl <- tbl[c(4,3,2)]
names(tbl) <- c("","Year","%")

print.xtable(xtable(tbl, caption = "Countries with highest share of children under 5 yards of age who are underweight (percent) (2006 to 2012)", digits = c(0,0,0,1)), type = "latex", table.placement = NULL, booktabs = TRUE, include.rownames = FALSE, size = "footnotesize", caption.placement = "top", 
             file = "./publication/Tables/MT.P2.UT.1.2.tex")
















dat <- filter(sybdata.df, Year %in% c(2006:2012)) %>% group_by(FAOST_CODE) %>% dplyr::summarise(value = mean(SH.STA.MALN.ZS, na.rm=TRUE))
tbl <- arrange(dat, -value)[1:5,]
tbl <- left_join(tbl,FAOcountryProfile[c("FAOST_CODE","SHORT_NAME")])
tbl <- tbl[c(3,2)]
names(tbl) <- c("", "%")

print.xtable(xtable(tbl, caption = "Countries with highest share of children under 5 yards of age who are underweight (percent)", digits = 1), type = "latex", table.placement = NULL, booktabs = TRUE, include.rownames = FALSE, size = "footnotesize", caption.placement = "top", 
             file = "./publication/Tables/MT.P2.UT.1.2.tex")




\footnotesize
\begin{center}
\begin{tabular}{lrr}
\toprule
& XX-XX & XX-XX\\
\midrule
World & XX & XX\\
Developing
countries & XX & XX\\
Africa & XX & XX\\
Asia & XX & XX\\
Latin Am. and the Carib. & XX & XX\\
Oceania & XX & XX\\
Developed
countries & $<$XX & $<$XX\\
\toprule
\end{tabular}
\end{center}

\scriptsize
\begin{center}
\begin{tabular}{lrr}
\toprule
& Year & \%\\
\midrule
Kuwait & 2002 & 2460\\
the United Arab Emirates & 2005 & 2208\\
Saudi Arabia & 2006 & 867.9\\
Libya & 2000 & 512\\
Qatar & 2005 & 451.7\\
\toprule
\end{tabular}
\end{center}


\footnotesize
\begin{center}
\begin{tabular}{lrr}
\toprule
& 1990-92 & 2012-14\\
\midrule
World & 18.7 & 11.3\\
Developing
countries & 23.4 & 13.5\\
Africa & 27.7 & 20.5\\
Asia & 23.7 & 12.7\\
Latin Am. and the Carib. & 15.3 & 6.1\\
Oceania & 15.7 & 14\\
Developed
countries & $<$5.0 & $<$5.0\\
\toprule
\end{tabular}
\end{center}