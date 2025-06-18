#!/bin/bash

#SBATCH --ntasks=1 
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000M
#SBATCH --time=8:00:00
#SBATCH --job-name=R-Test

# Load the modules:

module load arch/avx512  gcc/13.2.0 r/4.5.0+mkl-2024.1

echo "Starting run at: `date`"

Rscript my-program.R

echo "Program finished with exit code $? at: `date`"
