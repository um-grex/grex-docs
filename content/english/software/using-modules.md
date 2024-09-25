---
weight: 1200
linkTitle: "Using modules"
title: "Modules and software stacks"
description: "Everything you need to know about using modules on Grex."
categories: ["Software", "Applications"]
banner: true
bannerContent: "__Work in progress.__"
#tags: ["Configuration"]
---

## Introduction
---

<!--
{{< collapsible title="Modules allow for clean and dynamic modification of the user's Linux session environment" >}}
{{< /collapsible >}}
-->

On a Linux server or a Linux desktop, software can be installed in one of the standard locations, such as _/usr/bin_. This is where most of the system-level software binaries can be found. For custom user-built software it is a good practice to install it separately from the standard location, to avoid potential conflicts and make changes and uninstallation possible. One of the common locations would be under _/usr/local/_, as in _/usr/local/My_Custom_software/_ , or under _/opt_ (_/opt/My_Other_custom_software_).

> There is a Linux/UNIX [Filesystem Hierarchy Standard](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard) (FHS) that describes the conventions on where the files are.

The Linux operating system "finds" the software executable (binaries and/or scripts) using a special environment variable called **PATH**. By default, the variable has all the standard locations like _/usr/bin_ already. Custom software installed under other locations usually requires modifying the PATH variable to include these specific locations. Other variables might be required for a software to work, **LD_LIBRARY_PATH** for example, shows where to look for dynamic or static libraries. For the source code libraries variables, like **CPATH** and **CXXFLAGS** would tell where to find so-called header files and modules.

While it is possible for a Linux user to edit the PATH and related environment variables in their login script or application scripts by hand, it is an error-prone process. A typo in **PATH** may render the whole system binaries inaccessible, for example.
Another problem is the maintenance of multiple versions of the same package, as these would have the same names for binaries and no good result would happen if more than one version is in the same **PATH**.

To solve the problem, a tool called "Modules" was developed in the HPC ecosystem.

> * Modules allow for clean and dynamic modification of the user's environment (environment variables like **PATH**, **LD_LIBRARY_PATH**, **CPATH**, and almost anything else) in a Linux user session. Modules can be "loaded" and "unloaded", modifying the environment in a clean and atomic way.
> * Modules can also be used to find available software and to control software dependencies in a hierarchical way.
> * Modules on HPC machines are usually provided system-wide for all users; but individual users can create their own, private modules to be used along with the system software stacks.

There are two main implementations of Modules: the original TCL Modules and the hierarchical Lmod Modules developed at TACC. Grex and the Alliance systems are using Lmod.
That is, modules are files written in a special syntax in either TCL or Lua languages. There is a command, _module_, that works on the module files.

## Using Modules on HPC machines

First check if the __module__ command exists and works.

{{< highlight bash >}}
# This command should work:
module help
{{< /highlight >}}

Many HPC systems load some modules automatically, by default. To list the modules that are loaded, use:

{{< highlight bash >}}
# This command might return some modules, 
# or return nothing if there is no default modules
module list
{{< /highlight >}}

All modules can be unloaded with the __purge__ commmand, except the modules that are "sticky" and would refuse to unload, unless you add the option _-/-force__.

{{< highlight bash >}}
module purge
{{< /highlight >}}

The most useful command for which Modules exist is _load_. The command loads module into the current environment. The _unload_ commands does the opposite action.

{{< highlight bash >}}
# Lets have a clean envronment:
module purge
# We want minimap2 for our Genomics work, is it in the PATH?
which minimap2
# Nothing, lets load the module:
module load minimap2
module list
# Now there should be a working minimap2 executable in the PATH:
which minimap2
minimap2 --help
# If we unload the module, we should have no minimap2 in our environment:
module unload minimap2
which minimap2
# Nothing.
{{< /highlight >}}

How do we know there is a _minimap2_ module, and it is the software/version we need?

There is a command _module avail_ that shows modules currently available to load, and commands _module whatis_ and _module help_ to (hopefully) provide a useful description of a given module file.

{{< highlight bash >}}
module list
module help minimap2
module avail
{{< /highlight >}}

### Finding software using modules: Hierarchies

On most HPC systems, using Lmod command _module avail_ is less useful because of the existence of a _module hierarchy_. Lmod enforces a hierarchy of modules based on module dependencies. A typical dependency for a code is a compiler suite/version and an MPI implementation used to compile or build the program.

To avoid software conflicts, it is necessary that the same compiler/version (runtime, dynamic libraries) the code is built with, is loaded at the time of the execution of the code. Module hierarchies hide the software modules for which the dependencies are not yet loaded. Some of the modules make the "Core" level of the hierarchy and they do not require  dependencies.

One of the kinds of modules which are usually at "Core" level are, naturally, compilers and compiler toolchains. Another kind may be "CPU architecture".

To find the modules in a hierarchy of modules, the _module spider_ command is provided. Usually, it takes two invocations of _module spider_, first only with a software name to find available versions, and then with software name/version to find the required dependencies.

{{< highlight bash >}}
# Lets find a module for NWchem:
module avail nwchem
# Nothing, now run module spider:
module spider nwchem
# Returns a number of versions, including 7.2.2
module spider nwchem/7.2.2
# Knowing the dependencies, we can load them
module load arch/avx512 intel-one/2024.1 openmpi/4.1.6
# Now that dependencies are loaded, the module for NWchem is visible
module avail nwchem
module whatis nwchem
module load nwchem/7.2.2
# can start using nwchem on an input file, let it be siosi8.nw
which nwchem
mpiexec -np 4 nwchem siosi8.nw
{{< /highlight >}}

