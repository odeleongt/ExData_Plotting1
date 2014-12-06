# Plot 2

# Download data from provided uri
uri <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url = uri, destfile = "./data/household_power_consumption.zip")


# Unzip data
unzip(zipfile = "./data/household_power_consumption.zip", exdir = "./data")


# Read in data
power <- read.csv2(file = "./data/household_power_consumption.txt",
									 na.strings = "?", quote = "", dec = ".",
									 stringsAsFactors = FALSE)

# Prepare data for the plot (only use dates 2007-02-01 and 2007-02-02)
# Could have used a regular expression like "^0?[12]/0?A2/(20)?07" in case the
# dates were recorded with/without leading zeroes or the century, but it was not
# the case.
power <- subset(x = power, subset = Date %in% c("1/2/2007", "2/2/2007"))

# Set the date-time for each reading
power$datetime <- paste(power$Date, power$Time)

# Format the date-time as a time object (POSIXct)
power$datetime <- strptime(x = power$datetime, format = "%d/%m/%Y %H:%M:%S")

# Prepare the graphics device
png(filename = "plot2.png", width = 480, height = 480, bg = "transparent")


# Create the plot
plot(x = power$datetime,
		 y = power$Global_active_power,
		 type = "l",
		 xlab = "",
		 ylab = "Global Active Power (kilowatts)",
		 axes = FALSE)
box(col = "grey50")  # Fainter lines for the box
axis(side = 2, at = seq(0,6, by = 2))
axis(side = 1, at = as.POSIXct(paste0("2007-02-0", 1:3)),
		 labels = c("Thu", "Fri", "Sat"))
	

# Close the device to save the plot
dev.off()

# End of script
