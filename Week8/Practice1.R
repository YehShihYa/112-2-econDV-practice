library(dplyr)
FinanceData<-read.csv("C:/Arthur Yeh/論文/數據資料/DataSet 1130408/上市櫃公司氣象與財務變數(HW).csv",header = TRUE)
Subset<-filter(FinanceData,FinanceData$TSE.產業別==24)

########################################

library(tidyverse)
library(lubridate)
library(cowplot)
library(ggplot2)

Subset$Date <- as.Date(Subset$Date, format = "%Y/%m/%d")

# 迴圈遍歷每間公司
for (i in unique(Subset$股票代碼)) {
  
  # 篩選出每間公司的資料
  company_data <- Subset %>% filter(股票代碼 == i)
  
  # 使用ggplot2繪製折線圖和堆疊面積圖
  plot <- ggplot(company_data, aes(x =Date)) +
    geom_line(aes(y = ROA), color = "red", size = 1.5,Z=Inf) +  # 設定 z 參數為 Inf，確保在最上層
    geom_point(aes(y = ROA), color = "red", size = 3,Z=Inf) +    # 同樣設定 z 參數為 Inf
    geom_col(aes(y = Tem10or30, fill = "Tem10or30"), position = "dodge", alpha = 0.5) +  # 調整透明度
    geom_col(aes(y = Precp80to200, fill = "Precp80to200"), position = "dodge", alpha = 0.5) +  # 調整透明度
    geom_col(aes(y = Precp200, fill = "Precp200"), position = "dodge", alpha = 0.5) +  # 調整透明度
    geom_col(aes(y = DroughtT, fill = "DroughtT"), position = "dodge", alpha = 0.5) +  # 調整透明度
    geom_col(aes(y = DroughtT.1, fill = "DroughtT.1"), position = "dodge", alpha = 0.5) +  # 調整透明度
    geom_col(aes(y = DroughtT.2, fill = "DroughtT.2"), position = "dodge", alpha = 0.5) +  # 調整透明度 +
    labs(title = paste("Company", i, "ROA and Climate Factors Relationship"),
         x = "Year-Quarter", y = "ROA / Climate Factors") +
    scale_fill_manual(values = c("Tem10or30" = "blue", "Precp80to200" = "green", "Precp200" = "gray",
                                 "DroughtT" = "yellow", "DroughtT.1" = "orange", "DroughtT.2" = "purple"),
                      name = "Climate Factors", guide = "legend") +
    # 添加右邊 Y 軸，顯示氣候因素的單位（天數）
    scale_y_continuous(sec.axis = sec_axis(~., name = "Climate Factors (Days)")) +
    # 左邊 Y 軸標 ROA（%），並限制範圍為最小到最大 ROA
    coord_cartesian(ylim = c(min(company_data$ROA), max(company_data$Tem10or30,company_data$ROA,company_data$Precp80to200))) +
    ylab("ROA (%)") 
  
  # 匯出圖表
  ggsave(paste("company",i, "_ROA_and_Climate_Relationship.png", sep = ""), plot, width = 12, height = 8)
}


##########################
plot <- ggplot(company_data, aes(x =Date)) +
  geom_line(aes(y = ROA), color = "red")
