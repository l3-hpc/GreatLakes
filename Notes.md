Original files from Wilson, on Hazel
```
/rsstu/users/l/lllowe/LakeErie/Lake_Erie_Ecological_Model/FVCOM
```
Copied to my Mac
```
~/LakeErie/FVCOM
```

Input files:
```
~/LakeErie/FVCOM/simulations/input
```

XLSX files from Wilson
```

```

Remove write permissions from these original files
```
chmod u-w -R ~/LakeErie/FVCOM
```

ncks
```
ncks -d time,1416,8782 2013_leem_fine_forcing.nc forcing_1417_8783.nc
ncks -d time,59,365 2013_leem_fine_julian_obc.nc obc_60_366.nc
ncks -d time,59,365 2013_leem_fine_river_data.nc river_60_366.nc
```
