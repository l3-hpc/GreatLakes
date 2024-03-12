# Setting up FVCOM + BIO_TP model on Atmos

## Loading inputs
- I stole Wilson's Ontario input files as follows

```sh 
cp /work/GLFBREEZ/Lake_Ontario/Model_Runs/2018/LO_37/data/MyFiles.inp /work/GLHABS/LakeOntario/ccoffman/data/wilsonFiles.inp
cp /work/GLFBREEZ/Lake_Ontario/Model_Runs/2018/LO_37/GD_InputFile_TP /work/GLHABS/LakeOntario/ccoffman/data/wilson_InputFile_TP
```

## Compiling model
- Forked instructions from l3-hpc/LakeOntario

Compile the BIO_TP model
```sh
cd /work/GLHABS/LakeOntario/ccoffman
git clone https://github.com/l3-hpc/BIO_TP.git FVCOM-LOEM/src/BIO_TP
cp FVCOM_LOEM/src/BIO_TP/EXTERNAL/mod_bio_3D.F FVCOM_LOEM/src
cp FVCOM_LOEM/src/BIO_TP/EXTERNAL/run/input/TP.in ../simulations/input/
cd FVCOM-LOEM/src/BIO_TP
make
```
- Might need to edit the TP.in file or merge with Wilson's?


Compile the FVCOM libs
```sh
cd FVCOM-LOEM/libs
cp versions/netcdf* .
make
```


Edit the FVCOM model
- edit ‘make.inc’
  - library environments
  - control flags
  - and compiler settings. 



Compile the FVCOM model
```sh
cd ..
make
mv fvcom ../simulations/2013/
cd ../simulations/2013
```

First run, no sink out:
- before doing this 
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
- Need to update year
```
cd /work/GLHABS/LakeOntario/ccoffman/FVCOM/simulations/2018? 
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