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

Build log: https://win-builder.r-project.org/qLRecSwZfLQT/

Status: OK

##############################################################################

## 3. R-hub check, results from devtools::check_rhub()

## Test environments

── metrica 2.0.1: NOTE

  Build ID:   metrica_2.0.1.tar.gz-cddad00116384bfe8374f5e0222ab4a6
  Platform:   Windows Server 2022, R-devel, 64 bit
  Submitted:  28m 58s ago
  Build time: 7m 59.6s

❯ checking for detritus in the temp directory ... NOTE
  Found the following files/directories:
    'lastMiKTeXException'

0 errors ✔ | 0 warnings ✔ | 1 note ✖

── metrica 2.0.1: OK

  Build ID:   metrica_2.0.1.tar.gz-1bf5dd3e5aaf432286a28e77368835ee
  Platform:   Ubuntu Linux 20.04.1 LTS, R-release, GCC
  Submitted:  28m 58s ago
  Build time: 27m 21.4s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔

── metrica 2.0.1: OK

  Build ID:   metrica_2.0.1.tar.gz-3a7e79c144b74f3db218c7495e2cf5fa
  Platform:   Fedora Linux, R-devel, clang, gfortran
  Submitted:  28m 58s ago
  Build time: 27m 58.2s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔

── metrica 2.0.1: OK

  Build ID:   metrica_2.0.1.tar.gz-ab17ac63da134bffaa77f571fa694d0d
  Platform:   Apple Silicon (M1), macOS 11.6 Big Sur, R-release
  Submitted:  28m 58s ago
  Build time: 1m 20s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔

── metrica 2.0.1: OK

  Build ID:   metrica_2.0.1.tar.gz-cdc84b2cf7574c25b84eeae3614b0c5f
  Platform:   macOS 10.13.6 High Sierra, R-release, CRAN's setup
  Submitted:  28m 58s ago
  Build time: 1m 51.1s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔

####################################################################

