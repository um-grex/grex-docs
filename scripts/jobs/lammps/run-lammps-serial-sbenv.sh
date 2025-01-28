#!/bin/bash

#SBATCH --ntasks=1 
#SBATCH --cpus-per-task=1
#SBATCH --mem=1500M
#SBATCH --time=0-3:00:00
#SBATCH --job-name=Lammps-Test

# Load the modules:

module load arch/avx512 intel-one/2024.1 openmpi/4.1.6 
module load lammps/2021-09-29

echo "Starting run at: `date`"

lmp_exec=lmp
lmp_input="lammps.in"
lmp_output="lammps_lj_output.txt"

${lmp_exec} < ${lmp_input} > ${lmp_output}

echo "Program finished with exit code $? at: `date`"
