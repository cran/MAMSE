\name{MAMSE}
\alias{MAMSE}
\title{Minimum Averaged Mean Squared Error Weights}
\description{Computes the MAMSE weights (see references below for their definition).}
\usage{MAMSE(x,surv=FALSE,ub=NULL,lb=0,MCint=FALSE,nMC=10000)}
\arguments{
  \item{x}{A list of \code{m} samples. Elements of the list must be vectors of
  matrices. If they are vectors, the univariate MAMSE weights are computed. 
  Matrices should have \code{n} lines with one \code{p}-dimensional datum per line.
  The data are automatically tranformed into rescaled ranks by the function
  \link{ranked}.
  The MAMSE weights for copulas are then calculated. For survival
  MAMSE weights, use the argument \code{surv=TRUE} and
  provide an \code{n} by \code{2} matrix where the second column is an
  indicator (\code{delta}) of whether the time in column 1 is observed (\code{delta=1}) or censored 
  (\code{delta=0}).}
  \item{surv}{Controls the calculation of the survival MAMSE weights rather that
  the multivariate version for copulas.}
  \item{ub}{if \code{surv=TRUE}, the upper bound for the integral of the MAMSE criterion.}
  \item{lb}{If \code{surv=TRUE}, the lower bound for the integral of the MAMSE criterion.}
  \item{MCint}{When MAMSE weights are calculated for copulas, MCint=TRUE allows to proceed with
  Monte Carlo integration. The laternative MCint=TRUE will estimate the integral on the grid \code{[1/n1,2/n1,...,1]^p} which does not scale well with the number of dimensions p.}
\item{nMC}{When \code{MCint=TRUE}, \code{nMC} controls the number of samples used to approximate the integral.}
  }
\details{Provided a list of samples, this function returns the Minimum Averaged
Mean Squared Error weights. The MAMSE weights can be used in a weighted
likelihood, or to define mixtures of
empirical distributions. In both cases, the methodology is used to infer on 
Population 1 while borrowing strength from the other samples provided. 
Refer to the articles
below for the exact definition of the MAMSE weights, their asymptotic properties and 
simulations results, as well as additional information about the weighted likelihood.
}

\value{A vector of \code{p} elements containing the MAMSE weights for each of the
populations.}

\seealso{
\link{MAMSE-package}, \link{WKME}.
}

\examples{
set.seed(2009)

# MAMSE weights for univariate data
x=list(rnorm(25),rnorm(25,.1),rnorm(25,.2))
MAMSE(x)

#MAMSE weights for copulas
y=list(matrix(rnorm(150),nc=2),matrix(rnorm(150),nc=2),
   matrix(rnorm(150),nc=2))
MAMSE(y)
MAMSE(y,MCint=TRUE)

#MAMSE weights for right-censored data
z=list(cbind(rexp(50),rbinom(50,1,.5)),cbind(rexp(50,1.1),
   rbinom(50,1,.5)),cbind(rexp(50,.9),rbinom(50,1,.5)))
MAMSE(z,3,surv=TRUE)

#For more examples, see help on "MAMSE-package"
}

\references{
F. Hu and J. V. Zidek (2002). The weighted likelihood, \emph{The Canadian
Journal of Statistics}, \bold{30}, 347--371.

J.-F. Plante (2007). \emph{Adaptive Likelihood Weights and Mixtures of Empirical
Distributions}. Unpublished doctoral dissertation, University of British
Columbia.

J.-F. Plante (2008). Nonparametric adaptive likelihood weights. \emph{The
Canadian Journal of Statistics}, \bold{36}, 443-461.

J.-F. Plante (2009). Asymptotic properties of the MAMSE adaptive likelihood
weights. \emph{Journal of Statistical Planning and Inference}, \bold{139}, 2147-2161.

J.-F. Plante (2009). About an adaptively weighted Kaplan-Meier estimate.
\emph{Lifetime Data Analysis}, \bold{15}, 295-315. 

X. Wang (2001). \emph{Maximum weighted likelihood estimation}, unpublished
doctoral dissertation, Department of Statistics, The University of British
Columbia. 

}

\keyword{nonparametric}
\keyword{survival}
\keyword{multivariate}
\keyword{univar}
