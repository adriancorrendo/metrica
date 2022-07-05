# metrica 2.0.0 

* This is a major update of the package. Precedent version (v1.2.3)

## Author comment's on NOTES:

Potential misspelled words are not actually misspelled:

- "APSIM, DNDC, & DSSAT" stand for three different crop-soil simulation models
- "MASE, MBE, & dcorr" are acronyms for error metrics
- "multinomial" is a common denomination for models with multiple classes as potential output.

#########################################################################

## 1. Local R CMD check results ──────────────────────────── metrica 2.0.0 ────
Duration: 1m 6.3s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔

R CMD check succeeded

> sessionInfo()
R version 4.2.0 (2022-04-22 ucrt)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows 10 x64 (build 22000)

Matrix products: default

locale:
[1] LC_COLLATE=English_United States.utf8  LC_CTYPE=English_United States.utf8   
[3] LC_MONETARY=English_United States.utf8 LC_NUMERIC=C                          
[5] LC_TIME=English_United States.utf8    

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] metrica_2.0.0

##############################################################################

## 2. WIN-DEVEL. Results devtools::check_win_devel()

Build log: https://win-builder.r-project.org/0f1N2Trvfddi/

Status: 1 NOTE*

## 3. WIN_OLD-RELEASE: Results devtools::check_win_oldrelease()

Build log: https://win-builder.r-project.org/5N6tHA97WF37/

Status: 1 NOTE*

*Possibly misspelled words in DESCRIPTION:
  APSIM (15:237)
  DNDC (15:251)
  DSSAT (15:244)
  MASE (15:742)
  MBE (15:427)
  dcorr (15:648)
  multinomial (15:809)


##############################################################################

# 3. R-hub check, results from devtools::check_rhub()

## Test environments

── metrica 2.0.0: OK
https://builder.r-hub.io/status/metrica_2.0.0.tar.gz-9627b1e3a68145cabc4f95f14474e2aa

  Build ID:   metrica_2.0.0.tar.gz-9627b1e3a68145cabc4f95f14474e2aa
  Platform:   Apple Silicon (M1), macOS 11.6 Big Sur, R-release
  Submitted:  13m 11.3s ago
  Build time: 1m 7.9s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔

── metrica 2.0.0: OK
https://builder.r-hub.io/status/metrica_2.0.0.tar.gz-75833cbaf296433e9addbbbff81bd89e

  Build ID:   metrica_2.0.0.tar.gz-75833cbaf296433e9addbbbff81bd89e
  Platform:   macOS 10.13.6 High Sierra, R-release, CRAN's setup
  Submitted:  13m 11.3s ago
  Build time: 1m 36.1s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔

- R-hub windows-x86_64-devel (r-devel)
Awaiting for r-hub to fix check_for_cran()

- R-hub fedora-clang-devel (r-devel)
Awaiting for r-hub to fix check_for_cran()

- R-hub ubuntu-gcc-release (r-release)
Awaiting for r-hub to fix check_for_cran()

## R CMD check results


####################################################################

