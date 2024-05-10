---
weight: 1000
linkTitle: "Grex Updates"
title: "OS, Lustre and Sogtware updates"
description: "List of major changes on Grex: software and hardware updates."
titleIcon: "fa-solid fa-house-chimney"
banner: true
bannerContent: "**OS and Lustre Update - May 2024**"
#categories: ["Functionalities"]
#tags: ["Content management"]
---

Please review a brief summary of the Grex upgrade and changes:

# Operating System: 
---

Grex is now running a new version of Linux (Alma Linux 8.x). All modern compute nodes are upgraded to Alma Linux. The only exception is made for the legacy nodes (bison, tatanka and the old “compute” partition) that are still running Centos-7.9. The reason for that is related to the local software stack {GrexEnv}. For more details, see the “Software Stacks'' section below.

# Storage:
---

The storage servers for home and project have been upgraded. The users’ data was not affected.

# Login nodes:
---

The login nodes “bison” and “tatanka” are still running Centos-7.9 and they can be used to compile programs using the GrexEnv and submit the jobs to compute partitions. 

The new login node “yak” was upgraded to Alma Linux. To submit jobs to any partition other than “compute”, please use the “yak” login node! 

# Software Stacks:
---

Grex has now 3 different software stacks:

## GrexEnv: 
---

This environment is enabled by default on bison, tatanka and the “compute” partition.

CCEnv:
This environment corresponds to the software stack from the Alliance which is the same used on national systems, like cedar, graham, beluga and narval. It can be used on yak and all partitions, except for the “compute” partition that has an old architecture.

# SBEnv:
---

This is a new software stack that is meant to be used on yak and all modern partitions on Grex {except for the legacy compute partition}. SBEnv stands for “Simplified Build Environment”. It already has different compilers (gcc/13.2.0; intel/2019.5, intel/2023.2, intel-one/2023.2, intel-one/2024.1;  intelmpi/2019.8; intelmpi/2021.10), OpenMPI (openmpi/4.1.6), some commercial software (ORCA, Gaussian), some restricted software to particular groups, like STAT. We have also added some tools and popular dependencies. We will continue to add more programs as they are requested by users. If you can not find the program or the module you want to use, please send us a request via {support@tech.alliancecan.ca} and we will install the module for you. If you have compiled locally your programs, you may have to re-compile them using the compilers available under this software stack!

# Scheduler: 
---

1) No major changes to mention about the scheduler since we are still using the same version as before the outage. The only significant change is as follows. Due to two versions of Linux and Software existing now on Grex (all modern CPU and GPU nodes running Alma8, and legacy “compute” , bison and tatanka still have CentOS7), we have limited job submission between the new and old hardware. That is, jobs to compute must be submitted from the “grex/bison/tatanka” login node, and jobs to anything else must be submitted from the “yak” login node. Eventually we will decommission the legacy “compute” hardware altogether. 

2) However, we are still working on enabling and testing Grex, SLURM and reservations are being gradually lifted. Not all jobs might be able to start right away. 

# Open OnDemand Web interface:
---
 
Right now, the interface fully works, including “Simplified Desktop” jobs, Files App. We are still working on porting all other OOD applications to Alma Linux and for that some of them may not yet be available. 

If you have questions or concerns, please don't hesitate to contact us at: support@tech.alliancecan.ca

**Your Grex Team**

<!-- Changes and update:
-->
