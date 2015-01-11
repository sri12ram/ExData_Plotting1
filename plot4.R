## Set the column names and classes
colNames <- colnames(read.table("household_power_consumption.txt", header = TRUE, 
                                nrow = 1, sep = ";"))
colClasses <- c("character", "character", "numeric", "numeric", "numeric", "numeric", 
                "numeric", "numeric", "numeric")


## Read the file
powercon <- read.table("household_power_consumption.txt", header = TRUE, sep = ";",
                       col.names = colNames, colClasses = colClasses, na.strings = "?")


## Convert the date / time and Subset the data
powercon <- powercon[as.Date(powercon$Date, "%d/%m/%Y") == "2007-02-01" | 
                             as.Date(powercon$Date, "%d/%m/%Y") == "2007-02-02", ]
powercon$DateTime <- as.POSIXct(paste(powercon$Date, powercon$Time),
                                format = "%d/%m/%Y %H:%M:%S")
powercon <- powercon[-1:-2]


## Open a png file and set the parameters
png(file = "plot4.png", width = 480, height = 480, units = "px", bg = "transparent")


## Plot the Data
par(mfrow = c(2, 2))

with(powercon, {
        ## Plot 1
        plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
        
        ## Plot 2
        plot(DateTime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
        
        ## Plot 3
        plot(DateTime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
        points(DateTime, Sub_metering_1, type = "l", col = "black")
        points(DateTime, Sub_metering_2, type = "l", col = "red")
        points(DateTime, Sub_metering_3, type = "l", col = "blue")
        legend("topright", lty = 1, col = c("black", "red", "blue"), 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        
        ## Plot 4
        plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime")

        })

## Close the Device
dev.off()

