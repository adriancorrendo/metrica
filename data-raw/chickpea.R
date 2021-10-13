# load required packages ----
if (!require("pacman")) install.packages("pacman") 
pacman::p_load(usethis, here)

# clean data ----
chickpea <- read.csv(here::here("data-raw","chickpea.csv"),
                    sep = ',', header = TRUE)

chickpea <- as.data.frame(chickpea)

# write data in correct format to data folder ----
usethis::use_data(chickpea, overwrite = TRUE)
