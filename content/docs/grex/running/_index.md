---
bookCollapseSection: true
title: "Running Jobs"
weight: 50
---

# Running Jobs

## Why running jobs in batch mode?

There is a number of reasons for adopting a batch mode for running jobs on a cluster. From providing user's computations with fairness, traffic control to prevent resource congestion and resource trashing, enforcing organizational priorities, to better understanding the workload, utilization and resource needs for future capacity planning; the scheduler provides it all. 
After being long-time PBS/Moab users, we have switched to the SLURM batch system since December 2019.

## Partitions

Unlike original Grex under Moab which was flat, the current Grex that has contributed nodes, large memory nodes and contributed GPU nodes is (and getting more and more) heterogeneous. With SLURM as a scheduler, this requires partitioning: a "partition" is a set of compute nodes, groupped by a characteristic, usuall by kind of hardware the node has, and sometimes by who "owns" the hardware as well. 

Currently, the following partitions are available on Grex:

- **skylake**  : the new 40-core, CascadeLake compute nodes, 384 Gb/node (set as the default partition) **NEW**
- **compute**  : the original SSE4.2 12-core Grex nodes, RAM 48Gb/node (no longer set as the default partition)
- **bigmem**   : the original SSE4.2 12-core Grex nodes, RAM 94GB/node
- **gpu**      : two GPU V100/32GB AVX512 nodes, RAM 192GB/node **NEW**
- **davis**    : four of CPU AVX nodes contributed by Prof. R. Davis (Department of Chemistry)
- **stamps**   : three 4xGPU v100/16GB AVX512 nodes contributed by Prof. R. Stamps (Department of Physics and Astronomy)
- **livi**     : a HGX-2 16xGPU V100/32GB, NVSwitch server contributed by Prof. L. Livi (Department of Computer Science)
- **davis-b**  : Preemptible partition for general use of the above nodes contributed by Prof. R. Davis.
- **stamps-b** : Preemptible partition for general use of the above nodes contributed by Prof. R. Stamps.
- **livi-b**   : Preemptible partition for general use of the above nodes contributed by Prof. L. Livi.

The former four partitions (**skyake**, **compute** and **bigmem** and **gpu**) are generally accessible. The next three are open only to the contributor's groups.

On the contributed partitions, the owner's group has preferencial access. However, users belonging to other groups can submit jobs to one of the preemptible partitions (ending with **\-b**) to run on the contributed hardware as long as it is unused, on the condition that their jobs can be preempted (that is, killed) should owners jobs need the hardware.
There is a minimum runtime guaranteed to preemptible jobs, which is as of now 1 hour. The maximum walltime for the preemptible partition is set per partition (and can be seen in the output of the _sinfo_ command).

Jobs cannot span several partitions; but it is possible to specify more than one partiton, like in _-\-partition=compute,bigmem_ so that the job will be directed by the scheduler
to the first partiton available.
There is no fully automatic selection of partitions, other than the default _skylake_ for most of the users, and _compute_ for the short jobs. For the contributors' group members, the default partition will be their contributed nodes. **Thus in many cases users have to specify the partition manually when submitting their jobs!**

Jobs will be rejected by the SLURM scheduler if partition's hardware and requested resources do not match 
(that is, asking for GPUs on compute or bigmem partitions is not possible). So in some cases, explicitly adding_-\-partition=_ flag to SLURM job submission is needed.
Jobs that require *stamps-b* partiton have to use GPUs, otherwise they will be rejected; this is to prevent of bogging up the precious GPU nodes with CPU-only jobs!

## Accounts

Users belong to "accounting groups", led by their principal investigators (PIs). The accounting grops on Grex match CCDB roles. By default, a user's jobs are assigned to his primary/default accounting group. But it is possible for a user to belong to more than one group; then the _-\-account=_ parameter can be used for _sbatch_ or _salloc_ to select non-default account to run jobs under.

## QOSs

QOS stands for Quality of Service. It is a mechanism to modify scheduler's limits, hardware access policies and modify job priorities and job accounting/billing.
Presently, QOS might be used by our Scheduler machinery internally, but not specified by the users. Jobs that specify explicit _--qos=_ will be rejected by the 
SLURM job submission wrapper.

## Limits and policies

In order to prevent monopolization of the entire cluster by a single user or single accountig group, we enforce a MAXPS like limit;
for non-RAC accounts it is set to 4M CPU-minutes and 400 CPU cores. Accounts that have allocation (RAC) on Grex get higher MAXPS and max 
CPU cores limits in order to let them to utilize their usage targets. 

