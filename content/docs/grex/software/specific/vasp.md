# VASP

## Introduction

[VASP](https://www.vasp.at/wiki/index.php/The_VASP_Manual) is a massively parallel plane-wave solid state DFT code. On Grex it is available only for the research groups that hold VASP license. To get access, PIs would need to send us a confirmation email from the VASP vendor, detailing status of their license and a list of users allowed to use it. 

## System specific notes

On the Grex local software stack, we have VASP 5 and VASP 6  is using Intel compiler and  OpenMPI 3.1. To find out which versions of VASP re available, use ```module spider vasp``` .

For a version 6.1.2, at the time of writing the following modules have to be loaded:


```module load intel/2019.5  ompi/3.1.4```

```module load vasp/6.1.2```

There are three executables for VASP CPU version: _vasp\_gam_ , _vasp\_ncl_ , and   _vasp\_std_ . Refer to the VASP manual as to what these mean. An example VASP SLURM script using the standard version of the VASP binary is below:

{{< highlight bash >}}
#!/bin/bash
#SBATCH --ntasks=16 -cpus-per-task=1
#SBATCH --mem-per-cpu=3400mb
#SBATCH --time=0-3:00:00
#SBATCH --job-name=vasp-test

#adjust the number of tasks, time and memory required.
#the above spec is for 16 compute tasks, using 3400 MB per task .

module load intel/2019.5  ompi/3.1.4
module load vasp/6.1.2

which vasp_std

export MKL_NUM_THREADS=1

srun vasp_std  > vasp_test.$SLURM_JOBID.log

echo "all done!”
#######

{{< / highlight >}}

Assuming the script above is saved as _vasp.job_, it can be sumbitted with 

```sbatch vasp.job```

The script assumes that VASP6 inputs (INCAR, POTCAR etc.) are in the same directory as the job script.

