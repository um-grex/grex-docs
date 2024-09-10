---
weight: 7000
linkTitle: "OpenOnDemand"
title: "OpenOnDemand, HPC Portal"
description: "All you need to know to start using OpenOnDemand Portal on Grex."
titleIcon: "fa-solid fa-house-chimney"
categories: ["Software", "Interfaces"]
#tags: ["Content management"]
---

## Introduction
---

[OpenOnDemand](https://openondemand.org/ "OpenOnDemand") or __OOD__ for short, is an open source Web portal for High-Performance computing, developed at Ohio Supercomputing Center. OOD makes it easier for beginner HPC users to access the resources via a Web interface. OOD also allows for interactive, visualization and other Linux Desktop applications to be accessed on HPC systems via a convenient Web user interface.

Since the end of __October 2021__, OpenOnDemand version 2 is officially in production  on Grex. 

For more general OOD information, see the OpenOnDemand [paper](https://joss.theoj.org/papers/10.21105/joss.00622 "OpenOnDemand Paper")

## OpenOndemand on Grex 
---

{{< alert type="warning" >}}
**NOTE: aurochs.hpc.umanitoba.ca has been decommissioned since 29/11/2023. Please use zebu.hpc.umanitoba.ca to access the OpenOnDemand portal.**
{{< /alert >}}

Grex's OOD instance runs on **zebu.hpc.umanitoba.ca** and requires MFA. It is available only from UManitoba IP addresses -- that is, your computer should be on the UM Campus network to connect. 

To connect from outside the UM network, please install and start __UManitoba Virtual Private Network__ [VPN](https://umanitoba.ca/computing/ist/connect/virtualpn.html). OOD relies on in-browser VNC sessions; so, a modern browser with HTML5 support is required; we recommend Google Chrome or Firefox and its derivatives (Firefox, for example).

**Connect to OOD using UManitoba [VPN](https://umanitoba.ca/computing/ist/connect/virtualpn.html):**

> - Make sure Pulse Secure VPN is connected
> - Point your Web browser to [https://zebu.hpc.umanitoba.ca](https://zebu.hpc.umanitoba.ca) 
> - Use your Alliance (Compute Canada) username and password to log in to Grex OOD.

---

{{< collapsible title="OpenOndemand login page" >}}
![OpenOnDemand login page](/ood/loginpage.png)
{{< /collapsible >}}

Once connected, you will see the following screen with the current Grex Message-of-the-day (MOTD):

{{< collapsible title="File view on OpenOndemand web portal on Grex" >}}
![OpenOnDemand Front Page](/ood/frontpage.png)
{{< /collapsible >}}

OOD expects user accounts and directories on Grex to be already created. Thus, new users who want to work with OOD should first connect to Grex normally, via [SSH](connecting/ssh) shell at least once, to make the creation of account, directories, and quota complete. Also, OOD creates a state directory under users' ``/home`` (__/home/$USER/ondemand__) where it keeps information about running and completed OOD jobs, shells, desktop sessions and such. Deleting the __ondemand__ directory while a job or session is running would likely cause the job or session to fail.

{{< alert type="warning" >}}
It is better to leave the __/home/$USER/ondemand__ directory alone!
{{< /alert >}}

## Working with files and directories
---

One of the convenient and useful features of OOD is its Files app that allows you to browse the files and directories
across all Grex filesystems: __/home__, __/global/scratch__ and __/project__. 

{{< collapsible title="File view on OpenOndemand web portal on Grex" >}}
![](/ood/files.png)
{{< /collapsible >}}

You can also upload your data to Grex using this Web interface. Note that there are limits on uploads on the Web server (a few GBs) and there can be practical limits on download sizes as well due to internet connection speed and stability.

## Customized OOD apps on Grex
---

The OOD Dashboard menu, __Interactive Apps__, shows interactive applications. This is the main feature of OOD, it allows interactive work and visualizations, all in the browser. These applications will run as SLURM Jobs on Grex compute nodes. Users can specify required SLURM resources such as time, number of cores and partitions.

{{< collapsible title="OpenOndemand applications on Grex" >}}
![](/ood/applications.png)
{{< /collapsible >}}

As for now, the following applications are supported:

> - Linux Desktops in VNC
> - Matlab GUI in VNC
> - GaussView GUI in VNC
> - Jupyter Notebooks servers

As with regular SLURM jobs, it is important to specify SLURM partitions for them to start faster. Perhaps the __test__ partition for Desktop is the best place to start interactive Desktop jobs, so it is hardcoded in the Simplified Desktop item.

The following links are added to OOD:

> - From the menu __Jobs__, there is a link __Grex SLURM Queues State__ that shows a summary of running and pending jobs. It runs a modified version of the script **grex-summarize-queue** that is accessible from any login node.

> - From the menu __Clusters__, there is a link __Grex SLURM Node State__ to get a summary of allocated and idle nodes by partition. The same information can be accessed from any login node by running a custom script:__slurm-nodes-state__
 
---

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:

* Last reviewed on: Apr 29, 2024. 
-->
