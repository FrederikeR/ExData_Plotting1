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

## generating plot 4
# divide window into 4 plot areas and adjust margins and outermargins
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data_subset, {
  # plot1
  plot(Global_active_power~date.time, type="l", ylab="Global Active Power (kilowatts)", xlab="")
  # plot2
  plot(Voltage~date.time, type="l", ylab="Voltage (volt)", xlab="")
  # plot3
  plot(Sub_metering_1~date.time, type="l", ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~date.time,col='Red')
  lines(Sub_metering_3~date.time,col='Blue')
  # legend for plot3 
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  # plot4
  plot(Global_reactive_power~date.time, type="l", ylab="Global Rective Power (kilowatts)",xlab="")
})

## Saving to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
