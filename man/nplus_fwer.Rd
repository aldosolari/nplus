% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/nplus_fwer.R
\name{nplus_fwer}
\alias{nplus_fwer}
\title{Shortcut for determining the index set of positive and nonpositive parameters with FWER control at level alpha}
\usage{
nplus_fwer(p_right_tail, method = "Fisher", alpha = 0.05)
}
\arguments{
\item{p_right_tail}{vector of p-values for the null hypotheses H_i: theta_i <= 0, i = 1,...,n}

\item{method}{combining function specification. Default is Fisher's combination method}

\item{alpha}{The significance level of the test procedure. Default is 0.05}
}
\value{
index set of positive parameters (i.e. i: theta_i > 0) and nonpositive parameters (i.e. i: theta_i <= 0) with FWER control at level alpha
}
\description{
Shortcut for determining the index set of positive and nonpositive parameters with FWER control at level alpha
}
\examples{
# generate right-tailed p-values
set.seed(123)
x <- rnorm(50, mean = c(rep(2, 25), rep(-2, 25)))
p <- pnorm(x, lower.tail = FALSE)
res <- nplus_fwer(p)
res
}
