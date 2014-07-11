##  plot1.R     Dick Lane, 2014-07-10

##  work in correct directory for this project
setwd( '~/Desktop/DS-EDA/ExData_Plotting1' )

##  read.csv2.sql  is part of  sqldf  package
library( sqldf )

dataPath <- "household_power_consumption.txt"
sqlFiltr <- "SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007'"
heu <- read.csv2.sql( dataPath, sql=sqlFiltr, sep=";" )
##  system.time shows about 1 second for system and 32 seconds for user

png( 'plot1.png' )  ##  default size is 480 by 480, unit is pixels

hist( heu$Global_active_power ,
      col = "red" ,
      main = 'Global Active Power' ,
      xlab = 'Global Active Power (kilowatts)'
      )

dev.off()
