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

# Second plot: line plot of Global Active Power vs time

quant <- "Global Active Power"

# Output to a png file 480 x 480px (default size)
png(file = "plot2.png")
with(data, plot(DateTime, Global_active_power, type = "l", main = "", xlab = "", ylab = paste(quant, " (kilowatts)")))
dev.off()