### Switching between the Software stacks

On some HPC systems, there exists more than one Software stack, and the stacks would form separate module hierarchies.

Often it is used by systems that have a local and an external software stack. An example of the external software stack is the Alliance/ComputeCanada software stack (CCEnv).
On Grex, there are two main software stacks: __SBEnv__ (the default) and __CCEnv__ (the optional Alliance software stack). On the Niagara Large Parallel system at the University of Toronto, there exists __CCENv__ and a local __NiaEnv__ stack.

The command __module spider__ would find software only within the software stack. The stack itself is a _module_, and it sits above any __Core__ level in the hierarchy. It is necessary first to purge all the loaded modules and load the software stack, or environment. The stack modules (SBEnv, CCEnv) are sticky and cannot be purged. They are mutually exclusive (i.e., two stacks cannot be loaded at the same time).

{{< highlight bash >}}
module purge
module list
# By default the above on Grex shows SBEnv:
module help CCEnv
module help SBEnv
# Lets switch to CCEnv, the ComputeCanada software stack:
module load CCEnv
# we can proceed load "standard environments"; 
# on Grex it is best to use the latest one. Note the avx512 architecture.
module load arch/avx512 StdEnv/2023
# Is there an NWchem module?
module spider nwchem
# etc.
{{< /highlight >}}

At this point, equipped with _module spider_ and the knowledge of the available software stacks, the reader should be well equipped to find any centrally available software on a given HPC system.

In some cases, it may help to get more information about a given module, like the path to the installation directory and the location of the libraries and headers. If that's the case. the command _module show_ could be used. In the following example, we load _boost_ and show the variavles that points to the installation directory:

{{< highlight bash >}}
module load arch/avx512  gcc/13.2.0 boost/1.85.0
module show boost/1.85.0
----------------------------------------------------------------------------------------------------------------------------------------
   /global/software/alma8/sb/modules/arch-avx512-gcc-13.2.0/boost/1.85.0:
----------------------------------------------------------------------------------------------------------------------------------------
prepend_path("CMAKE_PREFIX_PATH","/global/software/alma8/sb/opt/arch-avx512-gcc-13.2.0/boost/1.85.0")
prepend_path("CPATH","/global/software/alma8/sb/opt/arch-avx512-gcc-13.2.0/boost/1.85.0/include")
prepend_path("LIBRARY_PATH","/global/software/alma8/sb/opt/arch-avx512-gcc-13.2.0/boost/1.85.0/lib")
prepend_path("LD_LIBRARY_PATH","/global/software/alma8/sb/opt/arch-avx512-gcc-13.2.0/boost/1.85.0/lib")
setenv("MODULE_BOOST_PREFIX","/global/software/alma8/sb/opt/arch-avx512-gcc-13.2.0/boost/1.85.0")
whatis("Description: Boost provides free peer-reviewed portable C++ source libraries, emphasizing libraries that work well with the C++ Standard Library")
whatis("Homepage: http://www.boost.org")
setenv("BOOST_ROOT","/global/software/alma8/sb/opt/arch-avx512-gcc-13.2.0/boost/1.85.0")
help([[
Boost provides free peer-reviewed portable C++ source libraries,
emphasizing libraries that work well with the C++ Standard Library.
Boost libraries are intended to be widely useful, and usable across a
broad spectrum of applications. The Boost license encourages both
commercial and non-commercial use.

Homepage: http://www.boost.org
]])
{{< /highlight >}}

From the above example, the variables _BOOST_ROOT_ and _MODULE_BOOST_PREFIX_ points to the installation directory. If needed to add the path to your Makefile (for example when compiling another program), this variable can be used. The variables could be used to add the location to the libraries, _$MODULE_BOOST_PREFIX/lib_, or headers, _$MODULE_BOOST_PREFIX/include_, ... etc. Note that the names of the variables may change from one cluster to another depending on the package manaer used to build the modules. Under the default standard environment on Grex, _SBEnv_, the name of the variable for each program is in the form, _MODULE_NAMEOFTHEPROGRAM_PREFIX_ while it is in the form of _EBROOT_ followed by _NAMEOFTHEPROGRAM_ when using __CCEnv__. It is recommended to use _module show_ to figure out what variables are used when using a given software stack on any cluster.

__As a summary, here are the most used commands when using modules:__

* __module list__: to list the modules that are loaded.
* __module avail__: to list the modules that currently available to load.
* __module spider <name of the program>__: to see how to load a given module.
* __module load <module names/versions ...>__: to load a given set of modules ....
* __module show <name of the program>__: to print more information about the module.
* __module purge__: to purge or unload all the modules loaded previously.

<!--
| Command                                   | Description  |
| :-----------:                             | :--------------: |
| __module list__                           | to list the modules that are loaded. |
| __module avail__                          | to list the modules that currently available to load. | 
| __module spider <name of the program>__   | to see how to load a given module. |
| __module load <module names/versions>__   | to load a given set of modules .... | 
| __module show <name of the program>__     | to print more information about the module. |
| __module purge__                          | to purge or unload all the modules loaded previously. |
-->

## External links
---

* What is PATH? [How to view and modify it](https://www.digitalocean.com/community/tutorials/how-to-view-and-update-the-linux-path-environment-variable)
* The Alliance documentation about [using Modules](https://docs.alliancecan.ca/wiki/Utiliser_des_modules/en)
* [Lmod User Guide](https://lmod.readthedocs.io/en/latest/010_user.html)
* Traditional/Origibal [TCL Modules](https://modules.readthedocs.io/en/v4.1.3/index.html) 

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* Last reviewed on: Apr 30, 2024.
-->
