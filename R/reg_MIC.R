#' @title Maximal Information Coefficient
#' @name MIC
#' @description It estimates the Maximal Information Coefficient (MIC) for 
#' a continuous predicted-observed dataset.
#' @param data (Optional) argument to call an existing data frame containing the data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param tidy logical operator (TRUE/FALSE) to decide the type of return. TRUE 
#' returns a data.frame, FALSE returns a list (default).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric` within a `list` (if tidy = FALSE) or within a
#' `data frame` (if tidy = TRUE).
#' @details The \strong{MIC} function is a wrapper for the \code{mine_stat} function of the
#' \strong{minerva}-package, a collection of Maximal Information-Based Nonparametric statistics (MINE).
#' See Reshef et al. (2011). 
#' 
#' For the predicted-observed case (PO), the \strong{MIC} is defined as follows:
#' \deqn{\textrm{MIC}(D)=\max_{PO<B(n)} M(D)_{X,Y} = \max_{PO<B(n)} \frac{I^ * (D,P,O)} {log(\min{P,O})},}{MIC(D)=max_{PO<B(n)} M(D)_{P,O}=max_{PO<B(n)} I * (D,P,O)/log(min(P,O)),} where
#' \eqn{B(n)=n^{\alpha}} is the search-grid size,
#' \eqn{I^*(D,P,O)}{I*(D,P,O)}
#' is the maximum mutual information over all grids \emph{P-by-O}, of the distribution 
#' induced by D on a grid having \emph{P} and \emph{O} bins (where the probability
#' mass on a cell of the grid is the fraction of points of D falling in that cell).
#' Albanese et al. (2013).
#' 
#' For the formula and more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics_regression.html)
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' MIC(obs = X, pred = Y)
#' }
#' @references 
#' Reshef, D., Reshef, Y., Finucane, H., Grossman, S., McVean, G., Turnbaugh, P.,  
#' Lander, R., Mitzenmacher, M., and Sabeti, P. (2011). Detecting novel associations 
#' in large datasets. 
#' _Science 334, 6062_. \doi{10.1126/science.1205438}. \cr
#' 
#' Albanese, D., M. Filosi, R. Visintainer, S. Riccadonna, G. Jurman, C. Furlanello. 
#' minerva and minepy: a C engine for the MINE suite and its R, Python and MATLAB wrappers. 
#' _Bioinformatics (2013) 29(3):407-408_. \doi{10.1093/bioinformatics/bts707}. \cr
#' @seealso 
#'  \code{\link[rlang]{eval_tidy}}, \code{\link[rlang]{defusing-advanced}}
#'  \code{\link[minerva]{mine_stat}}
#' @rdname MIC
#' @export 
#' @importFrom rlang eval_tidy quo
#' @importFrom minerva mine_stat
MIC <- function(data = NULL, obs,  pred, tidy = FALSE, na.rm = TRUE) {
  MIC <- rlang::eval_tidy(
              data = data,
              rlang::quo(
                minerva::mine_stat(x = {{obs}},
                                   y = {{pred}},
                                   measure = "mic")) )
  # Tidy = FALSE
  if (tidy == FALSE) { return(MIC) }
  # Tidy = TRUE
  if (tidy == TRUE) { return( as.data.frame(MIC) ) }
}
