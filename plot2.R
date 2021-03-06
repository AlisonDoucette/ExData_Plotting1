## Construct a plot and save to plot2.png
## Add Library
    library(lubridate)
## Download and unzip file
    temp <- tempfile()
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
    P1Data <- read.table(unz(temp, "household_power_consumption.txt"), sep=";",header=TRUE)
    unlink(temp)
##Reformat and subset data
    P1Data$Date <- dmy(P1Data$Date)
    P1Data$Global_active_power[P1Data$Global_active_power == "?"] <- NA
    FebData <- subset(P1Data, Date > as.POSIXct("2007-01-31") )  
    FebData2 <- subset(FebData, Date <= as.POSIXct("2007-02-02") ) 
    FebData2$datetime <- paste(FebData2$Date, FebData2$Time)
    FebData2$Global_active_power <- as.numeric(as.character(FebData2$Global_active_power))
## Set up data for plotting
    PlotDate = as.POSIXlt(FebData2$datetime) 
    GAP = FebData2$Global_active_power
## Plot
    png(filename = "plot2.png", width = 480, height = 480, units = "px", bg = "white")
    par(mar = c(6, 6, 5, 4))
    plot(PlotDate, GAP, type="l",ann=FALSE)
    title(ylab="Global Active Power(kilowatts)")
## Turn off plotting device
dev.off()

