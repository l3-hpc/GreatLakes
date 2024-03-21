# LakeErie

Notes and scripts for the Lake Erie model

## Contents
- [Restarts](Restarts.md): How to create a restart file to set the initial conditions(ICs) to match LEEM ICs.
- [run](run.md) - notes for compiling and running on Expanse at SDSC
- [submit.sh](submit.sh) - SLURM batch script for Expanse

**data**
- [TP_ZOO_Loads.csv](data/TP_ZOO_Loads.csv): Phosphorus loading, including Zooplankton component

**scripts**
- [add-tp-river-loads.R](scripts/add-tp-river-loads.R): R script to add TP loads to river forcing file
- [ncks_clip_forcing.sh](scripts/ncks_clip_forcing.sh): Clip forcing files in order to run FVCOM as 'restart' from March 1
