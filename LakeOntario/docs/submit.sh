#!/bin/bash
#SBATCH --job-name="LO_leem"
#SBATCH --output="qstdout.%j"
#SBATCH --error="qsterr.%j"
#SBATCH --partition=compute
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=128
#SBATCH --account=ncs124
#SBATCH -t 3:00:00

source modules.sh
#2node
/usr/bin/time -v mpirun -n 256 ./fvcom --casename=leem > leem_sinkout.out
echo "seff"
seff $SLURM_JOB_ID
echo "sacct"
sacct --jobs=$SLURM_JOB_ID --format=nnodes,ncpu,ntasks,maxrss,cputime,avecpu,maxdiskread,maxdiskwrite,maxpages
