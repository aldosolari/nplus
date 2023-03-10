% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/nplus_pvalue.R
\name{nplus_pvalue}
\alias{nplus_pvalue}
\title{Shortcut for computing the p-values f_v for the null hypotheses n+(I) = v, v = 0,...,|I|.}
\usage{
nplus_pvalue(p_right_tail, method = "Fisher", ix = 1:length(p_right_tail))
}
\arguments{
\item{p_right_tail}{vector of p-values for the null hypotheses H_i: theta_i <= 0, i = 1,...,n}

\item{method}{combining function specification. Default is Fisher's combination method}

\item{ix}{vector of indices for the coordinates of theta = (theta_1,...,theta_n) of interest. If missing, all coordinates}
}
\value{
p-values f_v, v=0,...,|I|
}
\description{
Shortcut for computing the p-values f_v for the null hypotheses n+(I) = v, v = 0,...,|I|.
}
\examples{
# generate right-tailed p-values
set.seed(123)
x <- rnorm(50, mean = c(rep(2, 25), rep(-2, 25)))
p <- pnorm(x, lower.tail = FALSE)
res <- nplus_pvalue(p)
res
}
