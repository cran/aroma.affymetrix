setMethodS3("extractMatrix", "AffymetrixCelFile", function(this, cells=NULL, ..., field=c("intensities", "stdvs", "pixels"), drop=FALSE, verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'cells':
  cdf <- getCdf(this)
  if (is.null(cells)) {
    ncells <- nbrOfCells(cdf)
  } else {
    cells <- Arguments$getIndices(cells, max=nbrOfCells(cdf))
    ncells <- length(cells)
  }
 
  # Argument 'field':
  field <- match.arg(field)

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose)
  if (verbose) {
    pushState(verbose)
    on.exit(popState(verbose))
  } 


  verbose && enter(verbose, "Getting data for one array")

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Allocate return matrix
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  verbose && enter(verbose, "Allocating matrix")
  naValue <- as.double(NA)
  df <- matrix(naValue, nrow=ncells, ncol=1)
  colnames(df) <- getName(this)
  verbose && str(verbose, df)
  verbose && printf(verbose, "RAM: %s\n", hsize(object.size(df), digits = 2L, standard = "IEC"))
  verbose && exit(verbose)

  if (!is.null(cells)) {
    verbose && enter(verbose, "Optimize reading order")
    srt <- sort(cells, method="quick", index.return=TRUE)
    o <- srt$ix
    cells <- srt$x
    # Not needed anymore
    srt <- NULL
    verbose && exit(verbose)
  } else {
    o <- seq_len(ncells)
  }
  
  verbose && enter(verbose, "Retrieving data")
  df[o,1] <- getData(this, indices=cells, fields=field, 
                                           verbose=less(verbose))[[field]]
  verbose && exit(verbose)

  # Drop singleton dimensions?
  if (drop) {
    df <- drop(df)
  }

  verbose && exit(verbose)
 
  df
}) # extractMatrix()
