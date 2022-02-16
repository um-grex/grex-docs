---
bookCollapseSection: true
title: "Running Jobs"
weight: 50
---

# Running Jobs

## Why running jobs in batch mode?

There is a number of reasons for adopting a batch mode for running jobs on a cluster. From providing user's computations with fairness, traffic control to prevent resource congestion and resource trashing, enforcing organizational priorities, to better understanding the workload, utilization and resource needs for future capacity planning; the scheduler provides it all. After being long-time PBS/Moab users, we have switched to the SLURM batch system since **December 2019**.

## Partitions

The current Grex system that has contributed nodes, large memory nodes and contributed GPU nodes is (and getting more and more) heterogeneous. With SLURM as a scheduler, this requires partitioning: a "partition" is a set of compute nodes, groupped by a characteristic, usually by kind of hardware the nodes have, and sometimes by who "owns" the hardware as well. 

There is no fully automatic selection of partitions, other than the default __skylake__ for most of the users, and __compute__ for the short jobs. For the contributors' group members, the default partition will be their contributed nodes. **Thus in many cases users have to specify the partition manually when submitting their jobs!**

Currently, the following partitions are available on Grex:

### * **General purpose partitions:**

{{< hint slurm >}}
- **skylake**  : the new **52-core**, CascadeLakeRefresh compute nodes, 96 Gb/node (set as the default partition). **NEW**
- **largemem** : the new **40-core**, CascadeLake compute nodes, 384 Gb/node.  **NEW**
- **compute**  : the original SSE4.2 **12-core** Grex nodes, RAM 48 Gb/node (no longer set as the default partition for jobs over 30 minutes).
- **gpu**      : two GPU **V100/32 GB** AVX512 nodes, RAM 192 GB/node. **NEW**
- **test**     : a **24-core** Skylake CPU Dell large memory (512 GB), NVMe workstation for interactive work and visualizations. **NEW**
{{< /hint >}}

### * **Contributed partitions:**

{{< hint slurm >}} 
- **stamps**   : three **4 x GPU v100/16GB** AVX512 nodes contributed by Prof. R. Stamps (Department of Physics and Astronomy).
- **livi**     : a **HGX-2 16xGPU V100/32GB**, NVSwitch server contributed by Prof. L. Livi (Department of Computer Science).
- **agro**     : two **24-core** AMD Zen, RAM 256 GB/node, two NVIDIA A30 GPUs per node, contributed by Faculty of Agriculture.
{{< /hint >}}

### * **Preemptible partitions:**

{{< hint slurm >}} 
- **stamps-b** : Preemptible partition for general use of the above nodes contributed by Prof. R. Stamps.
- **livi-b**   : Preemptible partition for general use of the above nodes contributed by Prof. L. Livi.
- **agro-b**   : Preemptible partition for general use of the above nodes contributed by Faculty of Agriculture.
{{< /hint >}}

The former five partitions (**skyake**, **compute**, **largemem**, **test** and **gpu**) are generally accessible. The next three are open only to the contributor's groups.

On the contributed partitions, the owner's group has preferencial access. However, users belonging to other groups can submit jobs to one of the preemptible partitions (ending with **\-b**) to run on the contributed hardware as long as it is unused, on the condition that their jobs can be preempted (that is, killed) should owners jobs need the hardware. There is a minimum runtime guaranteed to preemptible jobs, which is as of now 1 hour. The maximum walltime for the preemptible partition is set per partition (and can be seen in the output of the __sinfo__ command). To have a global overview of all partitions on Grex, run the custom script **partition-list** from your terminal. 

On the special partition **test**, oversubcsription is enabled in SLURM, to facilitate better turnaround of interactive jobs.

Jobs cannot run on several partitions at the same time; but it is possible to specify more than one partiton, like in __-\-partition=compute,skylake__, so that the job will be directed by the scheduler to the first partiton available.

Jobs will be rejected by the SLURM scheduler if partition's hardware and requested resources do not match (that is, asking for GPUs on compute, largeme or skylake partitions is not possible). So in some cases, explicitly adding __-\-partition=__ flag to SLURM job submission is needed.

Jobs that require __stamps-b__ or __gpu__ partitons have to use GPUs, otherwise they will be rejected; this is to prevent of bogging up the precious GPU nodes with CPU-only jobs!

