plot2 <- function(filename = "household_power_consumption.txt")
{
    #checks if database has already been imported
    if (!exists(as.character(substitute(consData)))) {
        #if not already imported, imports dataframe into global environment for future use
        consData <<- read.table(filename,header = T,sep = ";", stringsAsFactors = F)  
    }
    
    #subsets data to specific dates required
    febData <- consData[(consData$Date == "1/2/2007") | (consData$Date == "2/2/2007"),]
    
    #retrieve Global_active_power variable
    active_power <- febData$Global_active_power
    
    #concatenate Date and Time variables
    fullDate <- paste (febData$Date, febData$Time)
    
    #convert concatenated strings to POSIXlt objects
    dates <- strptime(fullDate, "%d/%m/%Y %H:%M:%S")
    
    #create png plot
    png("plot2.png")
    plot(dates, active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")
    dev.off()
}