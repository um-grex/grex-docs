#!/bin/bash

#SBATCH --time=0-8:00:00
#SBATCH --nodes=1
#SBATCH --ntask-per-node=1
#SBATCH --cpus-per-task=52
#SBATCH --mem=0
#SBATCH --partition=skylake
#SBATCH --job-name="OMP-Job-Test"

# An example of an OpenMP threaded job that 
# takes a whole "skylake" node for 8 hours. 

export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}

echo "Starting run at: `date`"

./your-openmp.x input.dat > output.log

echo "Job finished with exit code $? at: `date`"
