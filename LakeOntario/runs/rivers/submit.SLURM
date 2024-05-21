#!/bin/bash
#SBATCH -J fvcom_rivers
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=32
#SBATCH --mem=8gb
#SBATCH -A glhabs
#SBATCH -e fvcom_error
#SBATCH -o fvcom_out
#SBATCH --partition=ord
#SBATCH -t 5:00:00
#SBATCH --mail-user=coffman.christian@epa.gov
#SBATCH --mail-type=all

# To change how many tasks, only change the number of nodes

source ~/physicsModules.sh
cd /work/GLHABS/LakeOntario/ccoffman/LakeOntario/runs/rivers

ntasks=$((SLURM_NTASKS_PER_NODE * SLURM_NNODES))

mpiexec -n $ntasks ./fvcom --casename=fvcom
# Sometimes easier to diagnose not in parallel
#./fv_single --casename=hydro