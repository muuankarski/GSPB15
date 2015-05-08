yleisiä huomioita..

- jos uudempi WB-data niin jumittaa automaattisessa konstruktiossa kohdassa 4
- jos uudempi countryprofile, niin ei onnistu mikään.
- jos uudempi vesidata, niin ei toimi
- vesidatan generointi toimii jos
    - ajaa kustom-funktiolla, tai
    - ajaa uudemmalla countrydatalla



Notes for missing data in section 1
--------------------------------------------------------------------------------------------

- Population 0-14 & 65+



Misc. question
- chart 2/3 bars or dots
- year range 2012/2013?
- 2002 - 2012 / 2003 - 2013



Maps

- rounding of labels
- fill-color for missing data

1- Sudan & South Sudan case vrt. expo_maps

Agriculture, value added per worker annual growth - 2013 only from 72 countries -> 2002 - 2012
Agriculture, value added as share of GDP - 2012 no data from US -> ??


notes about plots
Misc 
Trade, FDI and ODA as shares of GDP - ODA avail until 2012 -> all at 2012






Notes from creating maps for EXPO
---------------------------------------------------------------------------------------------
- faosync/expo_maps
- data from different servers is not harmonised - be clear with this
- shapefile plotting is problematic as Lesotho is being overwritten by South Africa fill color. Always plot such regions on a separate layer afterwards.
- be careful with the breaks and take use of the scripts I wrote in the project



FAOSTAT_data
============================================================================================










row 255
# FAOSTAT, Government expenditures ----------------------------------------
                                            ----------------------------------------                                            
                                            ** FAOSTAT Data Download (6 in Total) **                                            
                                            ----------------------------------------                                            

(1): Downloading variable IG.AFFH.STOCGG.USD.SH ... The specified query has no data, consult FAOSTAT 
(2): Downloading variable IG.AFFH.STONCGG.USD.SH ... The specified query has no data, consult FAOSTAT 
(3): Downloading variable IG.AFFH.SAGCGG.USD.SH ... The specified query has no data, consult FAOSTAT 
(4): Downloading variable IG.AFFH.SAGNCGG.USD.SH ... The specified query has no data, consult FAOSTAT 
(5): Downloading variable IG.EP.STOCGG.USD.SH ... The specified query has no data, consult FAOSTAT 
(6): Downloading variable IG.EP.STONCGG.USD.SH ... The specified query has no data, consult FAOSTAT 

 Number of variables successfully downloaded: 0 out of 6

--- rerun 20150311 - same output

IG.AFFH.STOCGG.USD.SH
Agriculture, Forestry, Fishing, and Hunting, Cash (Budg. Cen. Govt.) (share of total outlays)

IG.AFFH.STONCGG.USD.SH
Agriculture, Forestry, Fishing, and Hunting, Noncash (Budg. Cen. Govt.)  (share of total outlays)

IG.AFFH.SAGCGG.USD.SH
Agriculture, Forestry, Fishing, and Hunting, Cash (Budg. Cen. Govt.) (share of agricultural GDP)

IG.AFFH.SAGNCGG.USD.SH
Agriculture, Forestry, Fishing, and Hunting, Noncash (Budg. Cen. Govt.)  (share of agricultural GDP)

IG.EP.STOCGG.USD.SH
Environmental Protection, Cash (Budg. Cen. Govt.) (share of total outlays)

IG.EP.STONCGG.USD.SH
Environmental Protection, Noncash (Budg. Cen. Govt.)  (share of total outlays)

row 293
# FAOSTAT, Production - Crops ---------------------------------------------


(37): Downloading variable QC.PRD.FC.TN.NO ... 
Error in `[.data.frame`(faoData, , name) : undefined columns selected
[1] 1

QC.PRD.FC.TN.NO
Fibre crop production (tonnes)



# FAOSTAT, Production - Live animals --------------------------------------

1-21 is fine, but


(22): Downloading variable QC.PRD.VEG.TN.NO ... 
Error in `[.data.frame`(faoData, , name) : undefined columns selected
[1] 1
OK
(23): Downloading variable QC.RHRV.VEG.HA.NO ... 
Error in `[.data.frame`(faoData, , name) : undefined columns selected
[1] 1
OK

