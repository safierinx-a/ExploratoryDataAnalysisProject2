library(dplyr)
library(ggplot2)
path_data = "F:/ML Datasets/summarySCC_PM25.rds"
path_codes = "F:/ML Datasets/Source_Classification_Code.rds"
data <- readRDS(path_data)
codes <- readRDS(path_codes)
str(data)
balt <- data[data$fips == c("24510"),]

motor_codes <- codes[codes$SCC.Level.One == c("Mobile Sources"),]$SCC
motor_balt <- balt[balt$SCC %in% motor_codes,]

years = c("1999", "2002", "2005", "2008")

#Open Graphics Device
png(file = "plot5.png", width = 480, height = 480)
plot(years, tapply(motor_balt$Emissions, motor_balt$year, FUN = sum)/100000, 'b',
     col = 'red', xlab = "Year", ylab = "PM2.5 Levels (Mega Tons)",
     main = 'PM2.5 Levels due to Motor Vehicles (1999-2008)',
     xaxp = c(1999, 2008, 3))

dev.off()
