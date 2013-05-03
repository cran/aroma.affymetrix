#! /usr/bin/env sh

# Launcher\n

# System
qRscript testScripts/launch.R --group=system --pattern=CytoScanHD_Array
qRscript testScripts/launch.R --group=system --pattern=Cytogenetics_Array
qRscript testScripts/launch.R --group=system --pattern=GenomeWideSNP_5
qRscript testScripts/launch.R --group=system --pattern=GenomeWideSNP_6
qRscript testScripts/launch.R --group=system --pattern=HG-U133_Plus_2
qRscript testScripts/launch.R --group=system --pattern=Hs_PromPR_v02
qRscript testScripts/launch.R --group=system --pattern=HuEx-1_0-st-v2
qRscript testScripts/launch.R --group=system --pattern=MOUSEDIVm520650
qRscript testScripts/launch.R --group=system --pattern=Mapping10K_Xba142
qRscript testScripts/launch.R --group=system --pattern=Mapping250K_Nsp
qRscript testScripts/launch.R --group=system --pattern=Mapping250K_Sty
qRscript testScripts/launch.R --group=system --pattern=Mapping50K_Hind240$
qRscript testScripts/launch.R --group=system --pattern=Mm_PromPR_v02
qRscript testScripts/launch.R --group=system --pattern=MoEx-1_0-st-v1
qRscript testScripts/launch.R --group=system --pattern=MoGene-1_0-st-v1
qRscript testScripts/launch.R --group=system --pattern=Test3

# Annotation
qRscript testScripts/launch.R --group=annotation --pattern=GenomeWideSNP_6
