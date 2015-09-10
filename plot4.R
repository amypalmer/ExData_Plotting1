# read in only the rows corresponding to Feb 1-2, 2007
data <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'), header = TRUE, sep = ";")

# read in the column headers
header <- read.table("household_power_consumption.txt", nrows = 1, sep = ";")
# and assing these to the data variable
colnames(data) <- unlist(header)

# concatenate the Date and Time columns and then convert to date format
data$fullDates <- paste(data$Date, data$Time, sep = " ")
data$fullDates = strptime(data$fullDates, format = "%d/%m/%Y %H:%M:%S")

png("plot4.png", width = 480, height = 480, units = "px")

par(mfcol = c(2,2))

# first plot..
plot(data$fullDates, data$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

# second plot..
plot(data$fullDates, data$Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "n")
points(data$fullDates, data$Sub_metering_1, type = "l", col = "black")
points(data$fullDates, data$Sub_metering_2, type = "l", col = "red")
points(data$fullDates, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, bty = "n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# third plot..
plot(data$fullDates, data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

# fourth plot...
plot(data$fullDates, data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()

