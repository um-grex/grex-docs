---
weight: 1000
linkTitle: "R"
title: "Running R on Grex"
description: "Everything you need to know about running R on Grex."
categories: ["Software", "Scheduler"]
#tags: ["Configuration"]
---

## Introduction
---

[R](https://www.r-project.org/) is a system for statistical computation and graphics. It consists of a language plus a runtime environment with graphics, a debugger, access to certain system functions, and the ability to run programs stored in script files. 

## Available R versions
---

Multiple versions of R are available. Use ```module spider r``` to find out the different versions of R:

{{< highlight bash >}}
[~@yak ~]$ module spider r
  r/4.4.1+aocl-4.2.0
  r/4.4.1+mkl-2019.5
  r/4.4.1+mkl-2024.1
  r/4.5.0+mkl-2024.1
  r/4.5.0+openblas-0.3.28
{{< /highlight >}}

To see how to load a particular version, run the command ```module spider r/<version>```.

At the time of updating this page, the version __r/4.5.0+mkl-2024.1__ is available and can be loaded using:

{{< highlight bash >}}
module load arch/avx512 gcc/13.2.0 r/4.5.0+mkl-2024.1
{{< /highlight >}}

{{< alert type="warning" >}}
The R modules include a set of packages by default. If the package you are looking for is not included in the base modules, you will have to install them locally under your account after loading a specifi version of R. For more information, please have a look to the section __Installing packages.__
{{< /alert >}}

The R interpreter can be launched by invoking the command R afyer loading the module:

{{< highlight bash >}}
[~@yak ~]$ module load arch/avx512  gcc/13.2.0 r/4.5.0+mkl-2024.1

[~@yak ~]$ R

R version 4.5.0 (2025-04-11) -- "How About a Twenty-Six"
Copyright (C) 2025 The R Foundation for Statistical Computing
Platform: x86_64-pc-linux-gnu

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

[Previously saved workspace restored]

> 
{{< /highlight >}}

To see the packages installed, use the command ```installed.packages()```

To run R code __my-program.R__ interactively, use:

{{< highlight bash >}}
[~@yak ~]$ module load arch/avx512  gcc/13.2.0 r/4.5.0+mkl-2024.1
[~@yak ~]$ Rscript my-program.R 
{{< /highlight >}}

The following shows an example of scripts to run R code on Grex using a batch job:

{{< collapsible title="Script example for running R on Grex" >}}
{{< snippet
    file="scripts/jobs/r-program/run-r-serial.sh"
    caption="run-r-serial.sh"
    codelang="bash"
/>}}
{{< /collapsible >}}

## Installing R packages
---

As mentioned above, the base modules have already some packages. However, users may have to install additional packages depending on what their program uses. Here is a quick example of installing a package called __tidyverse__ unsing the R module __r/4.5.0+mkl-2024.1__.

{{< highlight bash >}}
[~@yak ~]$ module load arch/avx512 gcc/13.2.0 r/4.5.0+mkl-2024.1
[~@yak ~]$ R
[~@yak ~]$ > Sys.setenv("DISPLAY"=":0.0")
[~@yak ~]$ > install.packages("tidyverse")
{{< /highlight >}}

The command ```Sys.setenv("DISPLAY"=":0.0")``` is not required but it helps for not opening the GUI interface that might be slow over ssh.

For the first installation, there are two warning messages that ask questions about the personal library where R packages will be installed:

{{< highlight bash >}}
Warning in install.packages("tidyverse") :
  'lib = "/home/software/alma8/sb/opt/arch-avx512-gcc-13.2.0/r/4.5.0+mkl-2024.1/lib64/R/library"' is not writable
Would you like to use a personal library instead? (yes/No/cancel) yes
Would you like to create a personal library
‘/home/$USER/R/x86_64-pc-linux-gnu-library/4.5’
to install packages into? (yes/No/cancel) yes
{{< /highlight >}}

The message refers to a path where the base module is installed. As a user, you do not have write access to this directory. Therefore, the answers to the above questions should be __yes__ and the packages will be installed under a directory __/home/$USER/R__ under your account where you have read and write access. You can add all your packages as described above and they will be stored under the directory __/home/$USER/R__. Please keep this directory as it is if you want to keep your packages. If deleted, you will have to re-install again all your packages. It is recommended to keep track on the installation process (like list of modules and packages) in case you need to reproduce the installation another time.

{{< alert type="info" >}}
Under the directory __/home/$USER/R/x86_64-pc-linux-gnu-library__, a sub directory named with the major version of R is created. For example, _4.5_ for all R versions _4.5.x_.
{{< /alert >}}

In the example of installing the package _tidyverse_, no additional library or module was required. However, on many cases, the installation of R packages requires additional modules. The list is, but not limited to, gsl, netcdf, hdf5, udunits, geos, proj, gdal, tbb, ... etc. Usually, the error message gives a hint to the misssing library. The dependencies used to install any R package are also required to be loaded when running the job. 

As an example, to install the package _rjags_, one need to load jags module in addition to R:
{{< highlight bash >}}
[~@yak ~]$ module load arch/avx512 gcc/13.2.0 r/4.5.0+mkl-2024.1
[~@yak ~]$ module load jags
[~@yak ~]$ R
[~@yak ~]$ > Sys.setenv("DISPLAY"=":0.0")
[~@yak ~]$ > install.packages("rjags")
{{< /highlight >}}

### Packages from CRAN mirrors

After loading r module and all the required dependencies, the installation of R package from CRAN is invoked by the command __install.packages("name of the package")__ like in the following example for installing _rjags_. This package requires an additional external module called _jags_:

{{< highlight bash >}}
[~@yak ~]$ module load arch/avx512 gcc/13.2.0 r/4.5.0+mkl-2024.1
[~@yak ~]$ module load jags
[~@yak ~]$ R
[~@yak ~]$ > Sys.setenv("DISPLAY"=":0.0")
[~@yak ~]$ > install.packages("rjags")
{{< /highlight >}}

It is possible to bundle more than one package in the same command line using:

{{< highlight bash >}}
install.packages(c("packae1", "package2", "package3"))
{{< /highlight >}}

### Packages from GitHub repositories

There are R packages hosted on GitHub and their installation require to first install [devtools](https://r-lib.r-universe.dev/devtools/doc/manual.html) or [remotes](https://r-lib.r-universe.dev/remotes/doc/manual.html). First, one need to add the package ```devtools``` or ```remotes``` if not installed already and make them available in the R prompt before using them to install other packages.

Here is an example used to install [stampr](https://github.com/jedalong/stampr) with ```devtools```:

{{< highlight bash >}}
[~@yak ~]$ module load arch/avx512 gcc/13.2.0 r/4.5.0+mkl-2024.1 gdal
[~@yak ~]$ R
[~@yak ~]$ > Sys.setenv("DISPLAY"=":0.0")
[~@yak ~]$ > install.packages("devtools")
[~@yak ~]$ > library("devtools")
[~@yak ~]$ > devtools::install_github("jedalong/stampr") 
{{< /highlight >}}

{{< alert type="warning" >}}
During the installation, you may get questions about updating packages and choose which packages to update. 
{{< /alert >}}

Similar procedure could be used to install a package with ```remotes`:

{{< highlight bash >}}
[~@yak ~]$ module load arch/avx512 gcc/13.2.0 r/4.5.0+mkl-2024.1 gdal geos
[~@yak ~]$ R
[~@yak ~]$ > Sys.setenv("DISPLAY"=":0.0")
[~@yak ~]$ > install.packages("remotes")
[~@yak ~]$ > library("remotes")
[~@yak ~]$ > remotes::install_github("jedalong/stampr")
{{< /highlight >}}

### Bioconductor packages

The following example shows how to install the packages "edgeR", "qvalue", "GenomicAlignments", "GenomicFeatures" using ```BiocManager``` :

{{< highlight bash >}}
[~@yak ~]$ module load arch/avx512 gcc/13.2.0 r/4.5.0+mkl-2024.1
[~@yak ~]$ R
[~@yak ~]$ > Sys.setenv("DISPLAY"=":0.0")
[~@yak ~]$ > if (!require("BiocManager", quietly = TRUE))
[~@yak ~]$ + install.packages("BiocManager")

[~@yak ~]$ > BiocManager::install(c("edgeR", "qvalue", "GenomicAlignments", "GenomicFeatures"))
{{< /highlight >}}

## External Links
---

* R [documentation](https://www.r-project.org/other-docs.html)

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* Last revision: Jun 17, 2025. 
-->
