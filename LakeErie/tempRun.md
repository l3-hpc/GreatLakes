On Expanse:
- login.expanse.sdsc.edu
```
cd /expanse/lustre/projects/ncs124/llowe/FVCOM/source_code
git clone https://github.com/l3-hpc/BIO_TP.git
module load cpu/0.15.4
module load intel/19.1.1.217
module load intel-mpi/2019.8.254
module load netcdf-c/4.7.4
module load netcdf-fortran/4.5.3
cp BIO_TP/EXTERNAL/mod_bio_3D.F .
cp BIO_TP/EXTERNAL/run/input/TP.in ../simulations/input/
cd BIO_TP
make
cd ..
make
mv fvcom ../simulations/2013/
cd ../simulations/2013
```

First run, no sink out:
```
0           !1=sink out, 0=no sink out
sbatch submit.sh
mv output output_nosinkout
mkdir output
vi ../input/TP.in
1           !1=sink out, 0=no sink out
vi submit.sh
/usr/bin/time -v mpirun -n 256 ./fvcom --casename=leem > leem_sinkout.out
sbatch submit.sh
```

After logging out/in
```
cd $WORK
cd FVCOM/simulations/2013
mv output output_nosinkout
```

Check the files with VisIt
- Well.  Sink out has less TP so I guess we're good.

## Full test runs
March 1 - October 31

Sink out
```
1           !Number of Detritus vars
"TP" "mg/L" !Name and units
0.00        !Minimum value for Detritus
6.0e-7      !Sinking rate, m/s
1           !1=sink out, 0=no sink out
```
