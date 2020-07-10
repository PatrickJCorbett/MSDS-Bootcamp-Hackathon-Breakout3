#set wd
setwd('C:/Users/pcorb/Documents/MSDS/bootcamp/hackathon/MSDS-Bootcamp-Hackathon-Breakout3')

#read in packages
library(tidyverse)

#read in the cleaned data
covid <- read_csv('confirmed cases per million_cleaned.csv')

#log transform the confirmed cases
covid$confirmed_log <- log10(covid$ConfirmedPerMillion)

#define the list of entities we want
entities = c("United States","United Kingdom","World","South Korea","China")
#First stab at the plot
covid %>%
  #filter to selected entities
  filter(Entity %in% entities) %>%
  #initialize ggplot chart saying we want Date on x axis, cases(logged) on y axis
  ggplot(aes(x = Date, y = ConfirmedPerMillion, col = Entity)) +
    geom_line() +
    scale_y_continuous(breaks = c(.01, .1, 1, 10, 100, 1000),labels = c('.01', '.1', '1', '10', '100','1000'),trans = 'log10') +
    ggtitle("Total Confirmed COVID-19 Cases Per Million People, July 10th, 2020") +
    theme(plot.title = element_text(size = 10, face = "bold")) +
    ggsave("Plot1.png")
  

