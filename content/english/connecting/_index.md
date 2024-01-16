---
weight: 4000
linkTitle: "Connect / Transfer data"
title: "Connecting to Grex and Transferring data"
description: "All you need to know to start using Grex: connect an transfer data."
titleIcon: "fa-solid fa-house-chimney"
categories: ["How-To", "Information"]
#tags: ["Content management"]
---

## Connecting to Grex
---

In order to use almost any HPC system, you would need to be able to somehow connect and log in to it. Also, it would be necessary to be able to transfer data to and from the system. The standard means for these tasks are provided by the [SSH protocol](https://en.wikipedia.org/wiki/Secure_Shell "Secure Shell"). The following hosts (login nodes) are avilable: 
 * yak.hpc.umanitoba.ca
 * grex.hpc.umanitoba.ca
 * bison.hpc.umanitoba.ca
 * tatanka.hpc.umanitoba.ca

To log in to Grex in the text (or bash) mode, connect to one of the above hosts using an [**SSH**](./ssh/) (Secure SHELL) client. 

The DNS name **grex.hpc.umanitoba.ca** serves as an alias for two login nodes: **bison.hpc.umanitoba.ca** and **tatanka.hpc.umanitoba.ca** . These two login nodes are the original login nodes, and can be used for accessing the system as well as building software that has to run on older compute nodes (Intel SSE4.2 instructions or earlier).

{{< highlight bash >}}
ssh someuser@grex.hpc.umanitoba.ca
{{< /highlight >}}

Since early 2021, a new login node, **yak.hpc.umanitoba.ca** is available to access and build software that uses new Intel AVX2, AVX512 CPU instructions. **Yak** is not part of the **grex.hpc.umanitoba.ca** alias, so users would want to specify this host directly. As of 2024, majority of users would likely use **Yak**.

{{< highlight bash >}}
ssh someuser@yak.hpc.umanitoba.ca
{{< /highlight >}}

{{< alert type="warning" >}}
Please remember to replace __someuser__ with your Alliance user name.
{{< /alert >}}

## Transferring Data
---

Uploading and downloading your data can be done using an **SCP/SFTP** capable file transfer client. The recommended clients are OpenSSH (providing **ssh** and **scp**, **sftp** command line tools on Linux and Mac OS X) and PuTTY/WinSCP/X-Ming or MobaXterm under Windows. Note that since June 1, 2014, the original "SSH Secure Shell" Windows SSH/SFTP client is not supported anymore.

## X2Go
---

Since Dec. 2015, support has been provided for the graphical mode connection to Grex using [**X2Go**](connecting/x2go).

[X2Go](https://wiki.x2go.org/doku.php/download:start "X2Go") remote desktop clients are available for Windows, Mac OS X and Windows. When creating a new session, please choose either of the supported desktop environments: **"OPENBOX"** or **"ICEWM"** in the "Session type" menu. The same  login/password should be used as for SSH text based connections. 

## OpenOnDemand (OOD) Web Interface
---

Since October 2021, there is an OpenOnDemand (OOD) Web interface to Grex, currently available at [https://zebu.hpc.umanitoba.ca](https://zebu.hpc.umanitoba.ca "OpenOnDemand OOD Web interface on Grex") from UManitoba IP addresses. OOD provides a way to connect both in text and graphical mode right in the browser, to transfer data between Grex local machines, and to run jobs.

See the documentation for more details on how to connect from various clients of operating systems: [SSH](connecting/ssh), [X2Go](connecting/x2go), [OOD](connecting/ood).

## Internal links
---

{{< treeview />}}

---

<!-- Changes and update:
* 
*
*
-->
