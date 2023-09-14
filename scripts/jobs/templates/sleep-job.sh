#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=500M
#SBATCH --time=00:01

echo "Starting run at: `date`"

echo "Hello world! will sleep for 10 seconds"

time sleep 10

echo "Program finished with exit code $? at: `date`"
