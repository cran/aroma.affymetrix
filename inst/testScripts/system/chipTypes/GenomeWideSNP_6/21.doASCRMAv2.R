##########################################################################
# Allele-specific CRMAv2
#
# Author: Henrik Bengtsson
# Created on: 2011-11-11
# Last updated: 2012-09-02
##########################################################################
library("aroma.affymetrix")
verbose <- Arguments$getVerbose(-8, timestamp=TRUE)


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
dataSet <- "GSE13372,testset"
chipType <- "GenomeWideSNP_6,Full"

csR <- AffymetrixCelSet$byName(dataSet, chipType=chipType)
print(csR)


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# AS-CRMAv2
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
dsNList <- doASCRMAv2(csR, verbose=verbose)
print(dsNList)
