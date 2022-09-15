---
weight: 1
bookFlatSection: true
title: "Grex HPC QuickStart"
bookToc: true
---

# Grex

Grex is an UManitoba High Performance Computing (HPC) system, first put in production in early 2011 as part of WestGrid consortium. Now it is owned and operated by University of Manitoba. Grex is accessible only for UManitoba users and their collaborators.

### A Very Quick Start guide

1. Create an account on [CCDB](https://ccdb.computecanada.ca/security/login "CCDB"). You will need an institutional Email address. If you are a sponsored user, you'd want to ask your PI for his/her __CCRI__ code {Compute Canada Role Identifier}. For a detailed procedure, visit the page [Apply for an account](https://alliancecan.ca/en/services/advanced-research-computing/account-management/apply-account "Apply for an account").

2. Wait for half a day. While waiting, install an SSH client, and SFTP client for your operating system.

3. Connect to **grex.hpc.umanitoba.ca** with SSH, using your username/password from step 1.

4. Make a sample job script, call it, for example, __sleep.job__ . The job script is a text file that has a special syntax to be recognized by SLURM. You can use the editor __nano__ , or any other right on Grex SSH prompt (vim, emacs, pico, ... etc); you can also create the script file on your machine and upload to Grex using your SFTP client or scp.

{{< hint slurm >}}
{{< highlight bash >}}
#!/bin/bash
#SBATCH --ntasks=1 --cpus-per-task=1
#SBATCH --time=00:01 --mem-per-cpu=500M
echo "Hello world! will sleep for 10 seconds"
time sleep 10
echo "all done" 
{{< / highlight >}}
{{< /hint >}}

5. Submit the script using sbatch command, to the __compute__ partition using:

{{< hint info >}}
sbatch --partition=compute sleep.job
{{< /hint >}}

6. Wait until the job finishes; you can monitor queue's state with the 'sq' command. When the job finishes, a file slurm-NNNN.out should be created in the same directory.

7. Download the output slurm-NNNN.out from grex.westgrid.ca to your local machine using your SFTP client.

8. Congratulations, you have just ran your first HPC-style batch job. This is the general workflow, more or less; you'd just want to substitute the __sleep__ command to something useful, like __./your-code.x your-input.dat__ .


# More information on this website

Check out [Getting an ccount](./access), [Moving Data](./connecting/data-transfer/) and [Running jobs](./running) for general information. [Software pages](./software) might have information specific to running particular [software items](./software/specific). [OpenOndemand](./ood) pages explain how to use the new Grex's Web portal.

<!--  -->
