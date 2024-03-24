# load required packages ----
if (!require("pacman")) install.packages("pacman") 
pacman::p_load(usethis, here)

# clean data ----
land_cover <- read.csv(here::here("data-raw","binary_land_cover.csv"),
                  sep = ',', header = TRUE)

land_cover <- as.data.frame(land_cover)

# write data in correct format to data folder ----
usethis::use_data(land_cover, overwrite = TRUE)


