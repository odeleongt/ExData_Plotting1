# Plot 4

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
png(filename = "plot4.png", width = 480, height = 480, bg = "transparent")

# Layout for 4 subplots
par(mfcol = c(2,2))


# Create subplot 1
plot(x = power$datetime,
		 y = power$Global_active_power,
		 type = "l",
		 xlab = "",
		 ylab = "Global Active Power",
		 axes = FALSE)
box(col = "grey50")  # Fainter lines for the box
axis(side = 2, at = seq(0,6, by = 2))
axis(side = 1, at = as.POSIXct(paste0("2007-02-0", 1:3)),
		 labels = c("Thu", "Fri", "Sat"))


# Create subplot 2
plot(x = power$datetime,
		 y = power$Sub_metering_1,
		 type = "l",
		 xlab = "",
		 ylab = "Energy sub metering",
		 axes = FALSE)
lines(x = power$datetime,
			y = power$Sub_metering_2,
			col = "red")
lines(x = power$datetime,
			y = power$Sub_metering_3,
			col = "blue")
legend(x = "topright",
			 box.col = "transparent",
			 lty = 1,
			 cex = 0.9,
			 legend = paste0("Sub_metering_", 1:3),
			 col = c("black", "red", "blue"))
box(col = "grey50")  # Fainter lines for the box
axis(side = 2, at = seq(0, 30, by = 10))
axis(side = 1, at = as.POSIXct(paste0("2007-02-0", 1:3)),
		 labels = c("Thu", "Fri", "Sat"))


# Create subplot 3
plot(x = power$datetime,
		 y = power$Voltage,
		 type = "l",
		 xlab = "datetime",
		 ylab = "Voltage",
		 axes = FALSE)
box(col = "grey50")  # Fainter lines for the box
axis(side = 2, at = seq(234, 246, by = 4))
axis(side = 1, at = as.POSIXct(paste0("2007-02-0", 1:3)),
		 labels = c("Thu", "Fri", "Sat"))


# Create subplot 4
plot(x = power$datetime,
		 y = power$Global_reactive_power,
		 type = "o",
		 pch = ".",
		 lwd = 0.5,
		 xlab = "datetime",
		 ylab = "Global_reactive_power",
		 axes = FALSE)
box(col = "grey50")  # Fainter lines for the box
axis(side = 2, at = seq(0, 0.5, by = 0.1))
axis(side = 1, at = as.POSIXct(paste0("2007-02-0", 1:3)),
		 labels = c("Thu", "Fri", "Sat"))


# Close the device to save the plot
dev.off()

# End of script
