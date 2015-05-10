
#reading .txt file where header is TRUE to take care of the first row which conatins the row names
data <- read.table("household_power_consumption.txt", sep=";", header=TRUE)

#merging the date and time columns of the given data and converted it to date format
data$Timestamp <- strptime(paste(data$Date,data$Time), format="%d/%m/%Y %H:%M:%S")

#converting the Date column into Date format
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

#subsetting the data for the given problem
data1 <- data[data$Date >=  as.Date("2007-02-01") & data$Date <=  as.Date("2007-02-02"),]


#plot4
par(mfrow=c(2,2), oma=c(0,0,2,0))

with(data1,
     
     plot(Timestamp, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", 
          xlab="Timestamp", main="Global Active Power and Timestamp"))
    )

with(data1,  
     plot(Timestamp, Voltage, type="l", ylab="Voltage", 
          xlab="datetime", main="Voltage and Timestamp")
    )

with(data1, plot(Timestamp, Sub_metering_1, col="green", type="l"))

with(data1, points(Timestamp, Sub_metering_2, col="orange", type="l"))
with(data1, points(Timestamp, Sub_metering_3, col="blue", type="l"))

legend("topright", lty=c(1,1,1), col=c("green","orange", "blue"),legend=c("Sub_metering_1", 
                                                                          "Sub_metering_2","Sub_metering_3"))
  

with(data1,
     plot(Timestamp, Global_reactive_power, type="l", xlab="datetime", ylab="Global Reactive Power",
          main="Global Reactive Power and Timestamp")
     )

dev.copy(png, "plot4.png",width=480,height=480,units="px")
dev.off()