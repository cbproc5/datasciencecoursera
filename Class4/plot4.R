if(!file.exists("exdata-data-household_power_consumption.zip")) {
    temp <- tempfile()
    download.file("https://d396qusza40orc.cloudfront.net/
                  exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
    file <- unzip(temp)
    unlink(temp)
}
elect <- read.table(file, header=T, sep=";")
elect$Date <- as.Date(elect$Date, format="%d/%m/%Y")
feb <- elect[(elect$Date=="2007-02-01") | (elect$Date=="2007-02-02"),]
feb$Global_active_power <- as.numeric(as.character(feb$Global_active_power))
feb$Global_reactive_power <- as.numeric(as.character(feb$Global_reactive_power))
feb$Voltage <- as.numeric(as.character(feb$Voltage))
feb <- transform(feb, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
feb$Sub_metering_1 <- as.numeric(as.character(feb$Sub_metering_1))
feb$Sub_metering_2 <- as.numeric(as.character(feb$Sub_metering_2))
feb$Sub_metering_3 <- as.numeric(as.character(feb$Sub_metering_3))

plot4 <- function() {
        par(mfrow=c(2,2))
        
        ##PLOT 1
        plot(feb$timestamp,feb$Global_active_power, type="l", xlab="", 
            ylab="Global Active Power")
        ##PLOT 2
        plot(feb$timestamp,feb$Voltage, type="l", xlab="datetime", ylab="Voltage")
        
        ##PLOT 3
        plot(feb$timestamp,feb$Sub_metering_1, type="l", xlab="", 
            ylab="Energy sub metering")
        lines(feb$timestamp,feb$Sub_metering_2,col="red")
        lines(feb$timestamp,feb$Sub_metering_3,col="blue")
        legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ",
            "Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5)
        
        #PLOT 4
        plot(feb$timestamp,feb$Global_reactive_power, type="l", xlab="datetime", 
            ylab="Global_reactive_power")
        
        #OUTPUT
        dev.copy(png, file="plot4.png", width=480, height=480)
        dev.off()
        cat("plot4.png has been saved in", getwd())
}
plot4()