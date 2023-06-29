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

forcing gives 4 hours before and a bunch after.
```
mkdir orig
cp *.nc orig
mkdir crop
ncks -d time,1416,7303 2013_leem_fine_forcing.nc crop/2013_leem_fine_forcing.nc
ncks -d time,59,303 2013_leem_fine_julian_obc.nc crop/2013_leem_fine_julian_obc.nc
ncks -d time,59,303 2013_leem_fine_river_data.nc crop/2013_leem_fine_river_data.nc
cp crop/* .
```

ncap2
```
ncap2 -s 'TP*=0.0' 2013_leem_fine_river_data.nc 2013_leem_fine_river_data2.nc
```
and
```
cp Baseline_2013_0001.nc TPtot.nc
ncap2 -s"ZOO1=ZOO1/50.;ZOO2=ZOO2/50.;ZOO3=ZOO3/50.;" -v Baseline_2013_0001.nc TPtot.nc
a
ncap2 -s"TP=RPOP+LPOP+RDOP+LDOP+PO4T+LPIP+RPIP+ZOO1+ZOO2+ZOO3" -v TPtot.nc TPtot.nc
a
ncks -x -v CHL,PHYT1,PHYT2,PHYT3,PHYT4,PHYT5,RPOP,LPOP,RDOP,LDOP,PO4T,RPON,LPON,RDON,LDON,NH4T,NO23,BSI,SIT,RPOC,LPOC,RDOC,LDOC,EXDOC,REPOC,REDOC,O2EQ,DO,ZOO1,ZOO2,ZOO3,BALG,DYE,LPIP,RPIP,IPOP,IPON,IPOC,Hyp2_Area TPtot.nc TP2tot.nc
mv TP2tot.nc TPtot.nc
```

To get Zero TP riverloads
```
ncap2 -s"TP=river_temp" -v 2013_leem_fine_river_data.nc 2013_leem_fine_river_data.nc
ncap2 -s"TP=0.0" 2013_leem_fine_river_data.nc 2013_leem_fine_river_data.nc
ncatted -O -a long_name,TP,o,c,TP 2013_leem_fine_river_data.nc
ncatted -O -a Name,TP,o,c,TP 2013_leem_fine_river_data.nc
ncatted -O -a units,TP,o,c,mg/L 2013_leem_fine_river_data.nc
```

Make a restart file.

Run until March 1st.  I put all restart in 1 file by mistake, so cut a slice.
```
ncks -d time,59,59 leem_restart_0001.nc leem_march1.nc
```

Get daily values from hourly output
```
cd /expanse/lustre/projects/ncs124/llowe/FVCOM/simulations/2013/OUT/ws1p0em6calc
ncks -d time,0,5832,24 leem_0001.nc leem_hourly.nc
```



