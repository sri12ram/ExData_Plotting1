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
png(file = "plot3.png", width = 480, height = 480, units = "px", bg = "transparent")


## Plot the Data
plot(powercon$DateTime, powercon$Sub_metering_1, type = "n", 
     xlab = "", ylab = "Energy sub metering")
points(powercon$DateTime, powercon$Sub_metering_1, type = "l", col = "black")
points(powercon$DateTime, powercon$Sub_metering_2, type = "l", col = "red")
points(powercon$DateTime, powercon$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Close the Device
dev.off()
