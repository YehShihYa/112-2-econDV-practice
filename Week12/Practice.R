library(osmdata)
library(sf)
library(ggplot2)
bbox<-c(121.1353, 25.3925, 122.0224, 24.8503)
query <- opq(bbox = bbox, timeout=60) %>%
  add_osm_feature(key = "railway", value = "subway") 

osm_data2 <- osmdata_sf(query)
mrt_lines <- osm_data2$osm_lines

library(ggmap)
register_stadiamaps("029eea6d-c328-456f-bb60-2a4d8a364cd0",write = FALSE)
us <- c(left = 121.1353, bottom = 24.8503, right = 122.0224, top = 25.3925)
get_stadiamap(us, zoom = 10, maptype = "alidade_smooth") |> ggmap() 
