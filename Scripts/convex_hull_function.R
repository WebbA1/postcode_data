
crossprod <- function(o, a, b) {
  return((a[1] - o[1]) * (b[2] - o[2]) - (a[2] - o[2]) * (b[1] - o[1]))
}


montone_chain_algo <- function(longitude_coord, latitude_coord) {
  browser()
  coordMatrix <- cbind(longitude_coord, latitude_coord)
  # Find Min and Max X Coord - Longitude
  points <- unique(latLongCoord[sort(latLongCoord[1:nrow(latLongCoord)]), 1:2])
  # Build lower hull
  lower <- c()
  for(row in 1:nrow(points)) {
    while(length(lower) >= 2 & crossprod(lower[nrow(lower), 1:2], 
                                         lower[nrow(lower) - 1, 1:2], 
                                         row) <= 0) {
      print("Hello")
      
    }
  }
}
test <- montone_chain_algo(lon_coord, lat_coord)
p <- Polygon(test)
ps <- Polygons(list(p), 1)
sps <- SpatialPolygons(list(ps))
plot(sps)

