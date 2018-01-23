
#source("C:/Users/TB/Documents/COURSERA DATA SCIENCE test/COURSE4WK1/plot1.r")
#This function creates plot1.png in a local specified directory
plot1<-function() {
  
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
  
  
  #PLOT 1 - 480X480 as PNG
  par(mfrow=c(1,1))
  hist(as.numeric(data$Global_active_power), col="red", xlab="Global Active Power (kilowatts)", 
       main="Global Active Power")
  
  dev.copy(png, file="C:/Users/TB/Documents/COURSERA DATA SCIENCE test/COURSE4WK1/PLOT1.png")
  dev.off()
  
}