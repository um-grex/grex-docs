# ORCA 

## Introduction

[ORCA](http://cec.mpg.de/forum/) is a flexible, efficient and easy-to-use general purpose tool for quantum chemistry with specific emphasis on spectroscopic properties of open-shell  molecules. It features a wide variety of standard quantum chemical methods ranging from semiempirical methods to DFT to single - and multireference correlated ab initio methods. It can also treat environmental and relativistic effects.

## User Responsibilities and Access

ORCA is a proprietary software, even if it is free it still requires you to agree to the ORCA license conditions. We have installed ORCA on Grex, but to access the binaries each of the ORCA users has to confirm they have accepted the license.

The procedure is as follows: first, register at [ORCA forum](https://orcaforum.kofo.mpg.de/). After the registration is complete,  go to ORCA download page, and accept the license conditions. Then contact us (via Compute Canada support for example) quoting the ORCA email and stating that you also would like to access ORCA on Grex.

## System specific notes

To see the versions installed on Grex and how to load them, please use **module spider orca** and follow the instructions. Both **ORCA-4** and **ORCA-5** are available on Grex.

To load **ORCA-5**, use:

{{< hint info >}}
module load gcc/4.8 ompi/4.1.1 orca/5.0.2
{{< /hint >}}

To load **ORCA-4**, use:

{{< hint info >}}
module load gcc/4.8 ompi/3.1.4 orca/4.2.1
{{< /hint >}}

**Note:**

{{< hint info >}}
The first realeased version of **ORCA-5** (5.0.1) is available on Grex. However, ORCA users should use the versions release after (as for now: **5.0.2** since it addresses few bugs of the two first releases 5.0.0 and 5.0.1).
{{< /hint >}}

## Using ORCA with SLURM

### Sample SLURM Script

{{< hint slurm >}}
{{< highlight bash >}}
#!/bin/bash
#SBATCH --ntasks=8
#SBATCH --mem-per-cpu=2500M
#SBATCH --time=0-3:00:00
#SBATCH --job-name="ORCA-test"
# Adjust the number of tasks, memory 
# and walltime above as necessary!
# Load the OpenMPI and ORCA modules:
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
{{< / highlight >}}
{{< /hint >}}

Assuming the script above is saved as __orca.job__, it can be sumbitted with:

{{< hint info >}}
```sbatch orca.job```
{{< /hint >}}




### Sample SLURM Script for NBO calculations

{{< hint slurm >}}
{{< highlight bash >}}
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
{{< / highlight >}}
{{< / hint >}}
