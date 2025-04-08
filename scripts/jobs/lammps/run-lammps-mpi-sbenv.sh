#!/bin/bash

#SBATCH --ntasks=16 
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1500M
#SBATCH --time=0-3:00:00
#SBATCH --job-name=Lammps-Test

# Load the modules:

module load arch/avx512 gcc/13.2.0 openmpi/4.1.6 
module load lammps/2024-08-29p1

echo "Starting run at: `date`"

lmp_exec=lmp
lmp_input="lammps.in"
lmp_output="lammps_lj_output.txt"

srun ${lmp_exec} -in ${lmp_input} -log ${lmp_output}

echo "Program finished with exit code $? at: `date`"
