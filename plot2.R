# Set working space
script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

# Set timezone to English format
Sys.setenv(TZ = "UTC")
Sys.setlocale("LC_TIME", "C")

# Unzip file if necessary
if(!file.exists("household_power_consumption.txt")){
    print("Unziping file...")
    unzip(zipfile="household_power_consumption.zip")
}
# Open dataset
print("Openning dataset...")
df <- read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?",colClasses = c("Date"="character","Time"="character"))
# Subset it
df <- subset(df, subset = Date == "1/2/2007" | Date=="2/2/2007")  # 2880x9
# Add a new column with data/time joined
df$DT <- strptime(paste(df$Date,df$Time), format="%d/%m/%Y %H:%M:%S")

print("Printing plot...")
# Config device where the plot will be build
png(file="plot2.png",width=480, height=480)
# Make plot
plot(df$DT,df$Global_active_power, type="l", xlab="",ylab="Global Active Power (kilowatts)")

#dev.copy(png,file="plot2.png",width=480, height=480)
# Close device
dev.off()
print("Done")