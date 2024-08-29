#!/bin/bash

#SBATCH --ntasks-per-node=7 --nodes=2 --cpus-per-task=1
#SBATCH --mem-per-cpu=2000mb
#SBATCH --time=0-3:00:00
#SBATCH --job-name=NWchem-dft-test

# Adjust the number of tasks, time and memory required.
# the above spec is for 12 compute tasks over two nodes.

# Load the modules:

module load arch/avx512 intel-one/2024.1 openmpi/4.1.6 
module load nwchem/7.2.2

echo "Starting run at: `date`"

which nwchem

# Uncomment/Change these in case you want to use custom basis sets

NWCHEMROOT=${MODULE_NWCHEM_PREFIX}
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
