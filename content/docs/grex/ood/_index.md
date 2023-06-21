---
bookCollapseSection: true
title: Grex's OpenOnDemand Web Portal
weight: 52
---

# Introduction

[OpenOnDemand](https://openondemand.org/ "OpenOnDemand") or __OOD__ for short, is an open source Web portal for High-Performance computing, developed at Ohio Supercomputing Center. OOD makes it easier for beginner HPC user to access the resources via a Web interface. OOD also allows for interactive, visualization and other linux Desktop applications to be accessed on HPC systems via a convenient Web user interface.

{{< hint info >}}
Since end of __October 2021__, OnDemand version 2 is officially in production  on Grex. 
{{< /hint >}}

For more general OOD information, see the [OpenOnDemand Paper](https://joss.theoj.org/papers/10.21105/joss.00622 "OpenOnDemand Paper")

## OpenOndemand on Grex 

Grex's OOD instance runs on **aurochs.hpc.umanitoba.ca** . It is available only from UManitoba IP addresses -- that is, your computer should be on UM Campus network to connect. 

To connect from outside UM network, please install and start [UManitoba Virtual Private Network](https://umanitoba.ca/computing/ist/connect/virtualpn.html). OOD relies on in-browser VNC sessions; so a modern browser with HTML5 support is required; we recommend Google Chrome or Firefox and its derivatives (Waterfox, for example).

**Connect to OOD using [UManitoba VPN](https://umanitoba.ca/computing/ist/connect/virtualpn.html):**
{{< hint info >}}
 - Make sure Pulse Secure VPN is connected
 - Point your Web browser to [https://aurochs.hpc.umanitoba.ca](https://aurochs.hpc.umanitoba.ca) 
 - Use your Compute Canada username and password to log in to Grex OOD.
{{< /hint >}}

<!-- 
When connected, you will see the following screen with the current Grex Message-of-the-day (MOTD):
![](ood-frontpage.jpg)
-->

OOD expects user accounts and directories on Grex to be already created. Thus, new users who want to work with OOD should first connect to Grex normally, via SSH shell at least once, to make the creation of account, directories, and quota complete. Also, OOD creates a state directory under users' ``/home`` (__/home/$USER/ondemand__) where it keeps information about running and completed OOD jobs, shells, desktop sessions and such. Deleting the __ondemand__ directory while a job or session is running would likely cause the job or session to fail.

{{< hint warning >}}
 - It is better to leave the __/home/$USER/ondemand__ directory alone!
{{< /hint >}}

## Working with files and directories

One of the convenient and useful features of OOD is its Files app that allows you to browse the files and directories
across all Grex filesystems: __/home__ and __/global/scratch__. 

<!--
![](ood-files.png)
-->

You can also upload your data to Grex using this Web interface. Note that there are limits on uploads on the Web server (a few GBs) and there can be practical limits on download sizes as well due to internet connection speed and stability.

## Customized OOD apps on Grex

The OOD Dashboard menues __Interactive Apps__ shows interactive applications. This is the main feature of OOD, it allows interactive work and visualizations, all in browser. These application will run on as SLURM Jobs on Grex compute nodes. Users can specify required SLURM resources such as time, number of cores and partitions.

<!--
![](ood-applications.jpg)
-->

As for now, the following applications are supported:

{{< hint info >}}
 - Linux Desktops in VNC
 - Matlab GUI in VNC
 - GaussView GUI in VNC
 - Jupyter Noteboooks servers
{{< /hint >}}

As with regular SLURM jobs, it is important to specify SLURM partitions for them to start faster. Perhaps the __test__ partition for Desktop is the best place to start interactive Desktop jobs, so it is hardcoded in the Simplified Desktop item.
 
<!--
-->
