# NWChem

## Introduction

[NWChem](https://nwchemgit.github.io/) is a Scalable open-source solution for large scale molecular simulations.
NWChem is actively developed by a consortium of developers and maintained by the EMSL located at the Pacific Northwest National Laboratory (PNNL) in Washington State. The code is distributed as open-source under the terms of the Educational Community License version 2.0 (ECL 2.0).

## System specific notes

On Grex software stack, NWChem  is using  OpenMPI 3.1 with Intel compilers toolchains. To find out which versions re available, use ```module spider nwchem``` .

For a version 6.8.1, at the time of writing the following modules have to be loaded:


```module load intel/15.0```

```module load ompi/3.1.4```

```module load nwchem/6.8.1```

The NWChem on Grex was built with the ARMCI variant [MPI-PR](https://github.com/nwchemgit/nwchem/wiki/ARMCI). Thus, NWCHem needs at least One process per node reserved for the data communication. To run a serial job one needs 2 tasks per node. To run a 22 core job over two whole nodes, one has to ask for 2 nodes, 12 tasks per node. Simple number of tasks specification likely wont work because of the chance of having a single-task node allocated by SLURM; so --nodes= --ntask-per-node specification is required!



## Sample SLURM Script

{{< highlight bash >}}
#!/bin/bash
#SBATCH --ntasks-per-node=7 --nodes=2 --cpus-per-task=1
#SBATCH --mem-per-cpu=2000mb
#SBATCH --time=0-3:00:00
#SBATCH --job-name=NWchem-dft-test

#adjust the number of tasks, time and memory required.
#the above spec is for 12 compute tasks over two nodes.

module load intel/15.0.5.223  ompi/3.1.4
module load nwchem/6.8.1

which nwchem

#Uncomment/Change these in case you want to use custom basis sets

export NWCHEM_NWPW_LIBRARY=/global/software/cent7/nwchem/6.8.1-intel15-ompi314/data/libraryps/
export NWCHEM_BASIS_LIBRARY=/global/software/cent7/nwchem/6.8.1-intel15-ompi314/data/libraries/

#In most cases SCRATCH_DIR would  be on local nodes scratch
#While results are in the same directory

export NWCHEM_SCRATCH_DIR=$TMPDIR
export NWCHEM_PERMANENT_DIR=`pwd`

#Optional memory setting; note that this one or the one in your code
# must match the #SBATCH --mem-per-cpu times compute tasks  !

export NWCHEM_MEMORY_TOTAL=2000000000 # 24000 MB, double precision words only
export MKL_NUM_THREADS=1

srun nwchem  dft_feco5.nw > dft_feco5.$SLURM_JOBID.log

echo "all done!”
#######



{{< / highlight >}}

Assuming the script above is saved as _nwchem.job_, it can be sumbitted with 

```sbatch nwchem.job```

