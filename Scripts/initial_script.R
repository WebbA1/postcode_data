library(tidyverse)
library(leaflet)
library(sp)

# Read in the postcode data
rawData <- read_csv("Data/postcodes.csv")
# Filter so we only have active postcodes in aberdeen city
activePostcodes <- rawData %>%
  filter(`In Use?` == "Yes") %>% 
  filter(Country == "Scotland") %>% 
  filter(Longitude != 0 & Latitude != 0) 
# Take the lat and long coords for Aberdeen City
lat_coord <- activePostcodes$Latitude 
lon_coord <- activePostcodes$Longitude

# Bind into a matrix
latLongCoord <- cbind(lon_coord, lat_coord)
p <- Polygon(latLongCoord)
ps <- Polygons(list(p), 1)
sps <- SpatialPolygons(list(ps))
plot(sps)



test <- activePostcodes %>%
  select(Longitude, Latitude)
example <- coordinates(test)

