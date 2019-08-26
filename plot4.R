# Set working space
script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

# Unzip file if necessary
if(!file.exists("household_power_consumption.txt")){
    print("Unziping file...")
    unzip(zipfile="household_power_consumption.zip")
}

print("Openning dataset...")
# Open dataset
df <- read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?",colClasses = c("Date"="character","Time"="character"))
# Subset it
df <- subset(df, subset = Date == "1/2/2007" | Date=="2/2/2007")  # 2880x9
# Add a new column with data/time joined
df$DT <- strptime(paste(df$Date,df$Time), format="%d/%m/%Y %H:%M:%S")
print("Printing plot...")
# Config device where the plot will be build
png(file="plot4.png",width=480, height=480)

# Set global configurations
# Set to build 4 plot divided 2x2 in the plot area
par(mfcol=c(2,2))

#           First plot
plot(df$DT,df$Global_active_power, type="l", xlab="",ylab="Global Active Power (kilowatts)")

#           Second plot

# Plot Sub_metering_1
plot(df$DT,df$Sub_metering_1, type="l", xlab="",ylab="Energy sub metering")
# Plot Sub_metering_2
lines(df$DT,df$Sub_metering_2, type="l", col="red" )
# Plot Sub_metering_3
lines(df$DT,df$Sub_metering_3, type="l", col="blue" )
# Add legend
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1)

#           Thid plot
plot(df$DT, df$Voltage, type = "l",xlab = "datetime", ylab = "Voltage")

#           Fourth plot
plot(df$DT, df$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()
print("Done")