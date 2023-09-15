---
weight: 1200
linkTitle: "Interactive jobs"
title: "How to run interactive jobs on Grex?"
description: "Everything you need to know for running interactive jobs on Grex."
categories: ["Scheduler"]
#tags: ["Configuration"]
---

## Interactive work
---

The login nodes of Grex are shared resources and should be used for basic operations such as (but not limited) to:

> * edit files
> * compile codes and run short interactive calculations.
> * configure and build programs (limit the number of threads to 4: make -j4)
> * submit and monitor jobs
> * transfer and/or download data
> * run short tests, ... etc. 

In other terms, anything that is not CPU, nor memory intensive [for example, a test with up to 4 CPUs, less than 2 Gb per core for 30 minutes or less].

{{< alert type="warning" >}}
To not affect other user's experience, please be aware that we reserve to ourselves the right to terminate any intensive process running on the login nodes without prior warning.
{{< /alert >}}

It is very easy to cause resource congestion on a shared Linux server. Therefore, all production calculations should be submitted in the batch mode, using our resource management system, SLURM. It is possible to submit so-called __interactive jobs__: a job that creates an interactive session but actually runs on dedicated CPUs (and GPUs if needed) on the compute nodes rather than on the login servers (or head nodes). Note that login nodes do not have GPUs.

Such mode of running interactive computations ensures that login nodes are not congested. A drawback is that when a cluster is busy, getting an interactive job to start will take some queuing time, just like any other job. So, in practice interactive jobs are to be short and small to be able to utilize backfill-able nodes. This section covers how to run such jobs with SLURM.

Note that manual SSH connections to the compute nodes without having active running jobs is forbidden on Grex.

## Interactive batch jobs
---

To request an interactive job, the **salloc** command should be used. These jobs are not limited to single node jobs; any nodes/tasks/gpus layout can be requested by salloc in the same way as for sbatch directives. However, to minimize queuing time, usually a minimal set of required resources should be used when submitting interactive jobs (less than 3 hours of wall time, less than 4 GB memory per core, ... etc). Because there is no batch file for interactive jobs, all the resource requests should be added as command line options of the **salloc** command. The same logic of __-\-nodes=__,  __-\-ntasks-per-node=__ , __-\-mem=__ and __-\-cpus-per-task=__ resources as per batch jobs applies here as well.

For a threaded SMP code asking for half a node for two hours:

{{< highlight bash >}}
salloc --nodes=1 --ntasks=1 --cpus-per-task=6 --mem=12000M --partition=compute --time=0-2:00:00
{{< /highlight >}}

For an MPI jobs asking for 48 tasks, irrespectively of the nodes layout: 

{{< highlight bash >}}
salloc  --ntasks=48 --mem-per-task=2000M --partition=compute --time=0-2:00:00
{{< /highlight >}}

Similar to [batch jobs](running-jobs), specifying a partition with __-\-partition=__ is required. Otherwise, the default partition will be used (as for now, **skylake** is set as default partition for CPU jobs).

<!-- AK: the default partition for interactive CPU jobs is compute. -->

## Interactive GPU jobs
---

The difference for GPU jobs is that they would have to be directed to a node with GPU hardware:

* The GPU jobs should run on the nodes that have GPU hardware, which means you'd always want to specify __-\-partition=gpu__ or __-\-partition=stamps-b__.

* SLURM on Grex uses the so-called "GTRES" plugin for scheduling GPU jobs, which means that a request in the form of __-\-gpus=N__ or __-\-gpus-per-node=N__ or __-\-gpus-per-task=N__ is required. Note that both partitions have up to four GPU per node, so asking more than 4 GPUs per node, or per task, is nonsensical. For interactive jobs, it makes more sense to use single GPU in most of the cases.

For an interactive session using two hours of one 16 GB V100 GPU, 4 CPUs and 4000MB per cpu:

{{< highlight bash >}}
salloc --gpus=1 --cpus-per-task=4 --mem-per-cpu=4000M --time=0-2:00:00 --partition=stamps-b
{{< /highlight >}}

Similarly, for a 32 GB memory V100 GPU:

{{< highlight bash >}}
salloc --gpus=1 --cpus-per-task=4 --mem-per-cpu=4000M --time=0-2:00:00 --partition=gpu
{{< /highlight >}}

## Graphical jobs
---

What to do if your interactive job involves a GUI based program? You can SSH to a login node with X11 forwarding enabled, or using X2Go remote desktop, and run it there. It is also possible to forward the X11 connection to compute nodes where your interactive jobs run with __-\-x11__ flag to **salloc**:

{{< highlight bash >}}
salloc --ntasks=1 --x11 --mem=4000M
{{< /highlight >}}

To make it work you'd want the SSH session login node is also supporting graphics: either through the -Y flag of ssh (or X11 enabled in PuTTy) or by using [X2Go](connecting/x2go). If you are using Mac OS, you will have to install [XQuartz](https://www.xquartz.org/) to enable X11 forwarding.

You may also try to use [OpenOnDemand](/ood) portal on Grex.

{{< collapsible title="OpenOnDemand portal on Grex: click on the image to read the documentation" >}}
[![](/ood/loginpage.png)](/ood)
{{< /collapsible >}}

---

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* 
*
*
-->
