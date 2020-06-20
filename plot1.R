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

#Plotting histogram
hist(
  electricdata$Global_active_power,
  main = "Global Active Power",
  xlab = "Global Active Power (kilowatts)",
  col = "red"
)

dev.copy(png,"plot1.png", width=480, height=480)
dev.off()