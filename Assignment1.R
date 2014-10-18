setwd("C:/Users/Kevin/SkyDrive/Documents/Personal/Coursera/Reproducible Research/Assignment 1")

##load in data file
durl <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
download.file(durl,destfile="activity.zip")
unzip("activity.zip")
activity <- read.csv("activity.csv")

##What is mean total number of steps taken per day?
##Make a histogram of the total number of steps taken each day
##Calculate and report the mean and median total number of steps taken per day
activity1 <- ddply(activity, .(date), summarise, sum_steps=sum(steps, na.rm=TRUE))
hist(activity1$sum_steps)
mean(activity1$sum_steps, na.rm=TRUE)
median(activity1$sum_steps, na.rm=TRUE)

##What is the average daily activity pattern?
activity2 <- ddply(activity, .(interval), summarise, average=mean(steps, na.rm=TRUE))
##Make a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days (y-axis)
plot(activity2$interval, activity2$average, type="l")
##Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps?
activity2$interval[which.max(activity2$average)]

##Calculate and report the total number of missing values in the dataset (i.e. the total number of rows with NAs)
sum(is.na(activity$steps))

##Replace NA values with mean for that day.


##Create a new dataset that is equal to the original dataset but with the missing data filled in.

##Make a histogram of the total number of steps taken each day and Calculate and report the mean and median total number of steps taken per day. Do these values differ from the estimates from the first part of the assignment? What is the impact of imputing missing data on the estimates of the total daily number of steps?

