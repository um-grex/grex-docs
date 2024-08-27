---
weight: 1000
linkTitle: "Grex Updates"
#title: "OS, Lustre and Software updates"
#description: "List of major changes on Grex: software and hardware updates."
title: "Grex upgrade: SISF2023 - Aug 26 -Sep 6, 2024"
description: "List of major changes on Grex: Hardware, cooling and power upgrades."
titleIcon: "fa-solid fa-house-chimney"
banner: true
#bannerContent: "**OS and Lustre Updates - May 2024**"
bannerContent: "**Grex upgrade: SISF2023 - Aug 26 -Sep 6, 2024.**"
#categories: ["Functionalities"]
#tags: ["Content management"]
---

Please review the brief summary of the Grex upgrades and changes that are done during the outage of **Aug 26 -Sep 6, 2024.**

# Operating System: 
---

Grex is now running a new version of Linux (__Alma Linux 8.10_). All compute nodes are upgraded to Alma Linux. 

# Login nodes:
---

* The login nodes __bison__ and __tatanka__ are offline.

* The login node __yak__ was upgraded to __Alma Linux.__ This is the only login node that you can use for now. To connect to Grex, use:

{{< highlight bash >}}
ssh -XY username@yak.hpc.umanitoba.ca
{{< /highlight >}}

* OOD is down during the outage. 

# Partitions
---

The following general purpose partitions are running Alma Linux:

* __skylake__ 
* __largemem__
* __gpu__
* __testgenoa__

# Legacy nodes:
---

As of Aug 29, 2024, the legacy nodes (bison, tatanka and **compute** partitions) are decommissions.

# Storage:
---

The storage servers for __/home__ and __/project__ are online. Users can have access and/or transfer data as needed. Please note that you can not submit jobs at this time. 

# Software Stacks:
---

Grex is now running one operating systems:

* __Alma Linux:__ This OS is running on the new login node __yak__ and __zebu__ (that serves as a host for OOD). All other partions {except for __compute__} are running Alma Linux.

The new sotftware stack __SBEnv__ is set as default.

## SBEnv:
---

This is a new software stack that is meant to be used on __yak__ and all __modern partitions__ on Grex {except for the legacy __compute__ partition}. __SBEnv__ stands for __Simplified Build Environment__. 

__SBEnv__ has already:

* different compiler versions for Intel and GCC suites: gcc/13.2.0; intel/2019.5, intel/2023.2, intel-one/2023.2, intel-one/2024.1;  intelmpi/2019.8; intelmpi/2021.10
* a new AOCC compiler suite for new AMD nodes (__testgenoa__ and __mcordcpu-b__ partitions): aocc/4.2.0
* OpenMPI (openmpi/4.1.6 is the default version to be used in most cases)
* some commercial software (ORCA, Gaussian)
* some restricted software to particular groups, like stata, vasp, adf. 
* some tools and popular dependencies. 

We will continue to add more programs as they are requested by users. If you can not find the program or the module you want to use, please send us a request via __support@tech.alliancecan.ca__ and we will install the module for you. 

{{< alert type="warning" >}}
If you have compiled locally your programs, you may have to re-compile them using the compilers available under this software stack.
{{< /alert >}}

Since this is a new software stack managed by a different package manager, the names of the modules may have changed compared to the old software stack. For example, the modules that have _uofm_ under their name, they no longer show this name. For example, instead of __uofm/adf__, the module name is __adf__. 

The better way to find modules and see how to load them is to run the usual command:

{{< highlight bash >}}
module spider <name of the program>
{{< /highlight >}}

## CCEnv
---

This environment corresponds to the software stack from the Alliance which is the same used on national systems, like cedar, graham, beluga and narval. It can be used on yak and all partitions, except for the __compute__ partition that has an old architecture.

To use it on Grex, you should first load the following modules on this odrer:

{{< highlight bash >}}
module load CCEnv
module load arch/avx512
module load StdEnv/2023
{{< /highlight >}}

Then use __module spider__ to search for other modules under this environment.

<!--
From the outage of May 2024:

Please review the brief summary of the Grex upgrades and changes that are done during the outage of **May 2024**:

# Operating System: 
---

Grex is now running a new version of Linux (__Alma Linux 8.x__). All modern compute nodes are upgraded to Alma Linux. 
The following general purpose partitions are running Alma Linux: 

* __skylake__ 
* __largemem__
* __gpu__
* __testgenoa__

The only exception is made for the legacy nodes (__bison__, __tatanka__ and the old __compute__ partition) that are still running __Centos-7.9.__ The reason for that is related to the local software stack __GrexEnv__. For more details, see the __Software Stacks__ section below.

# Storage:
---

The storage servers for __/home__ and __/project__ have been upgraded. The users’ data was not affected.

# Login nodes:
---

* The login nodes __bison__ and __tatanka__ are still running __Centos-7.9__ and they can be used to compile programs using the __GrexEnv__ and submit the jobs to __compute__ partition. 

