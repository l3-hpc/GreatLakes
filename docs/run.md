# setting up fvcom + bio_tp model on atmos
note that this run.md file was forked from [Lisa's repo](https://github.com/l3-hpc/LakeErie.git) to [my repo](https://github.com/coffm049-2/LakeOntario.git). I named the directory ccoffman in the LakeOntario folder.

this goes through:
- aquiring everything
  - fvcom 4.4.5 (older version for stability reasons)
  - bio_tp model
  - lake ontario loadings 
- compiling everything
  - bio_tp
  - fv_com
    - libs
    - model
- a first model run

## fvcom
git the fvcom model (we are choosing an older version for stability reasons). forked the fvcom repo

```sh
WDIR='/work/GLHABS/LakeOntario/ccoffman'
git clone --branch v4.4.6 https://github.com/coffm049-2/fvcom-loem.git FVCOM-LOEM
```

## bio_tp
Git the bio_tp model
```sh
git clone https://github.com/l3-hpc/bio_tp.git FVCOM-LOEM/src/BIO_TP

cp FVCOM-LOEM/src/BIO_TP/EXTERNAL/mod_bio_3D.F FVCOM-LOEM/src
mkdir simulations/input -p
cp FVCOM-LOEM/src/BIO_TP/EXTERNAL/run/input/TP.in simulations/input/
```
- might need to edit the tp.in file or merge with wilson's?

## inputs/loadings
- i stole wilson's ontario input files as follows

```sh 
cp /work/GLFBREEZ/Lake_Ontario/Model_Runs/2018/LO_37/data/MyFiles.inp /work/GLHABS/LakeOntario/ccoffman/data/WilsonFiles.inp
cp /work/GLFBREEZ/Lake_Ontario/Model_Runs/2018/LO_37/GD_InputFile_TP /work/GLHABS/LakeOntario/ccoffman/data/wilson_InputFile_TP
```

# compiling models
I source the following bashrc

```sh
module load dot
module load gcc/12.2
module load intel/23.2
module load intelmpi/23.2
module load openmpi/4.1.6
module load netcdf/4.9.2
module load pnetcdf/1.12.3
module load R/4.3.2
```

## BIO_TP
```sh
cd FVCOM-LOEM/src/BIO_TP
source ~/.bashrc
make
```

## FVCOM
Edit the following files
- make.inc
  - update library enviroment - set directories
  - compiler settings - did nothing
  - control flags - did nothing




Compile the FVCOM libs
```sh
cd ../../libs
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





# Running the models
## From Wilson's 
Generate template input file and copy compiled model to top project directory
```sh
cp /work/GLHABS/LakeOntario/ccoffman/FVCOM-LOEM/src/fvcom /work/GLHABS/LakeOntario/ccoffman
./fvcom --CREATE_NAMELIST simulations/OntarioTest
```
- this creates a default file with default values and blanks
- Edit the header information, note the time zone
- Took settings from Wilson's Lake Michigan /work/GLFBREEZ/Lake_Michigan/FVCOM_4_3_1/Compile_FVCOMv4/mi_run.nml
- Need to make sure have forcing files for instance forcing.nc
-

## From Lisa's
- These are still Lisa's notes and need to be updated

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