# Matlab on Grex

## Introduction

[MATLAB](http://www.mathworks.com/) is a general-purpose high-level programming package for numerical work such as linear algebra, signal processing and other calculations involving matrices or vectors of data. We have a campus license for MATLAB which is used on Grex and other local computing resources. MATLAB is available only for UManitoba users.

As most of the Grex software, MATLAB is available as module. The following command will load the latest version available on Grex:

{{< hint info >}}
```module load uofm/matlab```
{{< /hint >}}

Then the **matlab** executable will be in the PATH.

## Running Matlab

It is possible to run MATLAB GUI interactively, for best performance in an X2Go session and terminal. There is no **Applications** menu shortcut for MATLAB, because it is only in the PATH after the module is loaded from command line. After loading the module, the command will be in the PATH:

{{< hint info >}}
```matlab```
{{< /hint >}}

For running a MATLAB script in text mode, or a batch script, the following options can be used.

{{< hint info >}}
```matlab -nodisplay -nojvm -nodesktop -nosplash -r your_matlab_script.m```
{{< /hint >}}
 
However, each instance, GUI or command line, will consume a license unit. By submitting sufficiently many MATLAB jobs concurrently, it is possibly to exaust entire University's license pool. Thus in most cases, it might make sense to use compiled, standalone MATLAB code runners (MCRs) instead.

### Standalone Matlab runners

MATLAB comiler, the **mcc** command can be used to compile source code (__.m__ files) into a standalone excecutable. There is a couple of important considerations to keep in mind when creating an executable that can be run in the batch-oriented, HPC environment. One is that there is no graphical display attached to your session and the other is that the number of threads used by the standalone application has to be controlled.

For example, with code __mycode.m__ a source directory __src__, with the compiled files being written to a directory called __deploy__, the following **mcc** command line (at the Linux shell prompt) could be used:

{{< hint info >}}
```mkdir deploy ```

```cd src ```

```mcc -R -nodisplay -R -singleCompThread -m -v -w enable -d ../deploy mycode.m ```
{{< /hint >}}
  
Note the option __-singleCompThread__ has been included in order to limit the executable to just one computational thread. 

In the deploy directory, an executable mycode will be created along with a script __run_mycode.sh__. These two files should be copied to the target machine where the code is to be run.

### Example of SLURM script

After the standalone executable mycode and corresponding script run_mycode.sh have been transferred to a directory on the target system on which they will be run, a batch job script needs to be created in the same directory. Here is an example batch job script.

{{< hint slurm >}}
{{< highlight bash >}}
#!/bin/bash
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000mb
#SBATCH --time=0-3:00:00
#SBATCH --job-name=Matlab-mcr-job
# Choose the MCR directory according to the compiler version used
# The one below for uofm/matlab/R2017A
MCR=/global/software/matlab/mcr/v93
# If running on Grex, uncomment the following line to set MCR_CACHE_ROOT:
module load mcr/mcr
echo "Running on host: `hostname`"
echo "Current working directory is `pwd`"
echo "Starting run at: `date`" 
./run_mycode.sh $MCR > mycode_${SLURM_JOBID}.out
echo "Program finished with exit code $? at: `date`"
{{< / highlight >}}
{{< /hint >}}

The job is then submitted as any ordinary SLURM job with the sbatch command. See the Running Jobs page for more information. If the above script is called matlab.job, it could be submitted using:

{{< hint info >}}
```sbatch matlab.job```
{{< /hint >}}

The specified __-\-time__ and total memory (__-\-mem-per-cpu__) limits should be adjusted to appropriate values for your particular run.

An important part of the above script is the location of the MATLAB Compiler Runtime (MCR) directory. This directory contains files necessary for the standalone application to run. The version of the MCR files specified must match the version of MATLAB used to compile the code (check the [link](https://www.mathworks.com/matlabcentral/answers/102061-what-is-the-version-of-the-matlab-compiler-runtime-mcr-that-corresponds-to-the-version-of-matlab-c) for mathing module and MCR versions).

## Links

(Work in progress)

