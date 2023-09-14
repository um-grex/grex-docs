---
weight: 1000
linkTitle: "NWChem"
title: "Running NWChem on Grex"
description: "Everything you need to know to run NWChem on Grex."
categories: ["Software", "Scheduler"]
#tags: ["Configuration"]
---

## Introduction
---

[NWChem](https://nwchemgit.github.io/) is a Scalable open-source solution for large scale molecular simulations. NWChem is actively developed by a consortium of developers and maintained by the EMSL located at the Pacific Northwest National Laboratory (PNNL) in Washington State. The code is distributed as open-source under the terms of the Educational Community License version 2.0 (ECL 2.0).

## System specific notes
---

On the Grex software stack, NWChem is using OpenMPI 3.1 with Intel compilers toolchains. To find out which versions aare available, use **module spider nwchem**.

For a version 6.8.1, at the time of writing the following modules have to be loaded:

{{< highlight bash >}}
module load intel/15.0 ompi/3.1.4 nwchem/6.8.1
{{< /highlight >}}

The NWChem on Grex was built with the ARMCI variant [MPI-PR](https://github.com/nwchemgit/nwchem/wiki/ARMCI). Thus, NWCHem needs at least One process per node reserved for data communication. To run a serial job one needs 2 tasks per node. To run a 22-core job over two whole nodes, one has to ask for 2 nodes, 12 tasks per node. Simple number of tasks specification likely won't work because of the chance of having a single-task node allocated by SLURM; so __-\-nodes= -\-ntask-per-node__ specification is required.

{{< collapsible title="Script example for running NWChem on Grex" >}}
{{< snippet
    file="scripts/jobs/nwchem/run-nwchem.sh"
    caption="run-nwchem.sh"
    codelang="bash"
/>}}
{{< /collapsible >}}

Assuming the script above is saved as __run-nwchem.sh__, it can be submitted with:

{{< highlight bash >}}
sbatch run-nwchem.sh
{{< /highlight >}}

For more information, visit the page [running jobs on Grex](running-jobs)

## Related links
---

* [NWChem](https://nwchemgit.github.io/) 
* [Running jobs on Grex](running-jobs)

---

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* 
*
*
-->
