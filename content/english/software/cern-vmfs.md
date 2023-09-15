---
weight: 1800
linkTitle: "CVMFS"
title: "CVMFS and the Alliance software stack"
description: "Everything you need to know before using the theme."
categories: ["Software"]
#tags: ["Configuration"]
---

## Cern VMFS on Grex
---

[CVMFS or CernVM](https://cernvm.cern.ch/portal/filesystem) stands for CernVM File System. It provides a scalable, reliable and low-maintenance software distribution service. It was developed to assist High Energy Physics (HEP) collaborations to deploy software on the worldwide-distributed computing infrastructure used to run data processing applications. 

Presently, we use CernVMFS (CVMFS) to provide the Alliance's (or Compute Canada's) software stack. We plan to add more publically available CVMFS software repositories such as the one from [OpenScienceGrid](https://opensciencegrid.org/ "OpenScienceGrid"), in the near future. Note that we can only "pull" software from these repositories. To actually add or change software, datasets, ... etc., the respective organizations controlling CVMFS repositories should be contacted directly.

Access to the CVMFS should be transparent to the Grex users: no action is needed other than loading a software module or setting a path.

Grex does not have a local CVMFS stratum server. All we do is to cache the software items as they get requested. Thus, there can be a delay associated with pulling a software item from **Stratum 1 (Replica Server)** for the first time. It usually does not matter for serial programs but parallel codes, that rely on simultaneous process spawning across many nodes, might cause timeout errors. Thus, it is probably a good idea to first access the codes in a small interactive job to warm up the Grex's local CVMFS cache.

## The Alliance's software stack
---

The main reason for having CVMFS supported on Grex is to provide Grex users with the software environment as similar as possible with the environment existing on national Alliance's HPC machines. On Grex, the module tree from Compute Canada software stack is not set as default, but has to be loaded with the following commands:

{{< highlight bash >}}
module purge
module load CCEnv
{{< /highlight >}}

After the above command, use **module spider** to search for any software that might be available in the CC software stack. Note that "default" environments (the _StdEnv_ and _nixpkgs_ modules of the CC stack) are not loaded automatically, unlike on Compute Canada general purpose (GP) clusters. Therefore, it is a good practice to load these modules right away after the CCEnv. The example below loads the Nix package layer that forms the base layer of CC software stack, and then one of the "standard environments", in this case based on Intel 2018 and GCC 7.3 compilers, MKL and OpenMPI.

There is more than one StdEnv version to choose from.

{{< highlight bash >}}
module load nixpkgs/16.09
module load StdEnv/2018.3
{{< /highlight >}}

Note that there are several CPU architectures in the CC software stack. They differ in the CPU instruction set used by the compilers, to generate the binary code. The default for legacy systems like Grex is the lowest SSE3 architectures _arch/sse3_. It ensures that there is no failure on the legacy Grex nodes (which are of NEHALEM, SSE4.2 architecture) due to more recent instructions like AVX, AVX2 and AVX512 that were added by Intel afterwards.

For running on Contributed Nodes, that may be of much newer CPU generation, it is better to use the _arch/avx512_ module and setting RSNT_ARCH=avx512 environment variable in the job scripts.

Some of the software items on CC software stack might assume certain environment variables set that are not present on Grex; one example is SLURM_TMPDIR. In case your script fails for this reason, the following line could be added to the job script:

{{< highlight bash >}}
export SLURM_TMPDIR=$TMPDIR
{{< /highlight >}}

While a majority of CC software stack is built using OpenMPI, some items might be based on IntelMPI. These will require following additional environment variables to be able to integrate with SLURM on Grex:

{{< highlight bash >}}
export I_MPI_PMI_LIBRARY=/opt/slurm/lib/libpmi.so
export I_MPI_FABRICS_LIST=shm:dapl
{{< /highlight >}}
 
If a script assumes, or relies on using the _mpiexec.hydra_ launcher, the later might have to be provided with _-bootstrap slurm_ option.

### How to find software on CC CVMFS
---

Compute Canada's software building system automatically generates documentation for each item, which is available at the [Available Software](https://docs.alliancecan.ca/wiki/Available_software) page. So, the first destination to look for a software item is probably to browse this page. Note that this page covers the default CPU architectures (AVX2, AVX512) of the National systems, and legacy architectures (SSE3, AVX) might not necessarily have each of the software versions and items compiled for them. It is possible to request such versions to be added.

The Lmod, __module spider__, command can be used on Grex to search for modules that are actually available. Note that the _CCEnv_ software stack is not loaded by default; you would have to load it first to enable the spider command to search through the CC software stack:

{{< highlight bash >}}
module purge
module load CCEnv
module spider mysoftware
{{< /highlight >}}
  
Then, when finding available software versions and their dependencies, _module load_ command can be used, as described [here](https://docs.alliancecan.ca/wiki/Utiliser_des_modules/en)

### How to request software added to CC CVMFS
---

Compute Canada maintains and distributes the software stack as part of its mandate to maintain the National HPC systems. To request a software item installed, the requestor should be part of the Compute Canada system (that is, have an account in [CCDB](https://ccdb.computecanada.ca), which is also a prerequisite to have access to Grex. Any CC user can submit such a request to __support@tech.alliancecan.ca__ and notify if a version for non-default CPU architecture such as SSE3 is also necessary to build.

### An example, R code with dependencies from CC CVMFS stack

A real-world example of using R on Grex, with several dependencies required for the R packages.

For dynamic languages like R and Python, the Alliance (formerly known as Compute Canada) does not, in general, provide or manage pre-installed packages. Rather, users are expected to load the base R (Python, Perl, Julia) module and then proceed for the local installation of the required R (or Python, Perl, Julia etc.) packages in their home directories. Check the [R documentation](https://docs.alliancecan.ca/wiki/R) and [Python documentation](https://docs.alliancecan.ca/wiki/Python).

{{< collapsible title="Script example for running R using the Alliance's software stack (CC cvmfs)" >}}
{{< snippet
    file="scripts/jobs/cvmfs/run-r-cc-cvmfs.sh"
    caption="run-r-cc-cvmfs.sh"
    codelang="bash"
/>}}
{{< /collapsible >}}

### Notes on MPI based software from CC Stack

We recommend using a recent environment/toolchain that provides OpenMPI 3.1.x or later, which has a recent PMIx process management interface and supports UCX interconnect libraries that are used on Grex. Earlier versions of OpenMPI might or might not work. With OpenMPI 3.1.x or 4.0.x, __srun__ command should be used in SLURM job scripts on Grex.

Below is an example of an MPI job (Intel benchmark) using the StdEnv/2018.3 toolchain (Intel 2018 / GCC 7.3.0 and OpenMPI 3.1.2).

{{< collapsible title="Script example for running MPI program using the Alliance's software stack" >}}
{{< snippet
    file="scripts/jobs/cvmfs/run-mpi-cc-cvmfs.sh"
    caption="run-mpi-cc-cvmfs.sh"
    codelang="bash"
/>}}
{{< /collapsible >}}

If the script above is saved into __imb.slurm__, it can be submitted as follows:

{{< highlight bash >}}
sbatch imb.slurm
{{< /highlight >}}

### Notes on Code development with CC Stack
---

Because Compute Canada software stack can only distribute open source software to non-CC systems like Grex, proprietary/restricted software items are omitted. This means that Intel compiler modules, while providing their redistributable parts necessary to run the code compiled with them, will not work to compile new code on Grex. Thus, only GCC compilers and GCC-based toolchains from CC Stack are useful for the local code development on Grex.

## OpenScienceGrid
---

On Grex, we mount OSG repositories, mainly for Singularity containers provided through OSG. Pointing the singularity to the desired path under /cvmfs/singularity.opensciencegrid.org/ will automatically mount and fetch the required software items. Discovering them is up to the users. See more in our [Containers](software/containers) documentation page.

---

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* 
*
*
-->
