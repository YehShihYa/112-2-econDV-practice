library(tibble)
library(shinyjs)
library(ggnewscale)
# Create example data
example_data <- tibble(
  Year = rep(1998:2023, each = 3),
  Department = rep(c("Department A", "Department B", "Department C"), times = 26),
  Foreign_Student_Share = c(
    # Department A
    0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5, 0.55, 0.6, 0.65, 0.7, 0.75,
    0.8, 0.85, 0.9, 0.95, 0.95, 0.95, 0.95, 0.95, 0.95, 0.95, 0.95, 0.95, 0.95, 0.96,
    # Department B
    0.1, 0.12, 0.15, 0.18, 0.2, 0.22, 0.25, 0.28, 0.3, 0.32, 0.35, 0.38,
    0.4, 0.42, 0.45, 0.48, 0.5, 0.52, 0.55, 0.58, 0.6, 0.62, 0.65, 0.68, 0.7, 0.7,
    # Department C
    0.3, 0.28, 0.25, 0.22, 0.2, 0.18, 0.15, 0.12, 0.1, 0.08, 0.05, 0.02,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  )
)

glimpse(head(example_data,3))

colorspace::choose_palette(gui="shiny")
colorspace::qualitative_hcl(n = 7, h = c(0, 360), c = 35, l = 85, register = "Custom-Palette")

# Load the package
library(ggplot2)

# Create a data frame with the data points
data <- data.frame(
  Year = c(2000, 2002, 2004, 2006, 2008, 2010, 2012, 2014, 2016, 2018, 2020),
  Microsoft = c(0.51, 0.28, 0.30, 0.29, 0.23, 0.22, 0.24, 0.31, 0.51, 0.78, 1.24),
  Alphabet = c(NA, NA, NA, NA, NA, NA, NA, 0.20, 0.50, 0.73, 1.02),
  Apple = c(NA, NA, NA, NA, NA, 0.35, 0.55, 0.64, 0.62, 0.85, 1.39),
  Facebook = c(NA, NA, NA, NA, NA, NA, NA, 0.18, 0.35, 0.51, 0.77),
  Amazon = c(NA, NA, NA, NA, NA, 0.06, 0.10, 0.15, 0.36, 0.80, 1.57)
)

# Create the line plot
a<-ggplot(data, aes(x = Year)) +
  geom_line(aes(y = Microsoft, color = "Microsoft"), size = 1) +
  geom_line(aes(y = Alphabet, color = "Alphabet"), size = 1) +
  geom_line(aes(y = Apple, color = "Apple"), size = 1) +
  geom_line(aes(y = Facebook, color = "Facebook"), size = 1) +
  geom_line(aes(y = Amazon, color = "Amazon"), size = 1) +
  scale_y_continuous(limits = c(0, 1.6), breaks = seq(0, 1.6, 0.2)) +
  scale_x_continuous(breaks = seq(2000, 2020, 2)) +
  labs(x = "Year", y = "Market capitalisation ($trn)", title = "Trillion-dollar tech") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_color_manual(values = c("Microsoft" = "cyan", "Alphabet" = "red", "Apple" = "black", "Facebook" = "blue", "Amazon" = "green"))

######################################
