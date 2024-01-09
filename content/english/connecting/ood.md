---
weight: 1600
linkTitle: "Connect with OOD"
title: "Connect and Transfer data with OOD"
description: "Everything you need to know about connecting and transferring data with OOD."
categories: []
banner: true
bannerContent: "THe new Zebu OOD server works with the Duo MFA on Grex"
#tags: ["Configuration"]
---

## OSC OpenOnDemand on Grex
---

Grex's current OOD v.3 instance runs on **zebu.hpc.umanitoba.ca** (the earlier OOD v.2 instance on **aurochs.hpc.umanitoba.ca** is depreciated and no longer available) . It is available only from UManitoba IP addresses -- that is, your computer should be on the UM Campus network or the UM VPN to connect. 

To connect from outside the UM network, please install and start [UManitoba Virtual Private Network](https://umanitoba.ca/computing/ist/connect/virtualpn.html). OOD relies on in-browser VNC sessions; so, a modern browser with HTML5 support is required; we recommend Google Chrome or Firefox and its derivatives (Waterfox, for example).

**Connect to OOD when on campus network:**
> - Point your Web browser to [https://zebu.hpc.umanitoba.ca](https://zebu.hpc.umanitoba.ca) 
> - Use your Alliance CCDB username and password to log in to Grex OOD.
> - New: use your Alliance CCDB Duo second factor method to continue loggin in to Grex OOD.

**Connect to OOD using [UManitoba VPN](https://umanitoba.ca/computing/ist/connect/virtualpn.html):**

> - Make sure Pulse Secure VPN is connected. Use UManitoba second factor auth (as of 2024, Microsoft Entra) if asked.
> - Point your Web browser to [https://zebu.hpc.umanitoba.ca](https://zebu.hpc.umanitoba.ca) 
> - Use your Alliance CCDB username and password to log in to Grex OOD.
> - New: use your Alliance CCDB Duo second factor method to continue loggin in to Grex OOD.


### Connect via OOD
---

{{< collapsible title="OpenOndemand login page" >}}
![OpenOnDemand Login Page](/ood/loginpage.png)
{{< /collapsible >}}

When connected, you will see the following screen with the current Grex Message-of-the-day (MOTD):

{{< collapsible title="File view on OpenOndemand web portal on Grex" >}}
![OpenOnDemand Front Page](/ood/frontpage.png)
{{< /collapsible >}}

OOD expects user accounts and directories on Grex to be already created. Thus, new users who want to work with OOD should first connect to Grex normally, via SSH shell at least once, to make the creation of account, directories, and quota complete. Also, OOD creates a state directory under users' ``/home`` (__/home/$USER/ondemand__) where it keeps information about running and completed OOD jobs, shells, desktop sessions and such. Deleting the __ondemand__ directory while a job or session is running would likely cause the job or session to fail.

 - It is better to leave the __/home/$USER/ondemand__ directory alone!

### Transfer data
---

## Internal links
---

* Run applications with [OOD](ood)

## External links
---

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* 
*
*
-->
