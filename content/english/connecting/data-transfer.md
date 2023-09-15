---
weight: 1800
linkTitle: "Data transfer"
title: "Transferring data"
description: "Everything you need to know about transferring data."
banner: true
bannerContent: "GUI clients may need to be updated to the latest versions to work with the Duo MFA on Grex"
#categories: []
#tags: ["Configuration"]
---

## Introduction
---

## Globus Online file transfer
---

Unfortunately, the WestGrid Globus endpoint on Grex had expired. It is not possible to use Globus on Grex as of the time of writing this documentation. However, you can still use Globus to transfer data between the Allaince's (Compute Canada) systems as described [here](https://docs.alliancecan.ca/wiki/Globus "Globus on Compute Canada clusters"). 

Check the [ESNet](https://fasterdata.es.net/ "ESNet") website if you are curious about Globus, and why large data transfers over WAN might need specialized networks and software setups.

## OpenSSH tools: scp, sftp
---

### SFTP
---

On Mac OS and Linux, where OpenSSH client packages are always available, the following command line tools are present: __scp__, __sftp__. They work similar to UNIX __cp__ and __ftp__ commands, except that there is a remote target or source. 

SFTP opens a session and then drops the user to a command line, which provides commands like __ls__, __lls__, __get__, __put__, __cd__, __lcd__ to navigate the local and remote directories, upload and download files etc.

{{< highlight bash >}}
sftp someuser@grex.hpc.umanitoba.ca
sftp> lls
sftp> put  myfile.fchk
{{< /highlight >}}

Please replace __someuser__ with your username.

### SCP
---

SCP behaves like __cp__. To copy a file __myfile.fchk__ to Grex, from the current directory, into his __/global/scratch/__, a user would run the following command:

{{< highlight bash >}}
scp ./myfile.fchk someuser@grex.hpc.umanitoba.ca:/global/scratch/someuser
{{< /highlight >}}

Note that the destination is remote (for it has the form of user@host:/path). More information about file transfer tools exist on [Compute Canada documentation](https://docs.alliancecan.ca/wiki/Transferring_data#SCP "SCP")

### LFTP tool
---

[LFTP](http://lftp.yar.ru/) is a multi-protocol file transfer code for Linux, that supports some of the advanced features of Globus, enabling better bandwidth utilization through socket tuning and using multiple streams. On Grex (and between Grex and Compute Canada systems) only SFTP (that is, __sftp://__ URIs) is supported! So, the minimal syntax for opening a transfer session from Grex to Cedar would be (on Grex):

{{< highlight bash >}}
lftp sftp://someuser@cedar.computecanada.ca
{{< /highlight >}}

It has a command line interface not unlike the __ftp__ or __sftp__ command line tools, with __ls__, __get__, and __put__ commands.

### RSYNC
---

## File transfer clients with GUI
---

There are many file transfer clients that provide convenient graphical user interface.

Some examples of the popular file transfer clients are

* [WinSCP](https://winscp.net/eng/index.php "WinSCP") for Windows.
* [MobaXterm](https://mobaxterm.mobatek.net/ "MobaXterm") for Windows has an SFTP app.
* Cross platform [FileZilla Client](https://filezilla-project.org "FileZilla Client")

Other GUI clients will work with Grex too, as long as they provide SFTP protocol support.

To use such clients, one would need to tell them that SFTP is needed, and to provide the address, which is **grex.hpc.umanitoba.ca** and your Grex/Alliance username.

Note that we advise against saving your password in the clients: first, it is less secure, and second, it is easy to store a wrong password. File transfer clients would try to auto-connect automatically, and having a wrong password stored with them will create many failed connection attempts from your client machine, which in turn might temporarily block your IP address from accessing Grex.

## File transfers with OOD browser GUI
---

**NEW:** It is now possible to use [OpenOnDemand on aurochs](https://aurochs.hpc.umanitoba.ca "OpenOnDemand on Grex") Web interface to download and upload data to and from Grex. Use __Files__ dashboard menu to select a filesystem (currently __/home/$USER__ and __/global/scratch/$USER__ are available), and then Upload and Download buttons.

There is a limit of about 10GB to the file transfer sizes with OOD. The OOD interface is, as of now, open for UManitoba IP addresses only (i.e., machines from campus and on UM PulseVPN will work). 

More information is available on our [OOD pages](/jobs)

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* 
*
*
-->
