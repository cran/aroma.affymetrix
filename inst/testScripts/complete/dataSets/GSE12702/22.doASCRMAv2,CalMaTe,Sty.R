##########################################################################
# Allele-specific CRMAv2
##########################################################################
future::plan("multiprocess")
library("aroma.affymetrix")
library("calmate")
verbose <- Arguments$getVerbose(-8, timestamp=TRUE)


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Setup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
dataSet <- "GSE12702"
chipType <- "Mapping250K_Sty"

csR <- AffymetrixCelSet$byName(dataSet, chipType=chipType)
print(csR)


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# AS-CRMAv2
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
dsNList <- doASCRMAv2(csR, verbose=verbose)
print(dsNList)

dsN <- exportAromaUnitPscnBinarySet(dsNList)
print(dsN)


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# CalMaTe
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
cmt <- CalMaTeCalibration(dsNList)
print(cmt)
  
dsCList <- process(cmt, verbose=verbose)
print(dsCList)
  
dsC <- exportAromaUnitPscnBinarySet(dsCList)
print(dsC)
