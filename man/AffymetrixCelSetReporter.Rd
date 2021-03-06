%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  AffymetrixCelSetReporter.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{AffymetrixCelSetReporter}
\docType{class}
\alias{AffymetrixCelSetReporter}


\title{The AffymetrixCelSetReporter class}

\description{
 Package:  aroma.affymetrix \cr
\bold{Class AffymetrixCelSetReporter}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[aroma.affymetrix]{GenericReporter}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{\link[aroma.affymetrix]{AffymetrixFileSetReporter}}\cr
\code{~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~+--}\emph{\code{AffymetrixCelSetReporter}}\cr

\bold{Directly known subclasses:}\cr
\emph{\link[aroma.affymetrix]{SpatialReporter}}\cr

public abstract static class \bold{AffymetrixCelSetReporter}\cr
extends \emph{\link[aroma.affymetrix]{AffymetrixFileSetReporter}}\cr


}

\usage{
AffymetrixCelSetReporter(..., .setClass="AffymetrixCelSet")
}

\arguments{
  \item{...}{Arguments passed to \code{\link{AffymetrixFileSetReporter}}.}
  \item{.setClass}{The name of the class of the input set.}
}

\section{Fields and Methods}{
 \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{getDataSet} \tab  -\cr
}


 \bold{Methods inherited from AffymetrixFileSetReporter}:\cr
getFileSet, getInputName, getInputTags

 \bold{Methods inherited from GenericReporter}:\cr
as.character, getAlias, getAsteriskTags, getFullName, getInputName, getInputTags, getMainPath, getName, getPath, getReportSet, getRootPath, getTags, process, setAlias, setup

 \bold{Methods inherited from Object}:\cr
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clearLookupCache, clone, detach, equals, extend, finalize, getEnvironment, getFieldModifier, getFieldModifiers, getFields, getInstantiationTime, getStaticInstance, hasField, hashCode, ll, load, names, objectSize, print, save, asThis


}

\author{Henrik Bengtsson}
\keyword{classes}
