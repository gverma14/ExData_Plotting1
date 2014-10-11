plot1 <- function(filename = "household_power_consumption.txt")
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
    
    #create histogram png file
    png("plot1.png")
    hist(as.numeric(active_power), main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
    dev.off()
    
    
    
}