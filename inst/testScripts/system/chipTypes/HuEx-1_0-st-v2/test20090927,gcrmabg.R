if (interactive()) savehistory();
library("aroma.affymetrix");

verbose <- Arguments$getVerbose(-10, timestamp=TRUE);


dataSet <- "Affymetrix-HeartBrain";
chipType <- "HuEx-1_0-st-v2";

cdf <- AffymetrixCdfFile$byChipType(chipType, tags="Ensembl,exon");
print(cdf);

csR <- AffymetrixCelSet$byName(dataSet, chipType=chipType);
print(csR);

bc <- GcRmaBackgroundCorrection(csR, type="affinities");
print(bc);
csB <- process(bc, verbose=verbose);
print(csB);

