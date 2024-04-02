#ChatGpt 3.5 撞牆區
library(tidyverse)

# 產生日期序列
dates <- seq(as.Date("1960-01-01"), as.Date("1962-02-01"), by = "month")

# 產生隨機匯率資料
set.seed(123)
exchange_rate <- data.frame(
  date = rep(dates, 3),
  rate = c(rnorm(length(dates), mean = 30, sd = 5),
           rnorm(length(dates), mean = 25, sd = 5),
           rnorm(length(dates), mean = 40, sd = 5)),
  country = rep(c("美元", "日元", "英鎊"), each = length(dates))
)

# 繪製折線圖
ggplot(exchange_rate, aes(x = date, y = rate, color = country)) +
  geom_line() +
  labs(x = "日期", y = "對台幣匯率升值率") +
  scale_x_date(date_breaks = "6 months", date_labels = "%Y-%m") +
  scale_color_manual(values = c("美元" = "blue", "日元" = "red", "英鎊" = "green")) +
  theme_minimal()

#實際資料
ExchangeData1<-read.csv("C:/Users/USER/Downloads/BP01M01.csv",header = T)
glimpse(exchange_rate)
glimpse(ExchangeData1)

#轉換日期格式
ExchangeData1$期間 <- gsub("M", "-", ExchangeData$期間)
ExchangeData1$期間 <- as.Date(paste0(ExchangeData$期間, "-01"), format = "%Y-%m-%d")

# 計算新台幣對美元的匯率
ntd_usd_rate <- ExchangeData1$新台幣NTD.USD

# 計算其他貨幣的匯率，對新台幣的匯率，並儲存到新的欄位
ExchangeData1 <- ExchangeData1 %>%
  mutate(`日圓` = ntd_usd_rate / `日圓JPY.USD`,
         `英鎊` = ntd_usd_rate / (1/`英鎊USD.GBP`))

# 計算每個欄位的成長率
ExchangeData1 <- ExchangeData1%>%
  mutate(
    日圓_growth = (日圓 - lag(日圓)) / lag(日圓),
    英鎊_growth = (英鎊 - lag(英鎊)) / lag(英鎊)
    # 如果還有其他欄位，可以依此類推
  )

# 將資料框從寬格式轉換為長格式
ExchangeData1<- ExchangeData1 %>%
  pivot_longer(cols = starts_with("成長率"), names_to = "country", values_to = "升值率")
