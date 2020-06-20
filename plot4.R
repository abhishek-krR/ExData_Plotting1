# plot1.R

# download raw data

filename <- "exdata_data_household_power_consumption.zip"

# Checking if archieve already exists.
if (!file.exists(filename)) {
  fileURL <-
    "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filename, method = "curl")
}
# Checking if folder exists
if (!file.exists("Electric Power Dataset")) {
  unzip(filename)
  
}

#Reading data
electricdata <-
  read.table(
    "household_power_consumption.txt",
    header = TRUE,
    sep = ";",
    na.strings = "?",
    colClasses = c(
      'character',
      'character',
      'numeric',
      'numeric',
      'numeric',
      'numeric',
      'numeric',
      'numeric',
      'numeric'
    )
  )

electricdata$Date <- as.Date(electricdata$Date, "%d/%m/%Y")

#subsetting required data
electricdata <- subset(electricdata,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

dateTime <- paste(electricdata$Date, electricdata$Time)

electricdata <- cbind(dateTime, electricdata)

electricdata$dateTime <- as.POSIXct(dateTime)

#Plotting 
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(electricdata, {
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

dev.copy(png,"plot4.png", width=480, height=480)
dev.off()