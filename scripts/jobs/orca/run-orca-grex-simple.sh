#!/bin/bash

#SBATCH --ntasks=8
#SBATCH --mem-per-cpu=2500M
#SBATCH --time=0-3:00:00
#SBATCH --job-name="ORCA-test"

# Adjust the number of tasks, memory walltime above as necessary

# Load the modules: 

module load arch/avx512  gcc/13.2.0  openmpi/4.1.6
module load orca/6.0.1

echo "Current working directory is `pwd`"
echo "Running on $NUM_PROCS processors."
echo "Starting run at: `date`"

${MODULE_ORCA_PREFIX}/orca orca.inp > orca.out

echo "Program finished with exit code $? at: `date`"
