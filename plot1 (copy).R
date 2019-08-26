df <- read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")

df$Date <- as.Date( df$Date, format="%d/%m/%Y" )

df <- subset(df, subset = Date=="2007-02-01" | Date=="2007-02-02")  # 2880x9

df$Time <- strptime(df$Time,format="%H:%M:%S")