library(ggplot2)
library(tidyverse)
Weather<-read.csv("C:/Arthur Yeh/論文/數據資料/氣象觀測數據資料/Weather Variables/Weather Variables Season Extreme Days 1.csv",header = TRUE)
Weather$Time<-as.Date(Weather$Time,format = "%Y/%m/%d")

chart<-ggplot(Weather,aes(Time))+
  geom_col(aes(y = Max30, fill = "極端高溫"), alpha = 0.5) +
  geom_col(aes(y = Min10, fill = "極端低溫"), alpha = 0.5) +
  labs(
    title = "全台異常高低溫每季發生天數",
    subtitle = "單位：Days per Season",
    caption = "資料來源：交通部中央氣象署",
    fill = "Temperature Extremes"
  ) +
  scale_x_date(date_labels = "%Y/%m",date_breaks = "1 year") +
  scale_fill_manual(name="Extreme Temperature",values = c("極端高溫" = "darkorange", "極端低溫" = "deepskyblue"))
  
# 顯示圖表
print(chart)


