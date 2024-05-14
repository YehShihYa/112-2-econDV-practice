library(sf)
library(dplyr)
shapefile <- st_read("C:/Users/USER/Downloads/mapdata202301070205")
glimpse(head(shapefile))

#查看檔案大小
object_size <- object.size(shapefile)
object_size

#簡化
simplified_sf <- st_simplify(shapefile, preserveTopology = TRUE, dTolerance = 1)
glimpse(head(simplified_sf))

# Plotting the simplified simple features
library(ggplot2)
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

######################################################################

# Filtering out COUNTYNAME = "新北市" -----
simplified_sf2 <- simplified_sf %>% 
  filter(COUNTYNAME == "新北市")
class(simplified_sf2)

ggplot()+
  geom_sf(
    data=simplified_sf2,
    fill="blue",color="blue",
    linewidth=2
  )

# Creating a column "zone" with random assignment -----
set.seed(123)  # Setting seed for reproducibility
simplified_sf <- simplified_sf %>%
  mutate(zone = sample(c("north", "south", "east", "west"), size = n(), replace = TRUE))
glimpse(simplified_sf)

ggplot()+
  geom_sf(
    data=simplified_sf,
    mapping=aes(
      fill=zone
    )
  )

# Plotting simplified_shape with filled color determined by zone column -----
plot <- ggplot(simplified_sf) +
  geom_sf(aes(fill = zone)) +
  theme_minimal() +
  scale_fill_manual(values = c("north" = "blue", "south" = "green", "east" = "red", "west" = "yellow")) +
  labs(title = "Simplified Shape with Zone Coloring", subtitle = "Zone") +
  theme(legend.position = "bottom") +
  theme(legend.title = element_blank()) +
  theme(legend.text = element_text(size = 8)) +
  theme(axis.line.x = element_line(color = "black", size = 0.5)) +
  labs(caption = "Data Source: your_source")

print(plot)

