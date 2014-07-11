####    summary of work on EDA Project 1       Dick Lane, 2014-07-10

##  work in correct directory for this project
setwd( '~/Desktop/DS-EDA/ExData_Plotting1' )

#   download data (URL in README.md) to data folder in my course folder
#   fork & clone repo (per README) into my course folder
#   symbolic link in project folder for project's data
#       ln  -s  ../data/household_power_consumption.txt  ./household_power_consumption.txt

####    preliminary examination of data file structure
##  household_power_consumption.txt has a header line with variable names
##  data values separated by semicolon, ";"

##  dates in  %d/%m/%Y  format  (next items showed %d or %m can be 1 digit)
##  fgrep "2/2007" household_power_consumption.txt shows "1/2/2007"
##  fgrep ... | wc  shows 4320 cases for each of "1/2/2007" and "2/2/2007"
##      since first pattern matches 1/2/2007, 11/2/2007, 21/2/2007
##      and 4320/3 = 1440 = 24 * 60, sql pattern '1/2/2007' should work

##  fgrep "1/2/2007" [file] | fgrep "?" showed no missing values for 1-Feb
##  fgrep "2/2/2007" [file] | fgrep "?" showed no missing values for 2-Feb
##      therefore no recoding from "?" to NA is required for this project.

####    read.csv2.sql  is part of  sqldf  package
library( sqldf )

####    household energy use  data  for two target days
dataPath <- "../data/household_power_consumption.txt"
sqlFiltr <- "SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007'"
heu <- read.csv2.sql( dataPath, sql=sqlFiltr, sep=";" )
##  system.time shows about 1 second for system and 32 seconds for user
#       essentially same time for hard link or symbolic link to data elsewhere

##  plot 1
hist( heu$Global_active_power ,
      col = "red" ,
      main = 'Global Active Power' ,
      xlab = 'Global Active Power (kilowatts)'
      )


##  plot 2
dayTime <- strptime( paste(heu$Date,heu$Time) , "%d/%m/%Y %H:%M:%S" )
dayOfWeek <- weekdays( dayTime , abbreviate = TRUE )  ##  not needed
plot( dayTime , heu$Global_active_power ,
      type = "l" ,
      xlab = '' ,
      ylab = 'Global Active Power (kilowatts)'
      )


##  plot 3
plot( dayTime , heu$Sub_metering_1 , type = 'l' , col = 'grey' ,
      xlab = '' ,
      ylab = 'Energy sub metering'
    )
lines( dayTime , heu$Sub_metering_2 , type = 'l' , col = 'red' )
lines( dayTime , heu$Sub_metering_3 , type = 'l' , col = 'blue' )
legend( 'topright' , lty = 1 ,
        col = c( 'grey' , 'red' , 'blue' ) ,
        legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3')
        )


##  plot 4
par( mfcol = c(2,2) )
#       upper-left: figure 2, omitting '(kilowatts)'
plot( dayTime , heu$Global_active_power , type = "l" ,
      xlab = '' , ylab = 'Global Active Power' )
#       lower-left: figure 3 (without box around legend)
colors <- c( 'black' , 'red' , 'blue' )
plot( dayTime , heu$Sub_metering_1 , type = 'l' , col = colors[1] ,
      xlab = '' , ylab = 'Energy sub metering' )
lines( dayTime , heu$Sub_metering_2 , type = 'l' , col = colors[2] )
lines( dayTime , heu$Sub_metering_3 , type = 'l' , col = colors[3] )
legend( 'topright' , lty = 1 , lwd = 2 ,  col = colors , bty = 'n' ,
        legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3') )
#       upper-right
plot( dayTime , heu$Voltage , type = 'l' ,
      xlab = 'datetime' , ylab = 'Voltage' )
#       lower-right
plot( dayTime , heu$Global_reactive_power , type = 'l' ,
      xlab = 'datetime' , ylab = 'Global_reactive_power' )
par( mfcol = c(1,1) )

####    toDo: put code fragments into plot#.R to create plot#.png

####    toDo later: find cause(s) of warnings --- see plot1.log
##  Could not load tcltk.  Will use slower R code instead.  [Mac related ?]
##  closing unused connection ...       [bug in read.csv2.sql ?]

####    toDo much later: experiment to speed construction of data frame
#   http://stackoverflow.com/questions/1727772/quickly-reading-very-large-tables-as-dataframes-in-r
#   http://stackoverflow.com/questions/14124813/data-table-fread-function
