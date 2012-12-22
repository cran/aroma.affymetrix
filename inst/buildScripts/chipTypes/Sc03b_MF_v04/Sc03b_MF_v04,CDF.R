library("aroma.affymetrix");
 
chipType <- "Sc03b_MF_v04";

filename <- sprintf("%s.bpmap", chipType);
path <- file.path("annotationData", "chipTypes", chipType, "Affymetrix");
pathname <- file.path(path, filename);

res <- bpmapCluster2Cdf(pathname, chipType=chipType, verbose=-20);

