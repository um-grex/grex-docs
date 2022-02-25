---
bookCollapseSection: true
weight: 20
title: Connecting / Transferring data
---

# Connecting to Grex

In order to use almost any HPC system, you would need to be able to somehow connect and log in to it. ALso, it would be necessary to be able to transfer data to and from the system. The standard means for these tasks are provided by the [SSH protocol](https://en.wikipedia.org/wiki/Secure_Shell "Secure Shell").

To log in to Grex in the text mode, connect to **grex.westgrid.ca** using an [**SSH**](./ssh/) (secure shell) client. The DNS name grex.westgrid.ca serves as an alias for two login nodes: **bison.westgrid.ca** and **tatanka.westgrid.ca** .

Uploading and downloading your data can be done using an **SCP/SFTP** capable file transfer client. The recommended clients are OpenSSH (providing **ssh** and **scp**, **sftp** command line tools on Linux and MacOS X) and PuTTY/WinSCP/X-Ming or MobaXterm under Windows. Note that since Jun 1, 2014, the original "SSH Secure Shell" Windows SSH/SFTP client is not supported anymore.

Since Dec. 2015, support is provided for the graphical mode connection to Grex using [**X2go**](./x2go/).

[X2go](https://wiki.x2go.org/doku.php/download:start "X2go") remote desktop clients are available for Windows, MacOS X and Windows. When creting a new session, please chose either of the supported desktop environments: **"OPENBOX"** or **"ICEWM"** in the "Session type" menu. The same  login/password should be used as for SSH text based connections. 

**New login node:**  
{{< hint info >}}
Since early 2021, a new login node, **yak.westgrid.ca** is available to access and build software that uses new Intel AVX2, AVX512 CPU instructions. **Yak** is not part of the **grex.westgrid.ca** alias. 
{{< /hint >}}

**OpenOnDemand (OOD) Web interface:**
{{< hint info >}}
Since October 2021, there is an OpenOnDemand (OOD) Web interface to Grex, available at [https://aurochs.westgrid.ca](https://aurochs.westgrid.ca "OpenOnDemand OOD Web interface on Grex") from UManitoba IP addresses. OOD provides a way to connect both in text and graphical mode right in the browser, to transfer data between Grex local machines, and to run jobs.
{{< /hint >}}

See the documentation for more details on how to connect from various client operaton systems:

- [Connecting to Grex with SSH](./ssh/)
- [Connecting to Grex with X2Go](./x2go/)
- [Connecting to Grex with OOD](./ood/)

<!--
-->
