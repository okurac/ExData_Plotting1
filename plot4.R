## Code for creating plot # 4
getwd()
list.files()
power_cons <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
head(power_cons)

## Changing format of date
power_cons$Date <- as.Date(power_cons$Date, "%d/%m/%Y")

## filter power_cons
filter_pc <- power_cons[complete.cases(power_cons),]

## Getting 2 day data from filter_pc
twoday <- subset(filter_pc, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))


## Combine date and time of twoday
date_time <- paste(twoday$Date, twoday$Time)

## Remove columns
twoday <- twoday[, !names(twoday) %in% c("Date", "Time")]

## add date_time column
twoday <- cbind(date_time, twoday)

## Changing date_time column to days of the week
twoday$date_time <- as.POSIXct(date_time)

names(twoday)

## Creating Plot 4- 4 total plots
## Changing Parameters first
par(mar=c(4, 4, 1, 1), mfrow=(c(2,2)), oma=c(0, 0, 1, 1))
with(twoday, {
  plot(Global_active_power~date_time, type = "lines",
       ylab = "Global Active Power (kilowatts)", xlab = "")
  plot(Voltage~date_time, type = 'lines', ylab = "Voltage(volt)")
  plot(Sub_metering_1~date_time, type = "lines", 
       ylab = "Global Active Power (kilowatts")
  lines(Sub_metering_2~date_time, col ="red")
  lines(Sub_metering_3~date_time, col ="blue")
  legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2,
         bty="n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~date_time, type = "lines",
       ylab = ("Global Reactive Power (kilowatts"))
})

##Saving Plot 4
dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()
