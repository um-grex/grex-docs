---
weight: 7500
linkTitle: "Grex changes"
title: "Grex changes / software and hardware updates"
description: "List of major changes on Grex: software and hardware updates."
titleIcon: "fa-solid fa-house-chimney"
banner: true
bannerContent: "**Upcoming external network changes**"
#categories: ["Functionalities"]
#tags: ["Content management"]
---

---

<!--
This page is dedicated to the cluster updates: software, hardware, storage, ... etc.
-->

## Upcoming changes to Grex external network
---

> As you may know, for the last 12 years, Grex has been using Westgrid’s network (IPs and DNS names in .westgrid.ca, like grex.westgrid.ca, aurochs.westgrid.ca).

> This network is now being decommissioned, and we are migrating Grex’s external connection to UManitoba campus network. Grex’s new domain name will be __.hpc.umanitoba.ca__ . Grex continues to use the same CCDB user account credentials as before (that is, your Alliance or Compute Canada login/password).

> To minimize the impact on the users, migration will be rolling: we will first migrate some of the login nodes, then the rest of them. As of today, one new login node is available and uses the new UManitoba connection: __yak.hpc.umabitoba.ca__ . The yak login node should be available from both outside UManitoba campus and from the VPN. We would like you to test it by connecting to Grex using: 

{{< highlight bash >}}
ssh your-user-name@yak.hpc.umanitoba.ca 
{{< /highlight >}}

(Replace _your-user-name_ with your Alliance (Compute Canada) user name)

{{< alert type="warning" >}}
Please note that **yak** has **avx512** CPU architecture and if you have to use it for compiling your codes, they may not run on the "compute" partition that has older CPUs. Other than that, it should behave as any other old login node. The other nodes (tatanka, bison, aurochs, and the alias grex) will be migrated later this summer. 
{{< /alert >}}


## Internal links
---

{{< treeview />}}

---

<!-- Changes and update:
* 
*
*
-->
