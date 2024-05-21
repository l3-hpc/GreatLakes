#!/bin/csh
#SBATCH --mail-user=coffman.christian@epa.gov
#SBATCH --mail-type=all
#SBATCH -J fvcom_test 
#SBATCH -t 2:15:00
#SBATCH --ntasks=1
#SBATCH --mem=8gb
#SBATCH -A glhabs
#SBATCH -e fvcom_error
#SBATCH -o fvcom_out

source ~/physicsModules.sh
cd /work/GLHABS/LakeOntario/ccoffman/LakeOntario/runs/fvcom477test
#mpiexec -n 32 ./fvcom --casename=fvcom
# Sometimes easier to diagnose not in parallel
./fvcom --casename=fvcom
