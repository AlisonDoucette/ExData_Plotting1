## Construct a plot and save to plot1.png
## Read in data
    temp <- tempfile()
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
    P1Data <- read.table(unz(temp, "household_power_consumption.txt"), sep=";",header=TRUE)
    unlink(temp)
## Set libraries
library(lubridate)

## Set date to mdy and subset the data to extract just two dates.
    P1Data$Date <- dmy(P1Data$Date)
    FebData <- subset(P1Data, Date > as.POSIXct("2007-01-31") )  
    FebData2 <- subset(FebData, Date <= as.POSIXct("2007-02-02") )    
    FebData2$Global_active_power <- as.numeric(as.character(FebData2$Global_active_power))

## Set up data for plotting & send plot to png
    GAP = FebData2$Global_active_power
    png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "white")
    par(mar = c(6, 6, 5, 4))
    hist(GAP,main="Global Active Power", xlab ="Global Active Power(kilowatts)", 
         ylab="Frequency",col="red")

## Turn off device
    dev.off()
