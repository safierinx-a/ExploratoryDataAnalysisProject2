library(dplyr)
library(ggplot2)
path_data = "F:/ML Datasets/summarySCC_PM25.rds"
path_codes = "F:/ML Datasets/Source_Classification_Code.rds"
data <- readRDS(path_data)
codes <- readRDS(path_codes)
str(data)
balt <- data[data$fips == c("24510"),]
la <- data[data$fips == c("06037"),]

motor_codes <- codes[codes$SCC.Level.One == c("Mobile Sources"),]$SCC
motor_balt <- balt[balt$SCC %in% motor_codes,]
motor_la <- la[la$SCC %in% motor_codes,]

years = c("1999", "2002", "2005", "2008")

mod <- data.frame('year'= years, 
                  'Baltimore' = tapply(motor_balt$Emissions, motor_balt$year, FUN = sum)/100000,
                  'LA' = tapply(motor_la$Emissions, motor_la$year, FUN = sum)/100000)

#Open Graphics Device
png(file = "plot6.png", width = 480, height = 480)
ggplot(data = mod, aes(x = year, group = 1)) + 
  geom_line(aes(y = Baltimore, colour = 'Baltimore')) + 
  geom_line(aes(y = LA, colour = 'Los Angeles')) +
  scale_colour_manual("", 
                      breaks = c("Baltimore", "Los Angeles", "onroad", 'nonroad'),
                      values = c("red", "green", "blue", 'black')) +
  xlab("Year ") + ylab("Emissions (Mega Tons)")

dev.off()

