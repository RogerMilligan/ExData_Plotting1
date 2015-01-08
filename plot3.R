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
par(mfrow = c(1, 1))
with(days, {
    plot(DateTime, Sub_metering_1, type = "l", col="black",xlab="", ylab="Energy sub metering", main = "")
    points(DateTime, Sub_metering_2, type = "l", col="red")
    points(DateTime, Sub_metering_3, type = "l", col="blue")
    legend("topright", col = c("black", "red", "blue"), 
           legend = c("Sub_metering_1    ", "Sub_metering_2    ", "Sub_metering_3    "), 
           lty=c(1,1,1))
})
dev.copy(png, file = "plot3.png")
dev.off()