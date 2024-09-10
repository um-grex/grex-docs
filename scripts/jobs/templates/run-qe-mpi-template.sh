#!/bin/bash

#SBATCH --time=0-8:00:00
#SBATCH --mem-per-cpu=1500M
#SBATCH --ntasks=32
#SBATCH --job-name="QE-Job"

# A example of an MPI parallel that 
# takes 32 cores on Grex for 8 hours. 

# Load the modules:

module load arch/avx512  intel/2023.2  openmpi/4.1.6 espresso/7.3.1

export OMP_NUM_THREADS=1

echo "Starting run at: `date`"

srun pw.x -in MyFile.scf.in  > Myfile.scf.log

echo "Job finished with exit code $? at: `date`"
