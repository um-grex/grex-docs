#!/bin/bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=1000MB
#SBATCH --job-name="G16-tests"
#SBATCH --array=1-1204

echo "Current working directory is `pwd`"

echo "Running on `hostname`"
echo "Starting run at: `date`"

# Set up the Gaussian environment using the module command:

module load gaussian/g16.c01

# Run g16 on an array job element

id=`printf "%04d" $SLURM_ARRAY_TASK_ID`
v=test${id}.com
w=`basename $v .com`

g16 < $v > ${w}.${SLURM_JOBID}.out

echo "Job finished with exit code $? at: `date`"
