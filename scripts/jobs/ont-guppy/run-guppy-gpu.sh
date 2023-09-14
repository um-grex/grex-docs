#!/bin/bash

#SBATCH --gpus=1
#SBATCH --partition=stamps-b
#SBATCH --ntasks=1 
#SBATCH --cpus-per-task=6
#SBATCH --mem-per-cpu=6000M
#SBATCH --time=0-12:00:00
#SBATCH --job-name=genomics-test

# Adjust the resource requests above to your needs.
# Example of loading modules, CUDA:

module load gcc/4.8 cuda/10.2

export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}

echo "Starting run at: `date`"

nvidia-smi

guppy_basecaller -x auto --gpu_runners_per_device 6 -i Fast5 -s GuppyFast5 -c dna_r9.4.1_450bps_hac.cfg

echo "Job finished with exit code $? at: `date`"

