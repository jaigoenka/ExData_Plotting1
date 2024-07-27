# Read file into data frame in R using separator ';', Na = '?', defining column classes 
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

head(data)
names(data)
str(data)

# Convert Date to Date Class to subset the required data
data$Date<-as.Date(data$Date,format="%d/%m/%Y")

#Subset the data from 2007/02/01-2007/02/02
data<-subset(data,data$Date=="2007/02/01"|data$Date=="2007/02/02")

#Remove incomplete observation
data <- data[complete.cases(data),]

# Combine Date and Time column for plotting purposes
dateTime <- paste(data$Date, data$Time)

#Add additional Column to data combined DateTime 
data$DateTime<-dateTime

#Convert Time from character to posixct time 
data$DateTime <- as.POSIXct(data$DateTime)

#Open PNG Graphics device plot1.png  with a width of 480 pixels and a height of 480 pixels
png(filename = "plot4.png",width = 480,height = 480)

## Create Plot 4
par(mfrow=c(2,2))
with(data, {
  plot(Global_active_power~DateTime, type="l", 
  ylab="Global Active Power", xlab="")
  plot(Voltage~DateTime, type="l", 
  ylab="Voltage", xlab="datetime")
  plot(Sub_metering_1~DateTime, type="l", 
  ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~DateTime,col='Red')
  lines(Sub_metering_3~DateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1,bty="n",
  legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~DateTime, type="l", 
  ylab="Global_reactive_power (kilowatts)",xlab="datetime")
   })

#Close the graphics device
dev.off()