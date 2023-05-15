https://nicojourdain.github.io/students_dir/students_netcdf_nco/

To calculate time-averages, e.g. to calculate a monthly mean from a file containing daily outputs:

ncra -F -d time,1,31 file_January_daily.nc file_January_monthly.nc

```
ncrename -v elevation,TP CopyOf2013_leem_fine_julian_obc.nc leem_bio_obc.nc
ncatted -a long_name,TP,m,c,'total phosphorus' leem_bio_obc.nc
ncatted -a Name,TP,m,c,'TP' leem_bio_obc.nc
ncatted -a units,TP,m,c,'mg/L' leem_bio_obc.nc
ncap2 -s 'TP*=0.' leem_bio_obc.nc 
```
