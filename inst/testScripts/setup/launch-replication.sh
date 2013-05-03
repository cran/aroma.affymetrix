#! /usr/bin/env sh

# Replication
qRscript testScripts/launch.R --group=replication --pattern=GenomeWideSNP_6
qRscript testScripts/launch.R --group=replication --pattern=HG-U133_Plus_2
qRscript testScripts/launch.R --group=replication --pattern=Hs_PromPR_v02
qRscript testScripts/launch.R --group=replication --pattern=Mapping250K_Nsp
qRscript testScripts/launch.R --group=replication --pattern=Mapping50K_Hind240
