#' @title Shortcut for computing the lower and upper bounds for n+ by using the partitioning principle
#'
#' @param p_right_tail vector of p-values for the null hypotheses H_i: theta_i <= 0, i = 1,...,n
#' @param method combining function specification. Default is Fisher's combination method
#' @param alpha The significance level of the test procedure. Default is 0.05
#'
#' @return (1-alpha)-confidence lower and upper bounds for n+
#' @export
#'
#' @examples
#' # generate right-tailed p-values
#' set.seed(123)
#' x <- rnorm(50, mean = c(rep(2, 25), rep(-2, 25)))
#' p <- pnorm(x, lower.tail = FALSE)
#' res <- nplus_bound(p)
#' res

nplus_bound = function(p_right_tail, method="Fisher", alpha=0.05){

  if (method == "Fisher")   p_combi_test <- function(x) { pchisq(sum(-2*log(x)), df=2*length(x), lower.tail = F)  }
  if (method == "Simes")    p_combi_test <- function(x) { min(sort(x)*length(x)/(1:length(x))) }
  if (method == "ALRT")     p_combi_test <- function(x) { pchisq( sum((qnorm(x/2, lower.tail = FALSE))^2), df=length(x), lower.tail = F)  }
  if (method == "ASimes")   p_combi_test <- function(x) { ifelse(min(x)<=0.5, ifelse(length(x) < 3, 1, (sum(x>.5)+1)/(length(x)*0.5) ) * min(sort(x)*length(x)/(1:length(x))),1)  }

  p <- p_right_tail
  n <- length(p)
  S <- which(p <= 0.5)
  s <- length(S)
  Sc <- setdiff(1:n,S)

  A <- sort(2*p[S], decreasing = TRUE)
  B <- sort(2*(1-p[Sc]), decreasing = TRUE)

  f_k <- as.list(rep(1,n+1))

  if ( s > 0 ){
    for (k in 0:(s-1)){

      f_k[[k+1]] <- max(
        sapply( 0:(min(k,n-s)), function(v)
        p_combi_test( c(A[0:(s-k+v)],B[0:v]) )
      ))

      if (f_k[[k+1]] > alpha){ break }

    }
  }

  if (s < n) {

    for (k in n:(s+1)){

      f_k[[k+1]] <- max(
        sapply( 0:(min(k,n-s)-(k-s)), function(v)
        p_combi_test( c(B[0:(k-s+v)],A[0:v]) )
      ))

      if (f_k[[k+1]] > alpha){ break }

    }

  }

  bounds <- range(which(f_k > alpha)) - 1
  return(list(lo = bounds[1], up = bounds[2]))
}


