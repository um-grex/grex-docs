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

<!--
In the HPC world, software is more often meant as codes that do some scientific or engineering computation, data processing and visualization (as opposed to web services, relational databases, client-server business systems, email and office, ... etc.)
Tools and libraries used to develop HPC software are also software, and have several best practices associated with them. Some of  that will be covered below. Without means to provide software to do computations, HPC systems would be rather useless.
Fortunately, most HPC systems, and Grex is no exception, come with a pre-installed, curated software stack. This section covers how to find the installed software, how to access it, and what options you have if some of the software you need is missing.
-->

In HPC, "software" typically refers to scientific and engineering codes for computation, data processing, and visualization -— rather than common business IT applications like web services or email clients. Without software to run workloads, HPC systems would be of little use. Development tools and libraries used to build HPC applications are also considered to be "software". 

Fortunately, most HPC systems, including Grex, come with a curated set of pre-installed software. This section explains how to find, access, and manage HPC software, and what to do if some software item you need is missing.

## How software is installed and distributed
---

<!--
There are several mechanisms of software installation under Linux. One of them is using Linux software package manager (__apt__ on Ubuntu, __yum__ on Centos, ... etc.) and a binary package repository provided by some third party. These package managers would install a version of the code system wide, into standard OS directories like __/usr/bin__ where it would be immediately available in the system's PATH (PATH is a variable that specifies where the operating systems would look for executable code).
This method of installation is often practiced on a person's own workstations, because it requires no knowledge other than syntax of the OS package manager. There are however significant drawbacks to it for using on HPC clusters that consists of many compute nodes and are shared by many users:

> - Need of root access to install in the base OS is a systems stability and security threat and has a potential of users interfering with each other.
> - Package managers as a rule do not keep several versions of the same package; they are geared towards having only the newest one (as in "software update"), which poses a problem for reproducible research.
> - A package should be installed across all the nodes of the cluster; thus, the installations should be somehow managed.
> - Binary packages in public repos tend to be compiled for generic CPU architectures rather than optimized for a particular system.

