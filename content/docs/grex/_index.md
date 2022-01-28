---
weight: 1
bookFlatSection: true
title: "Grex HPC QuickStart"
bookToc: true
---

# Grex

Grex is an UManitoba High Performance Computing (HPC) system, first put in production in early 2011 as part of [Westgrid](https://www.westgrid.ca/) consortium.
Now it is owned and operated by University of Manitoba.

### A Very Quick Start guide

1. Create an account on [CCDB](https://ccdb.computecanada.ca/register). You will need and institutional Email address. If you are a sponsored user, you'd want to ask your PI for his _CCRI_ code.
2. Wait for half a day. While waiting, install an SSH client, and SFTP client for your operating system.
3. Connect to **grex.westgrid.ca** with SSH, using your username/password from step 1.
4. Make a sample job script, call it _sleep.job_ . The job script is a text file that has a special syntax to be
 recognized by SLURM. You can use the editor _nano_ , or any other right on Grex SSH prompt (vim, emacs, pico, .
..); you can also create the script file on your machine and upload to Grex using your SFTP client.
  {{< highlight bash >}}
   #!/bin/bash
   #SBATCH --ntasks=1 --cpus-per-task=1
   #SBATCH --time=00:01 --mem-per-cpu=100mb
   echo "Hello world! will sleep for 10 seconds"
   time sleep 10
   echo "all done"
  {{< / highlight >}}
5. Submit the script using sbatch command, to the _compute_ partition

 ```sbatch --partition=compute sleep.job```

6. Wait until the job finishes; you can monitor queue's state with the 'sq' command. When the job finishes, slur
m-NNNN.out should be in the job directory.
7. Download the output slurm-NNNN.out from grex.westgrid.ca  to your local machine using your SFTP client.
8. Congratulations, you have just ran your fist HPC-style batch job. This is the general workflow, more or less;
 you'd just want to substitute the _sleep_ command to something useful, like _your-code.x your-input.dat_ .

# More information on this website

Check out Getting Account, Moving Data and Running jobs for general information. Software pages might have information specific to running particular software items. Ondemand pages explain how to use the new Grex's Web portal.
