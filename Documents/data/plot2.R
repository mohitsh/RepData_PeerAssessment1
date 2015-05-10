
#reading .txt file where header is TRUE to take care of the first row which conatins the row names
data <- read.table("household_power_consumption.txt", sep=";", header=TRUE)

#merging the date and time columns of the given data and converted it to date format
data$Timestamp <- strptime(paste(data$Date,data$Time), format="%d/%m/%Y %H:%M:%S")

#converting the Date column into Date format
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

#subsetting the data for the given problem
data1 <- data[data$Date >=  as.Date("2007-02-01") & data$Date <=  as.Date("2007-02-02"),]


#plot 2

with(data1, plot(Timestamp, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", 
                 xlab="Timestamp", main="Global Active Power and Timestamp", col="orange"))

dev.copy(png, "plot2.png",width=480,height=480,units="px")
dev.off()
