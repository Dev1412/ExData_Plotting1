
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

## Plot2

plot(sub_data$Global_active_power ~ sub_data$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

## Save file and close device
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()

