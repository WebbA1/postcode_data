
crossprod <- function(o, a, b) {
  return((a[1] - o[1]) * (b[2] - o[2]) - (a[2] - o[2]) * (b[1] - o[1]))
}


montone_chain_algo <- function(longitude_coord, latitude_coord) {
  coordMatrix <- cbind(longitude_coord, latitude_coord)
  # Find Min and Max X Coord - Longitude
  points <- unique(coordMatrix[order(coordMatrix[1:nrow(coordMatrix)]), 1:2])
  # Build lower hull
  lower <- c()
  for(row in 1:nrow(points)) {
    while(length(lower)/2 >= 2) {
      if(crossprod(lower[nrow(lower), 1:2],
                lower[nrow(lower) - 1, 1:2],
                points[row, 1:2]) <= 0) {
        lower <- lower[-nrow(lower), 1:2]
      } else {break}
    }
    lower <- rbind(lower, points[row, 1:2])
  }
  # Build Upper Hull
  upper <- c()
  points <- unique(coordMatrix[order(coordMatrix[1:nrow(coordMatrix)], decreasing = T), 1:2])
  # Need to reverse the points now
  for(row in 1:nrow(points)) {
    while(length(upper)/2 >= 2) {
      if(crossprod(upper[nrow(upper), 1:2],
                   upper[nrow(upper) - 1, 1:2],
                   points[row, 1:2]) <= 0) {
        upper <- upper[-nrow(upper), 1:2]
      } else {break}
    }
    upper <- rbind(upper, points[row, 1:2])
  }
  return(rbind(upper[-nrow(upper), 1:2], lower[-nrow(lower), 1:2]))
}
test <- montone_chain_algo(lon_coord, lat_coord)
#test <- chull(lon_coord, lat_coord)
p <- Polygon(test)
ps <- Polygons(list(p), 1)
sps <- SpatialPolygons(list(ps))
plot(sps)

leaflet(sps) %>% 
  addTiles() %>%
  addPolygons()

ggplot() +
  geom_point(mapping = aes(x = latLongCoord[, 1], y = latLongCoord[, 2])) +
  geom_point(mapping = aes(x = test[, 1], y = test[, 2], color = "red"))
