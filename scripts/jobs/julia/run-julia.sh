#!/bin/bash

#SBATCH --ntasks=1 
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000M
#SBATCH --time=8:00:00
#SBATCH --job-name=Julia-Test

# Load the modules:

module load julia/1.10.3

echo "Starting run at: `date`"

julia test-julia.jl

echo "Program finished with exit code $? at: `date`"
