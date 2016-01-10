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

plot1 <- function() {
        hist(feb$Global_active_power, main = paste("Global Active Power"), 
             col="red", xlab="Global Active Power (kilowatts)")
        dev.copy(png, file="plot1.png", width=480, height=480)
        dev.off()
        cat("Plot1.png has been saved in", getwd())
}
plot1()