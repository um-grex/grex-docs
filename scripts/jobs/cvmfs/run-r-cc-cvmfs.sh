#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=4000M
#SBATCH --time=0-72:00:00
#SBATCH --job-name="R-gdal-jags-bench"
#SBATCH --partition=genoa

# Load the modules:

module load CCEnv
module load arch/avx512
module load StdEnv/2023
module load gcc/12.3 r/4.5.0 jags/4.3.2 geos/3.12.0 gdal/3.9.1

export MKL_NUM_THREADS=1

echo "Starting run at: `date`"

R --vanilla < Benchmark.R &> benchmark.${SLURM_JOBID}.txt

echo "Program finished with exit code $? at: `date`"
