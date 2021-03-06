#### Practice data set ####

# Use the 'beavers' dataset in R to apply some of the functions from the workshop

data(beavers) # has two different datasets within the dataset 'beavers'
head(beaver1)
head(beaver2)

# Consider a lm, finding averages of numeric variables, variances, z-scores, ect

#-------------------------------------------------------------------------------#

#### Challenge problem 1 ####

# If we list all the natural numbers below 10 that are multiples of 3 or 5, 
# we get 3, 5, 6 and 9. The sum of these multiples is 23.

# Find the sum of all the multiples of 3 or 5 below 1000.
     # hint: think about using modulo

#-------------------------------------------------------------------------------#

#### Challenge problem 2 ####

# Each new term in the Fibonacci sequence is generated by adding the previous two terms. 
# By starting with 1 and 2, the first 10 terms will be:
  
#  1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...

# By considering the terms in the Fibonacci sequence whose values do not exceed four million, 
# find the sum of the even-valued terms.

      # extension: instead of a loop, write a custom function in R that will give you
      # the sum of the Fibonacci sequence up to a custom value (like 1000, 2 million, ect)

#-------------------------------------------------------------------------------#