* The new login node _yak__ was upgraded to __Alma Linux.__ This node can be used to compile codes under the new environment __SBEnv__ that is loaded by default. From this node, tou can submit jobs to all partitions, except to __compute__ partition. If submitted to __compute__ partition, the scheduler will not even accept the job at submission time. From this node, you should be able to use the following partitions: __skylake__, __largemem__, and other contributed partitions, like __livi-b__ and __mcordcpu-b__. 

# Software Stacks:
---

As mentioned above, Grex is running two operating systems:

* __Alma Linux:__ This OS is running on the new login node __yak__ and __zebu__ (that serves as a host for OOD). All other partions {except for __compute__} are running Alma Linux.

* __Centos-7.9:__ This OS is running on the login nodes __bison__ and __tatanka__. The old __compute__ partition is also running Cento-7.9.

For convenience, we have kept the old software stacks __GrexEnv__ as it was before the outage. This can be only used for running jobs on __compute__ partition. 

For other partitions, we have deployed a new sotftware stack __SBEnv__ that is set as default when connecting to __yak__.

After the outage of May 2024, Grex has 3 different software stacks:

## SBEnv:
---

This is a new software stack that is meant to be used on __yak__ and all __modern partitions__ on Grex {except for the legacy __compute__ partition}. __SBEnv__ stands for __Simplified Build Environment__. 

__SBEnv__ has already:

* different compiler versions for Intel and GCC suites: gcc/13.2.0; intel/2019.5, intel/2023.2, intel-one/2023.2, intel-one/2024.1;  intelmpi/2019.8; intelmpi/2021.10
* a new AOCC compiler suite for new AMD nodes (__testgenoa__ and __mcordcpu-b__ partitions): aocc/4.2.0
* OpenMPI (openmpi/4.1.6 is the default version to be used in most cases)
* some commercial software (ORCA, Gaussian)
* some restricted software to particular groups, like stata, vasp, adf. 
* some tools and popular dependencies. 

We will continue to add more programs as they are requested by users. If you can not find the program or the module you want to use, please send us a request via __support@tech.alliancecan.ca__ and we will install the module for you. 

{{< alert type="warning" >}}
If you have compiled locally your programs, you may have to re-compile them using the compilers available under this software stack.
{{< /alert >}}

Since this is a new software stack managed by a different package manager, the names of the modules may have changed compared to the old software stack. For example, the modules that have _uofm_ under their name, they no longer show this name. For example, instead of __uofm/adf__, the module name is __adf__. 

The better way to find modules and see how to load them is to run the usual command:

{{< highlight bash >}}
module spider <name of the program>
{{< /highlight >}}

## GrexEnv
---

This environment is enabled by default on __bison__, __tatanka__ and the __compute__ partition. This environment was not changed and it is kept in the same state as before the outage. Now, it can be only used to run jobs on __compute__ partition.


## CCEnv
---

This environment corresponds to the software stack from the Alliance which is the same used on national systems, like cedar, graham, beluga and narval. It can be used on yak and all partitions, except for the __compute__ partition that has an old architecture.

To use it on Grex, you should first load the following modules on this odrer:

{{< highlight bash >}}
module load CCEnv
module load arch/avx512
module load StdEnv/2023
{{< /highlight >}}

Then use __module spider__ to search for other modules under this environment.

# Scheduler: 
---

 * No major changes to mention about the scheduler since we are still using the same version as before the outage. 
 * One significant change is as follows. Due to two versions of Linux and Software co-existing now on Grex (all modern CPU and GPU nodes running Alma Linux, and legacy __compute__ , bison and tatanka still have CentOS7), we have limited job submission between the new and old hardware. That is, jobs to compute must be submitted from the __grex/bison/tatanka__ login node, and jobs to anything else must be submitted from the __yak__ login node. Eventually we will decommission the legacy __compute__ hardware altogether. 
 * If no partition is specified, the default will be either **skylake** or **compute** depending on the job submission host, as per above.
>  NEW : another significant change introduced on Jun 19, 2024: For users that have more than one Account (that is, working for more than one research group), SLURM on Grex will no longer try to assume which of the accounts is default. Instead, _sbatch_ and _salloc_ would ask to provide the _--account=_ opton explicitly, list the possible accounts, and stop. If you are a member of more than one group, always specify the account you intend to be used for the job!

# Open OnDemand Web interface:
---
 
Right now, the interface fully works, including “Simplified Desktop” jobs, Files App. We are still working on porting all other OOD applications to Alma Linux and for that some of them may not yet be available. 

# Workflow summary
---

As a summary of the changes, there are two workflows on Grex now:

* __New environment:__

> * connect via __yak.hpc.umanitoba.ca__
> * Use the new environment __SBEnv__ for modules and/or compile your programs.
> * Submit your jobs to __skylake__, __largemem__ or any other partition, except for __compute__. For a complete list of partitions, run the command __partition-list__ from your terminal
> * You could also use __CCEnv__ as shown above.

* __Old environment:__

> * connect via __grex.hpc.umanitoba.ca__
> * Use the new environment __GrexEnv__ for modules and/or compile your programs.
> * Submit your jobs to __compute__ partition.

If you have questions or concerns, please don't hesitate to contact us at: support@tech.alliancecan.ca

**Your Grex Team**

-->

<!-- Changes and update:
-->
