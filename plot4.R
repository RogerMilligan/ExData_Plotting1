#R code for Exploratory Data Analysis - Project 1
#setwd("C:/Roger Docs/Documents/DS/ExploratoryDataAnalysis")

#Load data from file
if (file.exists("data/household_power_consumption.txt")) {
    fname <- "data/household_power_consumption.txt"
} else { fname <- "household_power_consumption.txt"}
consumption <- read.csv(fname, sep=";", na.strings="?", #nrows=10,
        colClasses = c("character", "character", "numeric", "numeric", "numeric", 
                       "numeric", "numeric", "numeric", "numeric"))

#Filter out 2 days and combine Date and Time into one datetime column
days <- consumption[consumption$Date=="1/2/2007"| consumption$Date=="2/2/2007",]
days$DateTime <- strptime(paste(days$Date,days$Time),"%d/%m/%Y %H:%M:%S")
rm(consumption)

#Plot graph(s) and save to file
par(mfrow = c(2, 2))
#1
plot(days$DateTime, days$Global_active_power, type = "l", col = "black", xlab="", 
     ylab="Global Active Power (kilowats)", main = "")
#2
plot(days$DateTime, days$Voltage, type = "l", col = "black", xlab="datetime", ylab="Voltage", main = "")
#3
with(days, {
    plot(DateTime, Sub_metering_1, type = "l", col="black",xlab="", ylab="Energy sub metering", main = "")
    points(DateTime, Sub_metering_2, type = "l", col="red")
    points(DateTime, Sub_metering_3, type = "l", col="blue")
    legend("topright", bty="n" , col = c("black", "red", "blue"), 
           legend = c("Sub_metering_1    ", "Sub_metering_2    ", "Sub_metering_3    "), 
           cex=0.8, lty=c(1,1,1))
})
#4
plot(days$DateTime, days$Global_reactive_power, type = "l", col = "black", xlab="datetime", 
     ylab="Global_reactive_power", main = "")
dev.copy(png, file = "plot4.png")
dev.off()
