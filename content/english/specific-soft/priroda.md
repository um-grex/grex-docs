---
weight: 1010
linkTitle: "Priroda"
title: "Running Priroda on Grex"
description: "Everything you need to know for running Priroda on Grex."
categories: ["Software", "Scheduler"]
#tags: ["Configuration"]
---

## Introduction
---

Priroda is a fast parallel relativistic DFT and _ab-initio_ code for molecular modeling, developed by Dr. Dimitri N. Laikov. The code originally implemented fast resolution-of-identity GGA DFT for coulomb and exchange integrals. Later it was extended to provide RI-DFT with hybrid functional, RI-HF and RI-MP2, and parallel high-level coupled-cluster methods. All these levels of theory can be used together with an efficient all-electron scalar-relativistic method, with small-component bases supplied for all the elements of the Periodic Table. The current release of the code also includes a novel NDO-based semi-empirical method.

## User Responsibilities and Access
---

The code is free for academic users, but is not open source. It is distributed on request by the Author, Dr. Dimitri N. Laikov.

To access the Priroda code on Grex, the prospective users have to send us (support@tech.alliancecan.ca) a free-form email confirming that  they have read and agreed to abide by the following conditions:

**Conditions for the Priroda code access on Grex:**

> * I understand that the Priroda code's ownership and copyright belongs solely to its Author, Dr. Dimitri N. Laikov. I will not incorporate any part of the Priroda code into any other program system, either for sale or for non-profit distribution, without written permission by the Author.

> * I will not copy, distribute or supply the Priroda code for any reason whatsoever to third persons or organizations. Instead, I will direct all the code requests to the Author.

> * If results obtained with the code are published, I will cite the proper Priroda code references and, when appropriate, the specific methods references, as described in the Priroda code documentation and/or Dr. Laikov's [website](http://rad.chem.msu.ru/~laikov/).

> * I understand that the Priroda code is provided "as is" and the author is not assuming any responsibilities or any liabilities that might arise from the usage of the code, whatsoever.

After receiving the email, we will add the user to the wg-prrda UNIX group that is used to control access to the Priroda program, basis sets and documentation.

## Running Priroda on Grex
---

The Priroda code is linked against OpenMPI built with a GCC compiler. There are several versions of them, and __module spider priroda__ would help to locate the dependencies. As of the time of writing this documentation, the following command would load the Priroda version of 2016:

{{< highlight bash >}}
module load gcc/5.2 ompi/3.1.4 priroda/2016
{{< /highlight >}}

The parallel Priroda executable (called __p__) will be in the PATH after loading of the module. Its basis sets and/or semi-empirical method parameters can be found under __$PRIRODA/bin__. Documentation and examples are available under __$PRIRODA/doc__ and __$PRIRODA/example__, correspondingly. 

The style of the Priroda input is of free format namelist groups, similar to that of GAMESS-US but more flexible (no limitations inherited from Fortran77). Examples and description of each input group are in the __doc__ and __example__ directories.
To invoke the code interactively:

{{< highlight bash >}}
mpiexec p name.inp name.out
{{< /highlight >}}

An archive of old Priroda documentation is here [Priroda old docs from KNC](/manuals/Priroda_Documentation_from_KNCWiki.pdf)

## Using Priroda with SLURM
---

Priroda is MPI-parallelized. The parallel efficiency varies on the method used and the kind of calculation (energies, geometry optimizations or analytical hessians) performed. Pure GGA DFT calculations are quite fast and tightly coupled, and it makes sense to use a single node with a few tasks per node, or a few nodes, as in the example below. RI-MP2 calculations would benefit from more massively parallel calculations, spanning several nodes. 

It makes no sense to ask more than 4000mb per task. 

{{< collapsible title="Script example for running PRIRODA on Grex" >}}
{{< snippet
    file="scripts/jobs/priroda/run-priroda.sh"
    caption="run-priroda.sh"
    codelang="bash"
/>}}
{{< /collapsible >}}

## Various scripts and utilities
---

There are some simple scripts and utilities in the __$PRIRODA/contrib__ directory. They can be used for conversions of inputs/outputs to and from Molden XYZ format, extraction of the MOs and vibrational frequencies, and restart information from the Priroda output files.

## Related links
---

* Dr. Laikov's [website](http://rad.chem.msu.ru/~laikov/)
* Priroda old docs from [KNC](/manuals/Priroda_Documentation_from_KNCWiki.pdf)

---

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* 
*
*
-->