## Accounts

Users belong to "accounting groups", led by their principal investigators (PIs). The accounting grops on Grex match CCDB roles. By default, a user's jobs are assigned to his primary/default accounting group. But it is possible for a user to belong to more than one group; then the __-\-account=__ parameter can be used for __sbatch__ or __salloc__ to select non-default account to run jobs under. For example, a use who belongs to two accounting groups: **def-sponsor1** and **def-sponsor2**, can specify which one to use:

{{< hint slurm >}}
#SBATCH --account=def-sponsor1
{{< /hint >}}

or 
{{< hint slurm >}}
#SBATCH --account=def-sponsor2
{{< /hint >}}

## QOSs

QOS stands for Quality of Service. It is a mechanism to modify scheduler's limits, hardware access policies and modify job priorities and job accounting/billing. Presently, QOS might be used by our Scheduler machinery internally, but not specified by the users. Jobs that specify explicit __-\-qos=__ will be rejected by the SLURM job submission wrapper.

## Limits and policies

In order to prevent monopolization of the entire cluster by a single user or single accountig group, we enforce a MAXPS like limit; for non-RAC accounts it is set to 4 M CPU-minutes and 400 CPU cores. Accounts that have allocation (RAC) on Grex get higher MAXPS and max CPU cores limits in order to let them to utilize their usage targets. 

Partitions for preemptible jobs running on contributed hardware might be further limited, so that they can not occupy the whole contributed hardware.

In cases when Grex is underutilized, but some jobs exist in the queue that can be run if not for the above mentioned limits, we might relax the limits as a temporary "bonus".

## SLURM commands

Naturally, SLURM provides a command line user interface. Some of the most useful commands are listed below.

### Exploring the system

The SLURM command that shows state of nodes and partitions is **sinfo**: 

**Examples:**

{{< hint slurm >}}
 * __sinfo__: to list all the nodes (idle, down, allocated, mixed) and partitions. 
 * __sinfo --state=idle__: to lisl all idle nodes. 
 * __sinfo -p compute__: to list information about partition (**compute** in this case).
 * __sinfo -p skylake --state=idle__: to list idle nodes on a given partition (**skylake** in this case).
{{< /hint >}}

### Submitting jobs 

Batch jobs are submitted as follow:

{{< hint slurm >}}
```sbatch [options] myfile.job```
{{< /hint >}}

Interactive jobs are submitted in exactly same way, but they do not need the job script because they will give you an interactive session:

```salloc [options]```

{{< hint info >}}
The command _sbatch_ returns a number called JobID and used by SLURM to identify the job in the queuing system.
{{< /hint >}}

The options are used to specify resources (wall time, tractable resources such as cores and nodes and GPUs) and accounts and QOS and partitions under which the jobs should run, and various other options like specifying whether jobs need X11 GUI (__-\-x11__), where its output should go, whether email should be sent when job changes its states and so on. Here is a list of the most frequent options to __sbatch__ command:

Resources (tractable resources in SLURMspeak) are CPU time, memory, and GPU time.

Generic resources can be software licenses, etc. There are also options to control job placement such as partitions and QOSs.

{{< hint info >}}

 * __-\-ntasks=__: specifies number of tasks (MPI processes) per job.
 * __-\-nodes=__: specifies number of nodes (servers) per job.
 * __-\-ntasks-per-node=__: specifies number of tasks (MPI processes) per node.
 * __-\-cpus-per-task=__: specifies number of threads per task.
 * __-\-mem-per-cpu=__: specifies memory per task (or thread?)
 * __-\-mem=__: specifies the memory per node.
 * __-\-gpus=__: specifies number of GPUs per job. There are also __-\-gpus-per-XXX__ and __-\-XXX-per-gpu__
 * __-\-time-__: specifies walltime in format DD-HH:MM
 * __-\-qos=__: specifies a QOS by its name (**Should not be used on Grex!**)
 * __-\-partition=__: specifies a partiton by its name (**Can be very useful on Grex!**)
{{< /hint >}}

An example of using some of these options with _sbatch_ and _salloc_ are listed below:

{{< hint info >}}
* ```sbatch --nodes=1 --ntasks-per-node=1 --cpus-per-task=12 --mem=40gb --time=0-48:00 gaussian.job```

