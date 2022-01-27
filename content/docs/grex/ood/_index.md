---
bookCollapseSection: true
title: Grex's OpenOnDemand Web Portal
weight: 52
---

# Introduction

[OpenOnDemand](https://openondemand.org/), or OOD for short, is an open source Web portal for High-Performance computing, developed at Ohio Supercomputing Center.
OOD makes it easier for beginner HPC user to access the resources via a Web interface. OOD also allows for interactive, visualization and other linux Desktop applications to be accessed on HPC systems via a convenient Web user interface.
Since end of October 2021, OnDemand version 2 is officially in production  on Grex. 

For more general OOD information, see the [OpenOnDemand Paper](https://joss.theoj.org/papers/10.21105/joss.00622)

## OpenOndemand on Grex 

Grex's OOD instance runs on [aurochs.westgrid.ca](https://aurochs.westgrid.ca) .
It is available only from UManitoba IP addresses -- that is, your computer should be on UM Campus network to connect.
To connect from outside network, please use install and start [UManitoba Virtual Private Network](https://umanitoba.ca/computing/ist/connect/virtualpn.html).

OOD relies on in-browser VNC sessions; so a modern browser with HTML5 support is required; we recommend Google Chrome or Firefox and its derivatives (Waterfox, for example).

OOD expects user accounts and directories on Grex to be already created. Thus, new users that want to work with OOD must first connect to Grex normally, via SSH shell at least once, to make the creation of account, directories, and quota complete.

OOD creates a state directory under users' ``/home`` (``/home/$USER/ondemand``) where it keeps information about running and completed OOD jobs, shells, desktop sessions and such. Deleting the ``ondemand`` directory while a job or session is running would likely cause the job or session to fail.

## Working with files

TODO

## Standard OOD apps: Shell, Jobs, Desktops 

TODO

## Customized OOD apps on Grex

 - Matlab GUI in VNC
 
 - GaussView GUI in VNC
 
 - Jupyter Noteboooks server
 
 - ShinyR App server
 
 - more to come! 
 
 