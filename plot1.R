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
	header=FALSE,skip=66637,nrow=numberOfRows)
colnames(data) <- unlist(header)

# Create base plot in a PNG file located in the current 
# working directory
png(file="plot1.png",width = 480, height = 480, units = "px")
	hist(data$Global_active_power,
		xlab="Global Active Power (kilowatts)",
		col="red",
		main="Global Active Powe")
dev.off()

