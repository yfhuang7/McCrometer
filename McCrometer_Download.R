##### Rscript for downloading McCrometer data ###########
#
#
# yfhuang@hawaii.edu  on 2018/05/29 
#
#######################################
#################

rm(list= ls(all = T))
ls(all = T)

### Environment Setting ---------------------------------

# Working directory
setwd("/home/yfhuang/Documents/")
dir.data <- './Data/'
dir.fig <- './Figure/'
dir.result <- './Result/'

# Library
library(bitops)  
library(methods)
library(RCurl)   # for download
library(XML)

# Conversion
m2ft<-3.28084
cms2cfs<-35.3146662127
in2mm <- 25.4

### Download data ---------------------------------------

station <- c(
#  "Lyon",
#  "Kaluanui" 
  "Poamoho"

)

fileURL <- c(
#  "http://automata-inc.net/McCrometer/SensorRSS.aspx?h1=B43F3811EC0A7D607F7E654EC866167ACB42336B&feed=1522&h2=54977C6BD46EFAA5E4BDB1E3A3C470D56D919A55&dataset=1&raw=1",
#  "http://automata-inc.net/McCrometer/SensorRSS.aspx?h1=B43F3811EC0A7D607F7E654EC866167ACB42336B&feed=1592&h2=74D054933052AA82023FDF5175CDC1183E673846"
  "http://automata-inc.net/McCrometer/SensorRSS.aspx?h1=B43F3811EC0A7D607F7E654EC866167ACB42336B&feed=1523&h2=C265E7A09B3E2862827326C45039568BF35FCF8E&dataset=1&raw=1"
)


for(i in 1:1){
  origin <- read.csv(paste(dir.result,"McCrometer_",station[i],".csv",sep = ""), stringsAsFactors = F)
  origin$Time <- as.POSIXct(origin$Time)
  # origin$Time <- as.POSIXct(origin$Time, format = "%m/%d/%Y %H:%M")
  
  xData <- getURL(fileURL[i])
  xData.frame <- xmlToDataFrame(xData)
  
  xData.frame$sn_value <- as.numeric(as.character(xData.frame$sn_value))
  # Getting the right timestamp (the original somehow having the sunlight time for a half year)
  xData.frame$sn_timestamp <- as.POSIXct(as.character(xData.frame$sn_timestamp),format = "%Y-%m-%dT%H:%M:%S",
                                         tryFormats = c("%Y-%m-%dT%H:%M:%S-08:00", "%Y-%m-%dT%H:%M:%S-07:00"), tz="UTC")
  attributes(xData.frame$sn_timestamp)$tzone <- "Pacific/Honolulu"
  
  xData.frame.clean <- data.frame(Time = xData.frame$sn_timestamp[1], 
                                  Sensor1 = xData.frame$sn_value[1]/m2ft,
                                  Sensor2 = xData.frame$sn_value[2],
                                  Sensor3 = xData.frame$sn_value[3]*in2mm,
                                  rainfall_mm = NA)
  colnames(xData.frame.clean) <- c("Time", "Level_mm",	"Battery_vott", 
                                   "AccumulatedRainfall_mm", "Rainfall_mm")
  
  ## Only for the first time
  # write.csv(xData.frame.clean, paste(dir.result,"McCrometer_",station[2],".csv",sep = ""),
  # row.names = F)
  
  # append the data if the 
  
  if(origin$Time[nrow(origin)]!=xData.frame.clean$Time){
    merge <- rbind(origin, xData.frame.clean)
    merge$Rainfall_mm[nrow(merge)] <- round(xData.frame.clean$AccumulatedRainfall_mm, digits = 3) - 
      round(origin$AccumulatedRainfall_mm[nrow(origin)],digits = 3)
    
    if (merge$Rainfall_mm[nrow(merge)] < 0){
      merge$Rainfall_mm[nrow(merge)] = merge$Rainfall_mm[nrow(merge)] + 40.95*in2mm
    }
    write.csv(merge, paste(dir.result,"McCrometer_",station[i],".csv",sep = ""), 
              row.names = F)
  }
  }

