Start with original FVCOM hydro.


First, create TP loads.

Next, clip forcings.
Here are file sizes before and after the clip:
```
(/Users/lllowe/env_ncdf) lllowe@LisasMacStudio input % ls -lrth *.nc
-rw-r--r--  1 lllowe  staff   1.3G Jul 24 12:20 2013_leem_fine_forcing.nc
-rw-r--r--  1 lllowe  staff    18K Jul 24 12:20 2013_leem_fine_julian_obc.nc
-rw-r--r--  1 lllowe  staff   406K Jul 24 12:20 2013_leem_fine_river_data.nc
(/Users/lllowe/env_ncdf) lllowe@LisasMacStudio input % ls -lrth full_year/*.nc
-rw-r--r--@ 1 lllowe  staff   1.6G Jul 24 09:57 full_year/2013_leem_fine_forcing.nc
-rw-r--r--@ 1 lllowe  staff    21K Jul 24 09:58 full_year/2013_leem_fine_julian_obc.nc
-rw-r--r--@ 1 lllowe  staff   367K Jul 24 10:12 full_year/2013_leem_fine_river_data_original_hydro.nc
-rw-r--r--@ 1 lllowe  staff   482K Jul 24 11:41 full_year/2013_leem_fine_river_data.nc
```
