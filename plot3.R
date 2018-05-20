
rm(list=ls(all=TRUE))          #clears the workspace

##Loading the needed library
library(data.table)

##Setting the path and extracting the data
path2data <- setwd(getwd())

data <- fread(file.path(path2data,"household_power_consumption.txt"),na.strings = c("NA","?", ""))

data[,Date1:= as.Date(Date,format = "%d/%m/%Y")]

dim(data)

## Subset the data for the 2 days of Feb 2007
sub_data <- data[Date1 >= "2007-02-01" & Date1 <= "2007-02-02"]

## Combine Date and Time 
sub_data$dateTime <- paste(sub_data$Date1, sub_data$Time)

## Format dateTime Column
sub_data$dateTime <- as.POSIXct(sub_data$dateTime)

## Plot3

with(sub_data, {
  plot(Sub_metering_1 ~ dateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2 ~ dateTime,col='Red')
  lines(Sub_metering_3 ~ dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Saving to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
