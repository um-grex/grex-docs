#!/bin/bash

#SBATCH --ntasks=32
#SBATCH --mem-per-cpu=4000M
#SBATCH --time=7-0:00:00
#SBATCH --job-name=nbo

# Load the modules:

module load gcc/4.8  ompi/4.1.1 orca/5.0.2 
module load nbo/7.0 

EBROOTORCA=/global/software/cent7/orca/5.0.2_linux_x86-64_openmpi411
export GENEXE=`which gennbo.i4.exe`
export NBOEXE=`which nbo7.i4.exe`

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

${EBROOTORCA}/orca ${ORCA_IN} > ${ORCA_OUT}

echo "Program finished with exit code $? at: `date`"
