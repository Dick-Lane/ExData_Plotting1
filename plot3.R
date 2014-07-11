##  plot3.R     Dick Lane, 2014-07-10

##  work in correct directory for this project
setwd( '~/Desktop/DS-EDA/ExData_Plotting1' )

####    file reading commented-out because data.frame heu created by plot1.R
##  read.csv2.sql  is part of  sqldf  package
#   library( sqldf )

#   dataPath <- "household_power_consumption.txt"
#   sqlFiltr <- "SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007'"
#   heu <- read.csv2.sql( dataPath, sql=sqlFiltr, sep=";" )
##  system.time shows about 1 second for system and 32 seconds for user
####    end of commented-out block

png( 'plot3.png' )  ##  default size is 480 by 480, unit is pixels

dayTime <- strptime( paste(heu$Date,heu$Time) , "%d/%m/%Y %H:%M:%S" )
##  dayOfWeek <- weekdays( dayTime , abbreviate = TRUE )

colors <- c( 'black' , 'red' , 'blue' )

plot( dayTime , heu$Sub_metering_1 , type = 'l' , col = colors[1] ,
      xlab = '' , ylab = 'Energy sub metering' )
lines( dayTime , heu$Sub_metering_2 , type = 'l' , col = colors[2] )
lines( dayTime , heu$Sub_metering_3 , type = 'l' , col = colors[3] )
legend( 'topright' , lty = 1 , lwd = 2 ,  col = colors ,
        legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3') )

dev.off()
