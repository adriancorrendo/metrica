# load required packages ----
if (!require("pacman")) install.packages("pacman") 
pacman::p_load(usethis, here)

# clean data ----
sorghum <- read.csv(here::here("data-raw","sorghum.csv"),
                   sep = ',', header = TRUE)

sorghum <- as.data.frame(sorghum)

# write data in correct format to data folder ----
usethis::use_data(sorghum, overwrite = TRUE)

