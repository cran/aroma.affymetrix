###########################################################################
# Replication test
#
# Description:
# This test verifies that aroma.affymetrix can reproduce the SNPRMA 
# chip-effect estimates as estimated by oligo.
# It verifies that they give the same results whether or not one
# is normalizing towards the HapMap reference (as defined by oligo).
#
# Author: Henrik Bengtsson
# Created: 2009-10-16
# Last modified: 2009-10-16
#
# Data set:
#  rawData/
#   HapMap270,100K,CEU,testSet/
#     Mapping50K_Hind240/
#       NA06985,Hind,B5,3005533.CEL
#       NA06991,Hind,B6,3005533.CEL
#       NA06993,Hind,B4,4000092.CEL
#       NA06994,Hind,A7,3005533.CEL
#       NA07000,Hind,A8,3005533.CEL
#       NA07019,Hind,A12,4000092.CEL
###########################################################################

library("aroma.affymetrix");
log <- Arguments$getVerbose(-8, timestamp=TRUE);

csR <- AffymetrixCelSet$byName("HapMap270,100K,CEU,testSet",
                                           chipType="Mapping50K_Hind240");
print(csR);

sfs <- extractSnpFeatureSet(csR);
print(sfs);
