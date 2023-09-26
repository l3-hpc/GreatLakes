# LakeErie.md

Notes and scripts for Lake Erie TP model.

## Contents
- [Restarts](https://github.com/l3-hpc/LakeErie/blob/main/Restarts.md): How to create a restart file to set the initial conditions(ICs) to match LEEM ICs.
- [run](run.md) - notes for compiling and running on Expanse at SDSC
- [submit.sh](submit.sh) - SLURM batch script for Expanse

**data**
- [TP_ZOO_Loads.csv](data/TP_ZOO_Loads.csv): Phosphorus loading, including Zooplankton component

**scripts**
- [add-tp-river-loads.R](scripts/add-tp-river-loads.R): R script to add TP loads to river forcing file
- [ncks_clip_forcing.sh](scripts/ncks_clip_forcing.sh): Shell script to create netCDF with TP derived from LEEM quantities


For VisIt, comparing with LEEM:
```
DefineScalarExpression("TP_tot", "RPOP + LPOP + RDOP + LDOP + PO4T + LPIP + RPIP + (ZOO1 + ZOO2 + ZOO3)/50.0")
```
