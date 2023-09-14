---
weight: 1000
linkTitle: "MATLAB"
title: "Running MATLAB on Grex"
description: "Everything you need to know to run MATLAB on Grex."
categories: ["Software", "Scheduler"]
#tags: ["Configuration"]
---

## Introduction
---

[MATLAB](http://www.mathworks.com/) is a general-purpose high-level programming package for numerical work such as linear algebra, signal processing and other calculations involving matrices or vectors of data. We have a campus license for MATLAB which is used on Grex and other local computing resources. MATLAB is available only for UManitoba users.

As with most of the Grex software, MATLAB is available as a module. The following command will load the latest version available on Grex:

{{< highlight bash >}}
module load uofm/matlab
{{< /highlight >}}

Then the **matlab** executable will be in the PATH.

## Available Toolboxes
---

To see a list of the MATLAB toolboxes available with MATLAB license on Grex, you can use the following command: 

{{< highlight bash >}}
module load uofm/matlab
matlab -nodisplay -nojvm -batch "ver"
{{< /highlight >}}

## Running Matlab
---

It is possible to run MATLAB GUI interactively, for best performance in an X2Go session, [OOD](ood) session and a terminal. There is no **Applications** menu shortcut for MATLAB, because it is only in the PATH after the module is loaded from the command line. After loading the module, the command **matlab** will be in the PATH.

For running a MATLAB script in text mode, or a batch script, the following options can be used:

{{< highlight bash >}}
matlab -nodisplay -nojvm -nodesktop -nosplash -r your_matlab_script.m
{{< /highlight >}}

However, each instance, GUI or command line, will consume a license unit. By submitting sufficiently many MATLAB jobs concurrently, there is a possibility to exhaust the entire University's license pool. Thus, in most cases, it might make sense to use compiled, standalone MATLAB code runners (MCRs) instead (please refer to the next section).

### Standalone Matlab runners: MCR
---

MATLAB compiler, the **mcc** command can be used to compile a source code (__.m__ file) into a standalone executable. There are a couple of important considerations to keep in mind when creating an executable that can be run in the batch-oriented, HPC environment. One is that there is no graphical display attached to your session and the other is that the number of threads used by the standalone application has to be controlled.

For example, with code __mycode.m__ a source directory __src__, with the compiled files being written to a directory called __deploy__, the following **mcc** command line (at the Linux shell prompt) could be used:

{{< highlight bash >}}
module load uofm/matlab
mkdir deploy
cd src
mcc -R -nodisplay -R -singleCompThread -m -v -w enable -d ../deploy mycode.m
{{< /highlight >}}
  
Note the option __-singleCompThread__ has been included in order to limit the executable to just one computational thread. 

In the deploy directory, an executable __mycode__ will be created along with a script __run_mycode.sh__. These two files should be copied to the target machine where the code is going to be run as a batch job.

### Example of SLURM script: MCR
---

After the standalone executable mycode and corresponding script __run_mycode.sh__ have been transferred to a directory on the target system on which they will be run, a batch job script needs to be created in the same directory. Here is an example batch job script.

{{< collapsible title="Script example for running MATLAB via MCR" >}}
{{< snippet
    file="scripts/jobs/matlab/run-matlab-mcr.sh"
    caption="run-matlab-mcr.sh"
    codelang="bash"
/>}}
{{< /collapsible >}}

The job is then submitted as any ordinary SLURM job with the sbatch command. See the Running Jobs page for more information. If the above script is called **run-matlab-mcr.sh**, it could be submitted using:

{{< highlight bash >}}
sbatch run-matlab-mcr.sh
{{< /highlight >}}

The specified __-\-time__ and total memory (__-\-mem-per-cpu__) limits should be adjusted to appropriate values for your particular run. The option __-\-partition__ is used to specify the partition to use for running the job. For more information, visit the page [running jobs on Grex](running-jobs)

An important part of the above script is the location of the MATLAB Compiler Runtime (MCR) directory. This directory contains files necessary for the standalone application to run. The version of the MCR files specified must match the version of MATLAB used to compile the code (check the [link](https://www.mathworks.com/matlabcentral/answers/102061-what-is-the-version-of-the-matlab-compiler-runtime-mcr-that-corresponds-to-the-version-of-matlab-c) for matching module and MCR versions).

## MATLAB on the Alliance's clusters
---

For using MATLAB on the Alliance's clusters, please visit the corresponding MATLAB [page](https://docs.alliancecan.ca/wiki/MATLAB). While there is a wide MATLAB license accessible for all users on [cedar](https://docs.alliancecan.ca/wiki/Cedar), [beluga](https://docs.alliancecan.ca/wiki/B%C3%A9luga/en) and [narval](https://docs.alliancecan.ca/wiki/Narval/en), using MATLAB on graham requires access to an external [license](https://docs.alliancecan.ca/wiki/MATLAB#Using_an_external_license). UManitoba users could use MATLAB on [graham](https://docs.alliancecan.ca/wiki/Graham) without additional settings.   

## Related links
---

* [MATLAB on the Alliance's clusters](https://docs.alliancecan.ca/wiki/MATLAB)
* MATLAB [documentation](https://www.mathworks.com/help/matlab/)
* [Running jobs on Grex](running-jobs)

---

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* 
*
*
-->
