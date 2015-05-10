
#reading .txt file where header is TRUE to take care of the first row which conatins the row names
data <- read.table("household_power_consumption.txt", sep=";", header=TRUE)

#merging the date and time columns of the given data and converted it to date format
data$Timestamp <- strptime(paste(data$Date,data$Time), format="%d/%m/%Y %H:%M:%S")

#converting the Date column into Date format
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

#subsetting the data for the given problem
data1 <- data[data$Date >=  as.Date("2007-02-01") & data$Date <=  as.Date("2007-02-02"),]


#plot1
# Globla_active_power was a factor variable to converted to numeric
data1$Global_active_power <- as.numeric(data1$Global_active_power)
hist(data1$Global_active_power, col="red", xlab="Global Active Power (kilowatts)",
     main="Global Active Power")
dev.copy(png, "plot1.png",width=480,height=480,units="px")
dev.off()
