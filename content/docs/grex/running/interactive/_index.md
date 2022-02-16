---
bookCollapseSection: true
title: "Interactive work"
weight: 2
---

# Interactive work

The login nodes of Grex should be used to compile codes and to run short interactive calculations, compilation of code, and/or test runs. It is very easy to cause resource congestion on a shared Linux server. Therefore, all production calculations should be sumbitted in the batch mode, using our resource management system, SLURM. It is possible to submit so called __interactive jobs__: a job that creates an interactive session but actually runs on dedicated CPUs (and GPUs if needed) on the compute nodes rather than on the login servers (or head nodes).

Such mode of running interactive computations ensures that login nodes are not congested. A drawback is that when a cluster is busy, getting an interactive job to start will take some queuing time, just like any other job. So in practice interactive jobs are to be short and small to be able to utilize backfill-able nodes. This section covers how to run such jobs with SLURM.

Note that manual SSH connections to the compute nodes without having active running jobs is forbidden on Grex.

## Interactive batch jobs

To request an interactive jobs, the **salloc** command should be used. These jobs are not limited to single node jobs; any nodes/tasks/gpus layout can be requested by salloc in the same way as for sbatch. However, to minimize queuing time, usually a minimal set of required resources should be used when submitting interactive jobs (less than 3 H of walltime, less than 4 GB memory per core, etc.). Because there is no batch file for interactive jobs, all the resource requests should be added as command line options of the **salloc** command. The same logic of __-\-nodes=__,  __-\-ntasks-per-node=__ , __-\-mem=__ and __-\-cpus-per-task=__ resources as per batch jobs applies here as well.

For a threaded SMP code asking for half a node for two hours:

{{< hint slurm >}}
 ```salloc --nodes=1 --ntasks-per-node=1 --cpus-per-task=6 --mem=12000M --time=0-2:00:00```
{{< /hint >}}

For an MPI jobs asking for 48 tasks, irrespectively of the nodes layout: 

{{< hint slurm >}} 
 ```salloc  --ntasks=48 --mem-per-task=2000M --time=0-2:00:00```
{{< /hint >}}

Similar to [batch jobs]({{< relref "/docs/grex/running/batch" >}}), specifying a partition with __-\-partition=__ is required. Otherwise, the default partition will be used (as for now, **skylake** is set as default partition for CPU jobs).

## Interactive GPU jobs

The difference for GPU jobs is that they would have to be directed to a node with GPU hardware:

{{< hint slurm >}}
* The GPU jobs should run on the nodes that have GPU hardware, which means you'd want always to specify __-\-partition=gpu__ or __-\-partition=stamps-b__.

* SLURM on Grex uses the so called "GTRES" plugin for scheduling GPU jobs, which means that a request in the form of __-\-gpus=N__ or __-\-\gpus-per-node=N__ or __-\-gpus-per-task=N__ is required. Note that both partitions have up to four GPU per node, so asking more than 4 GPUs per node, or per task, is nonsensical. For interactive jobs, it makes more sense to use single GPU in most of the cases.
{{< /hint >}}

For an interactive session using two hours of one 16 GB V100 GPU, 4 CPUs and 4000MB per cpu:

{{< hint slurm >}}
```salloc --gpus=1 --cpus-per-task=4 --mem-per-cpu=4000M --time=0-2:00:00 --partition=stamps-b```
{{< /hint >}}


Similarly, for a 32 GB memory V100 GPU:

{{< hint slurm >}}
```salloc --gpus=1 --cpus-per-task=4 --mem-per-cpu=4000M --time=0-2:00:00 --partition=gpu``` 
{{< /hint >}}


## Graphical jobs

What to do if your interactive job involves a GUI based program? You can SSH to a login node with X11 forwarding enabled, or using X2Go remote desktop, and run it there. It is also possible to forward the X11 connection to compute nodes where your interactive jobs run with __-\-x11__ flag to **salloc**:

{{< hint slurm >}}
```salloc --ntasks=1 --x11 --mem=4000M```
{{< /hint >}}

To make it work you'd want the SSH session login node is also supporting graphics: either through -Y flag of ssh (or X11 enabled in PuTTY) or by using X2Go.

You may also try to use [OpenOnDemand]({{< relref "/docs/grex/ood" >}}) portal on Grex.

