#!/bin/bash

#SBATCH --time=0-0:30:00
#SBATCH --mem=2500M
#SBATCH --job-name="Serial-Job-Test"

# Script for running serial program: your_program

echo "Current working directory is `pwd`"

# Load modules if needed:

echo "Starting run at: `date`"

./your_program <+options or arguments if any>

echo "Job finished with exit code $? at: `date`"
