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

## START
## Creating Plot 2
par(mar = c(4,4,2,2))
plot(twoday$Global_active_power~twoday$date_time, type='lines', ylab = "Global Active Power (kilowatts)", xlab = "")

## Saving plot 2
dev.copy(png, 'plot2.png', width = 480, height = 480)
dev.off()