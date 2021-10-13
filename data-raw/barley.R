# load required packages ----
if (!require("pacman")) install.packages("pacman") 
pacman::p_load(usethis, here)

# clean data ----
barley <- read.csv(here::here("data-raw","barley.csv"),
                  sep = ',', header = TRUE)

barley <- as.data.frame(barley)

# write data in correct format to data folder ----
usethis::use_data(barley, overwrite = TRUE)
