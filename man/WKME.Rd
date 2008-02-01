\name{WKME}
\alias{WKME}
\title{Kaplan-Meier Estimate}
\description{Computes the weighted Kaplan-Meier estimate over some time points
with optional confidence intervals.}
\usage{WKME(x,ub,lb=0,time=NULL,boot=NULL,REP=1000)
}
\arguments{
  \item{x}{A list of \code{m} samples. Each element is an \code{n} by \code{2} matrix whose
  second column is an indicator of whether the
  time in column 1 is observed (1) or censored (0).}
  \item{lb,ub}{Lower and upper bounds of the integral of the MAMSE criterion.}
  \item{time}{A vector of times at which to compute the Kaplan-Meier estimate.}
  \item{boot}{When NULL, bootstrap confidence intervals are not generated. 
  Otherwise must be a number in (0,1)
  corresponding to the coverage probability of the bootstrap intervals 
  to be built.}
  \item{REP}{When bootstrap is used, controls the number of pseudo-sample to
  generate.}  
}
\details{This function calculates the weighted Kaplan-Meier estimate and can
provide pointwise bootstrap confidence intervals.}
\value{List of elements:
\item{x}{Sorted list of the times (observed and censored) from each samples}

\item{weight}{The size of the jump that the Kaplan-Meier estimate allocates to each
time in \code{x}.}

\item{time}{Vector of time points where the function is evaluated.}

\item{kme}{The Kaplan-Meier estimate for Population 1 evaluated at \code{time}.}

\item{kmeCI}{Pointwise bootstrap confidence interval for \code{kme}.}

\item{wkme}{The weighted Kaplan-Meier estimate evaluated at \code{time}.}

\item{wkmeCI}{Pointwise bootstrap confidence interval for \code{wkme}.}
}
\seealso{
\link{MAMSE-package}, \link{WKME}.
}

\references{
J.-F. Plante (2007). \emph{Adaptive Likelihood Weights and Mixtures of Empirical
Distributions}. Unpublished doctoral dissertation, University of British
Columbia.

J.-F. Plante (2009). About an adaptively weighted Kaplan-Meier estimate.
\emph{Lifetime Data Analysis}. Under revision.
}
\examples{
set.seed(2009)
x=list(
  cbind(rexp(20),sample(c(0,1),20,replace=TRUE)),
  cbind(rexp(50),sample(c(0,1),50,replace=TRUE)),
  cbind(rexp(200),sample(c(0,1),200,replace=TRUE))
)

allx=pmin(1,c(x[[1]][x[[1]][,2]==1,1],x[[2]][x[[2]][,2]==1,1],x[[3]][x[[3]][,2]==1,1]))
K=WKME(x,1,time=sort(unique(c(0,1,allx,allx-.0001))),boot=.9)

plot(K$time,K$wkme,type='l',col="blue",xlab="x",ylab="P(X<=x)",ylim=c(0,1))
lines(K$time,K$kme[,1],col="red")

lines(K$time,K$wkmeCI[1,],lty=2,col="blue")
lines(K$time,K$wkmeCI[2,],lty=2,col="blue")

lines(K$time,K$kmeCI[1,],lty=2,col="red")
lines(K$time,K$kmeCI[2,],lty=2,col="red")
legend(.1,.9,c("Weighted Kaplan-Meier","Kaplan-Meier"),col=c("blue","red"),lty=c(1,1))

}
\keyword{nonparametric}
\keyword{survival}
