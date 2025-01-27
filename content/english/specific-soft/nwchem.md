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

[NWChem](https://nwchemgit.github.io/) is a Scalable, massive parallel open source solution for large scale molecular simulations. NWChem is actively developed by a consortium of developers and maintained by the EMSL located at the Pacific Northwest National Laboratory (PNNL) in Washington State. The code is distributed as open-source under the terms of the Educational Community License version 2.0 (ECL 2.0).

## System specific notes
---

To find out which versions of NWChem are available, use **module spider nwchem** .

For a version 7.2.2, and using the local _SBEnv_ software stack, at the time of writing the following modules must be loaded:

{{< highlight bash >}}
module load arch/avx512 intel-one/2024.1 openmpi/4.1.6 
module load nwchem/7.2.2
{{< /highlight >}}

or

{{< highlight bash >}}
module load arch/avx512  aocc/4.2.0  openmpi/4.1.6
module load nwchem/7.2.2+aocl-4.2.0-64
{{< /highlight >}}

or

{{< highlight bash >}}
module load arch/avx512  gcc/13.2.0  openmpi/4.1.6 
module load nwchem/7.2.2+aocl-4.2.0-64
{{< /highlight >}}

By inspecting the dependencies, you can see that the above versions are different with respect the compilers used to build NWChem: these are IntelOneAPI compiler, GNU GCC v 13, and AMD AOCC 4.2, correspondingly.
The latter two versions might be slightly faster on AMD-based partitions (such as _genoa_, _genlm_), while the former will be faster on Intel CPUs (_skylake_ and _largemem_ partitions).

>The NWChem on Grex was built with the ARMCI variant [MPI-PR](https://github.com/nwchemgit/nwchem/wiki/ARMCI). Thus, NWCHem needs at least One process per node reserved for data communication. To run a serial job, one needs 2 tasks per node. To run a 22-core job over two whole nodes, one should ask for 2 nodes, 12 tasks per node. Simple number of tasks specification likely won't work because of the chance of having a single-task node allocated by SLURM; so __-\-nodes= -\-ntask-per-node__ specification is required.

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
* Last revision: Jan 27, 2025. 
-->
