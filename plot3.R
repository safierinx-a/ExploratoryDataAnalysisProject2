library(dplyr)
library(ggplot2)
path_data = "F:/ML Datasets/summarySCC_PM25.rds"
path_codes = "F:/ML Datasets/Source_Classification_Code.rds"
data <- readRDS(path_data)
codes <- readRDS(path_codes)
str(data)
balt <- data[data$fips == c("24510"),]

mod <- data.frame('year' = years,
                    'point' = tapply(balt[balt$type == c("POINT"),]$Emissions, 
                                         balt[balt$type == c("POINT"),]$year,
                                         FUN = sum )/1000000,
                    'nonpoint' = tapply(balt[balt$type == c("NONPOINT"),]$Emissions, 
                                            balt[balt$type == c("NONPOINT"),]$year,
                                            FUN = sum )/1000000,
                    'onroad' = tapply(balt[balt$type == c("ON-ROAD"),]$Emissions, 
                                         balt[balt$type == c("ON-ROAD"),]$year,
                                         FUN = sum )/1000000,
                    'nonroad' = tapply(balt[balt$type == c("NON-ROAD"),]$Emissions, 
                                          balt[balt$type == c("NON-ROAD"),]$year,
                                          FUN = sum )/1000000)

years = c("1999", "2002", "2005", "2008")

#Open Graphics Device
png(file = "plot3.png", width = 480, height = 480)

ggplot(data = mod, aes(x = year, group = 1)) + 
  geom_line(aes(y = point, group = 1, colour = 'point')) + 
  geom_line(aes(y = nonpoint, colour = 'nonpoint')) + 
  geom_line(aes(y = onroad, group = 1, colour = 'onroad')) + 
  geom_line(aes(y = nonroad, group = 1, colour = 'nonroad'))+ 
  scale_colour_manual("", 
                      breaks = c("point", "nonpoint", "onroad", 'nonroad'),
                      values = c("red", "green", "blue", 'black')) +
  xlab("Year ") + ylab("Emissions (Mega Tons)")


dev.off()
