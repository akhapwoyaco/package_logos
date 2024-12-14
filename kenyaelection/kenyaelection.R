#
library(readxl)
library(janitor)
library(hexSticker)
library(here)
library(readr)
library(ggplot2)
library(gridExtra)
library(tidyr)
library(dplyr)
# data prep
# ALL total data
# ALL <- read_excel("data/ALL.xlsx") |> clean_names() 
# View(ALL)
# #
# logo_data <- ALL |> 
#   filter(county_name == "TOTAL") |> 
#   pivot_longer(
#     registered_voters:rejected_ballots
#   ) |> 
#   mutate(
#     perc = paste(round(100*value/22120458,2), '%', sep = '')
#   )
# logo_data
#
load('kenya_data_logo.rda')
#
subplot <- logo_data |> 
  ggplot(
    aes(y = value, x = reorder(name, value))
  ) + 
  geom_col(aes(fill = name)) +
  geom_text(aes(label = perc), position = position_stack(vjust = .5)) +
  annotation_custom(
    tableGrob(logo_data, rows = NULL,
              theme = ttheme_minimal(
                base_size = 6,
                base_colour = "blue",
                parse = FALSE,
                padding = unit(c(2, 2), "mm"))),
    xmin=6500, xmax=11500, ymin=35, ymax=60) +
  theme_void() + 
  theme(legend.position="none")
subplot  
#
# # Create Sticker:
sticker(subplot = subplot,                         # Subplot
        s_x = 1,                            # Subplot x coordinate
        s_y = 1.1,                         # Subplot y coordinate
        s_width = 1.2,                      # Subplot width
        s_height = 0.7,                       # Subplot height
        package = "kenyaelection", # Text
        p_size = 16,                        # Text size
        p_color = "#FFFFFF",                # Text color
        p_y = 0.7,                         # Text y coordinate
        h_fill = "#000000",                 # Hex background color
        h_size = 3,                         # Hex border size
        h_color = "#BB8300",                # Hex border color
        dpi = 500,
        filename = "logo_kenyaelectiondata.png")
# 
# save(logo_data, file = "kenya_data_logo.rda")
#