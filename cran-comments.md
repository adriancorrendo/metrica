# metrica 2.0.1 

* This is a minor update fixing bugs of the package v2.0.0. 

## Maintainer's comments on NOTES:

i - Problems with news in 'NEWS.md':
  Cannot extract version info from the following section titles:
    Previous versions
    
This note appeared using the devtools::check_win_devel (https://win-builder.r-project.org/oz5AIah7zsc4/). However, it does not affect the identification of the current version of the package (v2.0.1). The section "Previous version" contains comments to allow users to see the package progress over time. Moreover, I did not find errors on the version numbers of precedent versions.

ii - Found the following files/directories:
    'lastMiKTeXException'
  
This note only appeared for the rhub::Windows Server 2022, R-devel, and does not seem to mean a problem.

#########################################################################

## 1. Local R CMD (--as-cran = TRUE) check results ───────── metrica 2.0.1 ────
Duration: 1m 7.3s

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
[1] metrica_2.0.1

##############################################################################

## 2. WIN-DEVEL. Results devtools::check_win_devel()

Build log: https://win-builder.r-project.org/oz5AIah7zsc4/

Status: 1 NOTE*

Problems with news in 'NEWS.md':
  Cannot extract version info from the following section titles:
    Previous versions

##############################################################################

## 3. R-hub check, results from devtools::check_rhub()

## Test environments

── metrica 2.0.1: OK

  Build ID:   metrica_2.0.1.tar.gz-d0c1ba623d764e02921cb8fa2b2ff492
  Platform:   Ubuntu Linux 20.04.1 LTS, R-release, GCC
  Submitted:  6m 41s ago
  Build time: 28m 12s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔

── metrica 2.0.1: OK

  Build ID:   metrica_2.0.1.tar.gz-b9fd81b0136b4198b60718026c251ef1
  Platform:   Fedora Linux, R-devel, clang, gfortran
  Submitted:  6m 41s ago
  Build time: 29m 2.7s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔

── metrica 2.0.1: OK

  Build ID:   metrica_2.0.1.tar.gz-71bd1526f5014c039be2f2f5d9ddaa01
  Platform:   Apple Silicon (M1), macOS 11.6 Big Sur, R-release
  Submitted:  6m 41s ago
  Build time: 3m 38.8s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔

── metrica 2.0.1: OK

  Build ID:   metrica_2.0.1.tar.gz-2973b84910a140bd8bb42679fe351982
  Platform:   macOS 10.13.6 High Sierra, R-release, CRAN's setup
  Submitted:  6m 41s ago
  Build time: 2m 9.2s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔

── metrica 2.0.1: NOTE

  Build ID:   metrica_2.0.1.tar.gz-6f55d517dcb34cdeb316f241f7cfe4eb
  Platform:   Windows Server 2022, R-devel, 64 bit
  Submitted:  19m 29.1s ago
  Build time: 12m 57.1s

❯ checking for detritus in the temp directory ... NOTE
  Found the following files/directories:
    'lastMiKTeXException'

0 errors ✔ | 0 warnings ✔ | 1 note ✖

####################################################################

