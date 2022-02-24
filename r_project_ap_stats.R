##########################################################################################
##########################################################################################
##########################################################################################
#       A       PPPPPPP       SSSSSSSS  TTTTTTTTTT       A        TTTTTTTTTT   SSSSSSSS  #
#      AAA      PPPPPPPPP    SSSSSSSSSS TTTTTTTTTT      AAA       TTTTTTTTTT  SSSSSSSSSS #
#     AA AA     PP      PP   SS             TT         AA  AA         TT      SS         #
#    AA   AA    PP      PP    SS            TT        AA    AA        TT      SS         #
#   AAAAAAAAA   PPPPPPPPP      SSSSSSSS     TT       AAAAAAAAAA       TT       SSSSSSSS  #
#   AAAAAAAAA   PPPPPPP         SSSSSSSS    TT       AAAAAAAAAA       TT        SSSSSSSS #
#  AA       AA  PP                     SS   TT      AA        AA      TT              SS #
#  AA       AA  PP                     SS   TT      AA        AA      TT              SS #
#  AA       AA  PP            SSSSSSSSSSS   TT      AA        AA      TT      SSSSSSSSSS #
# AA         AA PP             SSSSSSSSS    TT     AA          AA     TT       SSSSSSSS  #
#                                                                                        #
# PPPPPPPP      RRRRRRRR      OOOOOOOO   JJJJJJJJJJ  EEEEEEEEEE   CCCCCCCC   TTTTTTTTTT  #
# PPPPPPPPP     RRRRRRRRR    OOOOOOOOOO  JJJJJJJJJJ  EEEEEEEEEE  CCCCCCCCCC  TTTTTTTTTT  #
# PP      PP    RR      RR   OO      OO      JJ      EE          CC              TT      #
# PP      PP    RR      RR   OO      OO      JJ      EE          CC              TT      #
# PPPPPPPPP     RRRRRRRRR    OO      OO      JJ      EEEEEEEE    CC              TT      #
# PPPPPPPP      RRRRRRRR     OO      OO      JJ      EEEEEEEE    CC              TT      #
# PP            RR    RR     OO      OO      JJ      EE          CC              TT      #
# PP            RR     RR    OO      OO      JJ      EE          CC              TT      #
# PP            RR      RR   OOOOOOOOOO  JJJJJJ      EEEEEEEEEE  CCCCCCCCCC      TT      #
# PP            RR      RR    OOOOOOOO    JJJJ       EEEEEEEEEE   CCCCCCCC       TT      #
##########################################################################################
##########################################################################################
##########################################################################################

# Basics of R: Simple Calculations
# Calculate 6 + 4


# Calculate 6 - 4


# Calculate 6 * 4


# Calculate 6/4


# Calculate 6^5 (6 ** 5 works the same)


# Assigning variables using <-


# Print out the variable value


# Assigning vectors


# Using calculations with vectors


# Summary Statistics
# Calculate mean


# Calculate the standard deviation


# Calculate the 5 number summary


# Selecting values with comparison operators (<, >, <=, >=, ==, or !=)


# Creating graphs using ggplot
# Import ggplot2
library(ggplot2)
str(mtcars)
head(mtcars)
tail(mtcars)
# Creating Histogram using dataset mtcars
ggplot(mtcars, aes(x = mpg)) +
  geom_histogram()

# Creating Dotplot
ggplot(mtcars, aes(x = hp)) +
  geom_dotplot()

# Creating Boxplot
ggplot(mtcars, aes(x = wt)) +
  geom_boxplot()

# Improving the visualizations
p <- ggplot(mtcars, aes(x = qsec))
p + geom_histogram(binwidth = 3, fill = 'blue', color = 'white') +
  labs(title = 'Quarter Mile Times', subtitle = '(in seconds)', x = 'Seconds',
       y = '# of Cars') +
  theme(title = element_text(size = 20, face = 'bold', color = 'indianred4'),
        plot.subtitle = element_text(size = 15, face = 'italic', color = 'royalblue'),
        axis.title = element_text(size = 12, face = 'bold', color = 'orange'),
        axis.text = element_text(face = 'bold.italic', color = 'navyblue'),
        panel.background = element_blank())
  
  

        ## Assignment Day 1
# assign the following values to create a list (vector) and set to a variable


# Run a one variable analysis on the variable (5 number summary, mean, and standard deviation)


# Import the dataset

# Run a one variable analysis on the dataset 


# Create 2 different visualizations (dotplot, histogram, or boxplot)



#################################################
#################################################
############## Linear Regression ################
#################################################
#################################################

# Creating Scatterplots
(sp <- ggplot(mtcars, aes(x = hp, y = mpg)) +
  geom_point())

# You can improve the scatterplot with the same tools used before
sp + theme_bw() +
  labs(title = 'Horsepower vs Miles Per Gallon', x = 'Horsepower', y = 'Miles Per Gallon') +
  theme(plot.title = element_text(size = 25, face = 'bold', color = 'forestgreen'),
        axis.title = element_text(size = 15, face = 'italic', color = 'indianred'),
        axis.text = element_text(size = 12, face = 'bold.italic'))

# You can add other variables as well
ggplot(mtcars, aes(x = hp, y = mpg, color = cyl)) +
  geom_point() +
  theme_bw()

# Transforming the data
ggplot(mtcars, aes(x = hp, y = mpg, color = cyl)) +
  geom_point() +
  theme_bw() +
  coord_trans(x = 'sqrt', y = 'log10')

# Calculating regression output using lm
model <- lm(mpg ~ hp, data = mtcars)
summary(model)

# Adding line of best fit
ggplot(data = mtcars, aes(x = hp, y = mpg)) +
  geom_point() +
  geom_smooth(method = 'lm', se = TRUE) +
  theme_bw()

# Assignment #2
data()
# Using the pbc data
# First install and import 'survival' package


# Pick two quantitative variables and create a scatterplot with the line of best fit.
# Don't forget to make sure you include all elements of a graph


# Now run a regression output for the two variables you selected


# Pick 2 more quantitative variables and repeat the steps.


# Assuming both sets of variables are linearly related, what is the correlation for
# each of the two sets of variables. 


# Which one had the higher correlation?


##################################################
##################################################
############### Inference Methods ################
##################################################
##################################################

# Run the appropriate inference method
# Install and import 'Rmisc' package
library(Rmisc)

# Assuming that the dataset mtcars is a srs of all american vehicles find a confidence
# interval for the true proportion of vehicles that gets 30 mpg or higher. cl = 90% and 95%
mtcars$high_mileage_cars <- ifelse(mtcars$mpg > 30, 1, 0)
count(mtcars$high_mileage_cars)  

mutate(high_mileage_cars =)
high_mileage_cars <- mtcars %>%
  filter(mpg >= 30)

prop_hm_cars <- nrow(high_mileage_cars)/nrow(mtcars)
prop_hm_cars
CI(mtcars$high_mileage_cars, ci = 0.9)
