% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/reg_MAPE.R
\name{MAPE}
\alias{MAPE}
\title{Mean Absolute Percentage Error (MAPE)}
\usage{
MAPE(data = NULL, obs, pred, tidy = FALSE, na.rm = TRUE)
}
\arguments{
\item{data}{(optional) argument to call an existing data frame containing the data.}

\item{obs}{Vector with observed values (numeric).}

\item{pred}{Vector with predicted values (numeric).}

\item{tidy}{Logical operator (TRUE/FALSE) to decide the type of return. TRUE
returns a data.frame, FALSE returns a list; Default : FALSE.}

\item{na.rm}{Logic argument to remove rows with missing values
(NA). Default is na.rm = TRUE.}
}
\value{
an object of class \code{numeric} within a \code{list} (if tidy = FALSE) or within a
\verb{data frame} (if tidy = TRUE).
}
\description{
It estimates the MAPE of a continuous predicted-observed dataset.
}
\details{
The MAPE is expressed in percentage units (independent scale), which it
makes easy to explain and to compare performance across models with different response variables.
MAPE is asymmetric (sensitive to axis orientation). The lower the better.
As main disadvantage, MAPE produces infinite or undefined values for zero or close-to-zero observed values.
For the formula and more details, see \href{https://adriancorrendo.github.io/metrica/articles/available_metrics_regression.html}{online-documentation}
}
\examples{
\donttest{
set.seed(1)
X <- rnorm(n = 100, mean = 0, sd = 10)
Y <- X + rnorm(n=100, mean = 0, sd = 3)
MAPE(obs = X, pred = Y)
}
}
\references{
Kim & Kim (2016).
A new metric of absolute percentage error for intermittent demand forecast.
_Int. J. Forecast. 32, 669-679._\doi{10.1016/j.ijforecast.2015.12.003}
}
