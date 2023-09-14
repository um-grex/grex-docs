---
weight: 1000
title: "Slurm partitions"
description: "Everything you need to know about slurm partitions on Grex."
categories: ["Scheduler"]
#tags: ["Content management"]
---

## Partitions
---

The current Grex system that has contributed nodes, large memory nodes and contributed GPU nodes is (and getting more and more) heterogeneous. With SLURM, as a scheduler, this requires partitioning: a "partition" is a set of compute nodes, grouped by a characteristic, usually by the kind of hardware the nodes have, and sometimes by who "owns" the hardware as well. 

There is no fully automatic selection of partitions, other than the default __skylake__ for most of the users, and __compute__ for the short jobs. For the contributors' group members, the default partition will be their contributed nodes. **Thus, in many cases users have to specify the partition manually when submitting their jobs!**

Currently, the following partitions are available on Grex:

### General purpose CPU partitions
---

| Partition    | Nodes   | CPUs/Node | CPUs     | Mem/Node | Notes              |
| :--------:   | :-----: | :-------: | :------: | :-----:  | :----:             |
| **skylake**  |  **42** |    **52** | **2184** |   96 Gb  | CascadeLakeRefresh |
| **largemem** |  **12** |    **40** |  **480** |  384 Gb  | CascadeLake        |
| **compute**  | **316** |    **12** | **3792** |   48 Gb  | SSE4.2             |  
| **compute**  |   **4** |    **20** |   **80** |   32 Gb  | Avx                |
| **-**        | **374** |     **-** | **6536** |   **-**  | **-**              |

### General purpose GPU partitions
---

| Partition  | Nodes   | GPU type           | CPUs/Node    | Mem/Node   | Notes       |
| :--------: | :-----: | :----:             | :----------: | :--------: | :---------: |
| **gpu**    |  **2**  | **4 - V100/32 GB** | **32**       | **187 Gb** | **AVX512**  |

<!--
> - **skylake**  : the new **52-core**, CascadeLakeRefresh compute nodes, 96 Gb/node (set as the default partition). **NEW**
> - **largemem** : the new **40-core**, CascadeLake compute nodes, 384 Gb/node.  **NEW**
> - **compute**  : the original SSE4.2 **12-core** Grex nodes, RAM 48 Gb/node (no longer set as the default partition for jobs over 30 minutes).
> - **gpu**      : two GPU **V100/32 GB** AVX512 nodes, RAM 192 GB/node. **NEW**
> - **test**     : a **24-core** Skylake CPU Dell large memory (512 GB), NVMe workstation for interactive work and visualizations. **NEW**
-->

### Contributed GPU partitions
---

| Partition       | Nodes   | GPU type                   | CPUs/Node    | Mem/Node    | Notes           |
| :--------:      | :-----: | :----:                     | :----------: | :--------:  | :---------:     |
| **stamps** [^1] | **3**   | **4 - V100/16GB**          | **32**       | **187 Gb**  | AVX512          |
| **livi**   [^2] | **1**   | **HGX-2 16xGPU V100/32GB** | **48**       | **1500 Gb** | NVSwitch server |
| **agro**   [^3] | **2**   | **AMD Zen**                | **24**       | **250 Gb**  | AMD             |

[^1]: **stamps:** GPU nodes contributed by Prof. R. Stamps
[^2]: **livi:**   GPU node  contributed by Prof. L. Livi 
[^3]: **agro:**   GPU node  contributed by Faculty of Agriculture

<!--
- **stamps**   : three **4 x GPU v100/16GB** AVX512 nodes contributed by Prof. R. Stamps (Department of Physics and Astronomy).
- **livi**     : a **HGX-2 16xGPU V100/32GB**, NVSwitch server contributed by Prof. L. Livi (Department of Computer Science).
- **agro**     : two **24-core** AMD Zen, RAM 256 GB/node, two NVIDIA A30 GPUs per node, contributed by Faculty of Agriculture.
-->

### Preemptible partitions
---

The following **pre-emptible partition** are set for general use of the contributed nodes:

| Partition       | Contributed by |
| :--------:      | :-----: |
| **stamps-b**    | Prof. R. Stamps|
| **livi-b**      | Prof. L. Livi |
| **agro-b**      | Faculty of Agriculture |

The former five partitions (**skylake**, **compute**, **largemem**, **test** and **gpu**) are generally accessible. The next three partitions (**stamps**, **livi** and **agro**) are open only to the contributor's groups.

On the contributed partitions, the owners' group has preferential access. However, users belonging to other groups can submit jobs to one of the pre-emptible partitions (ending with **\-b**) to run on the contributed hardware as long as it is unused, on the condition that their jobs can be preempted (that is, killed) should owners' jobs need the hardware. There is a minimum runtime guaranteed to pre-emptible jobs, which is as of now 1 hour. The maximum wall time for the pre-emptible partition is set per partition (and can be seen in the output of the __sinfo__ command). To have a global overview of all partitions on Grex, run the custom script **partition-list** from your terminal. 

On the special partition **test**, oversubscription is enabled in SLURM, to facilitate better turnaround of interactive jobs.

Jobs cannot run on several partitions at the same time; but it is possible to specify more than one partition, like in __-\-partition=compute,skylake__, so that the job will be directed by the scheduler to the first partition available.

Jobs will be rejected by the SLURM scheduler if partition's hardware and requested resources do not match (that is, asking for GPUs on compute, largemem or skylake partitions is not possible). So, in some cases, explicitly adding __-\-partition=__ flag to SLURM job submission is needed.

Jobs that require __stamps-b__ or __gpu__ partitions have to use GPUs, otherwise they will be rejected; this is to prevent of bogging up the precious GPU nodes with CPU-only jobs!

<!-- Changes and update:
* 
*
*
-->
