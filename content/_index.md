---
title: Introduction
type: docs
bookTOC: true
---

# User documentation for HPC resources at University of Manitoba

Since you have found this Website, you may be interested in Grex documentation. 
Grex is the University of Manitoba's High-Performance Computing system.

![](grex-room-2020.png)

## For experienced Grex users

Grex had a major, drastic Update on 9th year of its lifetime! The Update strongly affects the ways
users interact with it: the OS updated to CentOS7, resource management
software changed from Torque/Moab to SLURM, and communication libraries switched from MLNX OFED
to RDMA-Core and UCX. 

Thus, if you are a user experienced in the previous "version" of Grex,  you might benefit from reading this dociment: [Description of Grex changes](/doc/docs/longread/).

The the old Westgrid documentation, hosted on the [Westgrid website](https://www.westgrid.ca) became irrelevant after the Grex upgrade, so please visit [Grex's New Documentation](/doc/docs/grex).

## For new Grex users

If you are a new Grex user, proceed to the quick start guide.

### A Very Quick Start guide

1. Create an account on [CCDB](https://ccdb.computecanada.ca/register). You will need and institutional Email address. If you are a sponsored user, you'd want to ask your PI for his _CCRI_ code.
2. After the CCDB account is approved, login to CCDB and apply for Westgrid Consortium account. Follow directions on _portal.westgrid.ca_ to create Grex account.
3. Wait for half a day. Install an SSH client, and SFTP client for your operating system.
4. Connect to grex.westgrid.ca with SSH using your username/password from step 2.
5. Make a sample job script, call it _sleep.job_ . The job script is a text file that has a special syntax to be recognized by SLURM. You can use the editor _nano_ , or any other right on Grex SSH prompt (vim, emacs, pico, ...); you can also create the script file on your machine and upload to Grex using your SFTP client.
  {{< highlight bash >}}
   #!/bin/bash
   #SBATCH --ntasks=1 --cpus-per-task=1
   #SBATCH --time=00:01 --mem-per-cpu=100mb
   echo "Hello world! will sleep for 10 seconds"
   time sleep 10
   echo "all done"
  {{< / highlight >}}
6. Submit the script using sbatch command, to the _compute_ partition

 ```sbatch --partition=compute sleep.job```
  
7. Wait until the job finishes; you can monitor queue's state with the 'sq' command. When the job finishes, slurm-NNNN.out should be in the job directory.
8. Download the output slurm-NNNN.out from grex.westgrid.ca  to your local machine using your SFTP client. 
9. Congratulations, you have just ran your fist HPC-style batch job. This is the general workflow, more or less; you'd just want to substitute the _sleep_ command to something useful, like _your-code.x your-input.dat_ .

## Useful links

{{< columns >}}
{{< button href="https://docs.computecanada.ca/wiki/Compute_Canada_Documentation" >}}ComputeCanada{{< /button >}}
<--->
{{< button href="https://www.westgrid.ca" >}}Westgrid{{< /button >}}
<--->
{{< button href="https://monitor.hpc.umanitoba.ca/ganglia/" >}}Ganglia on Grex{{< /button >}}
<--->
{{< button href="https://monitor.hpc.umanitoba.ca/grafana/" >}}Garafana on Grex{{< /button >}}
<--->
{{< button relref="/docs/grex"  >}}Grex Documentation{{< /button >}}
<--->
{{< button relref="/docs/localit"  >}}Local Resources{{< /button >}}
{{< /columns >}}
