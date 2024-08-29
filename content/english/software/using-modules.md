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

On a Linux server or a Linux desktop, software can be installed in one of the standard locations, such as _/usr/bin_. This is where most of the system-level software binaries can be found. For custom user-built software it is a good practice to install it separately from the standard location, to avoid potential conflicts and make changes and uninstallation possible. One of the common locations would be under _/usr/local/_, as in _/usr/local/My_Custom_software/_ , or under _/opt_ (_/opt/My_Other_custom_software_).

There is a Linux/UNIX [Filesystem Hierarchy Standard](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard) (FHS) that describes the conventions on where the files are.

The Linux operation system "finds" the software executable (binaries or scripts) using a special environment variable called **PATH**. By default, the variable has all the standard locations like _/usr/bin_ already. Custom software installed under other locations usually requires modifying the PATH variable to include these specific locations. Other variables might be required for a software to work, **LD_LIBRARY_PATH** for example, shows the system where to look for dynamic libraries. For the source code libraries variables like **CPATH** and **CXXFLAGS** would tell where to find so-called header files and modules.

While it is possible for a Linux user to edit the PATH and related environment variables in their login script or application scripts by hand, it is an error-prone process. A typo in **PATH** may render the whole system binaries inaccessible, for example.
Another problem is the maintenance of multiple versions of the same package, as these would have the same names for binaries and no good result would happen if more than one version is in the same **PATH**.

To solve the problem, a tool called "Modules" was developed in the HPC ecosystem.

> * Modules allow for clean and dynamic modification of the user's environment (environment variables like **PATH**, **LD_LIBRARY_PATH**, **CPATH**, and almost anything else) in a Linux user session. Modules can be "loaded" and "unloaded", modifying the environment in a clean and atomic way.
> * Modules can also be used to find available software and to control software dependencies in a hierarchical way.
> * Modules on HPC machines are usually provided system-wide for all users; but individual users can create their own, private modules to be used along with the system software stacks.

There are two main implementations of Modules: the original TCL Modules and the hierarchical Lmod Modules developed at TACC. Grex and the Alliance systems are using Lmod.

## Using Modules

> This section is a work in progress.

### Loading and unloading the modules

### Finding software using modules

### Switching between the Software stacks

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
