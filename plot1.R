# loading data into R
data <- read.table("household_power_consumption.txt", header=T, sep=";",  
                   na.strings="?", stringsAsFactors=F, comment.char="", quote='\"', nrows=2075259)

# converting Date and Time column to R classes
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$Time <- strptime(data$Time, format="%H:%M:%S")

# getting data which is between the dates 2007-02-01 and 2007-02-02
data_subset <- data[which(data$Date >=as.Date("2007-02-01") & data$Date <= as.Date("2007-02-02")),]
# rm full data set
rm(data)

# generate plot1 - a historgram
hist(data_subset$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## Saving to file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
