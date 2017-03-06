setwd("~/Userdata/Personal/Data Science/RDir")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","Energy_Consumption.zip")
unzip("Energy_Consumption.zip",list = FALSE,unzip = "internal")
energy_file<- read.table("household_power_consumption.txt",header=TRUE,sep = ";", na.strings = "?", stringsAsFactors = FALSE)
energy_file_subset<-subset(energy_file, Date %in% c("1/2/2007","2/2/2007"))
energy_file_subset$Date<-as.Date(energy_file_subset$Date, "%d/%m/%Y")
datetime<-paste(as.Date(energy_file_subset$Date),energy_file_subset$Time)
energy_file_subset$DateTime<-as.POSIXct(datetime)
png(file="Plot4.png",width = 480,height = 480)
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(energy_file_subset, {
  plot(Global_active_power~DateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~DateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~DateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~DateTime,col='Red')
  lines(Sub_metering_3~DateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~DateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})
dev.off()