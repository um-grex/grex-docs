#!/bin/bash

#SBATCH --nodes=2
#SBATCH --ntasks-per-node=2
#SBATCH --mem-per-cpu=4000M
#SBATCH --time=0-1:00:00
#SBATCH --job-name="IMB-MPI1-4"

# Load the modules:
# first the CCEnv stack, then the dependencies, then the Intel IMB benchmark

module load CCEnv
module load StdEnv/2023 gcc/12.3  openmpi/4.1.5
module load imb/2021.3

module list

echo "Starting run at: `date`"

srun IMB-MPI1 > imb-ompi41-2x2.${SLURM_JOBID}.txt

echo "Program finished with exit code $? at: `date`"
