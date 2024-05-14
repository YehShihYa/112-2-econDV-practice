library(osmdata)
library(tidyverse)
library(sf)

# Define bounding box coordinates
bbox <- c(left = -74.05, bottom = 40.65, right = -73.85, top = 40.85)
# Create query
query <- opq(bbox = bbox) %>%
  add_osm_feature(key = "railway", value = "subway")
# Get subway railway data
subway_data <- osmdata_sf(query)
# geometry lines
mrt <- osm_data$osm_lines
mrt |>ggplot()+geom_sf()


shapefile <- st_read("C:/Users/USER/Downloads/mapdata202301070205")
simplified_sf <- st_simplify(shapefile, preserveTopology = TRUE, dTolerance = 2)

simplified_sf |>filter(COUNTYNAME %in% c("臺北市", "新北市")) |>
  ggplot() + geom_sf() +
  geom_sf(data=mrt)

bbox0 <- st_bbox(simplified_sf)
bbox0["xmin"] <- 121.0
bbox0["ymax"] <- 25.35
bbox0["xmax"] <- 121.7999
bbox0["ymin"] <- 24.9

simplified_shape_crop <- sf::st_crop(simplified_sf,bbox0)
simplified_shape_crop |>ggplot()+geom_sf() +geom_sf(data=mrt)


# econDV2 ------
library(ggmap)
mp <- econDV2::Map()
mp$sf$get_sf_taiwan_simplified() -> taiwan
taiwan$台灣本島$鄉鎮區 -> sf_township
sf_township |>ggplot()+geom_sf()
