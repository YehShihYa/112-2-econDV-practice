library(tidyverse)
library(ggplot2)
library(dplyr)

# 建立資料框
data <- data.frame(
  Year = rep(c(2022, 2023, 2024), times = 2),
  Index = c("Move", "CBOE-Vix", "Move", "CBOE-Vix", "Move", "CBOE-Vix"),
  Value = c(28.85, 81.3, 17.9, 130, 14.4, 124)
)

# 繪製分組長條圖
ggplot(data, aes(x = Year, y = Value, fill = Index)) +
  geom_col(position = "dodge")+
  labs(title = "Move and CBOE-Vix",
       x = "Year",
       y = "Index") +
  scale_fill_manual(values = c("steelblue", "goldenrod")) +
  scale_x_continuous(breaks = unique(data$Year)) +
  theme_minimal()


###################################
#台積電淨營運分析
df<-read.csv("C:/Users/USER/Downloads/活頁簿1.csv",header=TRUE)
# 將資料轉換成長格式
data_long <- pivot_longer(df, cols = c("平均收帳天數", "平均售貨天數", "應付帳款付現天數"), names_to = "項目", values_to = "天數")
# 繪製長條圖
bar_plot<-ggplot(data_long, aes(x = 年, y = 天數, fill = 項目)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "台積電財務指標", x = "年份", y = "天數") +
  scale_fill_manual(values = c("平均收帳天數" = "red", "平均售貨天數" = "blue", "應付帳款付現天數" = "gray")) +
  theme_minimal()

# 繪製折線圖
line_plot<-ggplot(df, aes(x =年, y =淨營業週期.日.)) +
  geom_line(color = "yellow") +
  labs(title = NULL, x = NULL, y = NULL) +
  theme_void()

# 合併圖表
combined_plot <- bar_plot + annotation_custom(ggplotGrob(line_plot), xmin = min(df$年), xmax = max(df$年), ymin = -Inf, ymax = Inf)

# 顯示圖表
print(combined_plot)
