---
weight: 1000
title: "Slurm partitions"
description: "Everything you need to know about slurm partitions on Grex."
categories: ["Scheduler"]
tags: ["SLURM"]
---

## Partitions
---

The current Grex system that has contributed nodes, large memory nodes and contributed GPU nodes is (and getting more and more) heterogeneous. With SLURM, as a scheduler, this requires partitioning: a "partition" is a set of compute nodes, grouped by a characteristic, usually by the kind of hardware the nodes have, and sometimes by who "owns" the hardware as well. 

There is no fully automatic selection of partitions, other than the default __skylake__ for most of the users for the short jobs. For the contributors' group members, the default partition will be their contributed nodes. **Thus, in many cases users have to specify the partition manually when submitting their jobs!**

On the special partition **test**, oversubscription is enabled in SLURM, to facilitate better turnaround of interactive jobs.

Jobs cannot run on several partitions at the same time; but it is possible to specify more than one partition, like in __-\-partition=skylake,largemem__, so that the job will be directed by the scheduler to the first partition available.

Jobs will be rejected by the SLURM scheduler if partition's hardware and requested resources do not match (that is, asking for GPUs on compute, largemem or skylake partitions is not possible). So, in some cases, explicitly adding __-\-partition=__ flag to SLURM job submission is needed.

Jobs that require __stamps-b__ or __gpu__ or other GPU-containing partitions, have to use GPUs (with a corresponding TRES flag like _\-\-gpus=_), otherwise they will be rejected; this is to prevent bogging up the expensive GPU nodes with CPU-only jobs!

Currently, the following partitions are available on Grex:

### General purpose CPU partitions
---

| Partition    | Nodes   | CPUs/Node | CPUs     | Mem/Node | Notes              |
| :--------:   | :-----: | :-------: | :------: | :-----:  | :----:             |
| **skylake**  |  **42** |    **52** | **2184** |  187 Gb  | CascadeLakeRefresh |
| **largemem** |  **12** |    **40** |  **480** |  380 Gb  | CascadeLake        |
| **genoa**    |  **27** |   **192** | **5184** |  750 Gb  | AMD EPYC 9654      |
| **genlm**    |  **3**  |   **192** |  **576** | 1500 Gb  | AMD EPYC 9654      |
| **test**     |  **1**  |    **18** |   **36** |  512 Gb  | CascadeLake        |

> All CPU partitions support a common subset of the AVX512 architecture. However, AMD EPYC CPUs have Zen4 architecture with extended set of AVX512 commands compared to CascadeLake. Thus host-optimized code compiled on __genoa__ or __genlm__ nodes may throw 'illegal instruction' error on __skylake__ and __largemem__ nodes

<!--
| **-**        | **374** |     **-** | **6536** |   **-**  | **-**              |
-->

<!--
| **compute**  | **316** |    **12** | **3792** |   48 Gb  | SSE4.2             |
| **compute**  |   **4** |    **20** |   **80** |   32 Gb  | Avx                |
-->

### General purpose GPU partitions
---

| Partition  | Nodes   | GPU type           | CPUs/Node    | Mem/Node   | Notes               |
| :--------: | :-----: | :----:             | :----------: | :--------: | :---------:         |
| **gpu**    |  **2**  | **4 - V100/32GB**  | **32**       | **187 Gb** | Intel AVX512 CPU, NVLink  |
| **lgpu**    |  **1**  | **2 - L40s/48GB**  | **64**       | **380 Gb** | AMD AVX512 CPU  |


### Contributed CPU partitions
---

| Partition         | Nodes   | CPU type                   | CPUs/Node    | Mem/Node    | Notes           |
| :--------:        | :-----: | :----:                     | :----------: | :--------:  | :---------:     |
| **mcordcpu** [^5] | **5**   | **AMD EPYC 9634 84-Core**  | **168**      | **1500 Gb** | -               |
| **chrim**  | **4**   | **AMD EPYC 9654 96-Core**  | **192**      | **750 Gb** | -               |
| **chrimlm**  | **1**   | **AMD EPYC 9654 96-Core**  | **192**      | **1500 Gb** | -               |

### Contributed GPU partitions
---

| Partition         | Nodes   | GPU type                   | CPUs/Node    | Mem/Node    | Notes                |
| :--------:        | :-----: | :----:                     | :----------: | :--------:  | :---------:          |
| **stamps** [^1]   | **3**   | **4 - V100/16GB**          | **32**       | **187 Gb**  | AVX512 CPU, NVLink   |
| **livi**   [^2]   | **1**   | **16 -V100/32GB**          | **48**       | **1500 Gb** | NVSwitch, AVX512 CPU |
| **agro**   [^3]   | **2**   | **2 - A30/24GB**           | **24**       | **250 Gb**  | AMD AVX2 CPU         |
| **mcordgpu** [^4] | **2**   | **4 - A30/24GB**           | **32**       | **512 Gb**  | AMD AVX2 CPU         |

> Note that newer GPU nodes with NVidia A30 GPUs have an older CPU architecture, up to AVX2 instruction set. Host-optimized code compiled on a CascadeLake or AMD Genoa CPU which have AVX512 instruction set will throw 'illegal instruction' errors on the AVX2 GPU nodes. 

[^1]: **stamps:** GPU nodes contributed by Prof. R. Stamps
[^2]: **livi:**   GPU node  contributed by Prof. L. Livi 
[^3]: **agro:**   GPU node  contributed by the Faculty of Agriculture
[^4]: **mcordgpu** GPU nodes contributed by Prof. Marcos Cunha Cordeiro 
[^5]: **mcordcpu** CPU nodes contributed by Prof. Marcos Cunha Cordeiro 


### Preemptible partitions
---

The following **preemptible partition** are set for general use of the contributed nodes:

| Partition       | Contributed by         |
| :--------:      | :-----:                |
| **stamps-b**    | Prof. R. Stamps        |
| **livi-b**      | Prof. L. Livi          |
| **agro-b**      | Faculty of Agriculture |
| **genoacpu-b**  | Spans all contributed AMD CPU nodes from Prof M. Cunha Cordeiro and CHRIM |
| **mcordgpu-b**  | Prof M. Cunha Cordeiro |

The following partitions (**skylake**, **largemem**, **test**, **gpu**, **lgpu**) are generally accessible. The other partitions (**stamps**, **livi**,  **agro**, **mcordcpu** and **mcordgpu**, **chrim** and **chrimlm** ) are open only to the contributor's groups.

On the contributed partitions, the owners' group has preferential access. However, users belonging to other groups can submit jobs to one of the preemptible partitions (ending with **\-b**) to run on the contributed hardware as long as it is unused, on the condition that their jobs can be preempted (that is, killed) should owners' jobs need the hardware. There is a minimum runtime guaranteed to preemptible jobs, which is as of now 1 hour. The maximum wall time for the preemptible partition is set per partition (and can be seen in the output of the __sinfo__ command). To have a global overview of all partitions on Grex, run the custom script _**partition-list**_ from your terminal. 

> Note that the owners' and corresponding preeemptible partitions do overlap! This means, that owners' group should not submit their jobs to both of the contributed and the corresponding preemptible partitions, otherwise their jobs may preeempt their other jobs!


<!-- Changes and update:
* Last revision: Jun 11, 2025. 
-->
