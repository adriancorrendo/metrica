# metrica 2.0.2 

* This is a minor update fixing bugs of the package v2.0.1. 

## Maintainer's comments on NOTES (1):

i - Found the following files/directories:
    'lastMiKTeXException'
  
This note only appeared for the rhub::Windows Server 2022, R-devel, and does not seem to represent a problem.

#########################################################################

## 1. Local R CMD (--as-cran = TRUE) check results ───────── metrica 2.0.2 ────

Duration: 1m 5s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔

R CMD check succeeded

> sessionInfo()
R version 4.2.1 (2022-06-23 ucrt)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows 11 x64, version 22H2, OS build 22621.1265

##############################################################################

## 2. WIN-DEVEL. Results devtools::check_win_devel()

Build log: https://win-builder.r-project.org/fRrt6yci0oEH/

Status: OK

##############################################################################

## 3. R-hub check, results from devtools::check_rhub()

## Test environments

- R-hub Windows Server 2022, R-devel, 64 bit, build log:
https://builder.r-hub.io/status/metrica_2.0.2.tar.gz-752293e692dd4dc4aa9b7ee49ef51364

- R-hub Ubuntu Linux 20.04.1 LTS, R-release, GCC, build log:
https://builder.r-hub.io/status/metrica_2.0.2.tar.gz-c5bc7096ecbf40bfb0873e4e26fadb8d

- R-hub Fedora Linux, R-devel, clang, gfortran, build log:
https://builder.r-hub.io/status/metrica_2.0.2.tar.gz-10e1f465207b482bbf83e3c5c8fd359e

## SUMMARY

── metrica 2.0.2: NOTE

  Build ID:   metrica_2.0.2.tar.gz-752293e692dd4dc4aa9b7ee49ef51364
  Platform:   Windows Server 2022, R-devel, 64 bit
  Submitted:  7m 17.5s ago
  Build time: 5m 33.2s

❯ checking HTML version of manual ... [13s] NOTE
  

❯ checking for detritus in the temp directory ... NOTE
    'lastMiKTeXException'

0 errors ✔ | 0 warnings ✔ | 2 notes ✖

── metrica 2.0.2: IN-PROGRESS

  Build ID:   metrica_2.0.2.tar.gz-c5bc7096ecbf40bfb0873e4e26fadb8d
  Platform:   Ubuntu Linux 20.04.1 LTS, R-release, GCC
  Submitted:  7m 17.5s ago


── metrica 2.0.2: IN-PROGRESS

  Build ID:   metrica_2.0.2.tar.gz-10e1f465207b482bbf83e3c5c8fd359e
  Platform:   Fedora Linux, R-devel, clang, gfortran
  Submitted:  7m 17.5s ago

