# metrica 2.1.0

* This is an update adding a new classification metric function and fixing minor bugs of the v2.0.3. 

## Maintainer's comments on NOTES (1):

i - Found the following (possibly) invalid URLs:
  URL: https://ciampittilab.shinyapps.io/metrica/

This note only appeared for the check_win_devel(), and does not seem to represent a problem as the URL is legit and corresponds to the Shinyapp that helps users with no R background to use the package.

#########################################################################

## 1. Local R CMD check results ──────────────────────────── metrica 2.1.0 ────
Duration: 42s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔

R CMD check succeeded

> sessionInfo()
R version 4.3.1 (2023-06-16)
Platform: aarch64-apple-darwin20 (64-bit)
Running under: macOS Sonoma 14.3.1

##############################################################################

## 2. WIN-DEVEL. Results devtools::check_win_devel()

Build log: https://win-builder.r-project.org/s3SdrA5R49Hx

Status: 1 NOTE

Found the following (possibly) invalid URLs:
  URL: https://ciampittilab.shinyapps.io/metrica/


##############################################################################

## 3. R-hub checks results from rhub::rhub_check()

## Tested environments

 1 🖥  linux          R-* (any version)     …
 2 🖥  macos          R-* (any version)     …
 3 🖥  macos-arm64    R-* (any version)     …
 4 🖥  windows        R-* (any version)     …

## SUMMARY
### Status: Success

<https://github.com/adriancorrendo/metrica/actions/runs/9732145422>