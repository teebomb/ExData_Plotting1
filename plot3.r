
#source("C:/Users/TB/Documents/COURSERA DATA SCIENCE test/COURSE4WK1/plot3.r")
#This function creates plot3.png in a local specified directory
plot3<-function() {
  
  library(sqldf)
  #We will only be using data from the dates 2007-02-01 and 2007-02-02
  data<-read.csv.sql("C:/Users/TB/Documents/COURSERA DATA SCIENCE test/COURSE4WK1/household_power_consumption.txt", sql = "select * from file where V1 = '1/2/2007' ", header=FALSE, sep=";")
  data1<-read.csv.sql("C:/Users/TB/Documents/COURSERA DATA SCIENCE test/COURSE4WK1/household_power_consumption.txt", sql = "select * from file where V1 = '2/2/2007' ", header=FALSE, sep=";")
  con<-file("C:/Users/TB/Documents/COURSERA DATA SCIENCE test/COURSE4WK1/household_power_consumption.txt")
  close(con)
  data<-rbind(data, data1)
  
  #Need to concat Date and Time columns together to acquire POSIXct class
  dt<-paste(data$V1, data$V2)
  t<-strptime(dt, format="%d/%m/%Y %T", tz="UTC")
  data<-cbind(data,t)
  
  colnam<-c('Date','Time','Global_active_power','Global_reactive_power','Voltage','Global_intensity','Sub_metering_1','Sub_metering_2','Sub_metering_3', "datetime")
  colnames(data)<-colnam  
  
  
  #PLOT 3 - 480X480 as PNG
  par(mfrow=c(1,1))
  plot(data$datetime, data$Sub_metering_1, type='l', ylab="Energy sub metering", xlab="", col="black")
  lines(data$datetime, data$Sub_metering_2, col="red")
  lines(data$datetime, data$Sub_metering_3, col="blue")
  
  #Adjusting legend border parameters so the output doesn't get cut off
  leg <- legend("topright", lty = 1,
                legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
                col = c("black","red","blue"),
                plot = FALSE)
  leftlegendx <- (leg$rect$left - 10000)
  rightlegendx <- (leftlegendx + 90000)
  toplegendy <- leg$rect$top
  bottomlegendy <- (leg$rect$top - leg$rect$h)

  legend(x = c(leftlegendx, rightlegendx), y = c(toplegendy, bottomlegendy), lty = 1,
         legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
         col = c("black","red","blue"))
  
  dev.copy(png, file="C:/Users/TB/Documents/COURSERA DATA SCIENCE test/COURSE4WK1/PLOT3.png")
  dev.off()
  
}