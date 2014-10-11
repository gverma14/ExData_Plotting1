plot4 <- function(filename = "household_power_consumption.txt")
{
    #checks if database has already been imported
    if (!exists(as.character(substitute(consData)))) {
        #if not already imported, imports dataframe into global environment for future use
        consData <<- read.table(filename,header = T,sep = ";", stringsAsFactors = F)  
    }
    
    #subsets data to specific dates required
    febData <- consData[(consData$Date == "1/2/2007") | (consData$Date == "2/2/2007"),]
    
    #concatenate Date and Time variables
    fullDate <- paste (febData$Date, febData$Time)
    
    #convert concatenated strings to POSIXlt objects
    dates <- strptime(fullDate, "%d/%m/%Y %H:%M:%S")
    
    #Retrieve required y-axis variables from dataset
    active_power <- febData$Global_active_power
    voltage <- febData$Voltage
    sub_metering <- febData[, 7:9]
    global_reactive <-febData$Global_reactive_power
    
    
    #Create png plots
    png("plot4.png")
    
    #Change layout of plots to be 2x2
    par(mfrow = c(2,2))
    plot(dates, active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")
    plot(dates, voltage, xlab = "datetime", ylab = "Voltage", type = "l")
    
    plot(dates, sub_metering[,1], col = "black", type= 'l', ylab = "Energy sub metering", xlab = "")
    lines(dates, sub_metering[,2], col = "red")
    lines(dates, sub_metering[,3], col = "blue")
    legend("topright", names(sub_metering),bty = "n", col = c("black", "red", "blue"), lty = rep(1,3), lwd = rep(1,3))
    
    plot(dates, global_reactive, xlab = "datetime",ylab = "Global_reactive_power", type = "l")
    dev.off()
    
}