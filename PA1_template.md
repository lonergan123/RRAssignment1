# "Reproducible Research - Assignment 1"
This report answers a variety of questions from data associated with a personal activity monitoring device. The data consists of two months of data from an anonymous individual collected during the months of October and November, 2012 and include the number of steps taken in 5 minute intervals each day.

## Loading and preprocessing the data

First, read the data file. Note that, as per assignment instructions, the file is not actaully downloaded.


```r
activity <- read.csv("activity.csv")
```
Process data using the plyr package to summarise it for this analyis.


```r
library("plyr")
activity1 <- ddply(activity, .(date), summarise, sum_steps=sum(steps, na.rm=TRUE))
activity2 <- ddply(activity, .(interval), summarise, average=mean(steps, na.rm=TRUE))
```

## Question 1: What is mean total number of steps taken per day?

Histogram:

```r
hist(activity1$sum_steps, main="Steps Per Day Histogram", xlab="# of steps")
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3.png) 

Table:

```r
act_mean <- mean(activity1$sum_steps, na.rm=TRUE)
act_median <- median(activity1$sum_steps, na.rm=TRUE)
```
The mean number of steaps per day is 9354.2295 and median is 10395.


## Question 2: What is the average daily activity pattern?
Time series plot:

```r
plot(activity2$interval, activity2$average, type="l", xlab="Time (5 min interval)", ylab="Average daily # of steps")
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5.png) 

```r
max_interval <- activity2$interval[which.max(activity2$average)]
```

The interval that, on average, had the most # of steps was 835.

## Question 3: Inputting missing values
There are 2304 missing values in the data set. To ensure this does not introduce bias into summary calculations, these values will be replaced with the mean value for that 5 minute interval.

First, merge the mean for each interval into the original data set:

```r
activity <- merge(activity2,activity)
```
Then, using subsetting, replace the NA values with the average and update the aggregate table:

```r
activity$steps[is.na(activity$steps)] <- activity$average[is.na(activity$steps)]
activity1 <- ddply(activity, .(date), summarise, sum_steps=sum(steps, na.rm=TRUE))
```
Now, generate another histogram:

```r
hist(activity1$sum_steps, main="Steps Per Day Histogram", xlab="# of steps")
```

![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-8.png) 

Table:

```r
act_mean <- mean(activity1$sum_steps, na.rm=TRUE)
act_median <- median(activity1$sum_steps, na.rm=TRUE)
```
After replacement of the NA values, the mean number of steaps per day is 1.0766 &times; 10<sup>4</sup> and median is 1.0766 &times; 10<sup>4</sup>.

This has raised the mean and median number of steps per day, and also changed the histogram by increasing the number of days with more steps and decreasing the number of days with fewer steps.

## Qestion 4: Are there differences in activity patterns between weekdays and weekends?
First, add a weekday factor to the data set, and summarise this:

```r
activity$weekday <- as.factor(ifelse(weekdays(as.Date(activity$date)) %in% c("Saturday", "Sunday"), "weekend","weekday"))
activity2 <- ddply(activity, .(interval, weekday), summarise, average=mean(steps, na.r=TRUE))
```
Now, build panel plot using the lattice package with this factor:

```r
library(lattice)
xyplot(average ~ interval | weekday,data = activity2, layout=c(1,2),type="l", xlab="Time (5 min interval)", ylab="Average daily # of steps")
```

![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-11.png) 
