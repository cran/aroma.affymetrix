if (interactive()) savehistory();
library("aroma.affymetrix");

verbose <- Arguments$getVerbose(-10, timestamp=TRUE);


dataSet <- "Affymetrix-HeartBrain";
chipType <- "MoEx-1_0-st-v1";

cdf <- AffymetrixCdfFile$byChipType(chipType, tags="coreR1,A20080718,MR");
print(cdf);

data <- getProbeSequenceData(cdf, verbose=verbose);
str(data);

