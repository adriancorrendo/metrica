# load required packages ----
if (!require("pacman")) install.packages("pacman") 
pacman::p_load(usethis, here)

# clean data ----
maize_phenology <- read.csv(here::here("data-raw","multiclass_phenology.csv"),
                            sep = ',', header = TRUE)

maize_phenology <- as.data.frame(maize_phenology)

# write data in correct format to data folder ----
usethis::use_data(maize_phenology, overwrite = TRUE)
