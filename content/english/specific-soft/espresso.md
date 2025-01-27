---
weight: 1000
linkTitle: "Espresso"
title: "Running Quantum Espresso on Grex"
description: "Everything you need to know to run Quantum Espresso on Grex."
categories: ["Software", "Scheduler"]
#tags: ["Configuration"]
---

## Introduction
---

[Quantum ESPRESSO](https://www.quantum-espresso.org) is an integrated suite of computer codes for electronic-structure calculations and materials modeling at the nanoscale. It is based on      density-functional theory, plane waves, and pseudopotentials (both norm-conserving and ultrasoft).

## System specific notes
---

On the Grex's default software stack (_SBEnv_), Espresso is built using a variety of compilers and Open MPI 4.1 . 
To find out which versions are available, use **module spider espresso**. 

For a version 7.3.1, at the time of writing the following modules shoud be loaded:

{{< highlight bash >}}
module load  arch/avx512  intel/2023.2  openmpi/4.1.6
module load  espresso/7.3.1
{{< /highlight >}}

The above module gives access to the Espresso built with traditional Intel compilers and MKL. These would be recommended for compute nodes using Intel AVX512 CPUs.

For better efficiency on AMD CPUs (partitions _genoa_, _genlm_) a better performance may be achieved by using GCC compilers and AOCL linear algebra packages:
Note that the module _version_ has _+aocl-4.2.0_ ; this notation shows that it had been built with AOCL.

{{< highlight bash >}}
module load arch/avx512  gcc/13.2.0  openmpi/4.1.6
module load espresso/7.3.1+aocl-4.2.0
{{< /highlight >}}


{{< collapsible title="Script example for running Quantum Espresso on Grex" >}}
{{< snippet
    file="scripts/jobs/nwchem/run-espresso.sh"
    caption="run-espresso.sh"
    codelang="bash"
/>}}
{{< /collapsible >}}

Assuming the script above is saved as __run-espresso.sh__, it can be submitted with:

{{< highlight bash >}}
sbatch run-espresso.sh
{{< /highlight >}}

For more information, visit the page [running jobs on Grex](running-jobs)

### Running GPU version of Espresso

It is possible to build a version of Quantum Espresso using GPU hardware. Doing so requires the NVidia HPC compilers toolkit which is available on the NGC Cloud.
However, an easier way would be to just pull a latest Espresso version from the same NGC cloud using either [Singularuty or Podman](/software/containers).

[https://catalog.ngc.nvidia.com/orgs/hpc/containers/quantum_espresso](https://catalog.ngc.nvidia.com/orgs/hpc/containers/quantum_espresso)


## Related links
---

* [Running jobs on Grex](running-jobs)
* [NVidia NGC cloud Catalogue](https://catalog.ngc.nvidia.com/)

---

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* Last revision: Jan 28, 2025. 
-->