* ```salloc --nodes=1 --ntasks-per-node=4 --mem-per-cpu=4000mb --x11 --partition=compute```
{{< /hint >}}

And so on. The options for batch jobs can be either in command line, or (perhaps better) in the special comments in the job file, like:

{{< highlight bash >}}
#SBATCH -\-mem=40gb
{{< /highlight >}}

Refer to the subsection for [Batch jobs]({{< relref "/docs/grex/running/batch" >}}) and [Interacive jobs]({{< relref "/docs/grex/running/interactive" >}}) for more information, examples of job scripts and how to actually sumbit jobs.

### Monitoring jobs

**Checking on the queued jobs:**

{{< hint info >}}
* ```squeue -u someuser``` (to see all queued jobs of the user **someuser**)
* ```squeue -u someuser -t R``` (to see all queued and running jobs of the user **someuser**)
* ```squeue -u someuser -t PD``` (to see all queued and pending jobs of the user **someuser**)
* ```squeue -A def-sponsor1``` (to see all queued jobs for the accounting group **def-sponsor1**)
{{< /hint >}}

Without the above parameters, squeue would return all the jobs in the system. There is a shortcut ''sq'' for ''squeue -u $USER''

**Cancelling jobs:**

{{< hint info >}}
* ```scancel JobID``` (to cancel a job JobID)
* ```echo "Deleting all the jobs by $USER" && scancel -u $USER``` (to cancel all your queued jobs at once).
* ```echo "Deleting all the pending jobs by $USER" && scancel -u $USER --state=pending``` (to cancel all your pending jobs at once).
{{< /hint >}}

**Hold and release queued jobs:**

To put hold some one or more jobs, use:

{{< hint info >}}
* ```scontrol hold JobID``` (to put on hold the job JobID).
* ```scontrol hold JobID01,JobID02,JobID03``` (to put on hold the jobs JobID01,JobID02,JobID03).
{{< /hint >}}

To release them, use: 

{{< hint info >}}
* ```scontrol release JobID``` (to release the job JobID).
* ```scontrol release JobID01,JobID02,JobID03``` (to release the jobs JobID01,JobID02,JobID03).
{{< /hint >}}
  
**Checking job efficiency:**

The command __seff__ is a wrapper around the command __sacct__ ang gives a friendly output, like the actual utilization of walltime and memory:

{{< hint info >}}
*  ```seff JobID```
*  ```seff -d JobID```
{{< /hint >}}

Note that the output from seff command is not accurate if the job was not successful.

**Checking resource limits and usage for past and current jobs:**

{{< hint info >}}
* ```sacct -j {JobID} -l```
* ```sacct -u $USER -s {STARTDATE} -e {ENDDATE} -l --parsable2``` 
{{< /hint >}}

### Getting info on accounts and priorities

Fairshare and accounting information for the accounting group **abc-12-aa**:

{{< hint slurm >}}
* ```sshare -l -A abc-12-aa```
* ```sshare -l -A abc-12-aa --format="Account,EffectvUsage,LevelFS"```
* ```sshare -a -l -A abc-12-aa```
* ```sshare -a -l -A abc-12-aa --format="Account,User,EffectvUsage,LevelFS"```
{{< /hint >}}

Fairshare and accounting information for a user:

{{< hint slurm >}}
```sshare -l -U -u $USER```
{{< /hint >}}

Limits and settings for an account:

{{< hint slurm >}}
```sacctmgr list assoc account=abc-12-aa format=account,user,qos```
{{< /hint >}}

## Useful links

 * SLURM [documentation](https://westgrid.github.io/trainingMaterials/tools/scheduling/)
 * [Running jobs](https://docs.computecanada.ca/wiki/Running_jobs) on Compute Canada clusters.
 * References for migrating from PBS to SLURM: [ICHEC](https://www.ichec.ie/academic/national-hpc/kay-documentation/pbs-slurm), [HPC-USC](https://hpcc.usc.edu/support/documentation/pbs-to-slurm/)
 * Westgrid training materials on SLURM: [Scheduling](https://westgrid.github.io/trainingMaterials/tools/scheduling/) 

Since the HPC technology is widely used by most of universities and National labs, simple googling your SLURM question will likely return a few useful links to their HPC/ARC documentation.

