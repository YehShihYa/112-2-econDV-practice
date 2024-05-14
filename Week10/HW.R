library(sf)
library(dplyr)
library(tidyverse)
library(ggplot2)
shapefile <- st_read("C:/Users/USER/Downloads/cb_2018_us_state_500k/cb_2018_us_state_500k.shp")
glimpse(head(shapefile))

simplified_sf <- st_simplify(shapefile, preserveTopology = TRUE, dTolerance = 1)
glimpse(head(simplified_sf))

plot <- ggplot() +
  geom_sf(data = simplified_sf)+
  geom_sf_text(data = simplified_sf, aes(label = NAME), size = 2, color = "black") + 
  theme_minimal() +
  theme(axis.line.x = element_line(color = "black", size = 3)) +
  coord_sf(xlim = c(-125, -70),ylim = c(25,55)) +
  labs(title = "USA Map with State Names",subtitle = "Unit of Y Axis: [Add Unit Here]",caption = "Data Source:U.S. Census Bureau")

plot

#########################################################################

ny_sf <- simplified_sf[simplified_sf$NAME == "New York", ]
plot <- ggplot() +
  geom_sf(data = ny_sf, fill = "gray", color = "black") +
  theme_minimal() +
  theme(axis.line.x = element_line(color = "black", size = 1),
    plot.background = element_rect(fill = "lightblue"),  # Set plot background color
  ) +
  coord_sf(xlim = c(-74.1,-73.7),ylim = c(40.55,40.95))+
  labs(title = "New York City",
       subtitle = "Subway Line",
       caption = "Data Source:U.S. Census Bureau and NYC Open Data")


subway_shapefile <- st_read("C:/Users/USER/Downloads/Subway Lines/geo_export_01446640-56b0-45d2-9d03-84842a50c4fd.shp")
simplified_subway_sf <- st_simplify(subway_shapefile, preserveTopology = TRUE, dTolerance = 1)


a<-plot+
  geom_sf(data = simplified_subway_sf, aes(color =rt_symbol), size = 5) +
  scale_color_manual(values = c("G" = "red", "N" = "blue", "B" = "green", "L" = "orange","A"="purple","7"="gray","J"="black","1"="chocolate","4"="darkorange")) +
  coord_sf(xlim = c(-74.1,-73.7),ylim = c(40.55,40.95))+
  labs(title = "New York City with Subway Routes")

ggsave("ny_map.png", plot = a, width = 10, height = 8, units = "in", dpi = 300)

