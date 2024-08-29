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

On the special partition **test**, oversubscription is enabled in SLURM, to facilitate better turnaround of interactive jobs.

Jobs cannot run on several partitions at the same time; but it is possible to specify more than one partition, like in __-\-partition=compute,skylake__, so that the job will be directed by the scheduler to the first partition available.

Jobs will be rejected by the SLURM scheduler if partition's hardware and requested resources do not match (that is, asking for GPUs on compute, largemem or skylake partitions is not possible). So, in some cases, explicitly adding __-\-partition=__ flag to SLURM job submission is needed.

Jobs that require __stamps-b__ or __gpu__ or other GPU-containing partitions, have to use GPUs (with a corresponding TRES flag like _\-\-gpus=_), otherwise they will be rejected; this is to prevent bogging up the expensive GPU nodes with CPU-only jobs!

Currently, the following partitions are available on Grex:

### General purpose CPU partitions
---

| Partition    | Nodes   | CPUs/Node | CPUs     | Mem/Node | Notes              |
| :--------:   | :-----: | :-------: | :------: | :-----:  | :----:             |
| **skylake**  |  **42** |    **52** | **2184** |   96 Gb  | CascadeLakeRefresh |
| **largemem** |  **12** |    **40** |  **480** |  384 Gb  | CascadeLake        |
| **test**     |   **1** |    **18** |   **36** |  512 Gb  | **-**              |

<!--
| **-**        | **374** |     **-** | **6536** |   **-**  | **-**              |
-->

<!--
| **compute**  | **316** |    **12** | **3792** |   48 Gb  | SSE4.2             |
| **compute**  |   **4** |    **20** |   **80** |   32 Gb  | Avx                |
-->

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

### Contributed CPU partitions
---

| Partition         | Nodes   | CPU type                    | CPUs/Node    | Mem/Node    | Notes           |
| :--------:        | :-----: | :----:                      | :----------: | :--------:  | :---------:     |
| **mcordcpu** [^5] | **5**   | ** AMD EPYC 9634 84-Core**  | **168**      | **1500 Gb** | -               |

### Contributed GPU partitions
---

| Partition         | Nodes   | GPU type                   | CPUs/Node    | Mem/Node    | Notes           |
| :--------:        | :-----: | :----:                     | :----------: | :--------:  | :---------:     |
| **stamps** [^1]   | **3**   | **4 - V100/16GB**          | **32**       | **187 Gb**  | AVX512          |
| **livi**   [^2]   | **1**   | **HGX-2 16xGPU V100/32GB** | **48**       | **1500 Gb** | NVSwitch server |
| **agro**   [^3]   | **2**   | **AMD Zen**                | **24**       | **250 Gb**  | AMD             |
| **mcordgpu** [^4] | **5**   | **AMD EPYC 9634**          | **168**      | **1500 Gb** | -               |

[^1]: **stamps:** GPU nodes contributed by Prof. R. Stamps
[^2]: **livi:**   GPU node  contributed by Prof. L. Livi 
[^3]: **agro:**   GPU node  contributed by Faculty of Agriculture
[^4]: **mcordgpu** GPU nodes contributed by Prof. Marcos Cordeiro (Department of Agriculture). 
[^5]: **mcordcpu** CPU nodes contributed by Prof. Marcos Cordeiro (Department of Agriculture). 

<!--
- **stamps**   : three **4 x GPU v100/16GB** AVX512 nodes contributed by Prof. R. Stamps (Department of Physics and Astronomy).
- **livi**     : a **HGX-2 16xGPU V100/32GB**, NVSwitch server contributed by Prof. L. Livi (Department of Computer Science).
- **agro**     : two **24-core** AMD Zen, RAM 256 GB/node, two NVIDIA A30 GPUs per node, contributed by Faculty of Agriculture.
-->

### Preemptible partitions
---

The following **preemptible partition** are set for general use of the contributed nodes:

| Partition       | Contributed by         |
| :--------:      | :-----:                |
| **stamps-b**    | Prof. R. Stamps        |
| **livi-b**      | Prof. L. Livi          |
| **agro-b**      | Faculty of Agriculture |
| **mcordcpu-b**  | Prof M. Cunha Cordeiro |
| **mcordgpu-b**  | Prof M. Conha Cordeiro |

The former following partitions (**skylake**, **largemem**, **test** and **gpu**) are generally accessible. The other partitions (**stamps**, **livi**,  **agro**, **mcordcpu** and **mcordgpu**) are open only to the contributor's groups.

On the contributed partitions, the owners' group has preferential access. However, users belonging to other groups can submit jobs to one of the preemptible partitions (ending with **\-b**) to run on the contributed hardware as long as it is unused, on the condition that their jobs can be preempted (that is, killed) should owners' jobs need the hardware. There is a minimum runtime guaranteed to preemptible jobs, which is as of now 1 hour. The maximum wall time for the preemptible partition is set per partition (and can be seen in the output of the __sinfo__ command). To have a global overview of all partitions on Grex, run the custom script _**partition-list**_ from your terminal. 

> Note that the owners' and corresponding preeemptible partitions do overlap! This means, that owners' group should not submit their jobs to both of the contributed and the corresponding preemptible partitions, otherwise their jobs may preeempt their other jobs!


<!-- Changes and update:
* Last revision: Aug 28, 2024. 
-->
