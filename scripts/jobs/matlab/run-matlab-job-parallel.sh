#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=4000M
#SBATCH --time=0-3:00:00
#SBATCH --job-name=Matlab-Parallel
#SBATCH --partition=skylake

# Load Matlab module/

module load matlab

echo "Starting run at: `date`"

# This is an example to run a code "matlab-code.m". 
# Use the file without the extension ".m"
# On this example, the script ois set to use 4 CPUs:
# Adjust --cpus-per-task and --mem-per-cpu as needed.

matlab -nodisplay -nojvm -nodesktop -nosplash -batch "matlab-code"

echo "Program finished with exit code $? at: `date`"
