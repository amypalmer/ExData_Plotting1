# read in only the rows corresponding to Feb 1-2, 2007
data <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'), header = TRUE, sep = ";")

# read in the column headers
header <- read.table("household_power_consumption.txt", nrows = 1, sep = ";")
# and assing these to the data variable
colnames(data) <- unlist(header)

# concatenate the Date and Time columns and then convert to date format
data$fullDates <- paste(data$Date, data$Time, sep = " ")
data$fullDates = strptime(data$fullDates, format = "%d/%m/%Y %H:%M:%S")

png("plot3.png", width = 480, height = 480, units = "px")

plot(data$fullDates, data$Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "n")
points(data$fullDates, data$Sub_metering_1, type = "l", col = "black")
points(data$fullDates, data$Sub_metering_2, type = "l", col = "red")
points(data$fullDates, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
