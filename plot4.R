library(data.table, lubridate)

plot4 <- function(){
    filename <- "exdata%2Fdata%2Fhousehold_power_consumption.zip"
    downloadurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    
    #Download zip file
    if(!file.exists(filename)){
        download.file(url = downloadurl, destfile = "./exdata%2Fdata%2Fhousehold_power_consumption.zip",method = "curl")
    }
    
    dataname <- "household_power_consumption.txt"
    if(!file.exists(dataname)){
        unzip(zipfile = "exdata%2Fdata%2Fhousehold_power_consumption.zip")
    }
    
    #Data selection
    data <- fread(file = "household_power_consumption.txt",header = TRUE, na.strings = "?")
    df <- data[which(data$Date %in% c("1/2/2007","2/2/2007")),]
    
    #Convert the class of first two columns as Date or Time
    datetime <- strptime(paste(df$Date, df$Time, sep = ""), "%d/%m/%Y %H:%M:%S")
    Sub_metering_1 <- as.numeric(df$Sub_metering_1)
    Sub_metering_2 <- as.numeric(df$Sub_metering_2)
    Sub_metering_3 <- as.numeric(df$Sub_metering_3)
    voltage <- as.numeric(df$Voltage)
    GlobalReactivePower <- as.numeric(df$Global_reactive_power)
    
    #Create graphics
    png(filename = "plot4.png", width = 480, height = 480)
    par(mfcol = c(2,2))
    plot(datetime, globalActivePower, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
    plot(datetime,Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
    lines(datetime,Sub_metering_2, col = "red")
    lines(datetime,Sub_metering_3, col = "blue")
    legend(c("topright"),c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n",
           lty= 1, lwd=2, col = c("black", "red", "blue"))
    plot(datetime, voltage, type = "l", xlab = "datetime", ylab = "Voltage")
    plot(datetime, GlobalReactivePower, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
    dev.off()
    
}
