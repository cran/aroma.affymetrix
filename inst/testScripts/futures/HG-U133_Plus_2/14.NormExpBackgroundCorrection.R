library("aroma.affymetrix")
ovars <- ls(all.names=TRUE)
oplan <- future::plan()

message("*** NormExpBackgroundCorrection ...")

dataSet <- "GSE9890"
chipType <- "HG-U133_Plus_2"
csR <- AffymetrixCelSet$byName(dataSet, chipType=chipType)
csR <- csR[1:3]
print(csR)

cdf <- getCdf(csR)
acs <- getAromaCellSequenceFile(cdf)
print(acs)

strategies <- future:::supportedStrategies()
strategies <- setdiff(strategies, "multiprocess")
if (require("future.BatchJobs")) {
  strategies <- c(strategies, "batchjobs_local")
  if (any(grepl("PBS_", names(Sys.getenv())))) {
    strategies <- c(strategies, "batchjobs_torque")
  }
}
if (require("future.batchtools")) {
  strategies <- c(strategies, "batchtools_local")
  if (any(grepl("PBS_", names(Sys.getenv())))) {
    strategies <- c(strategies, "batchtools_torque")
  }
}

checksum <- NULL

for (strategy in strategies) {
  message(sprintf("*** Using %s futures ...", sQuote(strategy)))

  future::plan(strategy)
  tags <- c("*", strategy)

  message("- NormExpBackgroundCorrection(method='mle') ...")
  bg <- NormExpBackgroundCorrection(csR, method="mle", tags=tags)
  print(bg)
  csB <- process(bg, verbose=verbose)
  print(csB)

  csBz <- getChecksumFileSet(csB)
  print(csBz[[1]])
  checksumT <- readChecksum(csBz[[1]])
  if (is.null(checksum)) checksum <- checksumT
  stopifnot(identical(checksumT, checksum))
  message("- NormExpBackgroundCorrection(method='mle') ... DONE")

  message(sprintf("*** Using %s futures ... DONE", sQuote(strategy)))
}

message("*** NormExpBackgroundCorrection ... DONE")

## CLEANUP
future::plan(oplan)
rm(list=setdiff(ls(all.names=TRUE), ovars))
