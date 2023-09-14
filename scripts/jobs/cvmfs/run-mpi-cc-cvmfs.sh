#!/bin/bash

#SBATCH --nodes=2
#SBATCH --ntasks-per-node=2
#SBATCH --mem-per-cpu=4000M
#SBATCH --time=0-1:00:00
#SBATCH --job-name="IMB-MPI1-4"

# Load the modules:

module load CCEnv
module load StdEnv/2018.3
module load imb/2019.3

module list

echo "Starting run at: `date`"

srun IMB-MPI1 > imb-ompi312-2x2.txt

echo "Program finished with exit code $? at: `date`"
