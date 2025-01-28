---
weight: 1000
linkTitle: "GROMACS"
title: "Running GROMACS MD package on Grex"
description: "Everything you need to know to run GROMACS on Grex."
categories: ["Software", "Scheduler"]
#tags: ["Configuration"]
---

## Introduction
---

[GROMACS](https://www.gromacs.org) (GROningen MAchine for Chemical Simulations) is a molecular  dynamics package primarily designed for simulations of proteins, lipids  and nucleic acids. GROMACS is one of the fastest and most popular software packages  available and can run on CPUs as well as GPUs. 

## System specific notes
---

On the Grex's default software stack (_SBEnv_), GROMACS is built using a variety of compilers and OpenMPI 4.1 

To find out which versions are available, use **module spider gromacs**. There could be more than one (for example, CPU and GPU)  builds available for each GROMACS version as listed by _module spider_.

For a version _gromacs/2024.1_, at the time of writing the following modules should be loaded for the CPU version:

{{< highlight bash >}}
module load SBEnv
module load arch/avx512 gcc/13.2.0 openmpi/4.1.6
module load gromacs/2024.1
{{< /highlight >}}

The above module/version gives access to the GROMACS built for compute nodes on GREX, using Intel or AMD AVX512 CPUs.

There is also a CUDA GPU version that would be able to use GPU partitions on Grex. It can be made available by loading modules in the following order:

{{< highlight bash >}}
module load SBEnv
module load cuda/12.4.1  arch/avx2  gcc/13.2.0  openmpi/4.1.6
module load gromacs/2024.1
{{< /highlight >}}


{{< collapsible title="Script example for running GROMACS on Grex" >}}
{{< snippet
    file="scripts/jobs/gromacs/run-gromacs.sh"
    caption="run-gromacs.sh"
    codelang="bash"
/>}}
{{< /collapsible >}}

Assuming the script above is saved as __run-espresso.sh__, it can be submitted with:

{{< highlight bash >}}
sbatch run-gromacs.sh
{{< /highlight >}}

For more information, visit the page [running jobs on Grex](running-jobs)


## Related links
---

* [Running jobs on Grex](running-jobs)
* [Alliance GROMACS documentation](https://docs.alliancecan.ca/wiki/GROMACS) provides more use cases and examples that largely apply to Grex as well.

---

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* Last revision: Jan 28, 2025. 
-->
