#!/bin/bash

#SBATCH --ntasks=1 
#SBATCH --cpus-per-task=12
#SBATCH --mem=40gb
#SBATCH --time=8:00:00
#SBATCH --job-name=Gauss16-test

module load gaussian/g16.c01

echo "Starting run at: `date`"

which g16

# note that input should have %nproc=12
# and %mem=40gb for the above resurce request.

g16 < input.gjf > output.$SLURM_JOBID.log

echo "Program finished with exit code $? at: `date`"
