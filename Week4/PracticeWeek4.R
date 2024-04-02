#ChatGPT4.0

# 匯入使用的套件
library(tidyverse)
library(lubridate)

# 建立資料框
exchange_rate <- tibble(
  date = rep(seq(as.Date("1960-01-01"), as.Date("1962-02-01"), by = "months"), 3),
  country = rep(c("美元", "日元", "英鎊"), each = 26),
  rate = runif(78, 20, 40)
)

# 計算匯率升值率 
exchange_rate <- exchange_rate %>%
  arrange(country, date) %>%
  group_by(country) %>%
  mutate(rise_rate = (rate - lag(rate)) / lag(rate))

head(exchange_rate)

# 濾出時間範圍內且國家為"美元", "日元", "英鎊" 的資料並繪圖
exchange_rate %>%
  filter(year(date) >= 1960 & year(date) <= 1962,
         month(date) >= 1 & month(date) <= 2,
         country %in% c("美元", "日元", "英鎊")) %>%
  ggplot(aes(x = date, y = rise_rate, color = country)) +
  geom_line() +
  labs(x = "日期（1960年1月到1962年2月）",
       y = "對台幣匯率升值率", 
       color = "國家") +
  theme_minimal()

#實際資料
ExchangeData<-read.csv("C:/Users/USER/Downloads/BP01M01.csv",header = T)
glimpse(exchange_rate)
glimpse(ExchangeData)

#轉換日期格式
ExchangeData$期間 <- gsub("M", "-", ExchangeData$期間)
ExchangeData$期間 <- as.Date(paste0(ExchangeData$期間, "-01"), format = "%Y-%m-%d")

# 計算新台幣對美元的匯率
ExchageData<-ExchageData %>% 
  mutate(across(c(日圓="日圓JPY.USD",英鎊="英鎊USD.GBP"), ~ ./`新台幣NTD.USD`, .names = "NTD/{.col}"))
