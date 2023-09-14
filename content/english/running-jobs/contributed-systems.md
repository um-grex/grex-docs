---
weight: 1800
linkTitle: "Contributed nodes"
title: "Scheduling policies and running jobs on Contributed nodes"
description: "Everything you need to know about running jobs on contributed hardware."
categories: ["Scheduler"]
#tags: ["Configuration"]
---

## Scheduling policies for contributed systems
---
<!--
![](hpcc/grex-room-2020.png)
-->

Grex has a few user-contributed nodes. The owners of the hardware have preferred access to them. The current mechanism for the "preferred access" is preemption.

## On the definition of preferential access to HPC systems
---

Preferential access is when you have non-exclusive access to your hardware, in a sense that others can share in its usage over large enough periods. There are the following technical possibilities that rely on the HPC batch queueing technology we have. HPC makes access to CPU cores / GPUs / Memory exclusive per job, for the duration of the job (as opposed to time-sharing). Priority is a factor that decides which job gets to start (and thus exclude other jobs) first if there is a competitive situation (more jobs than free cores).

The owner is the owner of the contributed hardware. Others are other users. A **partition** is a subset of the HPC system’s compute nodes.

Preemption by partition: the contributed nodes have a SLURM partition on them, allowing the owner to use them, normally, for batch or interactive jobs. The partition is a “preemptor”. There is an overlapping partition, on the same set of the nodes but for the others to use, which is “pre-emptible”. Jobs in the pre-emptible partition can be killed after a set “grace period” (1 hour) as the owner's job enters the "preemptor" partition. If works, preempted jobs might be check-pointed rather than killed, but that’s harder to set up. Currently, it is not generally supported. If you have a code that supports checkpoint/restart at the application level, you can get most of the contributed nodes.

On Grex, the "preemptor" partition is named after the name of the owner PI, and the pre-emptible partitions named similarly but with added **\-b** suffix. Use the __-\-partition=__ option to submit the jobs with __sbatch__ and __salloc__ commands to select the desired partition.

## Contributed Nodes
---

As of now, the pre-emptible partitions are:

| Partition         | Nodes   | GPUs/Node    | CPUs/Node    | Mem/Node    | Notes           |
| :--------:        | :-----: | :----:       | :----------: | :--------:  | :---------:     |
| **stamps-b** [^1] | **3**   | **4**        | **32**       | **187 Gb**  | AVX512          |
| **livi-b**   [^2] | **1**   | **16**       | **48**       | **1500 Gb** | NVSwitch server |
| **agro-b**   [^3] | **2**   | **2**        | **24**       | **250 Gb**  | AMD             |

[^1]: **stamps-b:** GPU [**4 - V100/16GB**] nodes contributed by Prof. R. Stamps
[^2]: **livi-b:**   GPU [**HGX-2 16xGPU V100/32GB**] node  contributed by Prof. L. Livi
[^3]: **agro-b:**   GPU [**AMD Zen**] node contributed by Faculty of Agriculture

<!--
For more information, please refer to [Contributed Nodes](contributed-gpu-partitions) section.
-->

### Partition "stamps-b"
---

To submit a GPU job to **stamps-b** partition, please include the directive:

{{< highlight bash >}}
#SBATCH --partition=stamps-b
{{< /highlight >}}

in your job script or submit your jobs using:

{{< highlight bash >}}
sbatch --partition=stamps-b run-gpu-job.sh
{{< /highlight >}}

assuming that **run-gpu-job.sh** is the name of your job script.

Here is an example of script for running LAMMPS job on this partition:

{{< collapsible title="Script example for running LAMMPS on **stamps-b** partition" >}}
{{< snippet
    file="scripts/jobs/contributed/run-lmp-gpu-a.sh"
    caption="run-lmp-gpu.sh"
    codelang="bash"
/>}}
{{< /collapsible >}}

### Partition "livi-b"
---

To submit a GPU job to **livi-b** partition, please include the directive:

{{< highlight bash >}}
#SBATCH --partition=livi-b
{{< /highlight >}}

in your job script or submit your jobs using:

{{< highlight bash >}}
sbatch --partition=livi-b run-gpu-job.sh
{{< /highlight >}}

assuming that **run-gpu-job.sh** is the name of your job script.

Here is an example of script for running LAMMPS job on this partition:

{{< collapsible title="Script example for running LAMMPS on **livi-b** partition" >}}
{{< snippet
    file="scripts/jobs/contributed/run-lmp-gpu-b.sh"
    caption="run-lmp-gpu.sh"
    codelang="bash"
/>}}
{{< /collapsible >}}

### Partition "agro-b"
---

To submit a GPU job to **agro-b** partition, please include the directive:

{{< highlight bash >}}
#SBATCH --partition=agro-b
{{< /highlight >}}

in your job script or submit your jobs using:

{{< highlight bash >}}
sbatch --partition=agro-b run-gpu-job.sh
{{< /highlight >}}

assuming that **run-gpu-job.sh** is the name of your job script.

Here is an example of script for running LAMMPS job on this partition:

{{< collapsible title="Script example for running LAMMPS on **agro-b** partition" >}}
{{< snippet
    file="scripts/jobs/contributed/run-lmp-gpu-c.sh"
    caption="run-lmp-gpu.sh"
    codelang="bash"
/>}}
{{< /collapsible >}}

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* 
*
*
-->
