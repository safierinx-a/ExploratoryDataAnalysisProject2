library(dplyr)
path_data = "F:/ML Datasets/summarySCC_PM25.rds"
path_codes = "F:/ML Datasets/Source_Classification_Code.rds"
data <- readRDS(path_data)
codes <- readRDS(path_codes)
str(data)
years = c("1999", "2002", "2005", "2008")

#Open Graphics Device
png(file = "plot1.png", width = 480, height = 480)
plot(years, tapply(data$Emissions, data$year, FUN = sum)/100000, 'b',
        col = 'red', xlab = "Year", ylab = "PM2.5 Levels (Mega Tons)",
        main = 'PM2.5 Levels across the United States (1999-2008)',
     xaxp = c(1999, 2008, 3))

dev.off()

