# metrica 1.2.3 

* This is a re-submission after feedback received from CRAN submission of v1.2.2 (SHA: 903b8af799731f71330827c9b45516596dec5bf5)

## 1. Author comment's on NOTES:
All possibly misspelled words listed are correctly spelled. 
The first 4 (CCC, KGE, NSE, RAC) are abbreviations of performance metrics.
The words "efficiencies", and "indices" are correct as well.

As for the possibly invalid URLs: they are all derived from "\doi{}". I double checked 
the links using different computers, but I just found them properly working, and 
always linked to "https" protocol. There is probably an issue related to server end.

#########################################################################

## 2. Local R CMD check results 

0 errors v | 0 warnings v | 0 notes v

R CMD check succeeded

## Results R-hub check, devtools::check_rhub()

## 3. Test environments
- R-hub windows-x86_64-devel (r-devel)
https://builder.r-hub.io/status/metrica_1.2.3.tar.gz-0e0293e081ce4ce28fba5716f312a8bc
- R-hub fedora-clang-devel (r-devel)
https://builder.r-hub.io/status/metrica_1.2.3.tar.gz-d3ff1224045042aeb4ce9a208e296f78
- R-hub ubuntu-gcc-release (r-release)
https://builder.r-hub.io/status/metrica_1.2.3.tar.gz-0713e7690e344cb68f74af9a1fc3abf9

## R CMD check results
> On windows-x86_64-devel (r-devel), ubuntu-gcc-release (r-release), fedora-clang-devel (r-devel)
  checking CRAN incoming feasibility ... NOTE
  Maintainer: 'Adrian A. Correndo <correndo@ksu.edu>'
  
  New submission
  
  Possibly misspelled words in DESCRIPTION:
    CCC (14:388)
    KGE (14:286)
    NSE (14:281)
    RAC (14:322)
    efficiencies (14:262)
    indices (14:292)
  
  Found the following (possibly) invalid URLs:
    URL: https://doi.org/10.1002/1521-4036(200203)44:2<161::AID-BIMJ161>3.0.CO;2-N
      From: man/B0_sma.Rd
            man/B1_sma.Rd
      Status: 503
      Message: Service Unavailable
    URL: https://doi.org/10.1002/joc.2419
      From: man/d1r.Rd
      Status: 503
      Message: Service Unavailable
    URL: https://doi.org/10.1029/1998WR900018
      From: man/E1.Rd
      Status: 503
      Message: Service Unavailable
    URL: https://doi.org/10.1029/jc090ic05p08995
      From: man/d1.Rd
      Status: 503
      Message: Service Unavailable
    URL: https://doi.org/10.13031/2013.23153
      From: man/RSR.Rd
      Status: Error
      Message: libcurl error code 35:
        	schannel: failed to receive handshake, SSL/TLS connection failed
    URL: https://doi.org/10.2134/agronj2000.922345x
      From: man/LCS.Rd
            man/SB.Rd
            man/SDSD.Rd
      Status: 503
      Message: Service Unavailable

> On windows-x86_64-devel (r-devel)
  checking for detritus in the temp directory ... NOTE
  Found the following files/directories:
    'lastMiKTeXException'

0 errors √ | 0 warnings √ | 2 notes x

####################################################################

## 4. WIN_DEVEL check with devtools::check_win_devel() results

Report: https://win-builder.r-project.org/vXQEOkrcn1sp/00check.log

### Results

R CMD check succeeded

New submission

Possibly misspelled words in DESCRIPTION:
  CCC (14:388)
  KGE (14:286)
  NSE (14:281)
  RAC (14:322)
  RMSE (14:249)

Found the following (possibly) invalid URLs:
  URL: https://doi.org/10.1002/1521-4036(200203)44:2<161::AID-BIMJ161>3.0.CO;2-N
    From: man/B0_sma.Rd
          man/B1_sma.Rd
    Status: 503
    Message: Service Unavailable
  URL: https://doi.org/10.1002/joc.2419
    From: man/d1r.Rd
    Status: 503
    Message: Service Unavailable
  URL: https://doi.org/10.1029/1998WR900018
    From: man/E1.Rd
    Status: 503
    Message: Service Unavailable
  URL: https://doi.org/10.1029/jc090ic05p08995
    From: man/d1.Rd
    Status: 503
    Message: Service Unavailable
  URL: https://doi.org/10.2134/agronj2000.922345x
    From: man/LCS.Rd
          man/SB.Rd
          man/SDSD.Rd
    Status: 503
    Message: Service Unavailable
  URL: https://doi.org/10.2307/2088760
    From: man/RAC.Rd
    Status: 403
    Message: Forbidden
  URL: https://doi.org/10.2307/2089382
    From: man/RAC.Rd
    Status: 403
    Message: Forbidden
  URL: https://doi.org/10.2307/2532051
    From: man/CCC.Rd
          man/Xa.Rd
    Status: 403
    Message: Forbidden

Status: 1 NOTE