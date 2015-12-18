# Midterm #2 Solution Script
# Date: Nov. 13, 2015
# Author: Angel Pineda, based on the solutions by Nick Italiano, Katherine
# Encarnacion and Michael Scarinci
############################################################################################################
library(ISwR)

# 1
# a)
# Produce 2 data frame's; one with the mean heart rate for each patient,
# and another with the average heart rate for all patients at each time
View(heart.rate)

# Split d.f. into seperate lists using the "split" function
heartRateByPatient <- split(heart.rate$hr, heart.rate$subj)
heartRateByTime <- split(heart.rate$hr, heart.rate$time)

# Take mean of each seperate list using "sapply"
avg.heartRateByPatient<-sapply(heartRateByPatient, mean)
avg.heartRateByTime<-sapply(heartRateByTime, mean)

# Create data fram using "data.frame"
avg.Heart.Rate.By.Patient<-data.frame(Patient=names(avg.heartRateByPatient),AverageHR=avg.heartRateByPatient)
avg.Heart.Rate.By.Time<-data.frame(Time=names(avg.heartRateByTime),AverageHR=avg.heartRateByTime)

# b)Using the data frames from part a) create a plot of average heart rate
# as a function of time and a plot for average heart rate as a function of patient

#plot d.f.'s with title and axis labels
plot(as.numeric(avg.Heart.Rate.By.Time$Time),avg.Heart.Rate.By.Time$AverageHR,
     main="Average Heart Rate By Time",
     xlab='time',
     ylab='Average Heart Rate')
plot(as.numeric(avg.Heart.Rate.By.Patient$Patient),avg.Heart.Rate.By.Patient$AverageHR,
     main="Average Heart Rate By Patient",
     xlab='time',
     ylab='Average Heart Rate')

# 2)

# We create a variable thues in order to manipulate the thuesen data
thues <- thuesen

#The variable blood will use the thuesen data and look only at the blood glucose level
blood <- thues$blood.glucose

#The variable x will be the intervals needed to cut the blood into the proper intervals
x <- c(4,7,9,12,20)
# a) Using x we cut the blood data into four intervals and give labels to each
groupedBlood <- cut(blood,x,labels = c("low","intermediate","high","very high"))

# b) We create a table
table(groupedBlood)

# c) we combine our original blood data table of the gluclose levels with the labels from grouped blood of "low","intermediate",etc..
groupedData <- cbind(thues,glucose.level=groupedBlood)


# 3) 

best <- function(state, outcome) {
  ## Read outcome data
  outcomedata <- read.csv("~/Coursera/RProgramming/ProgrammingAssignment3/rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that state and outcome are valid
  validState <- FALSE
  
  for (i in 1:length(outcomedata$State)){
    if (state == outcomedata$State[i]){validState <- TRUE}
  }
  if (validState == FALSE){ stop("invalid state")}
  
  outcomes <- c("heart attack", "heart failure", "pneumonia")
  validOutcome <- FALSE
  
  for (i in 1:length(outcomes)){
    if (outcomes[i] == outcome){validOutcome <- TRUE}
  }
  if (validOutcome == FALSE){ stop("invalid outcome")}
  
  
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  
  if (outcome == "heart attack"){
    Data <- subset(outcomedata, State == state, select = c(Hospital.Name,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack) )
    tData <- transform(Data,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack = as.numeric(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack))
    sortedData <- tData[order(tData$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,tData$Hospital.Name,na.last = NA),]
    return(sortedData$Hospital.Name[1])
  }
  
  if (outcome == "heart failure"){
    Data <- subset(outcomedata, State == state, select = c(Hospital.Name,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure) )
    tData <- transform(Data,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure = as.numeric(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure))
    sortedData <- Data[order(tData$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure,Data$Hospital.Name,na.last = NA),]
    return(sortedData$Hospital.Name[1])
  }
  
  
  if (outcome == "pneumonia"){
    Data <- subset(outcomedata, State == state, select = c(Hospital.Name,Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia) )
    tData <- transform(Data,Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia = as.numeric(Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))
    sortedData <- tData[order(tData$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia,Data$Hospital.Name,na.last = NA),]
    return(sortedData$Hospital.Name[1])
  }
  
}
