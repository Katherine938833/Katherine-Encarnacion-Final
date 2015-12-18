#Katherine Encarnacion
#Project 
#Problem 1
#a)
#Load package and data set
library(ISwR)
heart.rate.data <- heart.rate

#Take to columns from the data set
people <- heart.rate.data$subj
heart <- heart.rate.data$hr

#creates a new dataframe with the previous two columns
heart.rate.only <- data.frame(people, heart)

# we use tapply which breaks down the information to a matrix calculating the mean of each individual group.
# it finds all the people that are the same and calculates the mean of the values in heart.
heart.rate.tapply <- tapply(heart.rate.only$heart,heart.rate.only$people,mean)

#Makes the matrix into a dataframe
heart.rate.mean <- data.frame(heart.rate.tapply)

#Renames the column
names(heart.rate.mean)[1] <- "mean"

#The mean function is applied to each cell in hr column and seperates them by time.
heart.rate.tapply.time <- tapply(heart.rate.data$hr,heart.rate.data$time,mean)

#Makes a dataframe. 
heart.rate.time.mean <- data.frame(heart.rate.tapply.time)

#Renames the column.
names(heart.rate.time.mean)[1] <- "mean"

#b)
#Create a vector.
t <- c(0,30,60,120)

#Plot the mean as a function of the vector t and label accordingly.
plot(t,heart.rate.time.mean$mean, main = "Average Heart Rate by Time", xlab = "time", ylab = "heart rate")

#Create a vector
p <- c(1:9)

#Plot the mean as a function of the vector p and label accordingly.
plot(p,heart.rate.mean$mean, main = "Average Heart Rate by Patient", xlab = "patient",ylab = "heart rate")

#Problem 2
#Load data
thuesen.data <- thuesen

#Create a vector of only blood.glucose.
blood <- thuesen.data$blood.glucose

#Change the values of blood.glucose accordingly givig a value of 1 through 4.
thuesen.data[thuesen.data$blood.glucose>4 & thuesen.data$blood.glucose<=7,1] <- 1
thuesen.data[thuesen.data$blood.glucose>7 & thuesen.data$blood.glucose<=9,1] <- 2 
thuesen.data[thuesen.data$blood.glucose>9 & thuesen.data$blood.glucose<=12,1] <- 3
thuesen.data[thuesen.data$blood.glucose>12 & thuesen.data$blood.glucose<=20,1] <- 4

#Since I changed the values of thuesen.data's blood.glucose I inserted the blood column since it contains the original information of blood.glucose. 
newframe <- cbind(thuesen.data,blood)

#I insert the blood.glucose in a new vector.
sugar <- newframe$blood.glucose

#Make the values into factors with levels from 1 through 4.
Hsugar <- factor(sugar, levels = 1:4)

#Rename the levels.
levels(Hsugar) <- c("low","intermediate","high","very high")

#Created a table to count the number of people in each level.
a <- table(Hsugar)

#Takes a sequence of vectors from the previously made dataframes and combines them by column.
New.thuesen.data <- cbind(Hsugar,thuesen$blood.glucose,thuesen$short.velocity)

#Simplified version same information
New.thuesen.data <- cbind(Hsugar,thuesen)

#Probelm 3

#Read in hospital information.
hospital.outcome.data <- read.csv("C:/Users/Katherine/Desktop/MATG 611 Midterm II with supporting files/hospital-outcome-data.csv", header=TRUE)

#function
#Takes the state and the hospital character and outputs best hospital.
bestHospital <- function(st,h)
  #Creates a subset depending on the state inserted or the first variable in the function.
{state <- subset(hospital.outcome.data,hospital.outcome.data$State == st)

#turns both columns on heart attack and pneumonia in the subset from the csv file into a character then into a number since it is read into R as factors.
x <- as.integer(as.character(state$Number.of.Patients...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack))

y <- as.integer(as.character(state$Number.of.Patients...Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))

#takes the second variable in the function to determine which column it is looking at.  
if(h == "heart attack"){
  #Removes missing values
  range(x, na.rm = TRUE)
  #Looks at the indicie of the minimum value.
  j <- which.min(x)
} else {
  range(y, na.rm = TRUE)
  j <-  which.min(y)
}

#Takes the indicie from the min value and outputs that indicie in the second column which is the hospital.
output <- state[j,2]

return(output)
}
