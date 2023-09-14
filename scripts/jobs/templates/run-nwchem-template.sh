#!/bin/bash

#SBATCH --nodes=4
#SBATCH --ntasks-per-node=8 
#SBATCH --mem-per-cpu=4000M
#SBATCH --job-name="NWchem-Job"
#SBATCH --job-name=NWchem-dft-test

# Adjust the number of tasks, time and memory required.
# the above spec is for 32 compute tasks over 4 nodes.

# Load the modules:

module load intel/15.0.5.223 ompi/3.1.4 nwchem/6.8.1

echo "Starting run at: `date`"

which nwchem

# Uncomment/Change these in case you want to use custom basis sets

NWCHEMROOT=/global/software/cent7/nwchem/6.8.1-intel15-ompi314
export NWCHEM_NWPW_LIBRARY=${NWCHEMROOT}/data/libraryps
export NWCHEM_BASIS_LIBRARY=${NWCHEMROOT}/data/libraries

# In most cases SCRATCH_DIR would  be on local nodes scratch
# While results are in the same directory

export NWCHEM_SCRATCH_DIR=$TMPDIR
export NWCHEM_PERMANENT_DIR=`pwd`

# Optional memory setting; note that this one or the one in your code
# must match the #SBATCH --mem-per-cpu times compute tasks  !

export NWCHEM_MEMORY_TOTAL=2000000000 # 24000 MB, double precision words only
export MKL_NUM_THREADS=1

srun nwchem  dft_feco5.nw > dft_feco5.$SLURM_JOBID.log

echo "Program finished with exit code $? at: `date`"
