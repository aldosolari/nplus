#' @title Shortcut for determining the index set of positive and nonpositive parameters with FWER control at level alpha
#'
#' @param p_right_tail vector of p-values for the null hypotheses H_i: theta_i <= 0, i = 1,...,n
#' @param method combining function specification. Default is Fisher's combination method
#' @param alpha The significance level of the test procedure. Default is 0.05
#'
#' @return index set of positive parameters (i.e. i: theta_i > 0) and nonpositive parameters (i.e. i: theta_i <= 0) with FWER control at level alpha
#' @export
#'
#' @examples
#' # generate right-tailed p-values
#' set.seed(123)
#' x <- rnorm(50, mean = c(rep(2, 25), rep(-2, 25)))
#' p <- pnorm(x, lower.tail = FALSE)
#' res <- nplus_fwer(p)
#' res

nplus_fwer = function(p_right_tail, method="Fisher", alpha = 0.05){

  if (method == "Fisher")   p_combi_test <- function(x) { pchisq(sum(-2*log(x)), df=2*length(x), lower.tail = F)  }
  if (method == "Simes")    p_combi_test <- function(x) { min(sort(x)*length(x)/(1:length(x))) }
  if (method == "ALRT")     p_combi_test <- function(x) { pchisq( sum((qnorm(x/2, lower.tail = FALSE))^2), df=length(x), lower.tail = F)  }
  if (method == "ASimes")   p_combi_test <- function(x) { ifelse(min(x)<=0.5, ifelse(length(x) < 3, 1, (sum(x>.5)+1)/(length(x)*0.5) ) * min(sort(x)*length(x)/(1:length(x))),1)  }

  p <- p_right_tail
  n <- length(p)
  S <- which(p <= 0.5)
  Sc <- setdiff(1:n,S)
  s = length(S)

  R1 <- R2 <- 0

  ix1 <- which( 2*p <= alpha )

  if (length(ix1)>0){
    R1 <- rep(1,length=length(ix1))

    for (i in 1:length(ix1)){
      A <- sort(2*p[setdiff(S,ix1[i])], decreasing = TRUE)
      B <- sort(2*(1-p[Sc]), decreasing = TRUE)
      for (u in 0:(n-1)){
        for (j in max(0,u-s+1):min(u,n-s)){
          R1[i] <- p_combi_test( c(2*p[ix1[i]], A[0:(j-u+s-1)], B[0:j]) ) <= alpha
          if (R1[i]==0){ break }
        }
        if (R1[i]==0){ break }
      }
    }
  }

  ix2 <- which( 2*(1-p) <= alpha )

  if (length(ix2)>0){

    R2 <- rep(1,length=length(ix2))

    for (i in 1:length(ix2)){
      A <- sort(2*p[S], decreasing = TRUE)
      B <- sort(2*(1-p[setdiff(Sc,ix2[i])]), decreasing = TRUE)
      for (u in 0:(n-1)){
        for (j in max(0,u-s):min(u,n-s-1)){
          R2[i] <- p_combi_test( c(2*(1-p[ix2[i]]), A[0:(j-u+s)], B[0:j]) ) <= alpha
          if (R2[i]==0){ break }
        }
        if (R2[i]==0){ break }
      }
    }

  }

  R_ix1 <- ix1[R1==1]
  R_ix2 <- ix2[R2==1]

  return(list(positive = R_ix1, nonpositive = R_ix2))
}


