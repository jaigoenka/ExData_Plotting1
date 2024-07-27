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
png(filename = "plot3.png",width = 480,height = 480)

#Plot Sub Metering with Date Time Combined
with(data, {
  plot(Sub_metering_1~DateTime, type="l",
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~DateTime,col='Red')
  lines(Sub_metering_3~DateTime,col='Blue')
})

#Adding Legends
legend("topright",col=c("black","red","blue"),lwd=c(1,1,1),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


#Close the Graphics Device
dev.off()