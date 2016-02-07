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

##Creating Plot2
png("plot2.png", width=480, height=480)
plot(datadatetime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

