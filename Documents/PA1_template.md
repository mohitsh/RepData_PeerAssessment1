## Reproducible Research  
### Peer Assessment 1  

#### What is mean total number of steps taken per day?
#####  total number of steps taken per day


```r
library("data.table")
```

```
## Warning: package 'data.table' was built under R version 3.2.0
```

```
## Warning in fun(libname, pkgname): bytecode version mismatch; using eval
```

```
## data.table 1.9.4  For help type: ?data.table
## *** NB: by=.EACHI is now explicit. See README to restore previous behaviour.
```

```r
library("plyr")
data <- read.csv("./repdata-data-activity/activity.csv")
df <- data.table(data)
ans <- df[, sum(steps, na.rm=T), by=date]
sum_steps <- ans$V1

mydata <- split(data, data$date)$`2012-11-29`
sum(mydata$steps)
```

```
## [1] 7047
```
##### total number of steps taken per day 7047  

#####  a histogram of the total number of steps taken each day

```r
library(ggplot2)
library("MASS")
g <- ggplot(ans, aes(x=V1))
g <- g + geom_histogram(color="steelblue", binwidth=1500)
g <- g +geom_density()
g <- g + xlab("sum of steps by date")
g
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2-1.png) 

##### mean and median of the total number of steps taken per day

```r
rbind(c("Mean", "Median"),c(round(mean(sum_steps),3),median(sum_steps)))
```

```
##      [,1]      [,2]    
## [1,] "Mean"    "Median"
## [2,] "9354.23" "10395"
```
##### mean of total no of steps taken per day is 9354.2295082
##### median is 10395  

#### What is the average daily activity pattern?
#####  time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days (y-axis)


```r
avg_steps <- (sum_steps)/length(sum_steps)
data$avg_steps <- (data$steps)/61
g <- ggplot(data, aes(interval,avg_steps))
g <- g + geom_line() 
g
```

```
## Warning in loop_apply(n, do.ply): Removed 2 rows containing missing values
## (geom_path).
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4-1.png) 

#####  5-minute interval, on average across all the days in the dataset, contains the maximum number of steps


```r
subset(data, avg_steps == max(data$avg_steps, na.rm=T))
```

```
##       steps       date interval avg_steps
## 16492   806 2012-11-27      615  13.21311
```
##### interval containing maximum number of steps is 615

#### Imputing missing values
##### Calculate and report the total number of missing values in the dataset (i.e. the total number of rows with NAs)

```r
na_steps <- subset(data, is.na(data$steps))
nrow(na_steps) # total no or na values
```

```
## [1] 2304
```

```r
na_date <- subset(data, is.na(data$date))
nrow(na_date) # no na values
```

```
## [1] 0
```

```r
na_interval <- subset(data, is.na(data$interval))
nrow(na_interval) # no na values
```

```
## [1] 0
```

```r
na_avg_steps <- subset(data, is.na(data$avg_steps))
nrow(na_avg_steps) # no na values
```

```
## [1] 2304
```
##### total no of missing values 2304

#####  strategy for filling in all of the missing values in the dataset. On some days days I think periodically, data is missing. So missing values can be replaced by mean

##### Create a new dataset that is equal to the original dataset but with the missing data filled in.

```r
data[is.na(data)] <- floor(mean(data$steps, na.rm=T))
```
#####  histogram of the total number of steps taken each day

```r
df <- data.table(data)
ans <- df[, sum(steps, na.rm=T), by=date]
sum_steps <- ans$V1

g <- ggplot(ans, aes(x=V1))
g <- g + geom_histogram(binwidth=1500, color="steelblue")
g <- g + xlab("total steps per day (missing values replaced)")
g
```

![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-8-1.png) 

##### so mean and median of total number of steps taken per day are
##### mean 1.0751738 &times; 10<sup>4</sup> median 1.0656 &times; 10<sup>4</sup>
 
##### the impact of imputing missing data on the estimates of the total daily number of steps  
##### something count of steps per bin of the histogram has increased significantly after replacing  
##### the missing values which is logical too. 

#### differences in activity patterns between weekdays and weekends  
##### Create a new factor variable in the dataset with two levels - "weekday" and "weekend" indicating whether a given date is a weekday or weekend day.  


```r
data$date <- as.Date(data$date,"%Y-%m-%d")
data$days <- weekdays(data$date)


for (i in 1:dim(data)[1])
{
        if(data[i,"days"]=="Monday" | data[i,"days"]=="Tuesday" | data[i,"days"]=="Wednesday"
           | data[i,"days"]=="Thursday" | data[i,"days"]=="Friday")
                data[i,"level"] = "weekday"
        else
                data[i,"level"] = "weekend"
        
        
}
data[,"level"] <- as.factor(data[,"level"])
```

#####  panel plot containing a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all weekday days or weekend days (y-axis).


```r
for (i in 1:dim(data[1]))
{
        if (data[i,"level"]=="weekday")
                data[i,"avg_steps_week"] <- round(data[i,"steps"]/summary(data$level)[1],5)
        
        if (data[i,"level"]=="weekend")
                data[i,"avg_steps_week"] <- round(data[i,"steps"]/summary(data$level)[2],5)
        
}
```

```
## Warning in 1:dim(data[1]): numerical expression has 2 elements: only the
## first used
```

```r
g <- ggplot(data, aes(interval,avg_steps_week))
g <- g + geom_line(color="steelblue") 
g <- g + facet_grid(.~level)
g <- g + xlab("interval") + ylab("weekdays or weekend days")
g
```

![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-10-1.png) 

