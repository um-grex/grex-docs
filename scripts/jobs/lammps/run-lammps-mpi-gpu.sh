#!/bin/bash

#SBATCH --ntasks=1 --partition=gpu 
#SBATCH --cpus-per-gpu=8 --gpus=1
#SBATCH --mem=15000M
#SBATCH --time=0-3:00:00
#SBATCH --job-name=Lammps-Test-GPU

# Load the modules:

module load cuda/12.4.1 arch/avx2 gcc/13.2.0 openmpi/4.1.6 
module load lammps/2024-08-29p1

echo "Starting run at: `date`"

lmp_exec=lmp
lmp_input="lammps.in"
lmp_output="lammps_lj_output.txt"

# this example uses KOKKOS GPU module, on a single GPU

srun ${lmp_exec} -in ${lmp_input} -k on g 1 -sf kk -pk kokkos newton off neigh full -log ${lmp_output}

echo "Program finished with exit code $? at: `date`"
