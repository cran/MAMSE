\name{MAMSE-package}
\alias{MAMSE-package}
\docType{package}
\encoding{UTF-8}
\title{
Minimum Averaged Mean Squared Error (MAMSE) Weights.
}
\description{This package provides algorithms to calculate the nonparametric
adaptive MAMSE weights. The MAMSE weights can be used for the
weighted likelihood (see references below), or as mixing probabilities to define
mixtures of empirical distributions. They provide a framework to borrow strenght
with minimal assumptions.
}
\details{
\tabular{ll}{
Package: \tab MAMSE\cr
Type: \tab Package\cr
Version: \tab 0.2\cr
Date: \tab 2016-01-20\cr
License: \tab GPL-2\cr
}
Function \link{MAMSE} calculates the MAMSE weights for univariate data,
right-censored data, or for the copula underlying the distribution of multivariate
data. The function \link{WKME} is used to compute the MAMSE-weighted
Kaplan-Meier estimate with (optional) bootstrap confidence intervals.
The function \link{roc} calculates MAMSE-weighted ROC curves.
}
\author{Jean-Francois Plante, <jfplante(at)hec.ca>.

Maintainer: Jean-Francois Plante, <jfplante(at)hec.ca>.
}
\references{
J.-B. Débordès & J.-F. Plante (2009). Combining ROC curves using MAMSE weighted distributions.
\emph{Cahier du GERAD G-2015-69}. 

F. Hu and J. V. Zidek (2002). The weighted likelihood, \emph{The Canadian
Journal of Statistics}, \bold{30}, 347--371.

J.-F. Plante (2007). \emph{Adaptive Likelihood Weights and Mixtures of Empirical
Distributions}. Unpublished doctoral dissertation, University of British
Columbia.

J.-F. Plante (2008). Nonparametric adaptive likelihood weights. \emph{The
Canadian Journal of Statistics}, \bold{36}, 443-461.

J.-F. Plante (2009). Asymptotic properties of the MAMSE adaptive likelihood
weights. \emph{Journal of Statistical Planning and Inference}, \bold{139},
2147-2161.  

J.-F. Plante (2009). About an adaptively weighted Kaplan-Meier estimate.
\emph{Lifetime Data Analysis}, \bold{15}, 295-315. 

X. Wang (2001). \emph{Maximum weighted likelihood estimation}, unpublished
doctoral dissertation, Department of Statistics, The University of British
Columbia. 
}
\keyword{package}
\keyword{multivariate}
\keyword{nonparametric}
\keyword{survival}
\keyword{univar}

\seealso{
\link{MAMSE}, \link{WKME}, \link{roc}.
}

\examples{
set.seed(2009)

# MAMSE weights for univariate data
x=list(rnorm(25),rnorm(250,.1),rnorm(100,-.1))
wx=MAMSE(x)

# Weighted Likelihood estimate for the mean (Normal model)
sum(wx*sapply(x,mean))

#MAMSE weights for copulas
rho=c(.25,.3,.15,.2)
r=2*sin(rho*pi/600)
y=list(0,0,0,0)
for(i in 1:4){
  sig=matrix(c(1,r,r,1),2,2)
  y[[i]]=matrix(rnorm(150),nc=2)%*%chol(sig)
}
wy=MAMSE(y)

# Weighted coefficient of correlation
sum(wy*sapply(y,cor,method="spearman")[2,])

#MAMSE weights for right-censored data

z=list(0,0,0)
for(i in 1:3){  
  zo=rexp(100)
  zc=pmin(rexp(100),rexp(100),rexp(100))
  z[[i]]=cbind(pmin(zo,zc),zo<=zc)
}

MAMSE(z,.5,surv=TRUE)

allz=pmin(.5,c(z[[1]][z[[1]][,2]==1,1],z[[2]][z[[2]][,2]==1,1],
   z[[3]][z[[3]][,2]==1,1]))
K=WKME(z,.5,time=sort(unique(c(0,.5,allz,allz-.0001))))
plot(K$time,K$wkme,type='l',col="blue",xlab="x",ylab="P(X<=x)",
   ylim=c(0,.5))
lines(K$time,K$kme[,1],col="red")
legend(0,.5,c("Weighted Kaplan-Meier","Kaplan-Meier"),
   col=c("blue","red"),lty=c(1,1))

# MAMSE-weighted ROC curve

set.seed(2016)
nh=c(50,25,70,100)
nd=c(40,20,50,80)
muh=c(1.5,1,1.7,1.2)
mud=c(0,.2,.5,.4)

# Target curve
FPR=seq(0,1,.01)
TPR=pnorm(qnorm(FPR,mean=muh[1]),mean=mud[1])

simh=list()
simd=list()

for(i in (1:length(nh))){
  simh[[i]]=rnorm(nh[i],mean=muh[i])
  simd[[i]]=rnorm(nd[i],mean=mud[i])
}

par(mfrow=c(1,2))
plot(roc(simh,simd),col="red")
lines(roc(simh[[1]],simd[[1]]),col="blue")
lines(FPR,TPR,col="gray")
title("Empirical ROC curves")

plot(roc(simh,simd,method="normal"),col="red")
lines(roc(simh[[1]],simd[[1]],method="normal"),col="blue")
lines(FPR,TPR,col="gray")
title("Parametric ROC curves")
}
