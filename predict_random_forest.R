# Loading needed libraries
library(tidyverse)
library(ggmap)
library(viridis)
library(tree)
library(lubridate)
library(randomForest)
library(extrafont)
# Reading in the taxi data
taxi <- read.csv("~/stthom_classes/practicum/taxi.csv")

# Taking a look at the first few rows in taxi
head(taxi)

# Renaming the location variables
# Dropping any journeys with zero fares and zero tips,
# Creating the total variable as the log sum of fare and tip
# Using log to remedy any possible outliers
taxi <- taxi %>%
  rename(lat = pickup_latitude, long = pickup_longitude) %>%
  filter(fare_amount > 0 | tip_amount > 0) %>%
  mutate(total = log(fare_amount + tip_amount))

# Reducing the data to taxi trips starting in Manhattan
# Manhattan is bounded by the rectangle with 
# latitude from 40.70 to 40.83 and 
# longitude from -74.025 to -73.93
taxi <- taxi  %>% 
  filter(between(lat, 40.7, 40.83), between(long, -74.025, -73.93))

# Retrieving a stored map object which originally was created by
# manhattan <- get_map("manhattan", zoom = 12, color = "bw")
manhattan <- readRDS("~/stthom_classes/practicum/manhattan.rds")

# Drawing a density map with the number of journey start locations
ggmap(manhattan, darken = 0.5) +
  scale_fill_viridis(option = 'E') +
  geom_bin2d(data = taxi, aes(x = long, y = lat), bins = 60, alpha = 0.6) +
  labs(title = "Manhattan Taxi Fares", x = "Longitude", y = "Latitude", 
       fill = "Starting Locations") +
  theme(plot.title = element_text(color = "grey10", size=35, face = "bold", 
                                  family = 'Bodoni MT Black'),
        axis.text.y=element_text(face="italic",size=12, color = "grey10", 
                                 family = "garamond"),
        axis.title.y = element_text(face = "bold", size = 20, 
                                    color = "grey10", family = "garamond"),
        axis.title.x = element_text(face = "bold", size = 20, 
                                    color = "grey10", family = 'garamond'),
        axis.text.x = element_text(color = 'grey10', face = "italic", size = 12, 
                                   family = 'garamond'),
        plot.background = element_rect(fill="whitesmoke"),
        legend.background = element_rect(fill = "whitesmoke"),
        legend.title = element_text(face = "italic", color = "grey10", 
                                    family = "Lucinda Calligraphy"))
  

# Fitting a tree to lat and long
fitted_tree <- tree(total ~ lat + long, taxi)

# Draw a diagram of the tree structure
plot(fitted_tree)
text(fitted_tree)

# Generate the three new time variables
taxi <- taxi %>% 
  mutate(hour = hour(taxi$pickup_datetime), wday = wday(taxi$pickup_datetime, label = TRUE), 
         month = month(taxi$pickup_datetime, label =TRUE))

# Fitting a tree with total as the outcome and 
# lat, long, hour, wday, and month as predictors
fitted_tree <- tree(total ~ lat + long + hour + wday + month, taxi)

# draw a diagram of the tree structure
plot(fitted_tree)
text(fitted_tree)

# Summarizing the performance of the tree
summary(fitted_tree)

# Fitting a random forest
fitted_forest <- randomForest(total ~ lat + long + hour + wday + month, taxi, ntree = 80, sampsize = 10000)

# Printing the fitted_forest object
print(fitted_forest)

# Extracting the prediction from fitted_forest
taxi$pred_total <- fitted_forest$predicted

# Plotting the predicted mean trip prices from according to the random forest
ggmap(manhattan, darken = 0.5) +
  scale_fill_viridis(option = 'E') +
  stat_summary_2d(data = taxi, aes(x = long, y = lat, z = pred_total), fun = mean, bins = 60, alpha = 0.6) +
  labs(title = "Average Price per Trip", subtitle = "Manhattan",x = "Longitude", y = "Latitude", fill = "Predicted Mean Trip Price") +
  theme(plot.title = element_text(color = "grey10", size=35, face = "bold", 
                                  family = 'Bodoni MT Black'),
        legend.title = element_text(color = "grey10", face = "italic",
                                    family = "Lucinda Calligraphy"),
        axis.text.y=element_text(face="italic",size=12, color = "grey10", 
                                 family = "garamond"),
        axis.title.y = element_text(face = "bold", size = 20, 
                                    color = "grey10", family = "garamond"),
        axis.title.x = element_text(face = "bold", size = 20, 
                                    color = "grey10", family = 'garamond'),
        axis.text.x = element_text(color = 'grey10', face = "italic", size = 12, 
                                   family = 'garamond'),
        plot.background = element_rect(fill="whitesmoke"),
        legend.background = element_rect(fill = "whitesmoke"))

# Function that returns the mean *if* there are 15 or more datapoints
mean_if_enough_data <- function(x) { 
  ifelse( length(x) >= 15, mean(x), NA) 
}

# Plotting the mean trip prices from the data
ggmap(manhattan, darken = 0.5) +
  scale_fill_viridis(option = 'E') +
  stat_summary_2d(data = taxi, aes(x = long, y = lat, z = total), fun = mean_if_enough_data, bins = 60, alpha = 0.6) +
  labs(title = "Average Price per Trip", subtitle = "Manhattan",x = "Longitude", y = "Latitude", fill = "Predicted Mean Trip Price") +
  theme(plot.title = element_text(color = "grey10", size=35, face = "bold", 
                                  family = 'Bodoni MT Black'),
        plot.subtitle = element_text(color = "grey10", size = 15, face = "bold",
                                     family = "garamond"),
        legend.title = element_text(color = "grey10", face = "italic",
                                      family = "Lucinda Calligraphy"),
        axis.text.y=element_text(face="italic",size=12, color = "grey10", 
                                 family = "garamond"),
        axis.title.y = element_text(face = "bold", size = 20, 
                                    color = "grey10", family = "garamond"),
        axis.title.x = element_text(face = "bold", size = 20, 
                                    color = "grey10", family = 'garamond'),
        axis.text.x = element_text(color = 'grey10', face = "italic", size = 12, 
                                   family = 'garamond'),
        plot.background = element_rect(fill="whitesmoke"),
        legend.background = element_rect(fill = "whitesmoke"))

# The map shows that trips that spend the most come from the Downtown area