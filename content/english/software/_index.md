---
weight: 6000
linkTitle: "Software / Applications"
title: "Software and Applications"
description: "All you need to know about software on Grex."
titleIcon: "fa-solid fa-house-chimney"
categories: ["Software"]
#tags: ["Content management"]
---

## Software
---

In the HPC world, software is more often meant as codes that do some scientific or engineering computation, data processing and visualization (as opposed to web services, relational databases, client-server business systems, email and office, ... etc.)

Tools and libraries used to develop HPC software are also software, and have several best practices associated with them. Some of  that will be covered below. Without means to provide software to do computations, HPC systems would be rather useless.

Fortunately, most HPC systems, and Grex is no exception, come with a pre-installed, curated software stack. This section covers how to find the installed software, how to access it, and what options you have if some of the software you need is missing.

## How software is installed and distributed
---

There are several mechanisms of software installation under Linux. One of them is using Linux software package manager (__apt__ on Ubuntu, __yum__ on Centos, ... etc.) and a binary package repository provided by some third party. These package managers would install a version of the code system wide, into standard OS directories like __/usr/bin__ where it would be immediately available in the system's PATH (PATH is a variable that specifies where the operating systems would look for executable code).

This method of installation is often practiced on a person's own workstations, because it requires no knowledge other than syntax of the OS package manager. There are however significant drawbacks to it for using on HPC clusters that consists of many compute nodes and are shared by many users:

> - Need of root access to install in the base OS is a systems stability and security threat, and has a potential of users interfering with each other.
> - Package managers as a rule do not keep several versions of the same package; they are geared towards having only the newest one (as in "software update"), which poses a problem for reproducible research.
> - A package should be installed across all the nodes of the cluster; thus, the installations should be somehow managed.
> - Binary packages in public repos tend to be compiled for generic CPU architectures rather than optimized for a particular system.

Thus, in the HPC world, as a rule, only a minimal set of core Linux OS packages is installed by system administrators, and no access to package managers is given to the end users. There are ways to let users have their own Linux OS images through virtualization and containerization technologies (see the [containers](/software/containers/) section) when it is really necessary.

On most of the HPC machines, the application software is recompiled from sources and installed into a shared filesystem so that each compute node has access to the same code or program. Multiple versions of a software package can be installed into each own PATH; dependencies between software (such as libraries from one package needed to be accessed by another package) are tracked via a special software called Environmental Modules.

The Modules package would manipulate the PATH (and other systems environment variables like **LD_LIBRARY_PATH**, **CPATH** and application-specific ones like **MKLROOT**, **HDF5_HOME**) on user request, "loading" and "unloading" specified software items.

The two most popular Modules are the original [Tcl Modules](http://modules.sourceforge.net/) and its [Lmod](https://lmod.readthedocs.io/en/latest/) rewrite in Lua at [TACC](https://www.tacc.utexas.edu/research-development/tacc-projects/lmod). On the new Grex, **Lmod** is used.

## Lmod
---

The main feature of Lmod is the hierarchical module system to provide a better control of software dependencies. Modules for software items that depend on a particular core module (toolchains: a compiler suite, a MPI library) are only accessible after the core modules are loaded. This prevents situations where conflicts appear when software items built with different toolchains are loaded simultaneously. Lmod will also automatically unload conflicting modules and reload their dependencies should toolchain change. Finally, by manipulating module root paths, it is possible to provide more than one software stack per HPC system. For more information, please refer to the software stacks available on Grex and using modules [page](software/using-modules).

## How to find the software with Lmod Modules
---

A "software stack" module should be loaded first. On Grex, there are two software stacks, called __SBEnv__ and __CCEnv__, standing for the software built on Grex locally and the software environment from the Alliance (Compute Canada), correspondingly. __SBEnv__ is the only module loaded by default.

When a software stack module is loaded, the **module spider** command will find a specific software item (for example, GROMACS; note that all the module names are __lower-case__ on Grex and on Alliance software stacks) if it exist under that stack:

{{< highlight bash >}}
module spider gromacs
{{< /highlight >}}

It might return several versions; then usually a subsequent command with the version is used to determine dependencies required for the software. 
In case of GROMACS on Grex, at the time of writing, it returns four versions, with _gromacs/2024.1_ being the latest. Lets find its dependencies.

{{< highlight bash >}}
module spider gromacs/2024.1
{{< /highlight >}}

It will advise that there are two sets of dependencies, one for the CPU version and one for the GPU version. 
For the CPU version, we'd need to load the following modules: __"  arch/avx512  gcc/13.2.0  openmpi/4.1.6"__. Note that the first module is for CPU architecture. Most CPU nodes on Grex use _arch/avx512_.
Then, after the  dependencies are loaded  **module load** command can be used actually to load the GROMACS environment, for the CPU version. 

{{< highlight bash >}}
module load arch/avx512  gcc/13.2.0  openmpi/4.1.6
module load gromacs/2024.1
{{< /highlight >}}

For more information about using Lmod modules, please refer to the [Modules](software/using-modules) pages on this documentation.

## How and when to install software in your HOME directory
---

Linux (Unlike some Desktop operating systems) has a concept of user permissions separation. Regular users cannot, unless explicitly permitted, access the system's files and files of other users.

You can almost always install software without **super-user** access into your __/home/$USER__ directory. Moreover, you can manage the software with Lmod: Lmod automatically searches for module files under __$HOME/modulefiles__ and adds the modules it discovers there into the modules tree so they can be found by __module spider__, loaded by __module load__, etc.

Most Linux software can be installed from sources using either [Autoconf](https://www.gnu.org/software/autoconf/) or [CMake](https://cmake.org/) configuration tools. These will accept __-\-prefix=/home/$USER/my-software/version__ or __-DCMAKE_INSTALL_PREFIX=/home/$USER/my-software/version__ as arguments. These paths are used for the installation directories where the user has full access.

Software that comes as a binary archive to be unpacked can be simply unpacked into your home directory location. Then, the paths should be set for the software to be found: either by including the environment variable in __$HOME/.bashrc__ or in __$HOME/.bash_profile__ or by creating a specific module in __$HOME/modulefiles/my-software/version__ following Lmod instructions for [writing Modules](https://lmod.readthedocs.io/en/latest/015_writing_modules.html).

There exist binary software environments like _conda_ that manage their own tree of binary-everything. These can be used from your home directory as well, with some caution, because automatically pulling every software from a conda channel might conflict with the same software existing in the HPC environment (Python package paths, MPI libraries, etc.).
> Note that as of 2024, Anaconda owners strictened their licensing policy. We do not provide any system-wide _conda_ installations on Grex. In case users want to continue using _conda_, they must be sure that they have a proper Anaconda license to do so. Note also that the same applies for _mamba_ which would use the same conda software channels.

However, if a software is really a part of the base OS (something like a graphics Desktop software, etc.), it can be hard to rebuild from sources due to many dependencies. If needed, it may be better if installed centrally or used in a container, see Containers [documentation](software/containers).

## Internal links
---

{{< treeview />}}

## External links
---

* [Lmod](https://lmod.readthedocs.io/en/latest/ "Lmod")
* [Tcl Modules](http://modules.sourceforge.net/ "Tcl Modules")
* [CMake](https://cmake.org/ "CMake")
* [Autoconf](https://www.gnu.org/software/autoconf/ "Autoconf")

---

<!-- Changes and update:
* Last reviewed on: Apr 30, 2024.
-->
