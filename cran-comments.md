# metrica 2.0.3

* This is a minor update fixing a bug of the package v2.0.2 found on DEBIAN. 

## Maintainer's comments on NOTES (1):

i - Found the following files/directories:
    'lastMiKTeXException'
  
This note only appeared for the rhub::Windows Server 2022, R-devel, and does not seem to represent a problem.

#########################################################################

## 1. Local R CMD check results ───────────────────── metrica 2.0.3 ────
Duration: 1m 24.7s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔

R CMD check succeeded

> sessionInfo()
R version 4.2.1 (2022-06-23 ucrt)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows 11 x64, version 22H2, OS build 22621.1265

##############################################################################

## 2. WIN-DEVEL. Results devtools::check_win_devel()

Build log: https://win-builder.r-project.org/YlDfmXVZ7x6x/

Status: OK

##############################################################################

## 3. R-hub check, results from devtools::check_rhub()

## Test environments

- R-hub Windows Server 2022, R-devel, 64 bit, build log:
https://builder.r-hub.io/status/metrica_2.0.3.tar.gz-e272f183b7db46439ee19fb7e8072c52

- R-hub Ubuntu Linux 20.04.1 LTS, R-release, GCC, build log:
https://builder.r-hub.io/status/metrica_2.0.3.tar.gz-760966edde6647c9aafda6b7fc4ca4a5

- R-hub Fedora Linux, R-devel, clang, gfortran, build log:
https://builder.r-hub.io/status/metrica_2.0.3.tar.gz-70b962a509e44df19b2e952004917e87

## SUMMARY

> checks_metrica

── metrica 2.0.3: NOTE

  Build ID:   metrica_2.0.3.tar.gz-e272f183b7db46439ee19fb7e8072c52
  Platform:   Windows Server 2022, R-devel, 64 bit
  Submitted:  7m 45.7s ago
  Build time: 5m 50.6s

❯ checking HTML version of manual ... [13s] NOTE
  Skipping checking math rendering: package 'V8' unavailable

❯ checking for detritus in the temp directory ... NOTE
  Found the following files/directories:
    'lastMiKTeXException'

0 errors ✔ | 0 warnings ✔ | 2 notes ✖

── metrica 2.0.3: IN-PROGRESS

  Build ID:   metrica_2.0.3.tar.gz-760966edde6647c9aafda6b7fc4ca4a5
  Platform:   Ubuntu Linux 20.04.1 LTS, R-release, GCC
  Submitted:  7m 45.8s ago


── metrica 2.0.3: IN-PROGRESS

  Build ID:   metrica_2.0.3.tar.gz-70b962a509e44df19b2e952004917e87
  Platform:   Fedora Linux, R-devel, clang, gfortran
  Submitted:  7m 45.8s ago
  
------------

> debian_checks

── metrica 2.0.3: NOTE

  Build ID:   metrica_2.0.3.tar.gz-ed449a9f6bc349ad8ac44c3b3c16bd29
  Platform:   Debian Linux, R-devel, clang, ISO-8859-15 locale
  Submitted:  2h 21m 58.5s ago
  Build time: 2h 3m 3.7s

❯ checking HTML version of manual ... [7s/19s] NOTE
  Skipping checking math rendering: package 'V8' unavailable

0 errors ✔ | 0 warnings ✔ | 1 note ✖

── metrica 2.0.3: NOTE

  Build ID:   metrica_2.0.3.tar.gz-91d5bb05697f43418cf2688ec855cbb8
  Platform:   Debian Linux, R-devel, GCC
  Submitted:  2h 21m 58.6s ago
  Build time: 2h 4.5s

❯ checking HTML version of manual ... [6s/26s] NOTE
  Skipping checking math rendering: package 'V8' unavailable

0 errors ✔ | 0 warnings ✔ | 1 note ✖

── metrica 2.0.3: OK

  Build ID:   metrica_2.0.3.tar.gz-b1da016047fa4c47a937a86999c50a1d
  Platform:   Debian Linux, R-patched, GCC
  Submitted:  2h 21m 58.6s ago
  Build time: 2h 7.4s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔

── metrica 2.0.3: OK

  Build ID:   metrica_2.0.3.tar.gz-8afcf34bb9094e93a66991ab574085ea
  Platform:   Debian Linux, R-release, GCC
  Submitted:  2h 21m 58.6s ago
  Build time: 1h 47m 27.6s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔


