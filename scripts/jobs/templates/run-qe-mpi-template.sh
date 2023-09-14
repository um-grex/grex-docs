#!/bin/bash

#SBATCH --time=0-8:00:00
#SBATCH --mem-per-cpu=1500M
#SBATCH --ntasks=32
#SBATCH --job-name="QE-Job"

# A example of an MPI parallel that 
# takes 32 cores on Grex for 8 hours. 

# Load the modules:

module load intel/15.0.5.223 ompi/3.1.4 espresso/6.3.1

export OMP_NUM_THREADS=1

echo "Starting run at: `date`"

srun pw.x -in MyFile.scf.in  > Myfile.scf.log

echo "Job finished with exit code $? at: `date`"
