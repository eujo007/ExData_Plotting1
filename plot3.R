## Explaratory Data Analysis Course Project 1
## Plot1 - plots using a historgram

## read data
## Set the url to the raw data
rawDataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## Downlaod the raw data as a zip file if it does not exists
if( !file.exists("./data/rawdata.zip"))
{
  dir.create("./data")
  download.file(rawDataUrl,destfile = "./data/rawdata.zip",method = "curl", mode= "wb")
  
  ## now extract the files from the zip file
  unzip("./data/rawdata.zip")
}
## Read the table data
data <- read.csv2("household_power_consumption.txt", header=TRUE, sep=";", dec=".", na.strings="?")

## Pull out the project data which is all data between Feb 1, 2007 and Feb 2, 2007
FebData <- data[as.Date(data$Date,"%d/%m/%Y") < as.Date("03/02/2007","%d/%m/%Y") & as.Date(data$Date,"%d/%m/%Y") > as.Date("31/01/2007","%d/%m/%Y"), ]

## Pull out Date and Time and combine
dateOnly <- FebData$Date
timeOnly <- FebData$Time
DateTime <- paste(dateOnly,timeOnly)

## Add a DateTime Column to plot against
validData <- mutate(FebData, DateTime = strptime(DateTime, "%d/%m/%Y %H:%M:%S") )


yAxisLabel <- "Energy sub metering"
title <- "Global Active Power"
fillColor <-"red"

png(filename = "plot3.png")
Sub_metering_1 <-validData$Sub_metering_1
Sub_metering_2 <-validData$Sub_metering_2
Sub_metering_3 <-validData$Sub_metering_3

plot( validData$DateTime, validData$Sub_metering_1,ylab = yAxisLabel,xlab="", type="n")
lines(validData$DateTime, Sub_metering_1, col="black")
lines(validData$DateTime, Sub_metering_2, col="red")
lines(validData$DateTime, Sub_metering_3, col="blue")
##legend("topright", legend=Sub_metering_1 , col = "black")
##legend("topright", legend=Sub_metering_2 , col = "red")
##legend("topright", legend=Sub_metering_3 , col = "blue")
dev.off()