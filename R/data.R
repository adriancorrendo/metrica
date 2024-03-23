#' Wheat grain nitrogen
#'
#' @description This example dataset is a set of APSIM simulations of 
#' wheat grain N (grams per squared meter), which presents both high 
#' accuracy and high precision. The experimental trials come from 11 
#' site-years in 4 countries (Australia, Ethiopia, New Zealand, and
#' Turkey). 
#' These data correspond to the latest, up-to-date, documentation and
#' validation of version number 2020.03.27.4956. Data available at:
#' \doi{10.7910/DVN/EJS4M0}. 
#' Further details can be found at the official APSIM Next Generation
#' website:
#' \url{https://APSIMnextgeneration.netlify.app/modeldocumentation/}
#'
#' @format This data frame has 137 rows and the following 2 columns:
#' \describe{
#'   \item{pred}{predicted values}
#'   \item{obs}{observed values}
#' }
#' @source \url{https://github.com/adriancorrendo/metrica}
"wheat"

#' Barley grain number
#'
#' @description This example dataset is a set of APSIM simulations of 
#' barley grain number (x1000 grains per squared meter), which presents high 
#' accuracy but medium precision. The experimental trials come from 11 
#' site-years in 2 countries (Australia, and New Zealand). 
#' These data correspond to the latest, up-to-date, documentation and
#' validation of version number 2020.03.27.4956. Data available at:
#' \doi{10.7910/DVN/EJS4M0}. 
#' Further details can be found at the official APSIM Next Generation
#' website:
#' \url{https://APSIMnextgeneration.netlify.app/modeldocumentation/}
#'
#' @format This data frame has 69 rows and the following 2 columns:
#' \describe{
#'   \item{pred}{predicted values}
#'   \item{obs}{observed values}
#' }
#' @source \url{https://github.com/adriancorrendo/metrica}
"barley"

#' Chickpea dry mass
#'
#' @description This example dataset is a set of APSIM simulations of 
#' chickpea aboveground dry mass (kg per hectare), which exhibits low
#' accuracy and medium-low precision as it represents a model still under
#' development. The experimental trials come from 7 site-years in 
#' 3 countries (Australia, India, and New Zealand). 
#' These data correspond to the latest, up-to-date, documentation and
#' validation of version number 2020.03.27.4956. Data available at:
#' \doi{10.7910/DVN/EJS4M0}. 
#' Further details can be found at the official APSIM Next Generation
#' website:
#' \url{https://APSIMnextgeneration.netlify.app/modeldocumentation/}
#'
#' @format This data frame has 39 rows and the following 2 columns:
#' \describe{
#'   \item{pred}{predicted values}
#'   \item{obs}{observed values}
#' }
#' @source \url{https://github.com/adriancorrendo/metrica}
"chickpea"

#' Sorghum grain number
#'
#' @description This example dataset is a set of APSIM simulations of 
#' sorghum grain number (x1000 grains per squared meter), which exhibits 
#' both low accuracy and low precision as it represents a model still 
#' under development. The experimental trials come from 6 site-years in 
#' 1 country (Australia). 
#' These data correspond to the latest, up-to-date, documentation and
#' validation of version number 2020.03.27.4956. Data available at:
#' \doi{10.7910/DVN/EJS4M0}. 
#' Further details can be found at the official APSIM Next Generation
#' website:
#' \url{https://APSIMnextgeneration.netlify.app/modeldocumentation/}
#'
#' @format This data frame has 36 rows and the following 2 columns:
#' \describe{
#'   \item{pred}{predicted values}
#'   \item{obs}{observed values}
#' }
#' @source \url{https://github.com/adriancorrendo/metrica}
"sorghum"

#' Binary Land Cover Data 
#'
#' @description This example dataset was obtained in 2022 over a small region in Kansas,
#' using visual interpretation.
#' The predicted values were the result of a Random Forest classification, 
#' with a 70/30 % split. 
#' Values equal to 1 are associated to vegetation, and values equal to 0 are other type of land cover. 
#
#' @format This data frame has 284 rows and the following 2 columns:
#' \describe{
#'   \item{predicted}{predicted values}
#'   \item{actual}{observed values}
#' }
#' @source \url{https://github.com/adriancorrendo/metrica}
"land_cover"

#' Multi Class Phenology 
#'
#' @description This example data set includes maize phenology classes collected in Kansas during the 2018 growing season.
#' The predicted values were obtained using a Random Forest classifier with a 70/30 split. 
#' The dataset includes 16 phenology stages from VT to R6.
#' For more information please visit
#' \doi{https://doi.org/10.3390/rs14030469}. 
#' 
#' @format This data frame has 103 rows and the following 2 columns:
#' \describe{
#'   \item{predicted}{predicted values}
#'   \item{actual}{observed values}
#' }
#' @source \url{https://github.com/adriancorrendo/metrica}
"maize_phenology"
