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
png(filename = "plot1.png",width = 480,height = 480)

#Plot Histogram of Global Active Power (kilowatts)
with(data,hist(Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)"))

#Close the graphics device
dev.off()