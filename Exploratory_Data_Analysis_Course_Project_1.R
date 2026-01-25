# Read text file
powerConsum <- read.csv(
  "household_power_consumption.txt",
  sep = ";",
  stringsAsFactors = FALSE,
  na.strings = "?"
)

# Change classes of Date and Time variables
powerConsum$Date <- as.Date(powerConsum$Date, format = "%d/%m/%Y")
powerConsum$DateTime <- as.POSIXct(
  paste(powerConsum$Date, powerConsum$Time),
  format = "%Y-%m-%d %H:%M:%S"
)

# Choose data from "2007-02-01" to "2007-02-02"
powerConsum <- powerConsum[
  powerConsum$Date >= as.Date("2007-02-01") &
    powerConsum$Date <= as.Date("2007-02-02"),
]

# Change classes of columns 3:8
powerConsum[, 3:8] <- lapply(powerConsum[, 3:8], as.numeric)

# Construct Plot1
with(powerConsum, hist(Global_active_power,
                       xlab = "Global Active Power (kilowatts)",
                       col = "red",
                       main = "Global Active Power"))
dev.copy(png, width = 480, height = 480, file = "Plot1.png")
dev.off()

# Construct Plot2
with(powerConsum, plot(DateTime, Global_active_power, type = "l",
                       xlab = "", ylab = "Global Active Power (kilowatts)",
                       xaxt = "n"))
axis(side = 1,
     at = powerConsum$DateTime[c(1, 1441, nrow(powerConsum))],
     labels = c("Thu", "Fri", "Sat"))
dev.copy(png, width = 480, height = 480, file = "Plot2.png")
dev.off()

# Construct Plot3
with(powerConsum, plot(DateTime, Sub_metering_1, type = "n",
                       xaxt = "n", xlab = "",
                       ylab = "Energy sub metering"))
axis(side = 1,
     at = powerConsum$DateTime[c(1, 1441, nrow(powerConsum))],
     labels = c("Thu", "Fri", "Sat"))
with(powerConsum, lines(DateTime, Sub_metering_1))
with(powerConsum, lines(DateTime, Sub_metering_2, col = "red"))
with(powerConsum, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, width = 480, height = 480, file = "Plot3.png")
dev.off()

# Construct Plot4
par(mfrow = c(2, 2))

# Plot at top left
with(powerConsum, plot(DateTime, Global_active_power, type = "l",
                       xlab = "", ylab = "Global Active Power",
                       xaxt = "n"))
axis(side = 1,
     at = powerConsum$DateTime[c(1, 1441, nrow(powerConsum))],
     labels = c("Thu", "Fri", "Sat"))

# Plot at top right
with(powerConsum, plot(DateTime, Voltage, type = "l",
                       xlab = "datetime", ylab = "Voltage",
                       xaxt = "n"))
axis(side = 1,
     at = powerConsum$DateTime[c(1, 1441, nrow(powerConsum))],
     labels = c("Thu", "Fri", "Sat"))

# Plot at bottom left
with(powerConsum, plot(DateTime, Sub_metering_1, type = "n",
                       xaxt = "n", xlab = "",
                       ylab = "Energy sub metering"))
axis(side = 1,
     at = powerConsum$DateTime[c(1, 1441, nrow(powerConsum))],
     labels = c("Thu", "Fri", "Sat"))
with(powerConsum, lines(DateTime, Sub_metering_1))
with(powerConsum, lines(DateTime, Sub_metering_2, col = "red"))
with(powerConsum, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Plot at bottom right
with(powerConsum, plot(DateTime, Global_reactive_power, type = "l",
                       xlab = "datetime",
                       ylab = "Global_reactive_power",
                       xaxt = "n"))
axis(side = 1,
     at = powerConsum$DateTime[c(1, 1441, nrow(powerConsum))],
     labels = c("Thu", "Fri", "Sat"))

# Save Plot4
dev.copy(png, width = 480, height = 480, file = "Plot4.png")
dev.off()
