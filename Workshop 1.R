#### Basics in R ####

## Basic operations

2+2
2-4
2*8
2*(2+5)^4 
100%%9                                 # the %% represents modulo, 
                                            # gives you the remainder 100 mod 10 = 0

#-----------------------------------------------------------------------------------#

## Logicals and conditions

1>0
2==2
1==0
1!=0
2==2 & 1==0
2==2 | 1==0
2!=3

if(1==1) print("John is cool :)")
if(1==0) print("John is NOT cool :(")
if(1==1 & 10>1) print("John is cool :)")
if(1==1 & 0>1) print("John is NOT cool :(")
if(1==1 | 0>1) print("John is cool :)")

#-----------------------------------------------------------------------------------#

## Make variables and vectors

x = 4                                  # putting spaces doesn't matter in R
y = 8
x + y

x = c(2, 4, 7, 9)                      # c() creates a vector of numbers, they are
y = c(6, 1, 8, 9)                           # separated by a comma
x + y

?seq                                   # gives you details of built in functions

x = seq(
  from = 1,                            # starting number
  to = 30,                             # ending number
  by = 5,                              # count by (optional)
  length.out = 1                       # length (optional)
)

x = seq(1, 30, 5, 1)                   # same as above, you don't have to start new lines

## indexing vectors 

x[1]                                   # returns the first element of the x vector
y[4]                                   # returns the fourth element of the y vector
x[-1]                                  # returns everything but the first element, 
z = x[-c(1,2,3)]                       # the - can remove specified elements


#-----------------------------------------------------------------------------------#

## Some descriptive functions

x = seq(3, 45, length.out=8)
y = seq(5, 56, length.out=8)
mean(x)                                # average of the numbers
mean(y)
sd(x)                                  # standard deviation of the numbers
var(y)                                 # variance of the numbers

#-----------------------------------------------------------------------------------#

## Making your own function 

standardize = function(x){
  z = (x - mean(x)) / sd(x)            # create a variable with any procedure
  return(z)                            # need the return() function so a value is
}                                           # returned once the function is called

standardize(c(1,4,7,8,3,6,7))
scale(c(1,4,7,8,3,6,7))                # built in function that standardizes numbers

#-----------------------------------------------------------------------------------#

## Matrices and descriptives

?matrix                                # has some default selections
mat = matrix(
  data = x,                            # data to be used
  nrow = 2,                            # number of rows
  ncol = 4,                            # number of columns
  byrow = F                            # default; fills down the columns (optional)
)
mat                                         
mat = matrix(c(1,6,9,3,7,8), 2, 3, byrow=T)

colSums(mat)                           # calculates the sums of the columns

standardize(mat)

mat[1,2]                               # returns the element in the first row, second column
mat[2,3]                               # returns the element in the second row, third column
mat[1,]
mat[,3]

?which                                 # tells you where a condition is true
which(
  mat == 27,                           # logic statement to check
  arr.ind = T                          # should it return array of indices (optional)
)

#-----------------------------------------------------------------------------------#

## Useful function: apply()

?apply
apply(
  X = mat,                             # data to be used; array, matrix, array, etc.
  MARGIN = 1,                          # perform operation over row
  FUN = mean
)                                      # MARGIN = 2 for columns, MARGIN = c(1,2) for both

apply(mat, 2, mean)
apply(mat, c(1,2), function(x) x^2)    # you can also apply your own function
                                           # elementwise or by row/column
mat^2                                  # squares each element

#-----------------------------------------------------------------------------------#

#### Reading data ####

install.packages('readr')
library(readr)                         # efficent way of loading data
?getwd                                 # R prints out your directory location
setwd()                                # allows you to change your working directory
                                       # windows: 
                                            # type "C:/" and press tab
                                       # mac: 
                                            # type "~" and press tab (?)
trip = read_csv("tripadvisor_review.csv")

                                       # you can also specify full path and not change wd
trip = read_csv("C:/Users/allee/Box Sync/MU/Datafest SP19/tripadvisor_review.csv")
trip = as.data.frame(trip)             # change to dataframe, useful set up for plotting
summary(trip)                          # get summary of all the variables

# Data from trip advisor:
# Attribute 1 : Unique user id 
# Attribute 2 : Average user feedback on art galleries 
# Attribute 3 : Average user feedback on dance clubs 
# Attribute 4 : Average user feedback on juice bars 
# Attribute 5 : Average user feedback on restaurants 
# Attribute 6 : Average user feedback on museums 
# Attribute 7 : Average user feedback on resorts 
# Attribute 8 : Average user feedback on parks/picnic spots 
# Attribute 9 : Average user feedback on beaches 
# Attribute 10 : Average user feedback on theaters 
# Attribute 11 : Average user feedback on religious institutions

## Check for missing data

anyNA(trip)
which(is.na(trip)=='TRUE')

## Change a variable to a factor

trip$`User ID`= as.factor(trip$`User ID`)

## One way of using "for loops"

avg = rep(NA, ncol(trip[,-1]))           # ncol returns number of columns;  
                                              # trip[,-1] removes first column (user id)
for (i in 1:length(avg)){                # length gives number of elements
  avg[i] = mean(trip[,(i+1)])
}

avg2 = colMeans(trip[,-1])               # same as for loop above

#-----------------------------------------------------------------------------------#

## Simple linear regression model: lm()

colnames(trip)                           # these are not very R/user friendly
colnames(trip) = c('UserID', 'art', 'dance', 'juice', 'rest', 'mms', 'resort', 
                 'spots', 'beach', 'theatre', 'relig')
colnames(trip)
?lm
trip.lm1 = lm(
  formula = dance ~ spots + beach,       # specify linear regression formula
  data = trip                            # specify data to be used
)
summary(trip.lm1)                        

trip.lm2 = lm(
  dance ~ sports*beach,                  # the * includes the interaction term
  trip
)

#-----------------------------------------------------------------------------------#

## run multiple simple linear reg models at once

indep = colnames(trip)[-1]               # remove user id
for (i in indep[-1]){                    # -1 --> remove dependent variable being used
  form = formula(paste('art', '~', i))   # create formula to use
  lm.art = lm(form, data = trip)
  print(summary(lm.art))
}                         

## conditional statements

for (i in 1:length(avg)){
  if (avg[i]>1.5){
    print(indep[i])
  }
}

#-----------------------------------------------------------------------------------#

## Lists

?list
list.dat = list(mat, x, y,               # can combine various objects into one list 
                trip, lm.art)
list.dat[[1]]                            # calls first object in the list

data(cars)                               # R has built in data sets
head(cars)                               # prints first 6 rows of the data

lm.estimates = function(dat){            # make general function for data with 2 variables
  lm.dat = lm(dat[,1]~dat[,2], dat)           # return coefficients, yhats, and mse
  mse = sum((dat[,1]-lm.dat$fitted.values)^2)/nrow(dat)
  return(list(coef = lm.dat$coefficients, 
              fitted = lm.dat$fitted.values, 
              MSE = mse))
}

cars.data = lm.estimates(cars)
cars.data
