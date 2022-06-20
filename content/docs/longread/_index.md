---
weight: 1
bookFlatSection: true
title: "Notes of Grex Changes"
date: 2019-12-11
---

# Grex changes: Linux/SLURM update project.

**December 10-11, 2019**

## Introduction / Motivation {#introduction-motivation}

**Grex** runs an old version of CentOS 6, which gets unsupported in 2020. The 2.6.x Linux kernel that is shipped with CentOS 6 does not support containerized workloads that require recent kernel features. The Lustre parallel filesystem client had some troubles that we were unable to resolve with CentOS 6 kernel version as well. Finally, the original Grex resource management software, Torque 2.5 and Moab7 are unable to properly schedule jobs that use newer MPI implementations (OpenMPI 2 and 3), which are increasingly common amongst HPC users. Therefore, using the power outages of October and December 2019, we have embarked on a rather ambitious  project of updating entire Grex OS and software stack and scheduling to CentOS 7 and SLURM. This document outlines the changes and how they will affect Grex users.

## Connecting to Grex

Grex is still using Westgrid accounting system (Portal/LDAP). To connect to Grex, one needs an active Compute Canada account and a Westgrid consortium account linked to it. You are likely to have one.

### Hosts to connect to

{{< hint info >}}
* During the outage, most of the Grex compute nodes, and all the contributed systems have been reprovisioned to CentOS 7. Public access login nodes, **bison.westgrid.ca** and **tatanka.westgrid.ca** (and their DNS alias, **grex.westgrid.ca** ) give the new CentOS 7.6 / SLURM / LMOD environment.

* A test node, **aurochs.westgrid.ca** was preserved in the original CentOS 6 state, as well as about 600 cores of the Grex compute nodes. Logging in to aurochs for now allows users access to the original Grex environment (Torque, Moab, Tcl-Modules). We plan to eventually decommission the CentOS 6 partition when the CentOS 7 is debugged and fully in production.
{{< /hint >}}

### Command line access via SSH clients 

Because Grex login nodes were reinstalled, SSH clients might give either a warning or an error for not recognizing the Grex host keys. Remove the offending keys from the file **~/.ssh/known_hosts** mentioned in the error message.

### Graphical access with X2go

The new CentOS 7 supports X2Go connections to use GUI applications. However, the **~~GNOME Desktop environment~~** that was default in CentOS 6 is no longer available! Please use either **ICEWM** or **OPENBOX** Desktop environment in the X2Go client to connect. 

Because X2Go is using SSH under the hood to establish the connection, the advice above about **~/.ssh/known_hosts** holds: delete the old SSH keys from it if you have connection problems. On Windows, it is often located under C:\\Users\\**username**\\.ssh\\known_hosts. 

## Storage

Lustre storage (/global/scratch) was updated to Lustre 2.10.8 on both server and client sides. We have ran our extensive tests and observed an increase of the write throughputs for large parallel I/O up to 3x. The change should be transparent to Grex users.

## Software, Interconnect, LMOD, CC/local stacks

### Interconnect and communications libraries

Grex's HPC interconnect hardware is no longer officially supported by commercial MLNX IB Verbs drivers. At the same time, open source projects like RDMA-Core and the new universal interconnect, UCX almost reached maturity and superior performance. Therefore, for the Grex software update, we have opted for vanilla Kernel drivers for our Infiniband, RDMA-Core for verbs userland libraries and UCX for the communication layer for the new OpenMPI versions, of which we support **OpeMPI 3.1.4 (the new default)** and 4.0.2 (An experimental, bleeding edge MPI v3 standard implementation that obsoletes many old MPI features). The previous default version **OpenMPI 1.6.5** is still supported, and still uses IB Verbs from RDMA-core. 

Users that have codes directly linked against any IBVerbs or other low level MLNX libraries, or having fixed RPATH to the old OpenMPI binaries will have to recompile their codes! 

### Software Modules: LMOD

