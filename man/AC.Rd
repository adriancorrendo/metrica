% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/reg_AC.R
\name{AC}
\alias{AC}
\title{Ji and Gallo's Agreement Coefficient (AC)}
\usage{
AC(data = NULL, obs, pred, tidy = FALSE, na.rm = TRUE)
}
\arguments{
\item{data}{(Optional) argument to call an existing data frame containing the data.}

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
It estimates the agreement coefficient suggested by Ji & Gallo (2006)
for a continuous predicted-observed dataset.
}
\details{
The Ji and Gallo's AC measures general agreement, including both accuracy and precision.
It is normalized, dimensionless, positively bounded (-infinity;1), and symmetric.
For the formula and more details, see \href{https://adriancorrendo.github.io/metrica/articles/available_metrics_regression.html}{online-documentation}
}
\examples{
\donttest{
set.seed(1)
X <- rnorm(n = 100, mean = 0, sd = 10)
Y <- rnorm(n = 100, mean = 0, sd = 9)
df <- data.frame(obs = X, pred = Y)
AC(df, obs = X, pred = Y)
}
}
\references{
Ji & Gallo (2006). An agreement coefficient for image comparison.
\emph{Photogramm. Eng. Remote Sensing 7, 823–833} \doi{10.14358/PERS.72.7.823}
}
