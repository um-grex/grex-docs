#!/bin/bash

#SBATCH --ntasks=8
#SBATCH --mem-per-cpu=2500M
#SBATCH --time=0-3:00:00
#SBATCH --job-name="ORCA-test"

# Adjust the number of tasks, memory walltime above as necessary

# Load the modules: 

module load gcc/4.8 ompi/4.1.1 orca/5.0.2

# Assign the input file:

ORCA_INPUT_NAME=`ls *.inp | awk -F "." '{print $1}'`
ORCA_RAW_IN=${ORCA_INPUT_NAME}.inp

# Specify the output file:

ORCA_OUT=${ORCA_INPUT_NAME}.out

echo "Current working directory is `pwd`"

NUM_PROCS=$SLURM_NTASKS

echo "Running on $NUM_PROCS processors."
echo "Creating temporary input file ${ORCA_IN}"

ORCA_IN=${ORCA_RAW_IN}_${SLURM_JOBID}

cp ${ORCA_RAW_IN} ${ORCA_IN}
echo "%PAL nprocs $NUM_PROCS" >> ${ORCA_IN}
echo "   end "                >> ${ORCA_IN}
echo " "                      >> ${ORCA_IN}

# The orca command should be called with a full path:

echo "Starting run at: `date`"

ORCAEXEC=`which orca`

${ORCAEXEC} ${ORCA_IN} > ${ORCA_OUT}

echo "Program finished with exit code $? at: `date`"
