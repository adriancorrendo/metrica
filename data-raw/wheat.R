# load required packages ----
if (!require("pacman")) install.packages("pacman") 
pacman::p_load(usethis, here)

# clean data ----
wheat <- read.csv(here::here("data-raw","wheat.csv"),
                  sep = ',', header = TRUE)

wheat <- as.data.frame(wheat)

# write data in correct format to data folder ----
usethis::use_data(wheat, overwrite = TRUE)
