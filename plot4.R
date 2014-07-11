##  plot4.R     Dick Lane, 2014-07-10

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

png( 'plot4.png' )  ##  default size is 480 by 480, unit is pixels

dayTime <- strptime( paste(heu$Date,heu$Time) , "%d/%m/%Y %H:%M:%S" )
par( mfcol = c(2,2) )
#       figure 2, omitting '(kilowatts)'
plot( dayTime , heu$Global_active_power , type = "l" ,
      xlab = '' , ylab = 'Global Active Power' )
#       figure 3 (without box around legend)
colors <- c( 'black' , 'red' , 'blue' )
plot( dayTime , heu$Sub_metering_1 , type = 'l' , col = colors[1] ,
      xlab = '' , ylab = 'Energy sub metering' )
lines( dayTime , heu$Sub_metering_2 , type = 'l' , col = colors[2] )
lines( dayTime , heu$Sub_metering_3 , type = 'l' , col = colors[3] )
legend( 'topright' , lty = 1 , lwd = 2 ,  col = colors , bty = 'n' ,
        legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3') )
#       figure 4
plot( dayTime , heu$Voltage , type = 'l' ,
      xlab = 'datetime' , ylab = 'Voltage' )
#       figure 5
plot( dayTime , heu$Global_reactive_power , type = 'l' ,
      xlab = 'datetime' , ylab = 'Global_reactive_power' )
par( mfcol = c(1,1) )

dev.off()
