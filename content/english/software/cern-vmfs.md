---
weight: 1800
linkTitle: "CVMFS"
title: "CVMFS and the Alliance software stack"
description: "Everything you need to know before using the theme."
categories: ["Software"]
tags: ["CernVMFS", "Containers"]
---

## CC CernVMFS on Grex
---

[CVMFS or CernVM FS](https://cernvm.cern.ch/portal/filesystem) stands for CernVM File System. It provides a scalable, reliable and low-maintenance software distribution service. CVMFS was originally developed to assist High Energy Physics (HEP) collaborations to deploy software on the worldwide-distributed computing infrastructure used to run data processing applications. Since then it has been used as a a generic way of distributing software. 
Presently, we use CernVMFS (CVMFS) to provide the Alliance's (or Compute Canada's) software stack. Through the Alliance CVMVS servers, several other publically available CVMFS software repositories are available as well. 
The examples are a Singularity/Apptainer repository from [OpenScienceGrid](https://opensciencegrid.org/ "OpenScienceGrid"), Extreme-Scale Scientific Software Stack [E4S](https://e4s-project.github.io/), and a Genomics software colection (GenPipes/MUGQIC) from [C3G](https://computationalgenomics.ca/). Note that we can only "pull" the software from these repositories. To actually add or change software, datasets, etc., or receive support, the respective organizations controlling these CVMFS repositories should be contacted directly.

Access to the software and data distributed via CVMFS should be transparent to the Grex users: no action is needed other than loading a software module or setting a path. However, for accessing the Compute Canada software stack, a module should always be loaded to switch between software environments.

Grex does not have a local CVMFS "stratum" (that is, a replica server). All we do is to cache the software items as they get requested. Thus, there can be a delay associated with pulling a software item for the first time, from the Alliance's Stratum 1 (Replica Servers) located at the National HPC sites. It usually does not matter for serial programs but parallel codes, that rely on simultaneous process spawning across many nodes, might cause timeout errors. Thus, it could be useful to first access the codes in a small interactive job, or on a login node, to warm up Grex's local CVMFS cache.

## The Alliance's software stack
---

The main reason for having CVMFS supported on Grex is to provide Grex users with the software environment as similar as possible with the environment existing on National Alliance's HPC machines. On Grex, the module tree from Compute Canada software stack is not set as default, but has to be loaded with the following commands:

{{< highlight bash >}}
module purge
module load CCEnv
module load arch/avx512
module load StdEnv/2023
{{< /highlight >}}

After the above commands, use **module spider** to search for any software that might be available in the CC software stack. 

Note that "default" environments (the _StdEnv_ and _arch_ modules of the CC stack) are not loaded automatically, unlike on CC / Alliance general purpose (GP) HPC machines. Therefore, it is a good practice to load these modules right away after the _CCEnv_ module.
 
There is more than one _StdEnv_ version to choose from. The example above is for the current StdEnv/2023 . Each ["Standard Environment"](https://docs.alliancecan.ca/wiki/Standard_software_environments) of the ComputeCanada software stack provides an "OS Compatibility Layer" in form of _gentoo_ or _nixpkgs_ base OS packages, and a set version of Core GCC compilers and GCC and Intel toolchains. 

There is more than one CPU architecture (as set by the __arch__ modules) in the CC software stack. They differ in the CPU instruction set used by the compilers, to generate the binary code. Most of Grex would now use _arch/avx512_ . There are some of the GPU nodes on Grex that are of the AMD Rome and Milan architecture, and require _arch/avx2_ . AVX2 and AVX512 are also used on the majority of the Alliance HPC machines. 

> Note that AMD Genoa CPUs on Grex provide a larger subset of the AVX512 instructions than Intel Cascade Lake CPUs. Using _-xHost_ or _-march=native_ may generate a different code when ran on AMD or Intel compute nodes!

Some of software items on CC software stack might assume certain environment variables set that are not present on Grex; one example is SLURM_TMPDIR. In case your script fails for this reason, the following line could be added to the job script:

{{< highlight bash >}}
export SLURM_TMPDIR=$TMPDIR
{{< /highlight >}}

While a majority of CC software stack is built using OpenMPI, some items might be based on IntelMPI. These will require following additional environment variables to be able to integrate with SLURM on Grex:

{{< highlight bash >}}
export I_MPI_PMI_LIBRARY=/opt/slurm/lib/libpmi.so
export I_MPI_FABRICS_LIST=shm:dapl
{{< /highlight >}}
 
If a script or a pre-built software package assumes, or relies on, using the _mpiexec.hydra_ launcher, the later might have to be provided with _-bootstrap slurm_ option.

### How to find software on CC CVMFS
---

Compute Canada's software building system automatically generates documentation for each item, which is available at the [Available Software](https://docs.alliancecan.ca/wiki/Available_software) page. So, the first destination to look for a software item is probably to browse this page. Note that this page covers the default CPU architectures (AVX2, AVX512) of the National systems. Legacy architectures (SSE3, AVX) that were present on earlier versions of StdEnv, are no longer supported. 

The  __module spider__ command can be used on Grex to search for modules that are actually available. Note that the _CCEnv_ software stack is not loaded by default; you would have to load it first to enable the spider command to search through the CC software stack. The the example below is for the Amber MM software:

{{< highlight bash >}}
module purge
module load CCEnv
module load arch/avx512 
module load StdEnv/2023
module spider amber
{{< /highlight >}}
 
One of the available versions of Amber as returned by the commands above, would be  _amber/22.5-23.5_ . A subsequent command _module spider amber/22.5-23.5_ would then provide dependencies. Then, when finding available software versions and their dependencies, _module load_ commands can be used, as described [here](https://docs.alliancecan.ca/wiki/Utiliser_des_modules/en) or [here](/software/using-modules/)

### How to request software added to CC CVMFS
---

The Alliance (formerly Compute Canada) maintains and distributes the software stack as part of its mandate to maintain the National HPC systems. To request a software item installed, the requestor should have an account in [CCDB](https://ccdb.alliancecan.ca), which is also a prerequisite to have access to Grex. Any CCDB user can submit such a request to __support@tech.alliancecan.ca__ .

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

We recommend using a recent environment/toolchain that provides OpenMPI 4.1.x or later, which has a recent PMIx process management interface and supports UCX interconnect libraries that are used on Grex. Earlier versions of OpenMPI might or might not work. With OpenMPI 3.1.x or 4.1.x, __srun__ command should be used in SLURM job scripts on Grex.

Below is an example of an MPI job (Intel benchmark) using the StdEnv/2023 toolchain (GCC 12.3 and OpenMPI 4.1).

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

### Notes on Restricted/Commercial software on CC Stack
---

The Alliance (formerly Compute Canada) software stack has two options for distribution: open source software stack to all non-CC systems, or the full software stack to systems that obey CCDB groups and ACL permissions that control access to licensed, commercial software. Grex is presntly a CCDB-based system and has full access to the CC software stack.

However, each item of the proprietary code on the CC software stack comes with its own license and/or its own access conditions that we abide by. Thus, to request access to each item of commercial software the procedure must be found on the Alliance documentation site, and followed up via _support@tech.alliancecan.ca_ . 

Many commercial items there also are BYOL (bring-your-own license). An example would be Matlab, where our users would want to provide UManitoba's Matlab license even when using the code from CC CVMFS.

As of now, older Intel compiler modules on the CC CVMFS software stack do not match license available on Grex. Thus, while all GCC compilers and GCC-based toolchains from CC Stack are useful for the local code development on Grex, for Intel it might depend on a version. Newest Intel OneAPI compilers (past 2023.x) are free to use and will work without a license check-out.

## Other software repositories available through CC CVMFS

### OpenScienceGrid repository for Singularity/Apptainer OSG software
---

On Grex, we mount OSG repositories, mainly for Singularity/Apptainer containers provided through [OSG](https://osg-htc.org/). Pointing the singularity to the desired path under **/cvmfs/singularity.opensciencegrid.org/** will automatically mount and fetch the required software items. 

Discovering what software is where on the OSG stack, seems to be up to the users. One of the ways would be simply exploring the directories under the path _/cvmfs/singularity.opensciencegrid.org/_ using _ls_ and _cd_ commands.

See more about using Singularity in our [Containers](software/containers) documentation page. 

### E4S containers in the OSG repository of Singularity/Apptainer software
---

In particular, the path __/cvmfs/singularity.opensciencegrid.org/ecpe4s__ provides access to the containerized [E4S software stack for HPC and AI applications](https://e4s-project.github.io/). 

### C3G repository for GenPipes/MUGQIC genomes and modules
---

On Grex, GenPipes/MUGQIC repositories should be also available through CC CVMFS. Please refer to the [GenPipes/MUGQIC Documentation](https://genpipes.readthedocs.io/en/latest/deploy/access_gp_pre_installed.html#docs-access-gp-pre-installed) provided by C3G on how to use them.

---

### AlphaFold data repository from ComputeCanada CVMFS
---

On Grex, several Genomics data repositories are available thanks to the effort of the Alliance's Biomolecular National Teams. One of them is Alpha Fold. As of the time of writing this page, the current version of it can be seen as follows:

{{< highlight bash >}}
ls /cvmfs/bio.data.computecanada.ca/content/databases/Core/alphafold2_dbs/2024_01/
{{< /highlight >}}

Thus, Alphafold can be used on Grex using CC software stack as described [here](https://docs.alliancecan.ca/wiki/AlphaFold) .

A few other databases seems to be also available under:

{{< highlight bash >}}
/cvmfs/bio.data.computecanada.ca/content/databases/Core/
{{< /highlight >}} 

---

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* Last reviewed on: Oct 15, 2024.
-->
