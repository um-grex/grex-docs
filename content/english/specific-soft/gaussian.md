---
weight: 1000
linkTitle: "Gaussian"
title: "Running Gaussian on Grex"
description: "Everything you need to know to run Gaussian on Grex."
categories: ["Software", "Scheduler"]
#tags: ["Configuration"]
---

## Introduction
---

[Gaussian 16](http://gaussian.com/ "Gaussian") is a comprehensive suite for electronic structure modeling using __ab initio__, DFT and semi-empirical methods. A list of Gaussian 16 features can be found [here](http://gaussian.com/g16glance/ "Gaussian Features").

## User Responsibilities and Access
---

University of Manitoba has a site license for Gaussian 16 and GaussView. However, it comes with certain license limitations, so access to the code is subject to some license conditions.

Since, as of now, Compute Canada accounts are a superset of Grex accounts, users will want to initiate getting access by sending an email agreeing to Gaussian conditions to __support@tech.alliancecan.ca__, confirming that you have read and agree to abide by the following conditions, and mentioning that you'd also want to access it on Grex:

>  __1.__ I am not a member of a research group developing software competitive to Gaussian.

>  __2.__ I will not copy the Gaussian software, nor make it available to anyone else.

>  __3.__ I will properly acknowledge Gaussian Inc. and Compute Canada in publications.

>  __4.__ I will notify Compute Canada of any change in the above acknowledgement.

If you are a sponsored user, your sponsor (PI) must also have such a statement on file with us. 

Moreover, the terms of the UManitoba license are actually stricter than for the Alliance (Compute Canada). In particular, it excludes certain research groups at the University to have access to the software. Therefore, we are required by Gaussian to have each of the Gaussian users to sign a Confidentiality Agreement form as provided to us by Gaussian. Inc. Please drop by our office in Engineering, E2-588 to get the form and return it signed.

## System specific notes
---

On Grex, Gaussian is limited to a single node, SMP jobs and the memory of a single node. There is no Linda. The Gaussian code is accessible as a module. The module sets Gaussian's environment variables like __GAUSS_SCRDIR__ (the latter, to local node scratch).

{{< highlight bash >}}
module load gaussian/g16.c01
{{< /highlight >}}

To load the module and access the binaries, you will first get access as per above. Also, our Gaussian license span is less than Compute Canada's support contract, so there are fewer versions available. Use ```module spider gaussian``` to see what is available on Grex.

After a Gaussian module is loaded, the GaussView software also becomes available (provided you have connected with X11 support, perhaps using X2Go) as follows:

{{< highlight bash >}}
gv
{{< /highlight >}}
  
The viewer should not be used to run production calculations on Grex login nodes. Instead, as for any other production calculations, SLURM jobs should be used as described below.

## Using Gaussian with SLURM
---

### Sample SLURM Script
---

{{< collapsible title="Script example for running Gaussian on Grex" >}}
{{< snippet
    file="scripts/jobs/gaussian/run-gaussian.sh"
    caption="run-gaussian.sh"
    codelang="bash"
/>}}
{{< /collapsible >}}

### Simplified job submission
---

A simplified job script **sbg16** is available (after loading of the g16 module) for automatic generation and submission of SLURM Gaussian jobs.

{{< highlight bash >}}
sbg16 input.gjf -ppn 12 -mem 40000mb -time 8:00:00
{{< /highlight >}}

## Using NBO
---

University of Manitoba has site licenses for NBO6 and NBO7. Corresponding NBO modules would have to be loaded in order to use Gaussian's __POP=NBO6__ or __NBO7__ keywords.

To list available NBO versions and their dependencies, run the command:

{{< highlight bash >}}
module spider nbo
{{< /highlight >}}

## Related links
---

* [Gaussian](https://gaussian.com/man/) documentation.
* [Gaussian](https://docs.alliancecan.ca/wiki/Gaussian) page on Compute Canada wiki.
* Gaussian [error messages](https://docs.alliancecan.ca/wiki/Gaussian_error_messages).

---

<!-- Changes and update:
* 
*
*
-->
