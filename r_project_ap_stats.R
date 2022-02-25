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
mean(mtcars$mpg)

# Calculate the standard deviation


# Calculate the 5 number summary


# Selecting values with comparison operators (<, >, <=, >=, ==, or !=)


# Creating graphs using ggplot
# Import ggplot2
library(tidyverse)
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
# Goal to get one third of cars to get at least 30 mpg by 2020. Is there convincing
# evidence from our sample that we reached this goal?
# Run a confidence interval for the true proportion of vehicles that gets 30 mpg or higher. 
# cl = 90% and 95%

mtcars$high_mileage_cars <- ifelse(mtcars$mpg > 30, 1, 0)

successes <- sum(mtcars$high_mileage_cars)
n <- nrow(mtcars)
n
prop.test(successes, n, p = 1/3, conf.level = 0.9)
prop.test(successes, n, p = 1/3)
# Assuming the the dataset mtcars is a SRS of all vehicles driven in the US, is
# is there convincing evidence that mpg for cars in the US have improved since 1980?
# H0: mu = 18.3 versus Ha: mu > 18.3
t.test(mtcars$mpg, alternative = "greater", mu = 18.3)

# Is there convincing evidence that 4 cylinder cars get better gas mileage than
# 6 cylinder cars using alpha = 0.05.
# H0: mu1-mu2=0 versus Ha: mu1-mu2>0
four_cyl <- as.data.frame(mtcars %>%
  filter(cyl == 4) %>%
    select(mpg))
four_cyl

six_cyl <- as.data.frame(mtcars %>%
  filter(cyl == 6) %>%
  select(mpg))
six_cyl

mtcars <- rbind(four_cyl, six_cyl)
head(mtcars)
t.test(four_cyl, six_cyl, alternative = 'greater', mu = 0)

# We rejected H0. Calculate 90% and 95% CI for the difference.
t.test(four_cyl, six_cyl, alternative = 'two.sided', conf.level = 0.9)
t.test(four_cyl, six_cyl, alternative = 'two.sided', conf.level = 0.95)

# Chi square GOF
# A small coffee shop sells freshly squeezed juices in a refrigerated unit with 
#slots where juice is displayed. These slots are called facings. The manager of 
#the coffee shop suspects that the distribution of juice sales is different than 
#the distribution of facings for each type of juice, so the manager records the 
#sales of each juice over a two-week period. The proportion of facings and the 
#sales for each type of juice are shown in the given variables. Does the coffee
# shop owner have sufficient evidence to conclude that the distribution of sales
# is proportional to the number of facings with alpha = 0.05?
observed <- c(23, 35, 46, 12, 10, 5)
expected <- c(0.1875, 0.250, 0.250, 0.125, 0.125, 0.0625)

chisq.test(x = observed, p = expected)

# Chi square to see if there is an association between two categorical variables
# in a two-way table
# Is there an association between the number of cylinders in a car and the number
# of gears in a car
table(mtcars$cyl, mtcars$gear)
chisq.test(mtcars$cyl, mtcars$gear)

# Chi square test for homogeneity
table(gss_cat$race, gss_cat$relig)

# Is there a difference in religion and race with alpha = 0.01?
chisq.test(gss_cat$race, gss_cat$relig)

# Assignment 3
# Using the NFL players dataset
act <- act_district_data_class_2018.xlsx...ACT_District_Data_Class_2018
act
# Run one of each inference method (you pick the variables)
mean(act$Compos, na.rm = TRUE)

# Confidence Interval take random sample of at least 30 from one school district
# and pick a score (English, Math, Compos, etc.). Select confidence level other than 95% 
"
srs_cayuga <- act %>%  # Filtering to only use Cayuga ISD
  filter(DistName == 'Cayuga ISD')

cayuga_score <- sample(na.omit(srs_cayuga$Compos),30) # Taking a random sample of 30
cayuga_score

t.test(cayuga_score, mu = 19.94, conf.level = 0.90)
"

# One sample hypothesis test: using the same variable from before, change the
# alternative = to either 'greater' or 'less'

# Two sample hypothesis test: pick another school district and take a random sample
# Compare the two districts with a two sample t-test

# Chi Square GOF
school <- read.csv('https://drive.google.com/drive/folders/1dWvVaCaUvBPLnxdj2ZAQ9VJAhFSfv3OG')
# Select SRS from a dfferent school district than previously chosen (n>=30)
srs_conroe <- school_attendance %>%
  filter(District == 'CONROE ISD') %>%
  select(Weekday, Total_Students, Abs)
srs_conroe <- srs_conroe %>%
  group_by(Weekday) %>%
  sample_n(size = 250)
table(srs_conroe$Weekday)
obs <- c(mean(act$Math, na.rm = TRUE), mean(act$English, na.rm = TRUE), mean(act$Reading, na.rm = TRUE),
         mean(act$Science, na.rm = TRUE))
exp <- c(0.25, 0.25, 0.25, 0.25)
chisq.test(x = obs, p = exp)
# Chi Square Two way table (Homogeneity or Independence)