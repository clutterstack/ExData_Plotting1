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

# First plot: histogram of Global Active Power

quant <- "Global Active Power"

# Output to a png file 480 x 480px (default size)
png(file = "plot1.png")
hist(data$Global_active_power, col = "red", main = quant, xlab = paste(quant, " (kilowatts)"))
dev.off()


