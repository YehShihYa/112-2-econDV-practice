library(tidyverse)

# 創建一個時間序列數據框
set.seed(123)
dates <- seq(as.Date("2023-01-01"), as.Date("2024-03-31"), by = "month")
brent <- data.frame(date = dates, price = c(75, 80, 77, 85, 90, 88, 82, 75, 70, 68, 72, 80, 85, 92, 95))
names(brent) <- c("date", "Brent")
wti <- data.frame(date = dates, price = c(72, 77, 74, 82, 87, 85, 79, 72, 67, 65, 69, 77, 82, 89, 92))
names(wti) <- c("date", "West Texas Intermediate")
# 合併兩個數據框
oil_prices <- cbind(brent, wti$`West Texas Intermediate`)
names(oil_prices)<- c("date", "Brent","West Texas Intermediate")
# 將數據框轉為長形態
oil_prices_long <- pivot_longer(oil_prices, cols = c("Brent", "West Texas Intermediate"), 
                                names_to = "type", values_to = "price")

# 繪製折線圖
ggplot(oil_prices_long, aes(x = date, y = price, color = type)) +
  geom_line() +
  scale_x_date(date_labels = "%Y", date_breaks = "1 year") +
  labs(title = "Oil prices, $ per barrel", x = NULL, y = NULL, color = NULL) +
  theme_bw()

