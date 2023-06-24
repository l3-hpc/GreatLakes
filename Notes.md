Original files from Wilson, on Hazel, `/rsstu/users/l/lllowe/LakeErie/Lake_Erie_Ecological_Model/FVCOM`.

Copied to my Mac, `~/LakeErie/FVCOM`

Input files in `~/LakeErie/FVCOM/simulations/input`
```
2013_leem_fine_RIVERS_NAMELIST_no_niagara.nml
2013_leem_fine_forcing.nc
2013_leem_fine_julian_obc.nc
2013_leem_fine_river_data.nc
leem_fine_cor.dat
leem_fine_dep.dat
leem_fine_grd.dat
leem_fine_obc.dat
leem_sigma.dat
leem_spg.dat
```

XLSX files from Wilson in `~/LakeErie/xlsx`.
```
Lake_Erie_Stations.xlsx
TP_ZOO_Loads.xlsx
```

Remove write permissions from these original files
```
chmod -R u-w ~/LakeErie/FVCOM
chmod -R u-w ~/LakeErie/xlsx
```

ncks
```
ncks -d time,1416,8782 2013_leem_fine_forcing.nc forcing_1417_8783.nc
ncks -d time,59,365 2013_leem_fine_julian_obc.nc obc_60_366.nc
ncks -d time,59,365 2013_leem_fine_river_data.nc river_60_366.nc
```
