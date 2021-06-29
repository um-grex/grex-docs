# ORCA 

## Introduction

[ORCA](http://cec.mpg.de/forum/) is a flexible, efficient and easy-to-use general purpose tool for quantum
chemistry with specific emphasis on spectroscopic properties of open-shell  molecules. It features a wide variety of standard quantum chemical methods
ranging from semiempirical methods to DFT to single - and multireference correlated ab initio methods. It can also treat environmental and
relativistic effects.

## User Responsibilities and Access

ORCA is a proprietary software, even if it is free it still requires you to agree to the ORCA license conditions.
We have installed ORCA on Grex, but to access the  binaries each of the ORCA users has to confirm they have accepted the license.

The procedure is as follows: first, register at [ORCA forum](https://orcaforum.kofo.mpg.de/) . 
After the registration is complete,  go to ORCA download page, and accept the license conditions. 
Then contact us (via ComputeCanada support for example) quoting the ORCA email and stating that you also would like to access ORCA on Grex.

## System specific notes

On Grex, ORCA is using  OpenMPI 3.1.x from GCC toolchains. So the following modules have to be loaded before using ORCA:

```module load gcc/5.2```

```module load ompi/3.1.4```

```module load orca```

To load the ORCA module and access the binaries, you will have first get access as per above.
Use ```module spider orca``` to see what versions are available on Grex.

## Using ORCA with SLURM

### Sample SLURM Script

{{< highlight bash >}}

#!/bin/bash
#SBATCH --ntasks=8
#SBATCH --mem-per-cpu=2500M
#SBATCH --time=0-3:00:00
#SBATCH --job-name="ORCA-test"

# adjust the number of tasks, memory and walltime above as necessary!

# Load the OpenMPI and ORCA modules:
module load gcc/5.2  ompi/3.1.4 orca/4.2.1

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
# end of the script
{{< / highlight >}}

Assuming the script above is saved as _orca.job_, it can be sumbitted with 

```sbatch orca.job```

