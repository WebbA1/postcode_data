library(tidyverse)
library(leaflet)

# Read in the postcode data
rawData <- read_csv("Data/postcodes.csv")
# Filter so we only have active postcodes in aberdeen city
activePostcodes <- rawData %>%
  filter(`In Use?` == "Yes") %>% 
  filter(District == "Aberdeen City")
