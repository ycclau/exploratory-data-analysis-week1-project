library("data.table", "libridate")

plot1 <- function(){
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
    
    #Convert the class of first column of data as Date
    date <- as.Date(df$Date,"%d/%m/%Y")
    
    #Create graphics
    png(filename = "plot1.png", width = 480, height = 480)
    hist(as.numeric(df$Global_active_power),freq = TRUE, col = "red", main = "Global Active Power", 
         xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
    dev.off()
    
}
