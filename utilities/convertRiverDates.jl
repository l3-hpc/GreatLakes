using NetCDF

ncinfo("runs/testRun/input/loofs_riv_2022.nc")
time = ncread("runs/testRun/input/loofs_riv_2022.nc", "Itime")

# change the time
# Modified julia day (MJD) is days since 1858:11-17
# Between Jan 1 2018 and 2022 there are 1461 days, so subtract that 

time = time .- 1461

# write the time
ncwrite(time, "runs/rivers/input/loofs_riv_2018.nc", "Itime")

