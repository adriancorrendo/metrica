#' @title Distance Correlation
#' @description It estimates the Distance Correlation coefficient (dcorr) for 
#' a continuous predicted-observed dataset.
#' @param data (Optional) argument to call an existing data frame containing the
#'  data.
#' @param obs Vector with observed values (numeric).
#' @param pred Vector with predicted values (numeric).
#' @param tidy logical operator (TRUE/FALSE) to decide the type of return. TRUE 
#' returns a data.frame, FALSE returns a list (default).
#' @param na.rm Logic argument to remove rows with missing values 
#' (NA). Default is na.rm = TRUE.
#' @return an object of class `numeric`.
#' @details The \strong{dcorr} function is a wrapper for the \code{dcor} function 
#' from the \strong{energy}-package. See Rizzo & Szekely (2022).
#'  
#' The distance correlation (dcorr) coefficient is a novel measure of dependence 
#' between random vectors introduced by Szekely et al. (2007). For all distributions 
#' with finite first moments, distance correlation \eqn{\mathcal R}{R} generalizes 
#' the idea of correlation in two fundamental ways:
#' 
#' (1) \eqn{\mathcal R(X,Y)}{R(X,Y)} is defined for \eqn{X} and \eqn{Y} in arbitrary 
#' dimension.
#' 
#' (2) \eqn{\mathcal R(X,Y)=0}{R(X,Y)=0} characterizes independence of \eqn{X} and 
#' \eqn{Y}.
#' 
#' Distance correlation satisfies \eqn{0 \le \mathcal R \le 1}{0 \le R \le 1}, and 
#' \eqn{\mathcal R = 0}{R = 0} only if \eqn{X} and \eqn{Y} are independent. Distance 
#' covariance \eqn{\mathcal V}{V} provides a new approach to the problem of 
#' testing the joint independence of random vectors. The formal definitions of the
#' population coefficients \eqn{\mathcal V}{V} and 
#' \eqn{\mathcal R}{R} are given in Szekely et al. (2007). 
#' 
#' The empirical distance correlation \eqn{\mathcal{R}_n(\mathbf{X,Y})}{R(\mathbf{X,Y})} is 
#' the square root of 
#' \deqn{ \mathcal{R}^2_n(\mathbf{X,Y})= \frac {\mathcal{V}^2_n(\mathbf{X,Y})} 
#' {\sqrt{ \mathcal{V}^2_n (\mathbf{X}) \mathcal{V}^2_n(\mathbf{Y})}}. }
#'  
#' For more details, see [online-documentation](https://adriancorrendo.github.io/metrica/articles/available_metrics.html)
#' and the [energy-package](https://CRAN.R-project.org/package=energy)
#' 
#' @examples 
#' \donttest{
#' set.seed(1)
#' X <- rnorm(n = 100, mean = 0, sd = 10)
#' Y <- X + rnorm(n=100, mean = 0, sd = 3)
#' dcorr(obs = X, pred = Y)
#' }
#' @references 
#' Szekely, G.J., Rizzo, M.L., and Bakirov, N.K. (2007).
#' _Measuring and testing dependence by correaltion of distances. Annals of Statistics, Vol. 35(6): 2769-2794_.
#' \doi{10.1214/009053607000000505}.\cr
#' 
#' Rizzo, M., and Szekely, G. (2022). 
#' \emph{energy: E-Statistics: Multivariate Inference via the Energy of Data. R package version 1.7-10},
#' \url{https://CRAN.R-project.org/package=energy}.\cr
#' 
#' @seealso 
#'  \code{\link[rlang]{eval_tidy}}, \code{\link[rlang]{defusing-advanced}}
#'  \code{\link[energy]{dcor}}, \code{\link[energy]{energy}}
#' @rdname dcorr
#' @export 
#' @importFrom rlang eval_tidy quo
#' @importFrom energy dcor
dcorr <- function(data = NULL, obs,  pred, tidy = FALSE, na.rm = TRUE) {
  result <- rlang::eval_tidy(
    data = data,
    rlang::quo(
      energy::dcor(x = {{obs}},
                   y = {{pred}})) )
  # Tidy = FALSE
  if (tidy == FALSE) { return(result) }
  # Tidy = TRUE
  if (tidy == TRUE) { return(as.data.frame(list("dcorr" = result) ) ) }
}
