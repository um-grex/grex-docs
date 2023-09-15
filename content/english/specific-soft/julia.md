---
weight: 1000
linkTitle: "Julia"
title: "Running Julia on Grex"
description: "Everything you need to know about running Julia on Grex."
categories: ["Software", "Scheduler"]
#tags: ["Configuration"]
---

## Introduction
---

[Julia](https://julialang.org/) is a programming language that was designed for performance, ease of use and portability. It is available as a module on Grex. 

## Available Julia versions
---

Presently, binary Julia versions **1.3.0**, **1.5.4** and **1.6.1** are available. Use ```module spider julia``` to find out other versions.

## Installing packages
---

We do not maintain centralized versions of Julia packages. Users should install Julia modules in their home directory. 

The command is (in Julia REPL): 

{{< highlight bash >}}
Using Pkg; Pkg.Add("My-Package")
{{< /highlight >}}

In case of package/version conflicts, remove the packages directory __~/.julia/__.

## Using Julia notebooks
---

It is possible to use IJulia kernels for Jupyter notebooks. A preferable way of running a Jupyter notebook is SLURM interactive job with **salloc** command.

(More details coming soon).

## Running Julia jobs 
---

Julia comes with a large variety of packages. Some of them would use threads; and therefore, have to be run as SMP jobs with _--cpus-per-task_ specified. Moreover, you would want to set the __JULIA_NUM_THREADS__ environment variable in your job script to be the same as SLURM's number of threads. 

{{< collapsible title="Script example for running Julia on Grex" >}}
{{< snippet
    file="scripts/jobs/julia/run-julia.sh"
    caption="run-julia.sh"
    codelang="bash"
/>}}
{{< /collapsible >}}

Assuming the script above is saved as __run-julia.sh__, it can be submitted with:

{{< highlight bash >}}
sbatch run-julia.sh
{{< /highlight >}}

For more information, visit the page [running jobs on Grex](running-jobs)

## Using Julia for GPU programming
---

It is possible to use Julia with CUDA Array objects to greatly speed up the Julia computations. For more information, please refer to this link: [julia-gpu-programming](https://nextjournal.com/sdanisch/julia-gpu-programming). However, a suitable "CUDA" module should be loaded during the installation of the CUDA Julia packages. And you likely want to be on a GPU node when the Julia GPU code is executed.

## Related links
---

* Julia on the [Alliance's clusters](https://docs.alliancecan.ca/wiki/Julia)
* [Running jobs on Grex](running-jobs)

---

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* 
*
*
-->
