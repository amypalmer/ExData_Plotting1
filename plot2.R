# read in only the rows corresponding to Feb 1-2, 2007
data <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'), header = TRUE, sep = ";")

# read in the column headers
header <- read.table("household_power_consumption.txt", nrows = 1, sep = ";")
# and assing these to the data variable
colnames(data) <- unlist(header)

# concatenate the Date and Time columns and then convert to date format
data$fullDates <- paste(data$Date, data$Time, sep = " ")
data$fullDates = strptime(data$fullDates, format = "%d/%m/%Y %H:%M:%S")

png("plot2.png", width = 480, height = 480, units = "px")

plot(data$fullDates, data$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

dev.off()

