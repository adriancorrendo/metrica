#' @title import.apsim
#' @description Function to read/import *.out files and display them as data frames.
#' @param filepath Argument to specify the location path to the *.out file.
#' @return Element of class `data.frame`.
#' @details This function will generate a data frame from an APSIM Classic *.out file.
#' @examples 
#' \dontrun{
#' # Example out from apsimx package repo (by F. Miguez)
#' path <- ##
#' apsim.out <- import.apsim(filepath = path)
#' }
#' @rdname import.apsim
#' @importFrom utils read.delim
#' @export 

import.apsim <- function(filepath){
  uppersection <- utils::read.delim(filepath, sep = "",skip = 2,nrows = 1)
  
  COLNAMES <- colnames(uppersection)
  UNITY <- unlist(lapply(uppersection, as.character))
  HEADER <- mapply(function(x,y){paste(x,y)},COLNAMES,UNITY, SIMPLIFY = FALSE)
  
  
  dataframe <- utils::read.delim(filepath,sep = "",skip = 3,na.strings = c("?"),dec = ".")
  colnames(dataframe) <- HEADER
  
  return(dataframe)
}
