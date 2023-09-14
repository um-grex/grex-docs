#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=4000M
#SBATCH --time=0-72:00:00
#SBATCH --job-name="R-gdal-jags-bench"

# Load the modules:

module load CCEnv
module load nixpkgs/16.09 gcc/5.4.0
module load r/3.5.2 jags/4.3.0 geos/3.6.1 gdal/2.2.1

export MKL_NUM_THREADS=1

echo "Starting run at: `date`"

R --vanilla < Benchmark.R &> benchmark.${SLURM_JOBID}.txt

echo "Program finished with exit code $? at: `date`"
