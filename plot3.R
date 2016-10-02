setwd("C:/Users/user/Desktop/Coursera R")

# loading data into R
data <- read.table("household_power_consumption.txt", header=T, sep=";",  
                   na.strings="?", stringsAsFactors=F, comment.char="", quote='\"', nrows=2075259)

# converting Date column to R classes
data$Date <- as.Date(data$Date, format="%d/%m/%Y")


# getting data which is between the dates 2007-02-01 and 2007-02-02
data_subset <- data[which(data$Date >=as.Date("2007-02-01") & data$Date <= as.Date("2007-02-02")),]
# rm full data set
rm(data)

# converting Time column to R classes
date.time <- as.POSIXct(paste(as.Date(data_subset$Date), data_subset$Time))
data_subset$date.time <- date.time

## generating Plot 3
with(data_subset, {
  plot(Sub_metering_1~date.time, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2 ~ date.time,col='Red')
  lines(Sub_metering_3 ~ date.time,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Saving to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
