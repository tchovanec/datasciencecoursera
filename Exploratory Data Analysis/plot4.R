
if(!file.exists("./electric_power")){dir.create("./electric_power")}

##Checks to see if the file exists and if it doesn't it will downlaod and unzip the .zip file
destfile <- "./electric_power/exdata-data-household_power_consumption.zip"
if(!file.exists(destfile)){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, destfile = "./electric_power/exdata-data-household_power_consumption.zip")
  unzip(zipfile = "./electric_power/exdata-data-household_power_consumption.zip", exdir = "./electric_power")
  
}

datafile <- "./electric_power/household_power_consumption.txt"
data <- read.table(datafile, header = TRUE, sep = ";")

##Subsets the data to look from Jan 2nd, 2007 to Feb 2nd, 2007
subsetdata<- subset(data, (data$Date == "1/2/2007" | data$Date== "2/2/2007")) 


datadatetime <- strptime(paste(subsetdata$Date, subsetdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
globalActivePower <- as.numeric(subsetdata$Global_active_power)
globalReactivePower <- as.numeric(subsetdata$Global_reactive_power)
voltage <- as.numeric(subsetdata$Voltage)
subMetering1 <- as.numeric(subsetdata$Sub_metering_1)
subMetering2 <- as.numeric(subsetdata$Sub_metering_2)
subMetering3 <- as.numeric(subsetdata$Sub_metering_3)

##Creating Plot4
png("plot4.png", width=480, height=480)

##Creates 2 row, 2 column plot area
par(mfrow = c(2, 2)) 

plot(datadatetime, globalActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.2)
plot(datadatetime, voltage, type="l", xlab="datetime", ylab="Voltage")
plot(datadatetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(datadatetime, subMetering2, type="l", col="red")
lines(datadatetime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

plot(datetime, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()


