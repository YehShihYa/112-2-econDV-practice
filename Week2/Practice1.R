#Install Course-relevant packages
install.packages(c("showtext","extrafont", "remotes")) #為了讓中文能在圖表顯示
remotes::install_github("tpemartin/econDV2", force=T)


#Setup environment
library(ggplot2)
library(showtext)
library(econDV2)

# add google font: Noto Sans TC for chinese characters
sysfonts::font_add_google('Noto Sans TC')

# turn on showing chinese text in graph device
showtext_auto()

# set our graph theme to use the google font and a classic white back ground
theme_set(
  theme(
    text=element_text(family = "Noto Sans TC")
  )+
    theme_classic()
)

# some handy tool to use later through out the class
ggenv=new.env()
ggenv$gg <- list(
  dash = econDV2::ggdash,
  geom = econDV2::ggbrowse,
  aes = econDV2::ggaes
)
attach(ggenv)


sysfonts::font_families()
sysfonts::font_add("QFangsong", regular="C:/Users/USER/AppData/Local/R/cwtex-q-fonts-TTFs-0.42/cwtex-q-fonts-TTFs-0.42/ttf/cwTeXQFangsong-Medium.ttf")
install.packages("styler")
