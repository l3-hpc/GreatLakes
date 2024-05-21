#!/bin/csh
#SBATCH -J LO_FVCOM_TP
#SBATCH -t 2-00:00:00
#SBATCH --ntasks=8
#SBATCH --mem=80gb
#SBATCH --gid=glhabs
#SBATCH -A glhabs
#SBATCH -e lakeOntario_fvcomTP_error
#SBATCH -o lakeOntario_fvcomTP_out

cd /work/GLHABS/LakeOntario/ccoffman
source ~/.bashrc
date

#mpirun ./FVCOM-LOEM/src/fvcom gomdom GD_InputFile_TP Initial_Conditions.nc
mpirun ./FVCOM-LOEM/src/fvcom gomdom data/input_TP ../loofs_for_epa/forcing/loofs_met_2018_01.nc

date
