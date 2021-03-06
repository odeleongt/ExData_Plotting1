# Plot 1

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


# Prepare the graphics device
png(filename = "plot1.png", width = 480, height = 480, bg = "transparent")


# Create the plot
hist(x = power$Global_active_power,
		 col = "red",
		 main = "Global Active Power",
		 xlab = "Global Active Power (kilowatts)",
		 ylab = "Frequency",
		 breaks = seq(0, ceiling(max(power$Global_active_power)), by = 0.5),
		 axes = FALSE)
axis(side = 2, at = seq(0, 1200, by = 200), labels = seq(0, 1200, by = 200))
axis(side = 1, at = seq(0,6, by = 2), labels = seq(0,6, by = 2))


# Close the device to save the plot
dev.off()

# End of script
