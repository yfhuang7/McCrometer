


rm(list= ls(all = T))
ls(all = T)

### Environment Setting ---------------------------------

# Working directory
setwd("/home/yfhuang/Documents/")
dir.data <- './Data/'
dir.fig <- './Figure/'
dir.result <- './Result/'

idata <- read.csv(paste(dir.result,"McCrometer_Poamoho.csv", sep = ""))

idata$Rainfall_mm <- round(idata$Rainfall_mm, digits = 3)
idata$Rainfall_mm[idata$Rainfall_mm>500] <- 0
idata$Rainfall_mm

which(idata$Rainfall_mm>500)

write.csv(idata, paste(dir.result,"McCrometer_Poamoho.csv", sep = ""))
