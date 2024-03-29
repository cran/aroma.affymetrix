###########################################################################/**
# @RdocClass CnPlm
#
# @title "The CnPlm class"
#
# \description{
#  @classhierarchy
#
#  This support class represents a @see "SnpPlm" specially designed for
#  copy-number analysis.
# }
#
# @synopsis
#
# \arguments{
#   \item{...}{Arguments passed to @see "SnpPlm".}
# }
#
# \section{Methods}{
#  @allmethods "public"
# }
#
# \details{
#   Models implementing this copy-number PLM, provides either
#   allele-specific or total copy-number estimates.
#   For allele-specific CNs the underlying @see "SnpPlm" model is fitted as
#   is, i.e. for each allele separately with or without the strands first
#   being merged.
#
#   For total CNs the probe signals for the two alleles are combined
#   (=summed; not averaged) on the intensity scale before fitting
#   underlying @see "SnpPlm" model, again with or without the strands
#   first being merged.
# }
#
# \section{Requirements}{
#   Classes inheriting from this @see "R.oo::Interface" must provide the
#   following fields, in addition to the ones according to @see "SnpPlm":
#   \describe{
#    \item{combineAlleles}{A @logical indicating if total or allele-specific
#      copy numbers should be estimated according to the above averaging.}
#   }
# }
#
# @author "HB"
#*/###########################################################################
setConstructorS3("CnPlm", function(...) {
  extend(SnpPlm(...), "CnPlm")
})


setMethodS3("getParameters", "CnPlm", function(this, ...) {
  params <- NextMethod("getParameters")
  params$combineAlleles <- this$combineAlleles
  params
}, protected=TRUE)


setMethodS3("getCellIndices", "CnPlm", function(this, ...) {
  cells <- NextMethod("getCellIndices")

  # If combining alleles, still return all groups as is.
  # The summing is taken care of by the fitUnit() function.

  cells
})



## setMethodS3("getSubname", "CnPlm", function(this, ...) {
##   s <- NextMethod("getSubname")
##   if (this$combineAlleles) {
##     s <- sprintf("%sTotal", s)
##   } else {
##     s <- sprintf("%sAllelic", s)
##   }
##   s
## }, private=TRUE)


