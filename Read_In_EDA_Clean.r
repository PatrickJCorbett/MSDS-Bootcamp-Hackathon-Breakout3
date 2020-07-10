#libraries
library(tidyverse)
library(lubridate)

setwd('C:/Users/pcorb/Documents/MSDS/bootcamp/hackathon/MSDS-Bootcamp-Hackathon-Breakout3')
#read in data
covid <- read_csv('total-confirmed-cases-of-covid-19-per-million-people.csv')


#Initial EDA
head(covid)


#check how many entries per date and country
table(covid$Date)
table(covid$Entity)

#check one country with fewer entries
check_tanzania <- covid%>%
  filter(Entity == "Tanzania")

#check whether we have all dates for the countries in the time series plot
covid_selectcountries <- covid %>%
  filter(Entity %in% c("United States","United Kingdom","World","South Korea","China"))

table(covid_selectcountries$Entity)

#Change Date to a date variable instead of string
covid$Date = mdy(covid$Date)

#test whether that worked 
covid_sort <- covid %>%
  arrange(Entity, desc(Date))

#rename the confirmed cases field
colnames(covid)[4] <- "ConfirmedPerMillion"

#export cleaned dataset
write.csv(covid, 'confirmed cases per million_cleaned.csv')
