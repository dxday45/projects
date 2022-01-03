library(rvest)
library(stringr)
library(tidyverse)
library(ggplot2)
library(RColorBrewer)
library(viridisLite)

#Specify  the url for desired website to be scraped
url <- 'https://www.nfl.com/stats/player-stats/'

#Reading the HTML code from the website
webpage <- read_html(url)

# Using CSS selectors to scrape the names section
name_data_html <- html_nodes(webpage, '.nfl-o-cta--link')

# Converting the name data to text
name_data <- html_text(name_data_html)
head(name_data)
name_data <- gsub("\n","", name_data)
str_trim(name_data)

# Using CSS selectors to scrape the passing yards section
pass.yds_data_html <- html_nodes(webpage, '.selected')
pass.yds_data <- html_text(pass.yds_data_html)
head(pass.yds_data)
pass.yds_data <- gsub("\n","", pass.yds_data)
str_trim(pass.yds_data)
pass.yds_data <- as.numeric(pass.yds_data)


# Scraping the yds/att
yds.att_data_html <- html_nodes(webpage, 'td:nth-child(3)')
yds.att_data <- html_text(yds.att_data_html)
head(yds.att_data)
yds.att_data <- gsub("\n","", yds.att_data)
str_trim(yds.att_data)
yds.att_data <- as.numeric(yds.att_data)

# Scraping completion totals
comp_data_html <- html_nodes(webpage, 'td:nth-child(5)')
comp_data <- html_text(comp_data_html)
head(comp_data)
comp_data <- gsub("\n","", comp_data)
str_trim(comp_data)
comp_data <- as.numeric(comp_data)


# Scraping completion percentage totals
comp.per_data_html <- html_nodes(webpage, 'td:nth-child(6)')
comp.per_data <- html_text(comp.per_data_html)
head(comp.per_data)
comp.per_data <- gsub("\n","", comp.per_data)
str_trim(comp.per_data)
comp.per_data <- as.numeric(comp.per_data)


# Scraping touchdown totals
td_data_html <- html_nodes(webpage, 'td:nth-child(7)')
td_data <- html_text(td_data_html)
head(td_data)
td_data <- gsub("\n","", td_data)
str_trim(td_data)
td_data <- as.numeric(td_data)

# Scraping interception totals
int_data_html <- html_nodes(webpage, 'td:nth-child(8)')
int_data <- html_text(int_data_html)
head(int_data)
int_data <- gsub("\n","", int_data)
str_trim(int_data)
int_data <- as.numeric(int_data)

# Scraping qb rating totals
qbr_data_html <- html_nodes(webpage, 'td:nth-child(9)')
qbr_data <- html_text(qbr_data_html)
head(qbr_data)
qbr_data <- gsub("\n","", qbr_data)
str_trim(qbr_data)
qbr_data <- as.numeric(qbr_data)

# Scraping 1st down totals
first_data_html <- html_nodes(webpage, 'td:nth-child(10)')
first_data <- html_text(first_data_html)
head(first_data)
first_data <- gsub("\n","", first_data)
str_trim(first_data)
first_data <- as.numeric(first_data)

# Scraping 1st down % totals
first.per_data_html <- html_nodes(webpage, 'td:nth-child(11)')
first.per_data <- html_text(first.per_data_html)
head(first.per_data)
first.per_data <- gsub("\n","", first.per_data)
str_trim(first.per_data)
first.per_data <- as.numeric(first.per_data)

# Scraping 20+ yd gains totals
twenty_data_html <- html_nodes(webpage, 'td:nth-child(12)')
twenty_data <- html_text(twenty_data_html)
head(twenty_data)
twenty_data <- gsub("\n","", twenty_data)
str_trim(twenty_data)
twenty_data <- as.numeric(twenty_data)

# Scraping 40+ yd gains totals
forty_data_html <- html_nodes(webpage, 'td:nth-child(13)')
forty_data <- html_text(forty_data_html)
head(forty_data)
forty_data <- gsub("\n","", forty_data)
str_trim(forty_data)
forty_data <- as.numeric(forty_data)

# Scraping longest passing yards totals
long_data_html <- html_nodes(webpage, 'td:nth-child(14)')
long_data <- html_text(long_data_html)
head(long_data)
long_data <- gsub("\n","", long_data)
str_trim(long_data)
long_data <- as.numeric(long_data)

# Scraping sack totals
sack_data_html <- html_nodes(webpage, 'td:nth-child(15)')
sack_data <- html_text(sack_data_html)
head(sack_data)
sack_data <- gsub("\n","", sack_data)
str_trim(sack_data)
sack_data <- as.numeric(sack_data)

# Scraping sack loss yds totals
sack.loss_data_html <- html_nodes(webpage, 'td:nth-child(16)')
sack.loss_data <- html_text(sack.loss_data_html)
head(sack.loss_data)
sack.loss_data <- gsub("\n","", sack.loss_data)
str_trim(sack.loss_data)
sack.loss_data <- as.numeric(sack.loss_data)

#Combining them all into one dataframe
qb.stats_df <- data.frame(name = name_data, passing_yards = pass.yds_data, completions = comp_data,
                          comp_percentage = comp.per_data, touchdowns = td_data,
                          interceptions = int_data, qbr = qbr_data, first_downs = first_data,
                          first_down_percentage = first.per_data, twenty_plus_yds = twenty_data,
                          forty_plus_yds = forty_data, long = long_data, sacks = sack_data,
                          sack_yards_lost = sack.loss_data)
str(qb.stats_df)
head(qb.stats_df)


# Visualizing the Data
qb.stats_df %>%
  top_n(n = 8, qb.stats_df$touchdowns) %>%
  ggplot(aes(name, touchdowns,fill = name)) +
  geom_col() +
  labs(title = 'Touchdown Season Totals 2021', subtitle = 'Top Ten', x = 'Player',
        y = 'Number of Touchdowns') +
  scale_fill_brewer(type = 'seq', palette = 'Dark2', aesthetics = 'fill') +
  theme(legend.position = 'none', axis.text = element_text(size = 9, family = 'Georgia',
                                                           face = 'italic'),
        axis.title = element_text(size = 12, family = 'Georgia', face = 'bold'),
        title = element_text(size = 15, color = 'darkblue', face = 'bold', family = 'Georgia'),
        plot.subtitle = element_text(size = 12, color = 'indianred4', face = 'bold', family = 'Georgia'),
        panel.background = element_blank())

tail(qb.stats_df)
qb.stats_df %>%
  ggplot(aes(qbr, touchdowns)) +
  geom_point(aes(color = name)) +
  geom_label(label = "Brady", x = 100, y = 36) +
  geom_label(label = "Lawrence", x = 70, y = 12) +
  labs(title = 'QBR Predicting Touchdowns 2021', x = 'Quarterback Rating',
       y = 'Number of Touchdowns') +
  scale_color_viridis_d(option = 'A') +
  theme(legend.position = 'none', axis.text = element_text(size = 9, family = 'Georgia',
                                                           face = 'italic'),
        axis.title = element_text(size = 12, family = 'Georgia', face = 'bold'),
        title = element_text(size = 15, color = 'darkblue', face = 'bold', family = 'Georgia'),
        plot.subtitle = element_text(size = 12, color = 'indianred4', face = 'bold', family = 'Georgia'),
        panel.background = element_blank())

