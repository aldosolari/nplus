#' @title Shortcut for computing the p-values f_v for the null hypotheses n+(I) = v, v = 0,...,|I|.
#'
#' @param p_right_tail vector of p-values for the null hypotheses H_i: theta_i <= 0, i = 1,...,n
#' @param method combining function specification. Default is Fisher's combination method
#' @param ix vector of indices for the coordinates of theta = (theta_1,...,theta_n) of interest. If missing, all coordinates
#'
#' @return p-values f_v, v=0,...,|I|
#' @export
#'
#' @examples
#' # generate right-tailed p-values
#' set.seed(123)
#' x <- rnorm(50, mean = c(rep(2, 25), rep(-2, 25)))
#' p <- pnorm(x, lower.tail = FALSE)
#' res <- nplus_pvalue(p)
#' res

nplus_pvalue = function(p_right_tail, method="Fisher", ix = 1:length(p_right_tail)){

  if (method == "Fisher")   p_combi_test <- function(x) { pchisq(sum(-2*log(x)), df=2*length(x), lower.tail = F)  }
  if (method == "Simes")    p_combi_test <- function(x) { min(sort(x)*length(x)/(1:length(x))) }
  if (method == "ALRT")     p_combi_test <- function(x) { pchisq( sum((qnorm(x/2, lower.tail = FALSE))^2), df=length(x), lower.tail = F)  }
  if (method == "ASimes")   p_combi_test <- function(x) { ifelse(min(x)<=0.5, ifelse(length(x) < 3, 1, (sum(x>.5)+1)/(length(x)*0.5) ) * min(sort(x)*length(x)/(1:length(x))),1)  }

  p <- p_right_tail
  n <- length(p)
  S <- which(p <= 0.5)
  Sc <- setdiff(1:n,S)
  I <- ix
  Ic <- setdiff(1:n,I)
  A <- sort(2*p[intersect(S,I)], decreasing = TRUE)
  B <- sort(2*p[intersect(S,Ic)], decreasing = TRUE)
  C <- sort(2*(1-p[intersect(Sc,I)]), decreasing = TRUE)
  D <- sort(2*(1-p[intersect(Sc,Ic)]), decreasing = TRUE)
  a <- length(intersect(S,I))
  b <- length(intersect(S,Ic))
  c <- length(intersect(Sc,I))
  d <- length(intersect(Sc,Ic))

  f_v <-
    sapply(0:length(I), function(v)
      max(
        sapply(0:length(Ic), function(u)
          max(sapply(max(0,v-a):min(v,c), function(k)
            max(sapply( max(0,u-b):min(u,d), function(j)
              ifelse( length(c(0:(k-v+a),0:(j-u+b),0:k,0:j))==4, 1,
                      p_combi_test( c(A[0:(k-v+a)],B[0:(j-u+b)],C[0:k],D[0:j]) ) )
            ))
          ))
        ))
    )
  return(f_v)
}
