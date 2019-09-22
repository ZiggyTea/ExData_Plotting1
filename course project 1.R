
setwd('C:/Rachel/rachel/R_tutorials/Exploratory Data Analysis (Johns Hopkins, Coursera)/week1')

url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'

download.file(url, destfile='powerConsump.zip')

unzip('powerConsump.zip')

dat <- read.table('household_power_consumption.txt', sep=';', header=TRUE,
                  na.strings=c('?'),colClasses = c('character', 'character',
                                                'numeric','numeric','numeric',
                                                'numeric','numeric','numeric',
                                                'numeric'))


library(dplyr)
# convert date col to date format
dat <- mutate(dat, Date=as.Date(Date, format='%d/%m/%Y'))

dat2 <- filter(dat, Date=='2007-02-01'|Date=='2007-02-02')


head(dat)


#plot 1

hist(dat2$Global_active_power, col='red', xlab='Global Active Power (kilowatts)', 
     main='Global Active Power', ylim=c(0,1200))

dev.copy(png, file='plot1.png', width=480, height=480)
dev.off()


#plot2

plot(1:nrow(dat2),dat2$Global_active_power, type='l', xaxt='n', 
     ylab='Global Active Power (kilowatts)', xlab=NA)

axis(side=1,at=c(0,1440,2880),labels=c("Thu","Fri","Sat"))

dev.copy(png, file='plot2.png', width=480, height=480)
dev.off()


#plot3

#open a graphics device for png bitmap files
# need to send direct to the png graphics device here because copying like
# in the previous examples skews the legend
png(file='plot3.png', width=480, height=480)

plot(1:nrow(dat2),dat2$Sub_metering_1, type='l', xaxt='n', 
     ylab='Energy sub metering', xlab=NA)

lines(1:nrow(dat2),dat2$Sub_metering_2, xaxt='n', col='red')
lines(1:nrow(dat2),dat2$Sub_metering_3, xaxt='n', col='blue')

axis(side=1,at=c(0,1440,2880),labels=c("Thu","Fri","Sat"))

legend('topright', 
       legend=c('Sub_metering_1', 'Sub_metering_2','Sub_metering_3'),
       col=c('black','red','blue'), lty=1)

dev.off()


#plot 4

png(file='plot4.png', width=480, height=480)

par(mfrow=c(2,2))

#top left
plot(1:nrow(dat2),dat2$Global_active_power, type='l', xaxt='n', 
     ylab='Global Active Power', xlab=NA)

axis(side=1,at=c(0,1440,2880),labels=c("Thu","Fri","Sat"))


#topright
plot(1:nrow(dat2),dat2$Voltage, type='l', xaxt='n', 
     ylab='Voltage', xlab='datetime')

axis(side=1,at=c(0,1440,2880),labels=c("Thu","Fri","Sat"))

#bottom left
plot(1:nrow(dat2),dat2$Sub_metering_1, type='l', xaxt='n', 
     ylab='Energy sub metering', xlab=NA)

lines(1:nrow(dat2),dat2$Sub_metering_2, xaxt='n', col='red')
lines(1:nrow(dat2),dat2$Sub_metering_3, xaxt='n', col='blue')

axis(side=1,at=c(0,1440,2880),labels=c("Thu","Fri","Sat"))

legend('topright', 
       legend=c('Sub_metering_1', 'Sub_metering_2','Sub_metering_3'),
       col=c('black','red','blue'), lty=1, box.col=NA, inset=c(0,0.01))

#bottom right
plot(1:nrow(dat2),dat2$Global_reactive_power, type='l', xaxt='n', 
     ylab='Global_reactive_power', xlab='datetime')

axis(side=1,at=c(0,1440,2880),labels=c("Thu","Fri","Sat"))

dev.off()
