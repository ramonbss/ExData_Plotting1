# Set working space
script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

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
# Config device where the plot will be build
print("Printing plot...")
png(file="plot1.png",width=480, height=480)
# Build the histogram
hist(df$Global_active_power, col="red", main = "Global Active Power", xlab="Global Active Power (kilowatts)")
# Close device
dev.off()
print("Done")