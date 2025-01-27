#!/bin/bash
#SBATCH --nodes=1                # number of nodes
#SBATCH --ntasks-per-node=26     # request 26 MPI tasks per node
#SBATCH --cpus-per-task=2        # 2 OpenMP threads per MPI task 
#SBATCH --mem-per-cpu=1000M      # memory per CPU (in MB)
#SBATCH --time=0-03:00           # time limit (D-HH:MM)
#SBATCH --job-name=md-test

# Adjust the number of tasks, nodes, threads time and memory required.
# the above spec is for 26 MPI compute tasks each spawning 2 threads = 52 cores per node

# Load the modules for the CPU version using Grex SBEnv environment

module load SBEnv
module load arch/avx512  gcc/13.2.0  openmpi/4.1.6
module load gromacs/2024.1

# If multithreading is required, it has to be passed to the task with OMP_NUM_THREADS

export OMP_NUM_THREADS="${SLURM_CPUS_PER_TASK:-1}"

echo "Starting run at: `date`"
 
srun --cpus-per-task=$OMP_NUM_THREADS gmx_mpi mdrun -deffnm md

echo "Program finished with exit code $? at: `date`"


