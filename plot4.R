library(dplyr)
library(ggplot2)
path_data = "F:/ML Datasets/summarySCC_PM25.rds"
path_codes = "F:/ML Datasets/Source_Classification_Code.rds"
data <- readRDS(path_data)
codes <- readRDS(path_codes)
str(data)

coal_codes <- codes[codes$EI.Sector == c("Fuel Comb - Electric Generation - Coal ")|
                      codes$EI.Sector == c("Fuel Comb - Comm/Institutional - Coal")|
                      codes$EI.Sector == c("Fuel Comb - Industrial Boilers, ICEs - Coal"),]$SCC
coal <- data[data$SCC %in% coal_codes,]
years = c("1999", "2002", "2005", "2008")

#Open Graphics Device
png(file = "plot4.png", width = 480, height = 480)
plot(years, tapply(coal$Emissions, coal$year, FUN = sum)/100000, 'b',
     col = 'red', xlab = "Year", ylab = "PM2.5 Levels (Mega Tons)",
     main = 'PM2.5 Levels due to Coal Combustion (1999-2008)',
     xaxp = c(1999, 2008, 3))

dev.off()