Thus, in the HPC world, as a rule, only a minimal set of core Linux OS packages is installed by system administrators, and no access to package managers is given to the end users. There are ways to let users have their own Linux OS images through virtualization and containerization technologies (see the [containers](/software/containers/) section) when it is necessary.
On most of the HPC machines, the application software is recompiled from sources and installed into a shared filesystem so that each compute node has access to the same code or program. Multiple versions of a software package can be installed into each own PATH; dependencies between software (such as libraries from one package needed to be accessed by another package) are tracked via a special software called Environmental Modules.
The Modules package would manipulate the PATH (and other systems environment variables like **LD_LIBRARY_PATH**, **CPATH** and application-specific ones like **MKLROOT**, **HDF5_HOME**) on user request, "loading" and "unloading" specified software items.
The two most popular Modules are the original [Tcl Modules](http://modules.sourceforge.net/) and its [Lmod](https://lmod.readthedocs.io/en/latest/) rewrite in Lua at [TACC](https://www.tacc.utexas.edu/research-development/tacc-projects/lmod). On the new Grex, **Lmod** is used.
-->

Linux software is often installed system-wide using package managers (e.g., __apt__ on Debian and Ubuntu, __yum__ or __dnf__ on RedHat and its derivatives). These tools install binaries into standard locations like __/usr/bin__, making them immediately available via the system _PATH_. 
(_PATH_ is a variable specifying where the operating systems would look for executable code). 

While convenient on personal machines, this approach doesn’t scale well to HPC environments due to:

 * The need for users to have privileged (root) access, which can compromise stability and security of shared HPC systems.
 * Package managers typically support only a single, newest version of each package at a time, which hinders reproducibility.
 * Software must be consistently installed across all compute nodes.
 * Public binary packages are usually compiled for generic CPUs, not optimized for a specific HPC systems hardware.

Because of these limitations, HPC clusters usually do not rely on OS software repositories. They only include a minimal base OS install. Users don’t have access to system package managers. Instead, application software is built from source and installed on a shared filesystem accessible by all nodes. Multiple versions can coexist, and software dependencies are managed with [Environment Modules](/software/using-modules).

Modules allow users to dynamically modify their environment (e.g., _PATH_, _LD_LIBRARY_PATH_, _CPATH_, _MKLROOT_, _HDF5HOME_) to load or unload specific software packages.

## Lmod configuration on Grex
---

<!--
The main feature of Lmod is the hierarchical module system to provide a better control of software dependencies. Modules for software items that depend on a particular core module (toolchains: a compiler suite, a MPI library) are only accessible after the core modules are loaded. This prevents situations where conflicts appear when software items built with different toolchains are loaded simultaneously. Lmod will also automatically unload conflicting modules and reload their dependencies should toolchain change. Finally, by manipulating module root paths, it is possible to provide more than one software stack per HPC system. For more information, please refer to the software stacks available on Grex and using modules [page](software/using-modules).
-->

Grex uses [Lmod](https://lmod.readthedocs.io/en/latest), a modern, Lua-based module system developed at Texas Advanced Computing Center. Lmod supports hierarchical modules, which organize software based on dependencies like CPU architecture, compilers, and MPI implementations. Using module hierarchies helps to avoid conflicts between incompatible software toolchains.

Lmod would:

 * Hide software items for which their dependencies/toolchains are not yet loaded.
 * Automatically unload conflicting modules when switching toolchains.
 * Reload required dependencies as needed when a module is switched.
 * Supports multiple software stacks through configurable module paths.
 
For more information about Lmod, please refer to the software stacks available on the using modules [page](software/using-modules).

There are the following Grex-specific conventions on how Grex software environment is configured:

 * There is a module hierarchy. No software modules are loaded by default! 
 * There is more than one  "software" stacks. A special module "environment" needs to be loaded first to switch between them. 
 * CPU architecture (a module called __arch__ ) is often a root of a module hierarchy. Most commonly used __arch/avx512__ .
 * For the local software stack, __cuda__ module precees the arch module for GPU software.

On Grex, there are two software stacks, called __SBEnv__ and __CCEnv__, standing for the software built on Grex locally and the software environment from the Alliance (Compute Canada), correspondingly. In practice, all the above means that a required "software stack" module must be loaded first.

In the case of __CCEnv__, it must be followed by a __StdEnv__ module to pick the year/version of it. This would load a number of default modules like compilers and OpenMPI.

For __SBEnv__ , the local environment is the only module loaded by default. This enables the "Core" modules that do not depend on CPU architecture. Usually these are commercial and/or binary packages.

Then, a module that picks architecture should be loaded : either __cuda__ and __arch__ (for GPU-based software) or just __arch__ (for CPU-only software). 

> Note that the order of loading __cuda__ and __arch__ modules on SBEnv matters! __cuda__ must always be loaded first.

In case of __CCEnv__, it must be followed by loading a __StdEnv__ module to pick the year/version of it. This would load a number of default modules like compilers and OpenMPI. It still is a good practice to pick an __arch__ module correctly for __CCEnv__. 

> Note that __cuda__ modules of __CCEnv__ won't load on a non-GPU hardware. Use interactive jobs on GPU nodes to build __cuda__ enabled software!

## How to find the software with Lmod Modules
---

First, a software stack must be selected and loaded with __module load__ command.

> Lmod cannnot find modules across different software stacks!

When a software stack  module is loaded, the **module spider** command will find a specific software item (for example, GROMACS; note that all the module names are __lower-case__ on Grex and on Alliance software stacks) if it exists under that stack:

{{< highlight bash >}}
module load SBEnv
module spider gromacs
{{< /highlight >}}

It might return several versions; then usually a subsequent command with the version is used to determine dependencies required for the software. 
In case of GROMACS on Grex, at the time of writing, it returns four versions, with _gromacs/2024.1_ being the latest. Let's find its dependencies.

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
> Note that as of 2024, Anaconda owners have changed their licensing policy. We do not provide any system-wide _conda_ installations on Grex. In case users want to continue using _conda_, they must be sure that they have a proper Anaconda license to do so. Note also that the same applies for _mamba_ which would use the same conda software channels.

However, if a software is really a part of the base OS (something like a graphics Desktop software, etc.), it can be hard to rebuild from sources due to many dependencies. If needed, it may be better if installed centrally or used in a container, see Containers [documentation](software/containers).

## Internal links
---

{{< treeview />}}

## External links
---

* [Lmod](https://lmod.readthedocs.io/en/latest/ "Lmod, a new Lua Module system")
* [Tcl Modules](http://modules.sourceforge.net/ "Original Tcl Modules")
* [CMake](https://cmake.org/ "CMake")
* [Autoconf](https://www.gnu.org/software/autoconf/ "Autoconf")

---

<!-- Changes and update:
* Last reviewed on: Apr 8, 2025.
-->
