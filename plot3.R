## Construct a plot and save to plot3.png'
    temp <- tempfile()
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
    P1Data <- read.table(unz(temp, "household_power_consumption.txt"), sep=";",header=TRUE)
    unlink
## Reformat Data
    P1Data$Date <- dmy(P1Data$Date)
    P1Data$Global_active_power[P1Data$Global_active_power == "?"] <- NA
    FebData <- subset(P1Data, Date > as.POSIXct("2007-01-31") )  
    FebData2 <- subset(FebData, Date <= as.POSIXct("2007-02-02") ) 
    FebData2$datetime <- paste(FebData2$Date, FebData2$Time)
    PlotDate = as.POSIXlt(FebData2$datetime) 
    FebData2$Sub_metering_1 <- as.numeric(as.character(FebData2$Sub_metering_1))
    FebData2$Sub_metering_2 <- as.numeric(as.character(FebData2$Sub_metering_2))
    FebData2$Sub_metering_3 <- as.numeric(as.character(FebData2$Sub_metering_3))
## Modify data for plotting
  Sub_metering_1  = FebData2$Sub_metering_1
  Sub_metering_2  = FebData2$Sub_metering_2 
  Sub_metering_3  = FebData2$Sub_metering_3 
## Set up png device for plotting
    png(filename = "plot3.png", width = 480, height = 480, units = "px", bg = "white")
## PLot
    par(mar = c(6, 6, 5, 4))
    plot(PlotDate,Sub_metering_1, type="l",col="black",ann=FALSE)
    lines(PlotDate,Sub_metering_2, type="l",col="red")
    lines(PlotDate,Sub_metering_3, type="l",col="blue")
    title(ylab="Energy sub metering")
    legend ("topright",lwd=2,col=c("black","red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
##Close Plotting device
    dev.off()

