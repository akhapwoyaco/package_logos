

# LOGO DATA ---------------------------------------------------------------
#
# swissexchangedata::newsboard_data(firstDate = '2023-10-10', lastDate = '2023-10-13') -> mm
# #
# mm_original <- mm
# # extract text and table from newsText through apply
# newsText_column_index <- grep("newsText", colnames(mm))
# #
# mm$data <- apply(
#   X = mm[,newsText_column_index,drop=FALSE],
#   MARGIN = 1, simplify = T,
#   FUN = itemlist_newsText_clean)
# #
# mm$table_data <- apply(
#   X = mm[,newsText_column_index,drop=FALSE],
#   MARGIN = 1, simplify = F,
#   FUN = itemlist_newsText_table_clean)
# #
# mm$table_data[[1]]
#
# logo_data <- rbind.data.frame(
#   (mm[[16]][[1]])[[1]][[1]]
#   ,(mm[[16]][[2]])[[1]][[1]]
#   ,(mm[[16]][[3]])[[1]][[1]]
#   ,(mm[[16]][[4]])[[1]][[1]]
# )
# logo_data
# #
# write.csv(logo_data, 'logo_data.csv', row.names = F)

#
#
library(hexSticker)
library(here)
library(readr)
library(ggplot2)
library(gridExtra)
# INtell CORP DATA from startdate to October 13th Adjusted closing prices
INTC <- read_csv(
  "INTC(2).csv",
  col_types = cols(
    Date = col_date(format = "%Y-%m-%d"),
    Open  = col_skip(), High = col_skip(),
    Low = col_skip(), Close  = col_skip(),
    Volume = col_skip()))
# logo data obtained from NEWBOARDS
logo_data <- read_csv(
  "logo_data.csv",
  col_types = cols(
    `Trade Date` = col_date(format = "%d.%m.%Y")))
# #View(logo_data)
# #
subplot <- INTC |>
  ggplot(aes(x = Date, y = `Adj Close`)) +
  geom_area(fill = 'royalblue1') +
  annotation_custom(
    tableGrob(logo_data, rows = NULL,
              theme = ttheme_minimal(
                base_size = 6,
                base_colour = "blue",
                parse = FALSE,
                padding = unit(c(2, 2), "mm"))),
    xmin=6500, xmax=11500, ymin=35, ymax=60) +
  theme_void()
subplot
# #
# #
# # Create Sticker:
sticker(subplot = subplot,                         # Subplot
        s_x = 1,                            # Subplot x coordinate
        s_y = 1.1,                         # Subplot y coordinate
        s_width = 1.2,                      # Subplot width
        s_height = 0.7,                       # Subplot height
        package = "swissexchangedata", # Text
        p_size = 16,                        # Text size
        p_color = "#FFFFFF",                # Text color
        p_y = 0.7,                         # Text y coordinate
        h_fill = "#000000",                 # Hex background color
        h_size = 3,                         # Hex border size
        h_color = "#BB7351",                # Hex border color
        dpi = 500,
        filename =  "logo_swissexchangedata.png")
          # here(
          # "logo", "logo_swissexchangedata.png"))

#
# RDATA files in swissexchangedata\inst\ directory
# save(INTC, logo_data, file = ".\\inst\\extdata\\INTC_logo_data.RData")
#

#
