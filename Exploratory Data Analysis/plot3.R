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


datetime <- strptime(paste(subsetdata$Date, subsetdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
globalActivePower <- as.numeric(subsetdata$Global_active_power)
subMetering1 <- as.numeric(subsetdata$Sub_metering_1)
subMetering2 <- as.numeric(subsetdata$Sub_metering_2)
subMetering3 <- as.numeric(subsetdata$Sub_metering_3)

##Creating Plot3
png("plot3.png", width=480, height=480)
plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()