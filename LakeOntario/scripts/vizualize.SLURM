#!/bin/bash
#SBATCH -J fvcom_vizualization 
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=16gb
#SBATCH -A glhabs
#SBATCH -e fvcom_error
#SBATCH -o fvcom_out
#SBATCH --partition=ord
#SBATCH -t 1:00:00
#SBATCH --mail-user=coffman.christian@epa.gov
#SBATCH --mail-type=all



bash /work/GLHABS/GreatLakesHydro/vizualization/standardViz.sh \
  /work/GLHABS/GreatLakesHydro/LakeOntario/output/runs/rivers/fvcom_0001.nc \
  /work/GLHABS/GreatLakesHydro/LakeOntario/output/rivers/standard