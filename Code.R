#Set the working directory
setwd("~/Documents/RWorkspace/Spatial Data Science/NYC Trips")

#Download data
yellow <- read.csv("yellow_tripdata_2016-01.csv", header=T)

#Filter out observations which don't have dropoff datetime and co-ordination information
yellow <- with(yellow, yellow[!is.na(tpep_dropoff_datetime) & !is.na(dropoff_longitude) & !is.na(dropoff_latitude),])

#Cast datetime field to POSIXlt
yellow$tpep_dropoff_datetime <- strptime(x = as.character(yellow$tpep_dropoff_datetime),
                                         format = "%Y-%m-%d %H:%M:%S", tz="America/New_York")

#Get monday morning rides between 8 and 9 am. Ignore January 1 information, as it is a holiday.
yellow <- with(yellow, yellow[(tpep_dropoff_datetime)$wday == 1 
                           & (tpep_dropoff_datetime)$mday != 1 
                           & (tpep_dropoff_datetime)$hour %in% c(8, 9),])

names(yellow)[names(yellow)=="tpep_dropoff_datetime"] <- "dropoff_datetime"
names(yellow)[names(yellow)=="tpep_dropoff_datetime"] <- "dropoff_datetime"
names(yellow)[names(yellow)=="Dropoff_longitude"] <- "dropoff_longitude"
names(yellow)[names(yellow)=="Dropoff_latitude"] <- "dropoff_latitude"

#Export the data to be fed to GeoDA
write.csv(yellow, file = "trips.csv")