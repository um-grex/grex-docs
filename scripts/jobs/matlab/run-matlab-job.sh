#!/bin/bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000M
#SBATCH --time=0-3:00:00
#SBATCH --job-name=Matlab-Job
#SBATCH --partition=skylake

# Load Matlab module/

module load matlab

echo "Starting run at: `date`"

# This is an example to run a code "matlab-code.m". 
# Use the file without the extension ".m"
 
matlab -nodisplay -nojvm -nodesktop -nosplash -singleCompThread -batch "matlab-code"

echo "Program finished with exit code $? at: `date`"
