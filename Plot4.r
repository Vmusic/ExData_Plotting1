## Plot4.r - this script reads in the household_power_consumption.txt file and produces the required Plot4
## Alex Kerezy

## you MUST be in the correct working directory
## create a data frame of the total data set
df <- read.table("household_power_consumption.txt", header=TRUE, na.strings="?", sep=";", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

## the data contains a date and time column, that have been set to character
## so......make a new combined date and time column 
colnames(df)[1] <- "textDate"
df <- cbind(df, as.POSIXct(paste(df$textDate, df$Time), format="%d/%m/%Y %H:%M:%S"))
colnames(df)[10] <- "realDate"


## we only use data for two dates - so create a new data frame (newDF) with JUST the data for these two dates
## crreate two dates to use in the subsetting of the data
d1 <- as.Date("2007-02-01")
d2 <- as.Date("2007-02-02")

## nrow(df[as.Date(df$textDate, format="%d/%m/%Y") == d1 | as.Date(df$textDate, format="%d/%m/%Y") == d2, ])   ## debug code

newDF <-df[as.Date(df$textDate, format="%d/%m/%Y") == d1 | as.Date(df$textDate, format="%d/%m/%Y") == d2, ]


## now we can remove the data frame with all of the data
## rm(df)        ## I commented out this code, becuase it's not absolutely necessary, it does free up memory

## open up the device to push the plot to
png("Plot4.png", 600, 400)

## Plot 4 is a scatter plot - however it is actually four separate plots placed together
## Plot 4 has two rows, each with two separate plots
## first create the rows
par(mfrow = c(2,2), mar=c(4,4,1,1))

##the first row has these two plots: 1) Plot 2 (previously created) and 2 Voltage vs. Date (a new plot)
## the 1st plot in the 1st row in Plot 4, which was Plot 2 (previously created) 
plot(newDF$realDate, newDF$Global_active_power, xlab="", ylab="Global Active Power (kilowats)", type="n")
lines(newDF$realDate, newDF$Global_active_power)

## the 2nd plot in the 1st row in Plot 4, which is Voltage vs. dateTime (dateTime is the combined column and this is a new Plot)
plot(newDF$realDate, newDF$Voltage, xlab="dateTime", ylab="Voltage", type="n")
lines(newDF$realDate, newDF$Voltage)

## the 1st plot in the 2nd row in Plot 4, which was Plot 3 (previously created)
plot(newDF$realDate, newDF$Sub_metering_1, xlab="", ylab="Global Active Power (kilowats)", type="n")
lines(newDF$realDate, newDF$Sub_metering_1, col="black")
lines(newDF$realDate, newDF$Sub_metering_2, col="red")
lines(newDF$realDate, newDF$Sub_metering_3, col="blue")
legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## the 2nd plot the 2nd row Plot 4, which is Global_reactive_power vs. dateTime (dateTime is the combined column)
plot(newDF$realDate, newDF$Global_reactive_power, xlab="dateTime", ylab="Global_reactive_power", type="n")
lines(newDF$realDate, newDF$Global_reactive_power)


## close the opened device
invisible(dev.off()) 
