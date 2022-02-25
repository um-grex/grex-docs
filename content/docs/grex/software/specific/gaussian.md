# Gaussian 

## Introduction

[Gaussian 16](http://gaussian.com/ "Gaussian") is a comprehensive suite for electronic structure modeling using __ab initio__, DFT and semi-empirical methods. A list of Gaussian 16 features can be found [here](http://gaussian.com/g16glance/ "Gaussian Features").

## User Responsibilities and Access

University of Manitoba has a site license for Gaussian 16 and GaussView. However it comes with certain license limitations, so access to the code is subject to some license conditions.

Since, as of now, Compute Canada accounts are a superset of Grex accounts, users will want to initiate getting access by sendiong email agreeing to Gaussian conditions to **support@computecanada.ca**, confirming that you have read and agree to abide by the following conditions, and mentioning that you'd also want to access it on Grex:

{{< hint danger >}}
 * I am not a member of a research group developing software competitive to Gaussian.
 * I will not copy the Gaussian software, nor make it available to anyone else.
 * I will properly acknowledge Gaussian Inc. and Compute Canada in publications.
 * I will notify Compute Canada of any change in the above acknowledgement.
{{< /hint >}}

If you are a sponsored user, your sponsor (PI) must also have such a statement on file with us. 

Moreover, the terms of the UManitoba license are actually stricter than for the Compute Canada. In particular, it excludes certain research groups at the University to have access to the software. Therefore, we are required by Gaussian to have each of the Gaussian user to sign a Confidentiality Agreement form as provided to us by Gaussian. Inc. Please drop by our office in Engineering, E2-588 to get the form and return it signed.

## System specific notes

On Grex, Gaussian is limited to single node, SMP jobs and the memory of single node. There is no Linda. The Gaussian code is accessible as a module. The module sets Gaussian's environment variables like __GAUSS_SCRDIR__ (the later, to local node scratch).

{{< hint info >}}
module load gaussian/g16.c01
{{< /hint >}}

To load the module and access the binaries, you will have first get access as per above. Also, our Gaussian license span is less than Compute Canada's support contract, so there is fewer versions available. Use ```module spider gaussian``` to see what is available on Grex.

After a Gaussian module is loaded, the GaussView software also becomes available (provided you have connected with X11 support, perhaps using X2Go) as follows:

{{< hint info >}}
gv
{{< /hint >}}
  
The viewer should not be used to run production calculations on a Grex login nodes. Instead, as for any other production calculations, SLURM jobs should be used as described below.

## Using Gaussian with SLURM

### Sample SLURM Script

{{< hint slurm >}}
{{< highlight bash >}}
#!/bin/bash
#SBATCH --ntasks=1 --cpus-per-task=12
#SBATCH --mem=40gb
#SBATCH --time=8:00:00
#SBATCH --job-name=Gauss16-test
module load GrexEnv
module load gaussian/g16.c01
echo "Starting run at: `date`"
which g16
# note that input should have %nproc=12
# and %mem=40gb for the above resurce request.
g16 < input.gjf > output.$SLURM_JOBID.log
echo "Program finished with exit code $? at: `date`"
{{< / highlight >}}
{{< /hint >}}

### Simplified job sumbittion

A simplified job script **sbg16** is available (aftr loading of the g16 module) for automatic generation and sumbission of SLURM Gaussian jobs.

{{< hint info >}}
sbg16 input.gjf -ppn 12 -mem 40000mb -time 8:00:00
{{< /hint >}}

### Using NBO

University of Manitoba has site licenses for NBO6 and NBO7. Corresponding NBO modules would have to be loaded in order to use Gaussian's POP=NBO6 or NBO7 keywords.

{{< hint info >}}
module spider nbo
{{< /hint >}}

should list available NBO versions with their dependencies.


