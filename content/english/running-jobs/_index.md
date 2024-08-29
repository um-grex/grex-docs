---
weight: 5000
title: "Running jobs on Grex"
linktitle: "Running jobs"
description: "Everything you need to know about running jobs on Grex."
titleIcon: "fa-solid fa-house-chimney"
categories: ["Software", "Scheduler"]
#tags: ["Content management"]
---

## Why running jobs in batch mode?
---

There are many reasons for adopting a batch mode for running jobs on a cluster. From providing user's computations with fairness, traffic control to prevent resource congestion and wasting, enforcing organizational priorities, to better understanding the workload, utilization and resource needs for future capacity planning; the scheduler provides it all. After being long-time PBS/Moab users, we have switched to the [SLURM](https://slurm.schedmd.com/documentation.html) batch system since **December 2019** with the **Linux/SLURM update** [project](changes/linux-slurm-update).

## Accounting groups
---

Users belong to "accounting groups", led by their **Principal Investigators** (PIs). The accounting groups on Grex match CCDB roles. By default, a user's jobs are assigned to his primary/default accounting group. But it is possible for a user to belong to more than one accounting group; then the SLURM directive __-\-account=__ can be used for __sbatch__ or __salloc__ to select a non-default account to run jobs under. 

For example, a user who belongs to two accounting groups: **def-sponsor1** and **def-sponsor2** (sponsored by two PIs), can specify which one to use:

{{< highlight bash >}}
#SBATCH --account=def-sponsor1
{{< /highlight >}}

or 

{{< highlight bash >}}
#SBATCH --account=def-sponsor2
{{< /highlight >}}

> NEW : Since Jun 19, 2024,  for users that have more than one Account (that is, working for more than one research group), SLURM on Grex will no longer try to assume which of the accounts is default. Instead, sbatch and salloc would ask to provide the –account= opton explicitly, list the possible accounts, and stop. Thus, for users that are members of more than one group, specifying the account as per above is now mandatory!

## QOSs
---

QOS stands for Quality of Service. It is a mechanism to modify scheduler's limits, hardware access policies and modify job priorities and job accounting/billing. Presently, QOS might be used by our Scheduler machinery internally, but not specified by the users. Jobs that specify explicit __-\-qos=__ will be rejected by the SLURM job submission wrapper.

## Limits and policies
---

* In order to prevent monopolization of the entire cluster by a single user or single accounting group, we enforce a MAXPS like limit; for non-RAC accounts it is set to 4 M CPU-minutes and 400 CPU cores. Accounts that have allocation (RAC) on Grex get higher MAXPS and max CPU cores limits in order to let them utilize their usage targets. 

* To see these limits, one could run the command:

{{< highlight bash >}}
sacctmgr show assoc where user=$USER
{{< /highlight >}}

or with a specific format for the output:

{{< highlight bash >}}
export SACCTMGR_FORMAT="cluster%9,user%12,account%20,share%5,qos%24,maxjobs%15,grptres%12,grptresrunmin%20"
sacctmgr show assoc where user=$USER format=$SACCTMGR_FORMAT
{{< /highlight >}}

* Partitions for preemptible jobs running on contributed hardware might be further limited, so that they cannot occupy the whole contributed hardware.

* In cases when Grex is underutilized, but some jobs exist in the queue that can be run if not for the above-mentioned limits, we might relax the limits as a temporary "bonus".

## SLURM commands
---

Naturally, SLURM provides a command line user interface. Some of the most useful commands are listed below.

### Exploring the system
---

The SLURM command that shows the state of nodes and partitions is **sinfo**: 

**Examples:**

> * __sinfo__ to list the state of all the nodes (idle, down, allocated, mixed) and partitions. 
> * __sinfo -\-state=idle__ to list all idle nodes. 
> * __sinfo -p skylake__ to list information about a given partition (**skylake** in this case).
> * __sinfo -p skylake --state=idle__ to list idle nodes on a given partition (**skylake** in this case).
> * __sinfo -R__: to list all down nodes.
> * __sinfo -R -N -o"%.12N %15T [ %50E ]"|uniq -c__: to list all down nodes and print the output in a specific format.
> * __sinfo -s --format="# %20P %12A %.12l %.11L %.6a %.22C %.10m"__ to show all the partitions and their characteristics.
 
### Submitting jobs 
---

Batch jobs are submitted as follow:

{{< highlight bash >}}
sbatch [options] myfile.job
{{< /highlight >}}

Interactive jobs are submitted in exactly same way, but they do not need the job script because they will give you an interactive session:

{{< highlight bash >}}
salloc [options]
{{< /highlight >}}

For more information about the usage of sbatch and salloc commands, please visit the dedicated sections: [interactive](running-jobs/interactive-jobs) and [batch](running-jobs/batch-jobs) jobs.

The command __sbatch__ returns a number called JobID and used by SLURM to identify the job in the queuing system.

The options are used to specify resources (wall time, tractable resources such as cores and nodes and GPUs) and accounts and QOS and partitions under which the jobs should run, and various other options like specifying whether jobs need X11 GUI (__-\-x11__), where its output should go, whether email should be sent when job changes its states and so on. Here is a list of the most frequent options to __sbatch__ command:

Resources (tractable resources in SLURM speak) are CPU time, memory, and GPU time.

Generic resources can be software licenses, etc. There are also options to control job placement such as partitions and QOSs.