setMethodS3("getFitUnitFunction", "CnPlm", function(this, ...) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Select fit function
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Total copy number of not?
  if (this$combineAlleles) {
    # Get the fit function for a single set of intensities
    fitfcn <- getFitUnitGroupFunction(this, ...)

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # Create the one for all blocks in a unit
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    if (this$probeModel == "pm-mm") {
      # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      # (combineAlleles=TRUE, probeModel="pm-mm")
      # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      fitUnit <- function(groups, ...) {
        ngroups <- length(groups)
        if (ngroups == 2) {
          yA <- .subset2(.subset2(groups, 1), 1)
          yB <- .subset2(.subset2(groups, 2), 1)
          y <- yA + yB
          y <- y[1,,] - y[2,,];  # PM-MM
          list(fitfcn(y))
        } else if (ngroups == 4) {
          yA1 <- .subset2(.subset2(groups, 1), 1)
          yB1 <- .subset2(.subset2(groups, 2), 1)
          yA2 <- .subset2(.subset2(groups, 3), 1)
          yB2 <- .subset2(.subset2(groups, 4), 1)
          y1 <- yA1 + yB1
          y2 <- yA2 + yB2
          y1 <- y1[1,,] - y1[2,,];  # PM-MM
          y2 <- y2[1,,] - y2[2,,];  # PM-MM
          list(
            fitfcn(y1),
            fitfcn(y2)
          )
        } else if (ngroups == 6) {
          yA1 <- .subset2(.subset2(groups, 1), 1)
          yB1 <- .subset2(.subset2(groups, 2), 1)
          yA2 <- .subset2(.subset2(groups, 3), 1)
          yB2 <- .subset2(.subset2(groups, 4), 1)
          yA3 <- .subset2(.subset2(groups, 5), 1)
          yB3 <- .subset2(.subset2(groups, 6), 1)
          y1 <- yA1 + yB1
          y2 <- yA2 + yB2
          y3 <- yA3 + yB3
          y1 <- y1[1,,] - y1[2,,];  # PM-MM
          y2 <- y2[1,,] - y2[2,,];  # PM-MM
          y3 <- y3[1,,] - y3[2,,];  # PM-MM
          list(
            fitfcn(y1),
            fitfcn(y2),
            fitfcn(y3)
          )
        } else {
          # For all other cases, fit each group individually
          lapply(groups, FUN=function(group) {
            y <- .subset2(group, 1)
            y <- y[1,,] - y[2,,];  # PM-MM
            fitfcn(y)
          })
        }
      } # fitUnit()
    } else if (this$probeModel == "min1(pm-mm)") {
      # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      # (combineAlleles=TRUE, probeModel="min1(pm-mm)")
      # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      fitUnit <- function(groups, ...) {
        ngroups <- length(groups)
        if (ngroups == 2) {
          yA <- .subset2(.subset2(groups, 1), 1)
          yB <- .subset2(.subset2(groups, 2), 1)
          y <- yA + yB
          y <- y[1,,] - y[2,,];  # PM-MM
          y[y < 1] <- 1;         # min1(PM-MM)=min(PM-MM,1)
          list(fitfcn(y))
        } else if (ngroups == 4) {
          yA1 <- .subset2(.subset2(groups, 1), 1)
          yB1 <- .subset2(.subset2(groups, 2), 1)
          yA2 <- .subset2(.subset2(groups, 3), 1)
          yB2 <- .subset2(.subset2(groups, 4), 1)
          y1 <- yA1 + yB1
          y2 <- yA2 + yB2
          y1 <- y1[1,,] - y1[2,,];  # PM-MM
          y2 <- y2[1,,] - y2[2,,];  # PM-MM
          y1[y1 < 1] <- 1;          # min1(PM-MM)=min(PM-MM,1)
          y2[y2 < 1] <- 1;          # min1(PM-MM)=min(PM-MM,1)
          list(
            fitfcn(y1),
            fitfcn(y2)
          )
        } else if (ngroups == 6) {
          yA1 <- .subset2(.subset2(groups, 1), 1)
          yB1 <- .subset2(.subset2(groups, 2), 1)
          yA2 <- .subset2(.subset2(groups, 3), 1)
          yB2 <- .subset2(.subset2(groups, 4), 1)
          yA3 <- .subset2(.subset2(groups, 5), 1)
          yB3 <- .subset2(.subset2(groups, 6), 1)
          y1 <- yA1 + yB1
          y2 <- yA2 + yB2
          y3 <- yA3 + yB3
          y1 <- y1[1,,] - y1[2,,];  # PM-MM
          y2 <- y2[1,,] - y2[2,,];  # PM-MM
          y3 <- y3[1,,] - y3[2,,];  # PM-MM
          y1[y1 < 1] <- 1;          # min1(PM-MM)=min(PM-MM,1)
          y2[y2 < 1] <- 1;          # min1(PM-MM)=min(PM-MM,1)
          y3[y3 < 1] <- 1;          # min1(PM-MM)=min(PM-MM,1)
          list(
            fitfcn(y1),
            fitfcn(y2),
            fitfcn(y3)
          )
        } else {
          # For all other cases, fit each group individually
          lapply(groups, FUN=function(group) {
            y <- .subset2(group, 1)
            y <- y[1,,] - y[2,,];  # PM-MM
            y[y < 1] <- 1;         # min1(PM-MM)=min(PM-MM,1)
            fitfcn(y)
          })
        }
      } # fitUnit()
    } else if (this$probeModel == "pm+mm") {
      # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      # (combineAlleles=TRUE, probeModel="pm+mm")
      # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      fitUnit <- function(groups, ...) {
        ngroups <- length(groups)
        if (ngroups == 2) {
          yA <- .subset2(.subset2(groups, 1), 1)
          yB <- .subset2(.subset2(groups, 2), 1)
          y <- yA + yB
          y <- y[1,,] + y[2,,];  # PM+MM
          list(fitfcn(y))
        } else if (ngroups == 4) {
          yA1 <- .subset2(.subset2(groups, 1), 1)
          yB1 <- .subset2(.subset2(groups, 2), 1)
          yA2 <- .subset2(.subset2(groups, 3), 1)
          yB2 <- .subset2(.subset2(groups, 4), 1)
          y1 <- yA1 + yB1
          y2 <- yA2 + yB2
          y1 <- y1[1,,] + y1[2,,];  # PM+MM
          y2 <- y2[1,,] + y2[2,,];  # PM+MM
          list(
            fitfcn(y1),
            fitfcn(y2)
          )
        } else if (ngroups == 6) {
          yA1 <- .subset2(.subset2(groups, 1), 1)
          yB1 <- .subset2(.subset2(groups, 2), 1)
          yA2 <- .subset2(.subset2(groups, 3), 1)
          yB2 <- .subset2(.subset2(groups, 4), 1)
          yA3 <- .subset2(.subset2(groups, 5), 1)
          yB3 <- .subset2(.subset2(groups, 6), 1)
          y1 <- yA1 + yB1
          y2 <- yA2 + yB2
          y3 <- yA3 + yB3
          y1 <- y1[1,,] + y1[2,,];  # PM+MM
          y2 <- y2[1,,] + y2[2,,];  # PM+MM
          y3 <- y3[1,,] + y3[2,,];  # PM+MM
          list(
            fitfcn(y1),
            fitfcn(y2),
            fitfcn(y3)
          )
        } else {
          # For all other cases, fit each group individually
          lapply(groups, FUN=function(group) {
            y <- .subset2(group, 1)
            y <- y[1,,] + y[2,,];  # PM+MM
            fitfcn(y)
          })
        }
      } # fitUnit()
    } else {
      # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      # (combineAlleles=TRUE, probeModel="pm" or "mm")
      # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      fitUnit <- function(groups, ...) {
        ngroups <- length(groups)
        if (ngroups == 2) {
          yA <- .subset2(.subset2(groups, 1), 1)
          yB <- .subset2(.subset2(groups, 2), 1)
          y <- yA + yB
          list(fitfcn(y))
        } else if (ngroups == 4) {
          yA1 <- .subset2(.subset2(groups, 1), 1)
          yB1 <- .subset2(.subset2(groups, 2), 1)
          yA2 <- .subset2(.subset2(groups, 3), 1)
          yB2 <- .subset2(.subset2(groups, 4), 1)
          y1 <- yA1 + yB1
          y2 <- yA2 + yB2
          list(
            fitfcn(y1),
            fitfcn(y2)
          )
        } else if (ngroups == 6) {
          yA1 <- .subset2(.subset2(groups, 1), 1)
          yB1 <- .subset2(.subset2(groups, 2), 1)
          yA2 <- .subset2(.subset2(groups, 3), 1)
          yB2 <- .subset2(.subset2(groups, 4), 1)
          yA3 <- .subset2(.subset2(groups, 5), 1)
          yB3 <- .subset2(.subset2(groups, 6), 1)
          y1 <- yA1 + yB1
          y2 <- yA2 + yB2
          y3 <- yA3 + yB3
          list(
            fitfcn(y1),
            fitfcn(y2),
            fitfcn(y3)
          )
        } else {
          # For all other cases, fit each group individually
          lapply(groups, FUN=function(group) {
            y <- .subset2(group, 1)
            fitfcn(y)
          })
        }
      } # fitUnit()
    } # if (this$probeModel == ...)
  } else {
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # (combineAlleles=FALSE, probeModel=*)
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    fitUnit <- NextMethod("getFitUnitFunction")
  }

  fitUnit
}, private=TRUE)


setMethodS3("getChipEffectSetClass", "CnPlm", function(this, ...) {
  CnChipEffectSet
}, private=TRUE)


setMethodS3("getChipEffectSet", "CnPlm", function(this, ...) {
  ces <- NextMethod("getChipEffectSet")
  setCombineAlleles(ces, this$combineAlleles)
  ces
})

setMethodS3("getProbeAffinityFile", "CnPlm", function(this, ..., .class=CnProbeAffinityFile) {
  paf <- NextMethod("getProbeAffinityFile", .class=.class)
  setCombineAlleles(paf, this$combineAlleles)
  paf
})

setMethodS3("getCombineAlleles", "CnPlm", function(this, ...) {
  this$combineAlleles
})

setMethodS3("setCombineAlleles", "CnPlm", function(this, status, ...) {
  # Argument 'status':
  status <- Arguments$getLogical(status)

  oldStatus <- getCombineAlleles(this)

  ces <- getChipEffectSet(this)
  setCombineAlleles(ces, status, ...)
  paf <- getProbeAffinityFile(this)
  setCombineAlleles(paf, status, ...)
  this$combineAlleles <- status

  invisible(oldStatus)
})
