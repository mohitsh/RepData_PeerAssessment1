
#reading .txt file where header is TRUE to take care of the first row which conatins the row names
data <- read.table("household_power_consumption.txt", sep=";", header=TRUE)

#merging the date and time columns of the given data and converted it to date format
data$Timestamp <- strptime(paste(data$Date,data$Time), format="%d/%m/%Y %H:%M:%S")

#converting the Date column into Date format
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

#subsetting the data for the given problem
data1 <- data[data$Date >=  as.Date("2007-02-01") & data$Date <=  as.Date("2007-02-02"),]


#plot3

with(data1, plot(Timestamp, Sub_metering_1, col="green", type="l"))

with(data1, points(Timestamp, Sub_metering_2, col="orange", type="l"))
with(data1, points(Timestamp, Sub_metering_3, col="blue", type="l"))

legend("topright", lty=c(1,1,1), col=c("green","orange", "blue"),legend=c("Sub_metering_1", 
                                                                         "Sub_metering_2","Sub_metering_3"))
dev.copy(png, "plot3.png",width=480,height=480,units="px")
dev.off()