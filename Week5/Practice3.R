library(tidyverse)

# 定義每個學年的 CSV 下載按鈕對應的網址
csv_urls <- list(
  "104學年" = "https://stats.moe.gov.tw/files/ebook/native/104/104native_A1-1.csv",
  "105學年" = "https://stats.moe.gov.tw/files/ebook/native/105/105native_A1-1.csv",
  "106學年" = "https://stats.moe.gov.tw/files/ebook/native/106/106native_A1-1.csv",
  "107學年" = "https://stats.moe.gov.tw/files/ebook/native/107/107native_A1-1.csv",
  "108學年" = "https://stats.moe.gov.tw/files/ebook/native/108/108native_A1-1.csv",
  "109學年" = "https://stats.moe.gov.tw/files/ebook/native/109/109native_A1-1.csv",
  "110學年" = "https://stats.moe.gov.tw/files/ebook/native/110/110native_A1-1.csv",
  "111學年" = "https://stats.moe.gov.tw/files/ebook/native/111/111native_A1-1.csv",
  "112學年" = "https://stats.moe.gov.tw/files/ebook/native/112/112native_A1-1.csv"
)
csv_urls
# 將結果存入results中
results <- list(csv_urls = csv_urls)
## download and import ----
# 建立一個空的list來存儲下載的資料
data_list <- list()
# 循環下載每個CSV檔案並讀取到R中
for (year in names(csv_urls)) {
  # 下載CSV檔案
  download.file(csv_urls[[year]], paste0(year, ".csv"))
  
  # 讀取CSV檔案
  data <- read.csv(paste0(year, ".csv"))
  
  # 將讀取的資料存入data_list中
  data_list[[year]] <- data
}

# 將結果存儲在環境中已有的list物件results中
results$data_list <- data_list

library(purrr)
library(dplyr)

# 使用imap()函數向每個DataFrame添加"學年度"欄位
data_list <- imap(data_list, ~ mutate(.x, 學年度 = as.integer(gsub("\\D", "", .y))))
# 將結果存儲在環境中已有的list物件results中
results$data_list_with_year <- data_list

# 垂直合併data_list中的每個DataFrame
combined_data <- bind_rows(data_list)

# 將結果存儲在環境中已有的list物件results中
results$combined_data <- combined_data


############################

library(tidyverse)

# 將資料長寬轉換
combined_data_long <- combined_data %>%
  pivot_longer(cols = c("在學學生人數_博士班", "在學學生人數_碩士班", "在學學生人數_學士班"),
               names_to = "學制", 
               values_to = "在學學生人數") %>%
  mutate(學制 = gsub("在學學生人數_", "", 學制))

# 繪製分組條形圖
ggplot(combined_data_long, aes(x = 學年度, y = 在學學生人數, fill = 學制)) +
  geom_bar(position = "fill", stat = "identity") +
  labs(x = "學年度", y = "在學學生人數占比", fill = "學制") +
  theme_minimal()

# 將繪圖結果存入results
results$enrollment_ratio <- last_plot()