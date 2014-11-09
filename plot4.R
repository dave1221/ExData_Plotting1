dataurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(dataurl,"power_consumption.zip")
unzip("power_consumption.zip",exdir="quizdata")
raw<-read.csv2("./quizdata/household_power_consumption.txt",header=TRUE,na.strings="?",colClasses="character",skip=66636,nrows=2880)
for(i in 3:9) raw[,i]<-as.numeric(raw[,i])
names(raw)<-c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
date<-raw[,1]
date<-as.Date(date,"%d/%m/%Y")
new<-paste(date,raw[,2])
date_time<-as.POSIXct(new,tz="EST")
poc<-cbind(date_time,raw[,3:9])
Sys.setlocale("LC_TIME", "English")
png(filename="plot4.png",width=480,height=480,units="px")
par(mfrow=c(2,2))
with(poc,{{plot(date_time,Global_active_power,ylab="Global Active Power",xlab="",type="n")
               ; lines(date_time,Global_active_power)}
          {plot(date_time,Voltage,ylab="Voltage",xlab="datatime",type="n")
               ; lines(date_time,Voltage)}
          {plot(date_time,Sub_metering_1,ylab="Energy sub metering",xlab="",type="n"))
               ; with(poc,lines(date_time,Sub_metering_1))
               ; with(poc,lines(date_time,Sub_metering_2,col="red"))
              ;  with(poc,lines(date_time,Sub_metering_3,col="blue"))
               ; legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"),lty = c(1, 1, 1), pch = c(NA,NA,NA))
          }
          {plot(date_time,Global_reactive_power,ylab="Global_reactive_power",xlab="datatime",type="n")
               ; lines(date_time,Global_reactive_power)}
         }
     )
plot(poc$date_time,poc$Global_active_power,ylab="Global Active Power",xlab="",type="n")
lines(poc$date_time,poc$Global_active_power)
dev.off()