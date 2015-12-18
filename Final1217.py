# -*- coding: utf-8 -*-
"""
Created on Mon Dec 14 20:09:23 2015

@author: Katherine
"""

import pandas as pd
import numpy as np
import csv as csv
import matplotlib.pyplot as plt
#PRoblem 1
 # Load the train file into a dataframe
heart_df = pd.read_csv('heart.rate_data.csv', header=0) 

#Looks at the rows from heart_df dataframe and looks for all 
#the numbers equal to 1,2,3,...,9 in the column labeled subj and creates a
#seperate dataframe
sub_1 = heart_df.ix[heart_df.subj == 1]
sub_2 = heart_df.ix[heart_df.subj == 2]
sub_3 = heart_df.ix[heart_df.subj == 3]
sub_4 = heart_df.ix[heart_df.subj == 4]
sub_5 = heart_df.ix[heart_df.subj == 5]
sub_6 = heart_df.ix[heart_df.subj == 6]
sub_7 = heart_df.ix[heart_df.subj == 7]
sub_8 = heart_df.ix[heart_df.subj == 8]
sub_9 = heart_df.ix[heart_df.subj == 9]

#calculates the mean of the column labeled "hr" in each subset and creates 
#another dataframe with the mean
a = sub_1[["hr"]].mean()
b = sub_2[["hr"]].mean()
c = sub_3[["hr"]].mean()
d = sub_3[["hr"]].mean()
e = sub_5[["hr"]].mean()
f = sub_6[["hr"]].mean()
g = sub_7[["hr"]].mean()
h = sub_8[["hr"]].mean()
t = sub_9[["hr"]].mean()

    #Another way to calculate the mean
#Groups the hr column by the values in the subj column
grouped = heart_df['hr'].groupby(heart_df['subj'])

#Takes the mean of hr of each hr.
new = grouped.mean()

#Create a dataframe of the previous results, contains on column and indexed by subj
frame3 = pd.DataFrame(new)

#Extracts the mean from the dataframe
i = a[0]
j = b[0]
k = c[0]
l = d[0]
m = e[0]
n = f[0]
o = g[0]
p = h[0]
q = t[0]

#Create a dictionary
data = {'subject':[1,2,3,4,5,6,7,8,9],
        'mean':[i,j,k,l,m,n,o,p,q]}

#Make the dictionary into a dataframe   
frame = pd.DataFrame(data)

#Part b
my_subjects = [1,2,3,4,5,6,7,8,9]

my_mean = [i,j,k,l,m,n,o,p,q]

#Create a plot with the two list, my_subject & my_mean
plt.plot(my_subjects,my_mean,'g-')
plt.xlabel("Subjects")
plt.ylabel("mean")
plt.title("average heart rate of by patient")
plt.show()

#Create a csv I open it and "wb" to write in the csv, I call the csv new_file
new_file = open("heartVSpatient.csv", "wb")

#Create an object that will write into the file and call it open_file_object
open_file_object = csv.writer(new_file)

#I will write in the fist row
open_file_object.writerow(["Subject","Mean"])

#The list will be written into each row
open_file_object.writerows(zip(my_subjects, my_mean))

#Close the csv
new_file.close()

#Creates the csv
print 'Done.'


#Problem 2
#Part a)

#Uploads data from csv file and makes a dataframe
thuesen_df = pd.read_csv('thuesendata.csv', header=0)

#Extracts data from blood.glucose column in the dataframe thuesen_df
blood = np.array(thuesen_df['blood.glucose'])

#Create bins so that when I insert it into the pd.cut function it will divide the
#blood array into bins of (4,7], (7,9], (9,12], and (12,20]
bins = [4,7,9,12,20]

#I make the cuts and it shows for all values in which bin it is in and outputs 
#the levels which are the different bins.
group = pd.cut(blood,bins)

#I want to name each bin/level
group_name = ['low','intermidiate','high','very high']

#I cut blood array by the bins and identified that the labels will be group_name
group = pd.cut(blood,bins,labels=group_name)

#Part b)

#Counts the values in the array blood that fall in each bin
x = pd.value_counts(group)

#Make 'x' into a dataframe which are the values of each bin
frame2 = pd.DataFrame(x)

#Once I created the dataframe I rename the column
frame2.columns = ['Number of Patients']

#Part c)

#I create an array containing the bins that are labeled
y = np.array(group)

#I create another column containing 'y' the array I previously created and I 
#name it.
thuesen_df['levels of blood glucose'] = y

#I used this command to identify the columns in my dataframe
thuesen_df.columns

#I noticed a column I didn't need, so I used this command to delete it.
del thuesen_df['Unnamed: 0']

#Problem 3

#Upload CSV file
hospital_df = pd.read_csv('hospital-outcome-data.csv', header=0)

#define best hospital
def bestHospital(st,h):
    #Creates dataframes the only include specified values in each row
    state = hospital_df.ix[hospital_df.State == st]
    
    #Drops any row containig missing data
    #state.dropna()
    
    if h == "heart attack":
        state.sort_values(by='Hospital 30-Day Death (Mortality) Rates from Heart Attack')
        find_1 = np.array(state['Hospital Name'])
        
    else:
        state.sort_values(by='Hospital 30-Day Death (Mortality) Rates from Pneumonia')
        find_1 = np.array(state['Hospital Name'])
        
    return find_1[0]

