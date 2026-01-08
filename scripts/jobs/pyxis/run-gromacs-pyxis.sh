#!/bin/bash

#SBATCH --partition=lgpu
#SBATCH --nodes=1
#SBATCH --gpus=2
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=8G

#SBATCH --container-image=nvcr.io/hpc/gromacs:2023.2
#SBATCH --container-mounts=/PATH/TO/INPUT:/host_pwd
#SBATCH --container-workdir=/host_pwd
#SBATCH --container-entrypoint

# Run Gromacs:

echo "Starting run at: `date`"

gmx mdrun -ntmpi 4 -ntomp 8 -nb gpu -pme gpu -npme 1 -update gpu -bonded gpu \
    -nsteps 100000 -resetstep 90000 -noconfout -dlb no -nstlist 300 -pin on \
    -v -gpu_id 01

echo "Program finished with exit code $? at: `date`"