This is a most major change! We have made obsolete the tried and tested flat, TCL-based software Modules system in favour of Lmod. Lmod is a new software Module system developed by Robert McLay at TACC. The main difference between Lmod and TCL-mod is that Lmod is built to have a hierarchical module structure: it ensures that no modules of the same “kind” can be loaded simultaneously; that there be no deep module paths like _“intel/ompi/1.6.5_” or “_netcdf/pnetcdf-ompi165-nc433_” . Rather, users will load “root” modules first and dependent modules second. That is, instead of TCL-mode’s way on the old system (loading OpenMPI for Intel-14 compilers:

{{< hint slurm >}}
{{< highlight bash >}}
module load intel/14.0.2.144
module load intel/ompi/1.6.5
{{< /highlight >}}
{{< /hint >}}
 
The new Lmod way would be:

{{< hint slurm >}}
{{< highlight bash >}}
module load intel/14.0.2.144
module load ompi/1.6.5
{{< /highlight >}}
{{< /hint >}}

The hierarchy ensures that only a good **ompi/1.6.5** module that corresponds to the previously loaded Intel-14 compilers gets loaded. Note that swapping the compiler modules (Intel to GCC or Intel 14 to Intel 15) results in automatic reload of the dependent modules, if possible. Loading two versions of the same modules simultaneously is no longer possible! This largely removes the need for “_module purge”_ command.

In the hierarchical module system, dependent modules are not visible for “_module avail_” unless their dependencies are loaded. To figure what modules are available use now “_module spider_” instead. 

For more information and features, visit the official documentation of [Lmod](https://lmod.readthedocs.io/en/latest/010_user.html) and/or Compute Canada documentation for [modules](https://docs.computecanada.ca/wiki/Utiliser_des_modules/en). 

We have tried to preserve the module names and paths closest to the original TCL-modules on Grex, whenever that was possible with the new hierarchy format. Note that the hierarchy is not “complete”: not every combination of software, compilers, and MPI exists on Grex, for practical reasons. Use "_module spider <name of the software>/<version>_" to check what built variants are there. Send us a request to [support@computecanada.ca](mailto:support@tech.alliancecan.ca) if there is any missing software/toolchain combination you may want to use.

#### Software Modules: Stacks , CVMFS, Defaults

One of the nice features of Lmod is its ability to maintain several software stacks at once. We have used it and now provide the following software stacks modules. The modules are “sticky” which means, one of them is always loaded. (Use module avail to see them). _GrexEnv_ (default), _OldEnv_ and _CCEnv_ . 

1. _GrexEnv_ is the current Grex default software environment, (mostly) recompiled to CentOS-7. Note that **we do not load Intel compilers and OpenMPI modules by default** anymore, in contrast to the old environment of Grex. The recompilation is mostly done, but not completely: should you miss a software item, please contact us!

2. _OldEnv_ is an Lmod-ized version of the old CentOS-6 modules, should you need it for compatibility reasons. The software (except OpenMPI) is as it was before (not recompiled). It _may_ run on CentOS-7. 
 
3. _CCEnv_ is the full Compute Canada software stack, brought to Grex via Cern Virtual Filesystem (CVMFS). We use the “sse3” software stack of Compute Canada because this is the one that suits our older hardware. Note that the **default CC environment (_StdEnv_, _nixpkgs_) are NOT loaded by default** on Grex! In order to access the CC software, they have to be loaded after the CCEnv as follows. (Note that first load of the CC modules and software items might take a few seconds! It is probably a good practice to first access a CC software binary in a small interactive job to warm the local cache).

{{< hint slurm >}}
{{< highlight bash >}}
module load CCEnv
module load StdEnv/2016.4 nixpkgs/16.09 arch/sse3
module avail
{{< /highlight >}}
{{< /hint >}}
 
The CC software stack is documented at Compute Canada wiki: [Available_software](https://docs.computecanada.ca/wiki/Available_software)  page. A caveat: it is in general impossible to isolate and containerize high-performance software completely, so not all CC CVMFS software might work on Grex: the most troublesome parts are MPI and CUDA software that rely on low level hardware drivers and direct memory access. Threaded SMP software and serial software we expect to run without issues. 

Note that for Contributed systems it might be beneficial to use different architecture than the default SSE3, which is available at loading corresponding _arch/_ module.	

##  Running jobs, migration to SLURM

CentOS-7 provides a different method of process isolation (cgroups). It also allows for better support of containers such as Singularity which (hopefully) can now be run in user namespaces. Incidentally, the cgroups are not supported well by any Torque/Moab scheduler version that was compatible with our current Moab software license. Torque is not known to support the new process management interface (PMIX) that increasingly becoming a standard for MPI libraries either. Therefore, we had little choice but to migrate our batch workload management from Torque to SLURM. It wil also make Grex more similar to Compute Canada machines (which are documented here: [Running_jobs](https://docs.computecanada.ca/wiki/Running_jobs)).

Unlike Torque which is a monolithic, well engineered piece of software that we knew well, SLURM is a very modular, plugin-based ecosystem which is new to us. Therefore, **initially we will enable only short walltimes to test our SLURM configuration (48h)** before going to full production.

### Torque wrappers

To make life easier for PBS/Torque users, SLURM developers provided most of the Torque commands as wrappers over SLURM commands. So with some luck, you can continue using qsub, qstat, pbsnodes etc. keeping in mind correspondence between Torque’s queues and SLURM partitions. For example:

{{< hint slurm >}}
sbatch --allocation=abc-668-aa --partition=compute my.job
{{< /hint >}}

Can be called using Torque syntax as:

{{< hint slurm >}}
qsub -A abc-668-aa -q compute my.job
{{< /hint >}}

Presently, and unlike old Grex, there is no automatic queue/partition/QOS assignment based on jobs resource request. The option __-\-partition__ must be selected explicitly for using High Memory and contributed nodes, if you have access to the later. By default, jobs go into “__compute__” partition comprised of the original 48 GB, 12 Nehalem CPUs nodes. The command __qstat -q__ now actually lists partitions (which it thinks being queues).

###  Interactive Jobs

As before, and as usual for HPC systems, we ask users to limit their work on login nodes to code development and small, infrequent test runs and to use interactive jobs for **longer and/or heavier** interactive workloads.

Interactive jobs can be done using SLURM __salloc__ command as well as using __qsub -I__ . The one limitation for the later is there for graphical jobs: the latest and greatest SLURM 19.05 supports __-\-x11__ flags natively for salloc, but does not support yet corresponding __qsub -I -X__ flags for the Torque wrapper. So graphical interactive jobs are only possible with __salloc__.

Another limitation of qsub is the syntax: SLURM does distinguish between __-\-ntasks=__ for MPI parallel jobs and __-\-cpus-per-task=__ for SMP threaded jobs; while for qsub it is all the same for its __-l nodes=1:ppn=__ syntax. Therefore, the SMP threaded applications might not be placed correctly with the jobs submitted with qsub.

### Batch Jobs.

There are two changes: need to specify partitions explicitly and short maximal walltimes during initial Grex testing. Resource allocations for Grex RAC 2019-2020 will be implemented in the SLURM scheduler. Two useful commands: __sshare__ (shows your groups fairshare parameters) and __seff__ (shows efficiency of your jobs: CPU and memory usage) might help with effective usage of your allocation. 

In general, Compute Canada documentation on running SLURM jobs can be followed, obviously with the exception of different core count on Grex nodes. Presently, we schedule on Grex by CPU core (as opposed to by-node) so whole-node jobs do not get any particular prioritization. 

For the local scratch directories, __$TMPDIR__ should be used in batch scripts on Grex (as opposed to Compute Canada where $SLURM_TMPDIR is defined). Thus, for using software from Compute Canada stack that has references to SLURM_TMPDIR hardcoded in some scripts it relies on (an example being GAMESS-US) the following line should be added on Grex to your job scripts: 

{{< hint slurm >}}
export SLURM_TMPDIR=$TMPDIR
{{< /hint >}}

<!-- Docs to Markdown version 1.0β17 -->
