%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  RmaBackgroundCorrection.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{RmaBackgroundCorrection}
\docType{class}
\alias{RmaBackgroundCorrection}


\title{The RmaBackgroundCorrection class}

\description{
 Package:  aroma.affymetrix \cr
\bold{Class RmaBackgroundCorrection}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[aroma.core]{ParametersInterface}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{\link[aroma.core]{AromaTransform}}\cr
\code{~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~+--}\code{\link[aroma.affymetrix]{Transform}}\cr
\code{~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~+--}\code{\link[aroma.affymetrix]{ProbeLevelTransform}}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~+--}\code{\link[aroma.affymetrix]{BackgroundCorrection}}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~+--}\code{RmaBackgroundCorrection}\cr

\bold{Directly known subclasses:}\cr
\cr

public static class \bold{RmaBackgroundCorrection}\cr
extends \emph{\link[aroma.affymetrix]{BackgroundCorrection}}\cr



 This class represents the RMA background adjustment function.

}

\usage{
RmaBackgroundCorrection(..., addJitter=FALSE, jitterSd=0.2, seed=6022007)
}

\arguments{
  \item{...}{Arguments passed to the constructor of
    \code{\link{BackgroundCorrection}}.}
  \item{addJitter}{If \code{\link[base:logical]{TRUE}}, Zero-mean gaussian noise is added to the
    signals before being background corrected.}
  \item{jitterSd}{Standard deviation of the jitter noise added.}
  \item{seed}{An (optional) \code{\link[base]{integer}} specifying a temporary random seed
    to be used for generating the (optional) jitter.  The random seed
    is set to its original state when done.  If \code{\link[base]{NULL}}, it is not set.}
}

\section{Fields and Methods}{
 \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{process} \tab  -\cr
}


 \bold{Methods inherited from BackgroundCorrection}:\cr
getParameters, process

 \bold{Methods inherited from ProbeLevelTransform}:\cr
getRootPath

 \bold{Methods inherited from Transform}:\cr
getOutputDataSet, getOutputFiles

 \bold{Methods inherited from AromaTransform}:\cr
as.character, findFilesTodo, getAsteriskTags, getExpectedOutputFiles, getExpectedOutputFullnames, getFullName, getInputDataSet, getName, getOutputDataSet, getOutputDataSet0, getOutputFiles, getPath, getRootPath, getTags, isDone, process, setTags

 \bold{Methods inherited from ParametersInterface}:\cr
getParameterSets, getParameters, getParametersAsString

 \bold{Methods inherited from Object}:\cr
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach, equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstantiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis


}

\section{Jitter noise}{
  The fitting algorithm of the RMA background correction model may not
  converge if there too many small and discrete signals.  To overcome
  this problem, a small amount of noise may be added to the signals
  before fitting the model.  This is an ad hoc solution that seems to
  work.
  However, add Gaussian noise may generate non-positive signals.
}

\details{
  Internally \code{\link[affy]{bg.adjust}} is used to background correct the
  probe signals.  The default is to background correct PM signals only.
}

\author{Ken Simpson, Henrik Bengtsson}
\keyword{classes}
