---
weight: 1000
linkTitle: "ORCA"
title: "Running ORCA on Grex"
description: "Everything you need to know about running ORCA on Grex."
categories: ["Software", "Scheduler"]
#tags: ["Configuration"]
---

## Introduction
---

[ORCA](http://cec.mpg.de/forum/) is a flexible, efficient and easy-to-use general purpose tool for quantum chemistry with specific emphasis on spectroscopic properties of open-shell  molecules. It features a wide variety of standard quantum chemical methods ranging from semi-empirical methods to DFT to single - and multi-reference correlated ab initio methods. It can also treat environmental and relativistic effects.

## User Responsibilities and Access
---

ORCA is a proprietary software, even if it is free it still requires you to agree to the ORCA license conditions. We have installed ORCA on Grex, but to access the binaries, each of the ORCA users has to confirm they have accepted the license terms.

The procedure is as follow: 
> * First, register at [ORCA forum](https://orcaforum.kofo.mpg.de/). 
> * You will receive a first email to verify the email address and activate the account. Follow the instructions in that email.
> * After the registration is complete, go to the ORCA download page, and accept the license conditions. You will get a second email stating that the "registration for ORCA download and usage has been completed".
> * Then contact us (via the Alliance support for example) quoting the ORCA email and stating that you also would like to access ORCA on Grex. 

The same procedure is applied to get access to [ORCA on the Alliance's clusters](https://docs.alliancecan.ca/wiki/ORCA).

## System specific notes
---

To see the versions installed on Grex and how to load them, please use **module spider orca** and follow the instructions. Both **ORCA-4** and **ORCA-5** are available on Grex.

To load **ORCA-5**, use:

{{< highlight bash >}}
module load gcc/4.8 ompi/4.1.1 orca/5.0.2
{{< /highlight >}}

To load **ORCA-4**, use:

{{< highlight bash >}}
module load gcc/4.8 ompi/3.1.4 orca/4.2.1
{{< /highlight >}}

**Note:**

{{< alert type="warning" >}}
The first released version of **ORCA-5** (5.0.1) is available on Grex. However, ORCA users should use the versions released after (as for now: **5.0.2** since it addresses some bugs of the two first releases 5.0.0 and 5.0.1). We may remove these versions any time.
{{< /alert >}}

## Using ORCA with SLURM
---

In addition to the different keywords required to run a given simulation, users should make sure to set two additional parameters, like Number of CPUs and maxcore in their input files:

* __maxcore:__
This option sets the "max" memory per core. This is the upper limit under ideal conditions where ORCA can (and apparently often does) overshoot this limit. It is recommended to use no more than 75 % of the physical memory available. So, if the base memory is 4 GB per core, one could use 3 GB. The synatxe is as follow:

{{< highlight bash >}}
%maxcore 3000
{{< /highlight >}}

Basically, one can use 75 % of the total memory requested by SLURM divided by number of CPUs asked for.

* __Number of CPUs:__

ORCA can run in multiple processors with the aid of OpenMPI. All the modules are installed with the recommended OpenMPI version. To run ORCA in parallel, you can simply set the __PAL__ keyword. For instance, a calculation using four processors requires:

{{< highlight bash >}}
!HF DEF2-SVP PAL4
{{< /highlight >}}

or 8:

{{< highlight bash >}}
!HF DEF2-SVP PAL8
{{< /highlight >}}

For more than eight processors (!PAL8), the explicit %PAL option has to be used:

{{< highlight bash >}}
!HF DEF2-SVP
%PAL NPROCS 16 END
{{< /highlight >}}

When running ORCA calculations in parallel, always use the full path to ORCA:

* On Grex, you can use:

{{< highlight bash >}}
ORCAEXEC=`which orca`

${ORCAEXEC} your-orca-input.in > your-orca-output.txt
{{< /highlight >}}

* On the Alliance clusters, the path is defined via an environment variable __EBROOTORCA__ that is set by the module:

{{< highlight bash >}}
${EBROOTORCA}/orca your-orca-input.in > your-orca-output.txt
{{< /highlight >}}

### Example on input file
---

{{< collapsible title="Example of ORCA input file" >}}
{{< snippet
    file="scripts/jobs/orca/orca-example.inp"
    caption="orca-example.inp"
    codelang="bash"
/>}}
{{< /collapsible >}}

### Sample Script for running ORCA on Grex
---

{{< collapsible title="Script example for running ORCA on Grex" >}}
{{< snippet
    file="scripts/jobs/orca/run-orca-grex.sh"
    caption="run-orca-grex.sh"
    codelang="bash"
/>}}
{{< /collapsible >}}

Assuming the script above is saved as __run-orca-grex.sh__, it can be submitted with:

{{< highlight bash >}}
sbatch run-orca-grex.sh
{{< /highlight >}}

### Sample Script for running NBO with ORCA on Grex
---

The input file should include the keyword **NBO**.

{{< collapsible title="Script example for running NBO with ORCA on Grex" >}}
{{< snippet
    file="scripts/jobs/orca/run-nbo-orca-grex.sh"
    caption="run-nbo-orca-grex.sh"
    codelang="bash"
/>}}
{{< /collapsible >}}

Assuming the script above is saved as __run-orca-grex.sh__, it can be submitted with:

{{< highlight bash >}}
sbatch run-nbo-orca-grex.sh
{{< /highlight >}}

For more information, visit the page [running jobs on Grex](running-jobs)

## Related links
---

* ORCA [forum](http://cec.mpg.de/forum/)
* ORCA on the [Alliance's clusters](https://docs.alliancecan.ca/wiki/ORCA)
* ORCA [input libraries](https://sites.google.com/site/orcainputlibrary/home)
* ORCA [common problems](https://sites.google.com/site/orcainputlibrary/orca-common-problems)
* SCF [convergence-issues](https://sites.google.com/site/orcainputlibrary/scf-convergence-issues)
* ORCA [tutorial](https://www.orcasoftware.de/tutorials_orca/)
* [Running jobs on Grex](running-jobs)
 
---

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* Last reviewed on: Apr 26, 2024.
-->
