#找出Python路徑並創造虛擬環境
library(reticulate)
py_config()
use_python("C:/Users/USER/OneDrive/文件/.virtualenvs/econDV/Scripts/python.exe")
virtualenv_create(envname = "econDV", python = "C:/Users/USER/OneDrive/文件/.virtualenvs/econDV2/Scripts/python.exe")
virtualenv_install("econDV", packages = c("numpy", "pandas"))

py_install("openai")
py_install("openai", python = "C:/Users/USER/OneDrive/文件/.virtualenvs/econDV/Scripts/python.exe")
import("openai")




# 安装并加载 reticulate 包
library(reticulate)

# 使用 Python 运行代码
use_python("C:/Users/USER/OneDrive/文件/.virtualenvs/econDV2/Scripts/python.exe")  # 使用系统默认的 Python 解释器，或者指定路径来使用特定的 Python 解释器

# 安装并加载所需的 Python 库
py_install("opencv-python")
py_install("matplotlib")
py_install("numpy")

# 加载所需的 Python 库
cv <- import("cv2")
np <- import("numpy")
plt <- import("matplotlib.pyplot")

# 读取图像文件
img <- cv$imread("C:/Users/USER/Videos/Captures/看看這些《經濟學人》圖表設計師也會犯的設計錯誤，超有用! - 數據分析那些事 - Medium - Google Chrome 2024_3_26 下午 01_39_27.png")

# 显示原始图像和处理后的图像
plt$subplot(1, 2, 1)$imshow(img)
plt$title("Original Image")
plt$subplot(1, 2, 2)$imshow(gray_img, cmap="gray")
plt$title("Grayscale Image")
plt$show()
