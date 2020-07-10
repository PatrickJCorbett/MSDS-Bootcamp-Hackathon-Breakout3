#Packages
library(tidyverse)
library(maps)
install.packages("maps")

#Step 1. Read in world map
world_map = map_data("world")

table(world_map$region)

#Step 2. Read in COVID data
covid <- read_csv('confirmed cases per million_cleaned.csv')

#Step 3. Filter to July 10th COVID data
covid_july9 <- covid %>%
  filter(Date == "2020-07-09")


#Step 3.5 Fix name mismatches
#want to fix UK, USA, Spain
#see what those are called in COVID
covid_july9$Entity[covid_july9$Entity == "United States"]  <-  "USA"
covid_july9$Entity[covid_july9$Entity == "United Kingdom"]  <-  "UK"

#Step 4. Join World Map data and July 10th COVID data to get confirmed cases 
#in the same dataframe as long/lat
world_map_covid = left_join(world_map, covid_july9, by = c('region'='Entity'))

check_na <- world_map_covid %>%
  filter(is.na(ConfirmedPerMillion))
table(check_na$region)

#Step 5. Plot

ggplot(world_map_covid, aes(long, lat, group = group))+
  geom_polygon(aes(fill = ConfirmedPerMillion), color = "white") +
  scale_fill_viridis_c(option = "C") +
  ggtitle("Total Confirmed COVID-19 Cases Per Million People, July 10th, 2020") +
  theme(plot.title = element_text(size = 10, face = "bold")) +
  ggsave("Plot2.png")





