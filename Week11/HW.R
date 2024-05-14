library(osmdata)
library(sf)
library(ggplot2)
library(dplyr)
Data<-read.csv("C:/Users/USER/Downloads/File_22018.csv",header = TRUE)
shapefile <- st_read("C:/Users/USER/Downloads/mapdata202301070205")
simplified_sf <- st_simplify(shapefile, preserveTopology = TRUE, dTolerance = 1)

# Plotting the simplified simple features
bounding_box<-st_bbox(simplified_sf)
bounding_box[2] <- 21
simplified_sf <- st_crop(simplified_sf,bounding_box)
plot <- ggplot() +
  geom_sf(data = simplified_sf) +
  theme_minimal() +
  theme(axis.line.x = element_line(color = "black", size = 1)) +
  labs(
    title = "Simplified Simple Features",
    subtitle = "Unit: [unit of y axis]",
    caption = "Data source: [data source]"
  )

plot

