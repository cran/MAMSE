\name{roc}
\alias{roc}
\alias{plot.roc}
\encoding{UTF-8}
\title{Receiver Operating Characteristic (ROC) Curves}
\description{Computes the ROC curve (nonparametric or parametric based on likelihood) for single populations or a weighted ROC curve for lists of populations. The MAMSE weights are used by default for the multiple populations case.}
\usage{roc(healthy, diseased, wh=NULL, wd=NULL, FPR=NULL, method="np", 
   smalldiseased=TRUE, AUC=FALSE, nFPR=201)}
\arguments{
  \item{healthy}{A single numeric vector with the values of the diagnostic variable for the healthy group, or a list of \code{m} samples (each a numeric vector) from healthy subjects from different populations. When relevant (when MAMSE weights are used), the first sample (\code{healthy[[1]]}) is deemed to come from the population of interest and the \code{m-1} other samples are used to borrow strength.}
  \item{diseased}{A single numeric vector with the values of the diagnostic variable for the diseased group, or a list of \code{m} samples (each a numeric vector) from diseased subjects from different populations. The number of populations in \code{healthy} and \code{diseased} must match, and it is assumed that they are presented in the same order (i.e. the \code{j^{th}} element of both lists are from the same population. When relevant (when MAMSE weights are used), the first sample (\code{healthy[[1]]}) is deemed to come from the population of interest and the \code{m-1} other samples are used to borrow strength.}
  \item{wh}{Weights for the healthy population. If healthy is a vector, \code{wh} is a numeric vector of the same length that sums to one and if \code{wh} is \code{NULL}, equal weights are given to each datum. If healthy is a list, \code{wh} is a numeric vector of length \code{m} that sums to one and if \code{wh} is \code{NULL}, MAMSE weights are calculated.}
  \item{wd}{Weights for the diseased population. If healthy is a vector, \code{wd} is a numeric vector of the same length that sums to one and if \code{wd} is \code{NULL}, equal weights are given to each datum. If healthy is a list, \code{wh} is a numeric vector of length \code{m} that sums to one and if \code{wh} is \code{NULL}, MAMSE weights are calculated.}
  \item{FPR}{Numeric vector giving the values of \code{FPR} (the x-axis) where the ROC curve should be computed. If \code{FPR} is \code{NULL}, the default is to keep every step in the nonparametric settings, or to split the \code{[0,1]} interval in \code{nFPR} steps (keeping both 0 and 1).}
  \item{method}{Allowed values are \code{"np"} for nonparametric ROC curves, \code{"lognormal"} for a parametric curve based on the log-normal distribution or \code{"normal"} for a parametric curve based on the normal distribution. In the parametric cases, plug-in estimates are used with the (possibly weighted) likelihood.}
  \item{smalldiseased}{By default, it is assumed that diseased subjects tend to have smaller values than healthy ones, but \code{smalldiseased=FALSE} can be used when diseased present large values of the diagnostic variable.}
  \item{AUC}{If \code{AUC=TRUE}, the Area Under the Curve will be calculated and returned. Note that AUC will not be calculated if a manually provided \code{FPR} does not start at 0 and end at 1.}
  \item{nFPR}{If \code{FPR} is not provided in the parametric setting, it will be generated with equal steps between 0 and 1  (including those bounds).}
  }
\details{This function returns the ROC curve based on the provided data sets. The method can be either parametric (normal or log-normal) or nonparametric. Multiple samples can be used and weighted. MAMSE weights are used by default. The first sample appearing in the lists of data is then deemed to come from the population of interest. The function returns a list of point (FPR,TPR) that can be plotted to see the ROC curve. The points where the function is evaluated can be controlled by specifying FPR manually. By default, it is assumed that small values of the diagnostic variable indicate a disease, but the option \code{smalldiseased} can be used if small values are for healthy subjects.
}

\value{S3 object of type \code{roc} which is a list with the values TPR (vector with true positive rates for different thresholds), FPR (false positive rate for the corresponding threshold) and AUC (Area under the ROC curve). A method for plot has been defined for easier display (see exemples below).}

\seealso{
\link{MAMSE-package}, \link{MAMSE}.
}

\examples{
data(Progesterone)
healthy=lapply(Progesterone,function(x){x$viable})
diseased=lapply(Progesterone,function(x){sort(c(x$ecto,x$abort))})

par(mfrow=c(2,2))

plot(roc(healthy[[1]],diseased[[1]],AUC=TRUE))
title("Empirical ROC curve based on Ledger (1994)")
plot(roc(healthy[[1]],diseased[[1]],AUC=TRUE,method="lognormal"))
title("Parametric ROC curve based on Ledger (1994)")

plot(roc(healthy,diseased,AUC=TRUE))
title("MAMSE-weighted empirical ROC curve")
plot(roc(healthy,diseased,AUC=TRUE,method="lognormal"))
title("MAMSE-weighted parametric ROC curve")

}

\references{
J.-B. Débordès & J.-F. Plante (2009). Combining ROC curves using MAMSE weighted distributions.
\emph{Cahier du GERAD G-2015-69}. 
}

\keyword{nonparametric}
\keyword{ROC}
\keyword{diagnostic}
