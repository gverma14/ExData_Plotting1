plot3 <- function(filename = "household_power_consumption.txt")
{
    #checks if database has already been imported
    if (!exists(as.character(substitute(consData)))) {
        #if not already imported, imports dataframe into global environment for future use
        consData <<- read.table(filename,header = T,sep = ";", stringsAsFactors = F)  
    }
    
    #subsets data to specific dates required
    febData <- consData[(consData$Date == "1/2/2007") | (consData$Date == "2/2/2007"),]
    
    #extract sub_metering data
    sub_metering <- febData[, 7:9]
    
    #concatenate Date and Time variables
    fullDate <- paste (febData$Date, febData$Time)
    
    #convert concatenated strings to POSIXlt objects
    dates <- strptime(fullDate, "%d/%m/%Y %H:%M:%S")
    
    
    png("plot3.png")
    
    #create png plot
    plot(dates, sub_metering[,1], col = "black", type= 'l', ylab = "Energy sub metering", xlab = "")
    lines(dates, sub_metering[,2], col = "red")
    lines(dates, sub_metering[,3], col = "blue")
    #create legend
    legend("topright", names(sub_metering), col = c("black", "red", "blue"), lty = rep(1,3), lwd = rep(1,3))
    dev.off()
}