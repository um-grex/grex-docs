#!/bin/bash

#SBATCH --ntasks=16 
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=3400M
#SBATCH --time=0-3:00:00
#SBATCH --job-name=vasp-test

# Adjust the number of tasks, time and memory required.
# The above spec is for 16 compute tasks, using 3400 MB per task .

# Load the modules:

module load arch/avx512  gcc/13.2.0  openmpi/4.1.6
module load vasp/6.1.2-6.3.2-vtst

echo "Starting run at: `date`"

which vasp_std

export MKL_NUM_THREADS=1

srun vasp_std  > vasp_test.$SLURM_JOBID.log

echo "Program finished with exit code $? at: `date`"