Partitions for preemptible jobs running on contributed hardware might be further limited, so that they can not occupy the whole contributed hardware.

In cases when Grex is underutilized, but some jobs exist in the queue that can be run if not for the above mentioned limits, 
we might relax the limits as a temporary "bonus".

## SLURM commands

Naturally, SLURM provides a command line user interface. Some of the most useful commands are listed below.

### Exploring the system

The SLURM command that shows state of nodes and partitions is ''sinfo''

```sinfo```

### Submitting jobs 

Batch jobs are submitted as follow:

```sbatch [options] myfile.job```

Interactive jobs are submitted in exactly same way, but they do not need the job script because they will give you an interactive session:

```salloc [options]```

The command _sbatch_ returns a number called JobID and used by SLURM to identify the job in the queuing system.

The options are used to specify resources (wall time,  tractable resources such as cores and nodes and GPUs) and accounts and QOS and partitions under which the jobs should run, and various other options like specifying whether jobs need X11 GUI (-\-x11), where its output should go, whether email should be sent when job changes its states and so on. Here is a list of the most frequent options to _sbatch_ command:

Resources (tractable resources in SLURMspeak) are CPU time, memory, and GPU time.

Generic resources can be software licenses, etc. There are also options to control job placement such as partitions and QOSs.

 * _-\-ntasks=_ : specifies number of tasks (MPI processes) per job.
 * _-\-nodes=_  : specifies number of nodes (servers) per job.
 * _-\-ntasks-per-node=_ : works with
 * _-\-cpus-per-task=_ : specifies number of threads per task.
 * _-\-mem-per-cpu=_  : specifies memory per task (or thread?)
 * _-\-mem=_ : specifies the memory per node.
 * _-\-gpus=_ : specifies number of GPUs per job. There are also _-\-gpus-per-XXX_ and _-\-XXX-per-gpu_
 * _-\-time-_ : specifies walltime in format DD-HH:MM
 * _-\-qos=_  : specifies a QOS by its name.
 * _-\-partition=_ : specifies a partiton by its name.

An example of using some of these options with _sbatch_ and _salloc_ are listed below:

```sbatch --nodes=1 --ntasks-per-node=1 --cpus-per-task=12 --mem=40gb --time=0-48:00 gaussian.job```

```salloc --nodes=1 --ntasks-per-node=4 --mem-per-cpu=4000mb --x11 --partition=compute```

And so on. The options for batch jobs can be either in command line, or (perhaps better) in the special comments in the job file, like ''#SBATCH -\-mem=40gb ''

Refer to the subsection for Batch jobs and Interacive jobs for more information, examples of job scripts and how to actually sumbit jobs.

### Monitoring jobs

Checking on the queued jobs:

```squeue -u auser```

```squeue -A abc-12-aa```

Without the above parameters, squeue would return all the jobs in the system. There is a shortcut ''sq'' for ''squeue -u $USER''

Cancelling jobs:

```scancel JobID```

```echo "Deleting all the jobs by $USER" && scancel -u $USER```

```echo "Deleting all the pending jobs by $USER" && scancel -u $USER --state=pending```

Hold and release queued jobs:

```scontrol hold JobID```
  
```scontrol release JobID```

Checking job efficiency (the actual utilization of walltime and memory):

 ```seff JobID```

Checking resource limits and usage for past and current jobs:

```sacct -j {JobID} -l```

```sacct -u $USER -s {STARTDATE} -e {ENDDATE} -l --parsable2``` 

### Getting info on accounts and priorities

Fairshare and accounting information for the accounting group ''abc-12-aa''

```sshare -a -l -A abc-12-aa```

Fairshare and accounting information for a user:

```sshare -l -U -u $USER```

Limits and settings for an account:

```sacctmgr list assoc account=abc-12-aa format=account,user,qos```

## Useful links

 * SLURM [documentation](https://westgrid.github.io/trainingMaterials/tools/scheduling/)
 * [Running jobs](https://docs.computecanada.ca/wiki/Running_jobs) on Compute Canada clusters.
 * References for migrating from PBS to SLURM: [ICHEC](https://www.ichec.ie/academic/national-hpc/kay-documentation/pbs-slurm), [HPC-USC](https://hpcc.usc.edu/support/documentation/pbs-to-slurm/)
 * Westgrid training materials on SLURM: [Scheduling](https://westgrid.github.io/trainingMaterials/tools/scheduling/) 

Since the HPC technology is widely used by most of universities and National labs, simple googling your SLURM question will likely return a few useful links to their HPC/ARC documentations.

