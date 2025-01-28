#!/bin/bash

#SBATCH --ntasks=32  --mem-per-cpu=4000mb
#SBATCH --time=0-3:00:00
#SBATCH --job-name=ausurf

# Adjust the number of tasks, time and memory required.
# the above spec is for 32 MPI compute tasks 

# Load the modules for the Intel version

module load SBEnv

module load arch/avx512 intel/2023.2 openmpi/4.1.6 
module load espresso/7.3.1

## for AMD partitions --partition=genoa uncomment the modules below:

#module load  arch/avx512  gcc/13.2.0  openmpi/4.1.6
#module load  espresso/7.3.1+aocl-4.2.0

# Unless multithreading is required, it is better to use serial BLAS/LAPACK

export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export BLIS_NUM_THREADS=1

which pw.x

# lets run the AuSurf example, assuming inputs in the current directory
# adjust pw.x options such as -npool and -ndiag according to your system and number of tasks!

echo "Starting run at: `date`"

srun pw.x -input ausurf.in -npool 2 -ndiag 16 > ausurf.${SLURM.}.log

echo "Program finished with exit code $? at: `date`"
