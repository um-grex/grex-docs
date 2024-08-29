#!/bin/bash

#SBATCH --ntasks=1 
#SBATCH --cpus-per-task=1
#SBATCH --mem=1500M
#SBATCH --time=0-3:00:00
#SBATCH --job-name=Lammps-Test

# Load the modules:

module purge
module load CCEnv
module load arch/avx512
module load StdEnv/2023
module load intel/2023.2.1  openmpi/4.1.5
module load lammps-omp/20230802

echo "Starting run at: `date`"

lmp_exec=lmp
lmp_input="lammps.in"
lmp_output="lammps_lj_output.txt"

${lmp_exec} < ${lmp_input} > ${lmp_output}

echo "Program finished with exit code $? at: `date`"
