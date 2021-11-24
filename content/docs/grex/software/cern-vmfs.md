---
title: "CVMFS and ComputeCanada"
weight: 10
---
# Cern VMFS on Grex

[CVMFS or CernVM](https://cernvm.cern.ch/portal/filesystem) stands for CernVM File System. It provides a scalable, reliable and low-maintenance software distribution service. It was developed to assist High Energy Physics (HEP) collaborations to deploy software on the worldwide-distributed computing infrastructure used to run data processing applications. 

Presently, we use CernVMFS (CVMFS) to provide Compute Canada's software stack. We plan to add more publically available CVMFS software repositories such as the one from [OpenScienceGrid](https://opensciencegrid.org/), in a near future. Note that we can only "pull" software from these repositories. To actually add or change software, datasets etc., the respective orgaizations controlling CVMFS repositories should be contacted directly.

Access to the CVMFS should be transparent to the Grex users: no action is needed other than loading a software module or setting a path.

Grex does not have a local CVMFS stratum server. All we do is to cache the software items as they get requested. Thus there can be a delay associated with pulling a software item from **Strartum 1** for the first time. It usually does not matter for serial progams but parallel codes, that rely on simultaneus process spawning across many nodes, it might cause timeout errors. Thus, it is probably a good idea to first access the codes in a small interactive job to warm up the Grex's local CVMFS cache.

## ComputeCanada software stack

The main reason for having CVMFS supported on Grex is to provide Grex users with the software environment as similar as possible with the environment existig on National Compute Canada HPC machines. On Grex, the module tree from Compute Canada software stack is not set as default, but has to be loaded with the following commands:

```module purge; module load CCEnv```

After the above command, use ''module spider'' to search for any software that might be available in the CC software stack. Note that "default" environment (the _StdEnv_ and _nixpkgs_ modules of the CC stack) are not loaded automatically, unlike on Compute Canada general purpose (GP) and on Niagara clusters. Therefore, it is a good practice to load these modules right away after the CCEnv. The example below loads the Nix package layer that forms the base layer of CC software stack, and then one of the "standard environments", in this case based on Intel 2018 and GCC 7.3 compilers, MKL and OpenMPI.

There is more than one StdEnv version to chose from.

```module load nixpkgs/16.09```
  
```module load StdEnv/2018.3```

Note that there are several CPU architectures in the CC software stack. They differ in the CPU instruction set used by the compilers, to generate the binary code. The default for legacy systems like Grex is the lowest SSE3 architecture _arch/sse3_. It ensures that there is no failure on the legacy Grex nodes (which are of NEHALEM, SSE4.2 architecture) due to more recent instructions like AVX, AVX2 and AVX512 that were added by Intel afterwards.

For running on Contributed Nodes, that may be of much newer CPU generation, it is better to use the _arch/avx512_ module and setting RSNT_ARCH=avx512 environment variable in the job scripts.

Some of the software items on CC software stack might assume certain environment variables set that are not present on Grex; one example is SLURM_TMPDIR. In case your script fails for this reason, the following line could be added to the job script:

```export SLURM_TMPDIR=$TMPDIR```

While a majority of CC software stack is built using OpenMPI, some items might be based on IntelMPI. These will require following addirional environment variables to be able to integrate with SLURM on Grex:

```export I_MPI_PMI_LIBRARY=/opt/slurm/lib/libpmi.so```
  
```export I_MPI_FABRICS_LIST=shm:dapl```
 
If a script assumes, or relies on using the _mpiexec.hydra_ launcher, the later might have to be provided with _-bootstrap slurm_ option.

### How to find software on CC CVMFS

Compute Canada's software building system automatically generates documentation for each item, which is available at the [Available Software](https://docs.computecanada.ca/wiki/Available_software) page. So the first destination to look for a software item is probably to browse this page. Note that this page covers the default CPU arhitectures (AVX2, AVX512) of the National systems, and legacy architecturs (SSE3, AVX) might not necessary have each of the software versions and items compiled for them. It is possible to request such versions to be added.

The Lmod _module spider_ command can be used on Grex to search for modules that are actually available. Note that the _CCEnv_ software stack is not loaded by default; you would have to load it first to enable the spider command to search through the CC software stack:

```module purge; module load CCEnv```
  
```module spider mysoftware```
  
Then, when finding available software versions and their dependencies, _module load_ command can be used, as descibed [here](https://docs.computecanada.ca/wiki/Utiliser_des_modules/en)

### How to request software added to CC CVMFS

Compute Canada maintains and distributes the software stack as part of its mandate to maintain the National HPC systems. To request a software item installed, the requestor should be part of Compute Canada system (that is, have an account in [CCDB](https://ccdb.computecanada.ca), which is also a prerequisite to have Grex access. Any CC user can submit such request to [support@computecanada.ca](mailto:support@computecanada.ca) and notify if a version for non-default CPU architecture such as SSE3 is also necessary to build.

### An example, R code with dependencies from CC CVMFS stack

A real world example of using R on Grex, with several dependencies required for the R packages.
 
For the dynamic languages like R and Python, Compute Canada does not, in general, provide or manage pre-installed packages. Rather, users are expected to load the base R (Python, Perl, Julia) module and then proceed for the loacl installation of the required R (or Python, Perl, Julia etc.) packages in their home directories. Check the [CC R documentation](https://docs.computecanada.ca/wiki/R) and [CC Python documentation](https://docs.computecanada.ca/wiki/Python).

{{< highlight bash >}}
#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=4000M
#SBATCH --time=0-72:00:00
#SBATCH --job-name="R-gdal-jags-bench"

# Load the modules:

module load CCEnv
module load nixpkgs/16.09 gcc/5.4.0
module load r/3.5.2 jags/4.3.0 geos/3.6.1 gdal/2.2.1

export MKL_NUM_THREADS=1

echo "Starting run at: `date`"

R --vanilla < Benchmark.R &> benchmark.${SLURM_JOBID}.txt

echo "Program finished with exit code $? at: `date`"
{{</highlight>}}

### Notes on MPI based software from CC Stack

We recommend to use a recent ComputeCanada environment/toolchain that provides OpenMPI 3.1.x or later, which has a recent PMIx process management interface and supports UCX interconnect libraries that are used on Grex.
Earlier versions of OpenMPI might or might not work. With OpenMPI 3.1.x or 4.0.x, ```srun``` command should be used in SLURM job scripts on Grex.
Below is an example of MPI job (Intel benchmark) using the StdEnv/2018.3 toolchain (Intel 2018 / GCC 7.3.0 and OpenMPI 3.1.2).

{{< highlight bash >}}
#!/bin/bash
#SBATCH --ntasks-per-node=2 --nodes=2
#SBATCH --mem-per-cpu=4000M
#SBATCH --time=0-1:00:00
#SBATCH --job-name="IMB-MPI1-4"

# Load the modules:

module load CCEnv
module load StdEnv/2018.3
module load imb/2019.3

module list

echo "Starting run at: `date`"

srun IMB-MPI1 > imb-ompi312-2x2.txt

echo "Program finished with exit code $? at: `date`"
{{</highlight>}}

If the script above is saved into _imb.slurm_, it can be submitted as follows:

```sbatch imb.slurm```

### Notes on Code development with CC Stack

Because ComputeCanada stack only can distribute open source software to non-CC systems like Grex, proprietary/restricted software items are omtted.
This means that Intel compiler modules, while providing their redistributable parts necessary to run the code compiled with them, will not work to compile new code on Grex.
Thus, only GCC compilers and GCC-based toolchains from CC Stack are useful for the local code development on Grex.

## OpenScienceGrid

On Grex, we mount OSG reporsitories, mainly for Singularity containers provided through OSG. Pointing the singularuty to the desired path under /cvmfs/singularity.opensciencegrid.org/ will automatically mount and fetch the required software items. Discovering them is up the the users. See more in our [Containers](../containers/) documentation page.


