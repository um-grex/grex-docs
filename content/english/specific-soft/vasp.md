---
weight: 1010
linkTitle: "VASP"
title: "Running VASP on Grex"
description: "Everything you need to know about running VASP on Grex."
categories: ["Software", "Scheduler"]
#tags: ["Configuration"]
---

## Introduction
---

[VASP](https://www.vasp.at/wiki/index.php/The_VASP_Manual) is a massively parallel plane-wave solid state DFT code. On Grex it is available only for the research groups that hold VASP licenses. To get access, PIs would need to send us a confirmation email from the VASP vendor, detailing the status of their license and a list of users allowed to use it. 

## System specific notes
---

On the Grex local software stack, we have VASP 5 and VASP 6 using Intel compiler and OpenMPI 3.1. To find out which versions of VASP are available, use ```module spider vasp``` .

For a version 6.1.2, at the time of writing the following modules have to be loaded:

{{< highlight bash >}}
module load intel/2019.5  ompi/3.1.4
module load vasp/6.1.2`
{{< /highlight >}}

There are three executables for VASP CPU version: __vasp_gam__ , __vasp_ncl__ , and  __vasp_std__. Refer to the VASP manual as to what these mean. An example VASP SLURM script using the standard version of the VASP binary is below:

The following script assumes that VASP6 inputs (INCAR, POTCAR etc.) are in the same directory as the job script.

{{< collapsible title="Script example for running VASP Grex" >}}
{{< snippet
    file="scripts/jobs/vasp/run-vasp.sh"
    caption="run-vasp.sh"
    codelang="bash"
/>}}
{{< /collapsible >}}

Assuming the script above is saved as __run-vasp.sh__, it can be submitted with:

{{< highlight bash >}}
sbatch run-vasp.sh
{{< /highlight >}}

For more information, visit the page [running jobs on Grex](running-jobs)

## Related links
---

* VASP [manual](https://www.vasp.at/wiki/index.php/The_VASP_Manual)
* [Running jobs on Grex](running-jobs)

---

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* 
*
*
-->