Then, 24 - 43 runs ok.

--- rerun 20150311 - it all work works, oddly there is only 8/8 variables when last time there were 43/43


row 426
# FAOSTAT, Trade - Crops and livestock products ---------------------------

1-5 fine

(6): Downloading variable TP.IMVAL.CRLS.USD.NO ... 
Error in `[.data.frame`(faoData, , name) : undefined columns selected
[1] 1
OK

7-44 fine

--- rerun 20150311 - it all work works




row 505
# FAOSTAT, Food balance sheets --------------------------------------------

(1): Downloading variable CC.FSQ.GT.GCD.NO ... The specified query has no data, consult FAOSTAT 
(2): Downloading variable CC.PSQ.GT.GCD.NO ... The specified query has no data, consult FAOSTAT 

 Number of variables successfully downloaded: 0 out of 2

 Show Traceback
 
 Rerun with Debug
 Error in `[.data.frame`(FAOfb.df, , i) : undefined columns selected 

--- rerun 20150311 - same errors


CC.FSQ.GT.GCD.NO
Fat supply quantity (g/cap/day)

CC.PSQ.GT.GCD.NO
Protein supply quantity (g/cap/day)



WorldBank data
============================================================================================
1:72 fine

(73): Downloading variable EE.BOD.WRKR.KG ... 
Error in fromJSON(url)[[2]] : subscript out of bounds
Download fail after 10 tries

(74): Downloading variable EE.BOD.CHEM.ZS ... 
Error in fromJSON(url)[[2]] : subscript out of bounds
Download fail after 10 tries

(75): Downloading variable EE.BOD.CGLS.ZS ... 
Error in fromJSON(url)[[2]] : subscript out of bounds
Download fail after 10 tries

(76): Downloading variable EE.BOD.FOOD.ZS ... 
Error in fromJSON(url)[[2]] : subscript out of bounds
Download fail after 10 tries

(77): Downloading variable EE.BOD.MTAL.ZS ... 
Error in fromJSON(url)[[2]] : subscript out of bounds
Download fail after 10 tries

(78): Downloading variable EE.BOD.OTHR.ZS ... 
Error in fromJSON(url)[[2]] : subscript out of bounds
Download fail after 10 tries

(79): Downloading variable EE.BOD.PAPR.ZS ... 
Error in fromJSON(url)[[2]] : subscript out of bounds
Download fail after 10 tries

(80): Downloading variable EE.BOD.TXTL.ZS ... 
Error in fromJSON(url)[[2]] : subscript out of bounds
Download fail after 10 tries

(81): Downloading variable EE.BOD.WOOD.ZS ... 
Error in fromJSON(url)[[2]] : subscript out of bounds
Download fail after 10 tries

82:88 fine

--- rerun 20150311 - same errors

so, missing codes are

EE.BOD.WRKR.KG
Organic water pollutant (BOD) emissions (kg per day per worker)

EE.BOD.CHEM.ZS
Water pollution, chemical industry (share of total BOD emissions)

EE.BOD.CGLS.ZS
Water pollution, clay and glass industry (share of total BOD emissions)

EE.BOD.FOOD.ZS
Water pollution, food industry (share of total BOD emissions)

EE.BOD.MTAL.ZS
Water pollution, metal industry (share of total BOD emissions)

EE.BOD.OTHR.ZS
Water pollution, other industry (share of total BOD emissions)

EE.BOD.PAPR.ZS
Water pollution, paper and pulp industry (share of total BOD emissions)

EE.BOD.TXTL.ZS
Water pollution, textile industry (share of total BOD emissions)

EE.BOD.WOOD.ZS
Water pollution, wood industry (share of total BOD emissions)




From metadata we can see:
http://databank.worldbank.org/data/views/variableselection/selectvariables.aspx?source=World-Development-Indicators#




Manual_data
============================================================================================
- water data from Karen 
    - there were no data for absolute values Water withdrawal by sector, but only shares. Absolute values were in the previous database, but they were not used in the report. So, I did not ask for them. Those data are:
    "AQ.WAT.WWAGR.MC.NO"
    "AQ.WAT.WWIND.MC.NO"
    "AQ.WAT.WWMUN.MC.NO"
    
    
    
    