> * __-\-ntasks=__ (specifies number of tasks (MPI processes) per job)
> * __-\-nodes=__ (specifies number of nodes (servers) per job)
> * __-\-ntasks-per-node=__ (specifies number of tasks (MPI processes) per node)
> * __-\-cpus-per-task=__ (specifies number of threads per task)
> * __-\-mem-per-cpu=__ (specifies memory per task (or thread?))
> * __-\-mem=__ (specifies the memory per node)
> * __-\-gpus=__ (specifies number of GPUs per job. There are also __-\-gpus-per-XXX__ and __-\-XXX-per-gpu__)
> * __-\-time-__ (specifies wall time in format DD-HH:MM)
> * __-\-qos=__ (specifies a QOS by its name (**Should not be used on Grex!**))
> * __-\-partition=__ (specifies a partition by its name (**Can be very useful on Grex!**))

An example of using some of these options with __sbatch__ and __salloc__ are listed below:

{{< highlight bash >}}
sbatch --nodes=1 --ntasks-per-node=1 --cpus-per-task=12 --mem=40G --time=0-48:00 gaussian.job
{{< /highlight >}}

and

{{< highlight bash >}}
salloc --nodes=1 --ntasks-per-node=4 --mem-per-cpu=4000M --x11 --partition=skylake
{{< /highlight >}}

And so on. The options for batch jobs can be either in command line, or (perhaps better) in the special comments in the job file, like:

{{< highlight bash >}}
#SBATCH --nodes=1 
#SBATCH --ntasks-per-node=1 
#SBATCH --cpus-per-task=12
#SBATCH --mem=40G
#SBATCH --time=0-48:00
#SBATCH --partition=skylake
{{< /highlight >}}

Refer to the subsection for [batch jobs](running-jobs/batch-jobs) and [interactive jobs](running-jobs/interactive-jobs) for more information, examples of job scripts and how to actually submit jobs.

### Monitoring jobs
---

**Checking on the queued jobs:**

> * __squeue -u someuser__ (to see all queued jobs of the user **someuser**)
> * __squeue -u someuser -t R__ (to see all queued and running jobs of the user **someuser**)
> * __squeue -u someuser -t PD__ (to see all queued and pending jobs of the user **someuser**)
> * __squeue -A def-sponsor1__ (to see all queued jobs for the accounting group **def-sponsor1**)

Without the above parameters, squeue would return all the jobs in the system. There is a shortcut __sq__ for __squeue -u $USER__

**Canceling jobs:**

> * __scancel JobID__ (to cancel a job JobID)
> * __echo "Deleting all the jobs by $USER" && scancel -u $USER__ (to cancel all your queued jobs at once).
> * __echo "Deleting all the pending jobs by $USER" && scancel -u $USER --state=pending__ (to cancel all your pending jobs at once).

**Hold and release queued jobs:**

To put hold some one or more jobs, use:

* ```scontrol hold JobID``` (to put on hold the job JobID).
* ```scontrol hold JobID01,JobID02,JobID03``` (to put on hold the jobs JobID01,JobID02,JobID03).

To release them, use: 

* ```scontrol release JobID``` (to release the job JobID).
* ```scontrol release JobID01,JobID02,JobID03``` (to release the jobs JobID01,JobID02,JobID03).
  
**Checking job efficiency:**

The command __seff__ is a wrapper around the command __sacct__ that gives a friendly output, like the actual utilization of walltime and memory:

*  ```seff JobID```
*  ```seff -d JobID```

Note that the output from the seff command is not accurate if the job was not successful.

**Checking resource limits and usage for past and current jobs:**

* ```sacct -j {JobID} -l```
* ```sacct -u $USER -s {STARTDATE} -e {ENDDATE} -l --parsable2``` 

### Getting info on accounts and priorities
---

Fairshare and accounting information for the accounting group **def-someprofessor**:

{{< highlight bash >}}
sshare -l -A def-someprofessor
sshare -l -A def-someprofessor --format="Account,EffectvUsage,LevelFS"

sshare -a -l -A def-someprofessor
sshare -a -l -A def-someprofessor --format="Account,User,EffectvUsage,LevelFS"
{{< /highlight >}}

Fairshare and accounting information for a user:

{{< highlight bash >}}
sshare -l -U --user $USER
sshare -l -U --user $USER --format="Cluster,User,EffectvUsage,FairShare,LevelFS"
{{< /highlight >}}

Limits and settings for an account:

{{< highlight bash >}}
sacctmgr list assoc account=def-someprofessor format=account,user,qos
{{< /highlight >}}

## Internal links
---

{{< treeview />}}

## External links
---

 * SLURM [documentation](https://westgrid.github.io/trainingMaterials/tools/scheduling/)
 * [Running jobs](https://docs.alliancecan.ca/wiki/Running_jobs) on the Alliance (Compute Canada) clusters.
 * References for migrating from PBS to SLURM: [ICHEC](https://www.ichec.ie/academic/national-hpc/kay-documentation/pbs-slurm), [HPC-USC](https://hpcc.usc.edu/support/documentation/pbs-to-slurm/)
 * Westgrid training materials on SLURM: [Scheduling](https://westgrid.github.io/trainingMaterials/tools/scheduling/) 

---

{{< alert type="info" >}}
Since the HPC technology is widely used by most universities and National labs, simply googling your SLURM question will likely return a few useful links to their HPC/ARC documentation. Please remember to adapt your script according to the available hardware and software as some SLURM directives and modules are specific to a given cluster. 
{{< /alert >}}

<!-- Changes and update:
* Last revision: Aug 28, 2024.  
-->
