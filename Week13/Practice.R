library(ggplot2)
library(tidyverse)

# Create some sample data
data <- data.frame(
  x = c(1, 2, 3, 4, 5),
  y = c(10, 15, 13, 17, 20)
)

# Create the plot
plot <- ggplot(data, aes(x = x, y = y),
               size = 1, #input$size
               color= "red" #input$color
) +
  geom_point() +
  labs(
    title = "Example Point Plot",
    subtitle = "This is a subtitle",
    caption = "Footer text"
  ) +
  theme(
    plot.caption = element_text(size = 12 #input$footer
    ),
    plot.title =  element_text(size=13 #input$title
    ))  

# Display the plot
print(plot)

######################################################################################
library(tidyverse)
library(sf)

election2020 = jsonlite::fromJSON("https://www.dropbox.com/s/a3torx0p41hheb6/presidentElection2020.json?dl=1")

mp <- econDV2::Map()
mp$sf$get_sf_taiwan_simplified() -> list_sf_taiwan
list_sf_taiwan$鄉鎮區 -> tw_township

# Assuming election2020 is the name of your data frame
election2020 <- election2020 %>%
  mutate(支持率 = if_else(`(2)\n 韓國瑜\n 張善政` > `(3)\n 蔡英文\n 賴清德`, -(`(2)\n 韓國瑜\n 張善政`), `(3)\n 蔡英文\n 賴清德`))


# election plot----
tw_township |>filter(is_in.city == "新北市") -> sf_newTaipei
sf_newTaipei |>left_join(election2020,by=c("name"="鄉(鎮、市、區)別" )) -> sf_newTaipei
sf_newTaipei |>ggplot() + geom_sf(aes(fill=支持率) )
colorspace::diverging_hcl(n = 12, h = c(249, 106), c = 98, l = c(34, 96), power = 1.5, register = "Custom-Palette")

sf_newTaipei |>ggplot() +
  geom_sf(aes(fill=支持率)) +
  colorspace::scale_fill_continuous_diverging(pal = "Custom-Palette",
                                              mid=0,
                                              limits=c(-1,1))
sf_newTaipei |>ggplot() +
  geom_sf(aes(fill=支持率)) +
  colorspace::scale_fill_binned_diverging(
    pal="Custom-Palette",
    n.breaks=8,
    limits=c(-1,1)
  )

#新北市地圖

shapefile<-st_read("C:/Users/USER/Downloads/鄉鎮市區界線(TWD97經緯度)1120928/TOWN_MOI_1120825.shp")
new_taipei <- shapefile %>%filter(COUNTYNAME == "新北市")

map_plot <- ggplot() +
  geom_sf(data = new_taipei)+
  labs(title = "New Taipei City",
       subtitle = "Unit of Y Axis",
       caption = "Data source: Your Source")
  
print(map_plot)

