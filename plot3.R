# Data are in a local file
filename <- "household_power_consumption.txt"

# We've established that the data we want are in rows 66638 to 69517
data <- read.table(filename, sep = ";", na.strings = "?", nrows = 2880, skip = 66637) 

# Get the column names from the first line in the text file.
fileconn <- file(filename, "r")
colnamesd <- scan(filename, "", sep = ";",nmax = 9, quiet = TRUE)
close(fileconn)
colnames(data) <- colnamesd

# Get the dates recognized as dates
data$Date  <- as.Date(data$Date, "%d/%m/%Y")

# Put the date and time together in one value
data  <- transform(data, DateTime = strptime(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S"))

# Third plot: Sub_metering 1, 2, 3 vs time (line, black, red, blue)

quant <- "Energy sub metering"

# Output to a png file 480 x 480px (default size)
png(file = "plot3.png")
with(data, {
  plot(DateTime, Sub_metering_1, type = "l", main = "", xlab = "", ylab = quant)
  points(DateTime, Sub_metering_2, type = "l", col= "red")
  points(DateTime, Sub_metering_3, type = "l", col= "blue")
})
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty =c(1,1,1), col = c("black","red","blue"))
dev.off()


