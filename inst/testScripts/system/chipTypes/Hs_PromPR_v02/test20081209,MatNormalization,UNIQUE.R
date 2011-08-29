library("aroma.affymetrix");
verbose <- Arguments$getVerbose(-20, timestamp=TRUE);


## dataSet <- "MNtest";
## chipType <- "Hs_PromPR_v02,Harvard,ROIs";

dataSet <- "E-MEXP-1481";
chipType <- "Hs_PromPR_v02";

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Setup the tiling array data set
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
cdf <- AffymetrixCdfFile$byChipType(chipType);
print(cdf);

csR <- AffymetrixCelSet$byName(dataSet, cdf=cdf);
print(csR);


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Normalize the data using the MAT model
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
mn <- MatNormalization(csR);
csM <- process(mn, verbose=more(verbose, 30));


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Convert data set such that it maps to the "unique" CDF
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Get the "unique" CDF, which is generated if missing
cdfU <- getUniqueCdf(cdf, verbose=more(verbose, 60));
print(cdfU);

# Note that the "unique" CDF has the same units as the main CDF.
stopifnot(nbrOfUnits(cdfU) == nbrOfUnits(cdf));
# stopifnot(nbrOfCells(cdfU) >= nbrOfCells(cdf));

csU <- convertToUnique(csM, verbose=verbose);
print(csU);


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Assert that these "unique" estimates are identical at the unit level
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
csList <- list(csM, csU);
for (aa in seq(csU)) {
  yList <- lapply(csList, FUN=function(cs) {
    cf <- getFile(csM, aa);
    cdf <- getCdf(cf);
    units <- indexOf(cdf, "^chr1F");
    cells <- getCellIndices(cdf, units=units, stratifyBy="pm", 
                                            unlist=TRUE, useNames=FALSE); 
    y <- extractMatrix(cf, drop=TRUE);
    y;
  })
  stopifnot(all.equal(yList[[1]], yList[[2]]));
  rm(yList);
}
