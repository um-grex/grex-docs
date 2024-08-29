---
weight: 1000
linkTitle: "LAMMPS"
title: "Running LAMMPS on Grex"
description: "Everything you need to know about running LAMMPS on Grex."
categories: ["Software", "Scheduler"]
banner: true
bannerContent: "__Work in progress.__"
#tags: ["Configuration"]
---

**Note: Lammps is not available yet under the new environment _SBEnv_.**

## Introduction
---

[LAMMPS](https://www.lammps.org/) is a classical molecular dynamics code. The name stands for Large-scale Atomic / Molecular Massively Parallel Simulator.

## Modules
---

As fo now, there is no LAMMPS version added to the new environment. We will add them when users request a specific version. With that said, it is possible to use LAMMPS from the Alliance software stack after load _CCEnv_:

{{< highlight bash >}}
module purge
module load CCEnv
module load arch/avx512 
module load StdEnv/2023
module load intel/2023.2.1  openmpi/4.1.5
module load lammps-omp/20230802
{{< /highlight >}}

### Serial version

{{< collapsible title="Script example for LAMMPS: Serial version" >}}
{{< snippet
    file="scripts/jobs/lammps/run-lammps-serial-cc.sh"
    caption="run-lammps-serial-cc.sh"
    codelang="bash"
/>}}
{{< /collapsible >}}

### MPI version
---

{{< collapsible title="Script example for LAMMPS: MPI version" >}}
{{< snippet
    file="scripts/jobs/lammps/run-lammps-mpi-cc.sh"
    caption="run-lammps-mpi-cc.sh"
    codelang="bash"
/>}}
{{< /collapsible >}}

<!--

Multiple versions of LAMMPS were installed on Grex. To see all the available versions, use __module spider lammps__ and follow the instructions. 

## Available CPU versions:
---

| Version   | Module Name     | Supported Packages |
| :-------: | :---------:     | ------------------ | 
| 29 Sep 21 | lammps/29Sep21  | * |
| 05 Jun 19 | lammps/5Jun19   | * |
| 11 Aug 17 | lammps/11Aug17  | * |
| 05 Nov 16 | lammps/5Nov16   | * |
| 30 Jul 16 | lammps/30jul16  | * |

## Available GPU versions:
---

As for the time when writing this page, there is only one version of LAMMPS with GPU support. It can be loaded using:

{{< highlight bash >}}
module load intel/2020.4  ompi/4.1.2 lammps-gpu/24Mar22
{{< /highlight >}}

The name of the binary is called __lmp_gpu__ (see the example of script below).

| Version   | Module name        |
| -------   | -----------        |
| 24 Mar 22 | lammps-gpu/24Mar22 |

## Scripts examples
---

## Serial version
---

{{< collapsible title="Script example for LAMMPS: Serial version" >}}
{{< snippet
    file="scripts/jobs/lammps/run-lammps-serial.sh"
    caption="run-lammps-serial.sh"
    codelang="bash"
/>}}
{{< /collapsible >}}

## MPI version 
---

{{< collapsible title="Script example for LAMMPS: MPI version" >}}
{{< snippet
    file="scripts/jobs/lammps/run-lammps-mpi.sh"
    caption="run-lammps-mpi.sh"
    codelang="bash"
/>}}
{{< /collapsible >}}

## OpenMP version
---

## Hybrid version: MPI and OpenMP
---

## GPU version
---

{{< collapsible title="Script example for LAMMPS: GPU version" >}}
{{< snippet
    file="scripts/jobs/lammps/run-lammps-mpi-gpu.sh"
    caption="run-lammps-mpi-gpu.sh"
    codelang="bash"
/>}}
{{< /collapsible >}}

# Performance
---

-->

# Related links
---

* [LAMMPS](https://www.lammps.org/) website.
* LAMMPS [GitHub](https://www.lammps.org/)
* LAMMPS [online](https://docs.lammps.org/Manual.html) documentation.
* [LAMMPS](https://docs.alliancecan.ca/wiki/LAMMPS/en)
<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* Last reviewed on: Apr 26, 2024.
-->
