
<!-- README.md is generated from README.Rmd. Please edit that file -->

# nplus

<!-- badges: start -->
<!-- badges: end -->

nplus is the package developed to provide confidence bounds on the
number of positive parameters on subsets of interest by using the
partitioning principle. Details may be found in Heller and Solari (2023)
\<arXiv:2301.01653\>.

# Installation

The latest version of the package can be installed with:

``` r
devtools::install_github("aldosolari/nplus")
```

# Example

Generate
![X_i \sim N(\theta_i,1)](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;X_i%20%5Csim%20N%28%5Ctheta_i%2C1%29 "X_i \sim N(\theta_i,1)")
with
![\theta_i = 2](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Ctheta_i%20%3D%202 "\theta_i = 2")
for
![i=1,\ldots,25](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;i%3D1%2C%5Cldots%2C25 "i=1,\ldots,25")
and
![\theta_i = -2](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Ctheta_i%20%3D%20-2 "\theta_i = -2")
for
![i=26,\ldots,50](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;i%3D26%2C%5Cldots%2C50 "i=26,\ldots,50").
Let
![n^+](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;n%5E%2B "n^+")
denote the number of positive parameters in the vector
![\theta=(\theta_1,\ldots,\theta_n)](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Ctheta%3D%28%5Ctheta_1%2C%5Cldots%2C%5Ctheta_n%29 "\theta=(\theta_1,\ldots,\theta_n)").
In our simulated data,
![n^+ = 25](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;n%5E%2B%20%3D%2025 "n^+ = 25").

The right-sided
![p](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;p "p")-values
for the null hypotheses
![H_i: \theta_i \leq 0](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;H_i%3A%20%5Ctheta_i%20%5Cleq%200 "H_i: \theta_i \leq 0")
are computed as
![P_i = 1-\Phi(X_i)](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;P_i%20%3D%201-%5CPhi%28X_i%29 "P_i = 1-\Phi(X_i)"),
where
![\Phi](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5CPhi "\Phi")
is the cdf of the standard normal distribution.

``` r
set.seed(123)
x <- rnorm(50, mean = c(rep(2, 25), rep(-2, 25)))
p <- pnorm(x, lower.tail = FALSE)
n <- length(p)
```

To get
![(1-\alpha)](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%281-%5Calpha%29 "(1-\alpha)")-confidence
lower and upper bounds for the number of positive parameters
![n^+](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;n%5E%2B "n^+"):

``` r
library(nplus)
nplus_bound(p, alpha = 0.1)
#> $lo
#> [1] 14
#> 
#> $up
#> [1] 35
```

To get
![p](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;p "p")-values
for the null hypotheses
![n^+=v](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;n%5E%2B%3Dv "n^+=v")
for
![v=0,\ldots,n](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;v%3D0%2C%5Cldots%2Cn "v=0,\ldots,n"):

``` r
res <- nplus_pvalue(p)
res
#>  [1] 2.021188e-14 2.915688e-12 3.073869e-10 1.902482e-08 4.794630e-07
#>  [6] 3.950739e-06 2.200764e-05 1.116684e-04 4.974741e-04 2.002367e-03
#> [11] 5.709003e-03 1.543082e-02 3.837075e-02 6.917452e-02 1.212053e-01
#> [16] 1.757155e-01 2.482393e-01 3.297027e-01 4.348771e-01 5.496902e-01
#> [21] 6.704640e-01 7.986769e-01 8.591563e-01 9.299771e-01 9.869359e-01
#> [26] 9.733693e-01 1.000000e+00 7.951683e-01 7.102403e-01 6.282977e-01
#> [31] 5.547233e-01 4.824313e-01 4.017362e-01 3.096198e-01 2.231691e-01
#> [36] 1.515984e-01 9.354081e-02 4.701387e-02 1.812525e-02 6.595256e-03
#> [41] 1.977698e-03 5.074691e-04 1.246477e-04 2.658206e-05 5.346949e-06
#> [46] 9.457918e-07 1.074061e-07 4.777329e-09 1.932899e-10 5.474822e-12
#> [51] 4.799139e-14
```

Plot of the
![p](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;p "p")-value
function:

``` r
plot(0:n, res, xlab="n+", ylab="p-value")
alpha = 0.1
abline(h = alpha)
segments(x0=min(which(res>alpha))-1, x1=min(which(res>alpha))-1, y0=0, y1=alpha)
segments(x0=max(which(res>alpha))-1, x1=max(which(res>alpha))-1, y0=0, y1=alpha)
```

<img src="man/figures/README-unnamed-chunk-5-1.png" width="100%" />

To get lower and upper bounds for
![n^+](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;n%5E%2B "n^+")
from the
![p](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;p "p")-values:

``` r
range(which(res > alpha)) - 1
#> [1] 14 35
```

Index set of identified positive parameters
(i.e. ![i:\theta_i \>0](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;i%3A%5Ctheta_i%20%3E0 "i:\theta_i >0"))
and negative parameters
(![i:\theta_i \<0](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;i%3A%5Ctheta_i%20%3C0 "i:\theta_i <0"))
with familywise error rate control at level
![\alpha](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Calpha "\alpha"):

``` r
nplus_fwer(p, alpha = 0.1)
#> $positive
#> [1]  3  6 16
#> 
#> $negative
#> [1] 26
```

For any subset
![\mathcal{I} \subset \\{1,\ldots,n\\}](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Cmathcal%7BI%7D%20%5Csubset%20%5C%7B1%2C%5Cldots%2Cn%5C%7D "\mathcal{I} \subset \{1,\ldots,n\}"),
let
![n^+(\mathcal{I})](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;n%5E%2B%28%5Cmathcal%7BI%7D%29 "n^+(\mathcal{I})")
denote the number of positive parameters in the vector
![\theta(\mathcal{I}) = (\theta_i, i\in \mathcal{I})](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Ctheta%28%5Cmathcal%7BI%7D%29%20%3D%20%28%5Ctheta_i%2C%20i%5Cin%20%5Cmathcal%7BI%7D%29 "\theta(\mathcal{I}) = (\theta_i, i\in \mathcal{I})").
In our simulated data,
![n^+(\mathcal{I}) = 25](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;n%5E%2B%28%5Cmathcal%7BI%7D%29%20%3D%2025 "n^+(\mathcal{I}) = 25")
for
![\mathcal{I}=\\{1,2,\ldots,25\\}](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Cmathcal%7BI%7D%3D%5C%7B1%2C2%2C%5Cldots%2C25%5C%7D "\mathcal{I}=\{1,2,\ldots,25\}").

To get
![p](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;p "p")-values
for the null hypotheses
![n^+(\mathcal{I})=v](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;n%5E%2B%28%5Cmathcal%7BI%7D%29%3Dv "n^+(\mathcal{I})=v")
for
![v=0,\ldots,\|\mathcal{I}\|](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;v%3D0%2C%5Cldots%2C%7C%5Cmathcal%7BI%7D%7C "v=0,\ldots,|\mathcal{I}|"):

``` r
I = 1:25
resI <- nplus_pvalue(p, ix = I)
# lower and upper bound for n+(I)
range(which(resI > alpha)) - 1
#> [1] 14 25
```

# References

Heller, R., & Solari, A. (2023). Simultaneous directional inference.
arXiv preprint arXiv:2301.01653.

# Did you find some bugs?

Please write to <solari.aldo@gmail.com>.
