#!/bin/bash

# This script was developed off of Brad Vivivano's helpful advice

JOB1=$(sbatch rivers.SLURM | awk '{ print $4 }')

STATUS1=$?

if [ ${STATUS1} -eq 0 ]; then # Only submit the 2nd job if the 1st sbatch worked
      echo $JOB1
      JOB2=$(sbatch  --dependency=afterok:${JOB1} vizualize.SLURM)
      STATUS2=$?
      if [ ${STATUS2} -eq 0 ]; then
            echo $JOB2
      else
            echo "Uh oh, my 2nd job failed to submit, I need to do something..."
      fi
else
      echo "Uh oh, my 1st job failed to submit, I need to do something..."
fi