#!/bin/bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000M
#SBATCH --time=0-3:00:00
#SBATCH --job-name=Matlab-mcr-job
#SBATCH --partition=skylake



# the mcr version must correspond to Matlab version the code was compiled with!

module load mcr/R2023b

# Provide the MCR directory according to the compiler version used.
# Presently $MCRROOT variable from the mcr module points to it


echo "Running on host: `hostname`"
echo "Current working directory is `pwd`"
echo "Starting run at: `date`"

./run_mycode.sh $MCRROOT > mycode_${SLURM_JOBID}.out

echo "Program finished with exit code $? at: `date`"
