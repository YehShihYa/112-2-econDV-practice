library(ggplot2)
library(tidyverse)
# Data
candidates <- c("Candidate A", "Candidate B", "Candidate C")
supporting_rate <- c(40.05, 33.49, 26.45)
data <- data.frame(candidates, supporting_rate)

# Plot
myPlot <- ggplot(data, aes(x = candidates, y = supporting_rate)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "2024 Presidential Election",
       subtitle = "Unit: Percentage",
       x = NULL, # Remove x-axis label
       y = NULL) + # Remove y-axis label
  scale_y_continuous(expand = c(0, 0), limits = c(0, 45)) + # Set y-axis limits with no expansion
  theme_minimal()

# Print the plot
print(myPlot)

# Save the plot as an image file
ggsave("presidential_election_plot.png", plot = myPlot, width = 6, height = 4, dpi = 300)

###########################################################
library(ggplot2)

# 建立資料
candidates <- c("candidate A", "candidate B", "candidate C")
supporting_rate <- c(40.05, 33.49, 26.45)
labels <- paste0(supporting_rate, "%")
data <- data.frame(candidates, supporting_rate, labels)

# 重新排序資料
data$candidates <- factor(data$candidates, levels = c("candidate A", "candidate B", "candidate C"))

# 建立 bar chart
myPlot <- ggplot(data, aes(x = candidates, y = supporting_rate, fill = candidates)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = labels), vjust = -0.5, size = 3.5, position = position_dodge(width = 0.9)) + # 加入支持率標籤
  labs(title = "2024 Presidential Election",
       subtitle = "Unit: Percentage",
       x = "", # 添加 x 軸標籤
       y = "支持率", # 添加 y 軸標籤
       fill = NULL) + # 移除圖例標籤
  scale_fill_manual(values = c("candidate A" = "green", "candidate B" = "darkblue", "candidate C" = "cyan")) + # 設定顏色
  scale_y_continuous(expand = c(0, 0), limits = c(0, 45)) + # 設定 y 軸範圍，不延伸
  theme_minimal()

# 顯示圖表
print(myPlot)

#########################################################################

library(ggplot2)

# 建立資料
candidates <- c("Candidate A", "Candidate B", "Candidate C")
supporting_rate <- c(40.05, 33.49, 26.45)
labels <- paste0(supporting_rate, "%")
data <- data.frame(candidates, supporting_rate, labels)

# 重新排序資料
data$candidates <- factor(data$candidates, levels = c("Candidate A", "Candidate B", "Candidate C"))

# 建立 bar chart
myPlot <- ggplot(data, aes(x = candidates, y = supporting_rate, fill = candidates)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = labels), vjust = -0.5, size = 3.5, position = position_dodge(width = 0.9)) + # 加入支持率標籤
  labs(title = "2024 Presidential Election",
       subtitle = "Unit: Percentage",
       x = NULL, # 添加 x 軸標籤
       y = NULL) + # 移除 y 軸標籤
  scale_fill_manual(values = c("Candidate A" = "green", "Candidate B" = "darkblue", "Candidate C" = "cyan")) + # 設定顏色
  scale_y_continuous(expand = c(0, 0), limits = c(0, 45), name = "Supporting rate") + # 設定 y 軸範圍，不延伸，並移除 y 軸標籤
  theme_minimal() +
  theme(legend.position = "none", # 移除圖例
        axis.title.y = element_text(angle = 0, vjust = 1, hjust = 0))# 將 y 軸標題橫寫並放在左上方)

# 顯示圖表
print(myPlot)

# 儲存圖表
ggsave("presidential_election_result.png", plot = myPlot, width = 6, height = 4, dpi = 300)

