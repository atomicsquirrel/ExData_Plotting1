# Coursera
# Exploratory Data Analysis
# Course Project 1
#
# "Individual household electric power consumption Data Set"
# Re-creation of plots

# The code assumes that the corresponding data file 
# 	household_power_consumption.txt
# has been downloaded and placed in a location one 
# branch above the current working directory (to avoid 
# uploading it as part of the repository at commit).

# Check that data file exists at the correct location
file_path <- "../household_power_consumption.txt"
if(!file.exists(file_path)) {
    stop("data file not found !")
}

# To avoid reading the whole table (takes a long time), identify 
# rows of interest manually and read only those.
#01/02/2007 starts at row 66638 (counted including header)
#02/02/2007 ends at row 69517 (counted including header)
numberOfRows <- as.integer(69517 - 66638 + 1)

# When using "nrow"/"skip" with "header=TRUE", the first line is not 
# correctly read and assigned as header names. Do so manually 
# by reading the header separately
header <- read.table(file_path,sep=";",
	header=FALSE,nrow=1, stringsAsFactors = FALSE)
data <- read.table(file_path,sep=";",
	header=FALSE,skip=66637,nrow=numberOfRows,
	stringsAsFactors = FALSE)
colnames(data) <- unlist(header)

# Convert date and time column from factors to date/time format
data$Date <- as.Date(data$Date,format="%d/%m/%Y")
data$DateTime <- strptime(paste(data$Date,data$Time),format="%Y-%m-%d %H:%M:%S")



# Create base plot in a PNG file located in the current 
# working directory
png(file="plot3.png",width = 480, height = 480, units = "px")
	plot(data$DateTime,data$Sub_metering_1,
		type = "n",
		ylab="Energy sub metering",
		xlab="")
	points(data$DateTime,data$Sub_metering_1,type="l")
	points(data$DateTime,data$Sub_metering_2,type="l",col="red")
	points(data$DateTime,data$Sub_metering_3,type="l",col="blue")
	legend("topright", lwd=1,
		col=c("black","red","blue"),
		legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()

