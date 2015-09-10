# read in only the rows corresponding to Feb 1-2, 2007
data <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'), header = TRUE, sep = ";")

# read in the column headers
header <- read.table("household_power_consumption.txt", nrows = 1, sep = ";")
# and assing these to the data variable
colnames(data) <- unlist(header)

png("plot1.png", width = 480, height = 480, units = "px")

hist(data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

dev.off()

