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

## OpenSSH tools: SCP, SFTP
---

The OpenSSH package, available on Linux, MacOS and recent versions of Windows, provides not only the command line SSH client, but two command line file transfer tools: SFTP and SCP.
Thus, on almost any system that allows for SSH connection, data transfers can be performed using these tools.
OpenSSH encrypts all the traffic and provides several authentication options. A useful option for SCP and SFTP is to have a key pair, with the public key deposited in CCDB.

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

SCP behaves like __cp__. It needs a "source" and a "destination" specified. Either of these can be local or remote. The remote destination has the format of __user@host:/path__ .

To copy a file __myfile.fchk__ to Grex, from the current directory into his home directory, a user would run the following command:

{{< highlight bash >}}
scp ./myfile.fchk someuser@grex.hpc.umanitoba.ca:/home/someuser
{{< /highlight >}}

The same example but using a key pair, assuming the corresponding public key is deposited in CCDB:

{{< highlight bash >}}
scp -i a-private-key.key ./myfile.fchk someuser@grex.hpc.umanitoba.ca:/home/someuser
{{< /highlight >}}

The Home filesystem is limited in space and performance. For larger files, it might make sense to use SCP for the Project filesystem instead.
A convenience symbolic link under /home/someuser/projects points to the Project filesystem.

{{< highlight bash >}}
scp ./myfile_bigdata.csv  someuser@grex.hpc.umanitoba.ca:/home/someuser/projects/def-somegroup/someuser/
{{< /highlight >}}



More information about OpenSSH file transfer tools exist on [OpenSSH SSP manpage](https://man.openbsd.org/scp). [The Alliance/ComputeCanada documentation](https://docs.alliancecan.ca/wiki/Transferring_data#SCP "SCP") has a detailed Wiki entry on SCP.

### File transfer SCP/SFTP clients with GUI
---

There are many file transfer clients that provide convenient graphical user interface (GUI) while using and implementation of SCP or SFTP under the hood.

Some examples of the popular file transfer clients are

* [WinSCP](https://winscp.net/eng/index.php "WinSCP") for Windows.
* [MobaXterm](https://mobaxterm.mobatek.net/ "MobaXterm") for Windows has an SFTP app. 
* Cross platform [FileZilla Client](https://filezilla-project.org "FileZilla Client")
* [CyberDuck](https://cyberduck.io/) for MacOS X

Other GUI clients will work with Grex too, as long as they provide SFTP protocol support.

To use such clients, one would need to tell them that SFTP is needed, and to provide the address, which is a name of a Grex login node (**yak.hpc.umanitoba.ca** or **grex.hpc.umanitoba.ca**) and your Grex/Alliance username.

Note that we advise against saving your password in the clients: first, it is less secure, and second, it is easy to store a wrong password. File transfer clients would try to auto-connect automatically, and having a wrong password stored with them will create many failed connection attempts from your client machine, which in turn might temporarily block your IP address from accessing Grex.

Note that for GUI clients, care should be taken for support of  [MultiFactor Authentication](/connecting/mfa/). MFA is enforced on both Grex and The Alliance HPC systems.

## RSYNC over SSH
---

[__rsync__](https://linux.die.net/man/1/rsync) is a versatile local and remote copying tool. Because rsync would "synchronize" the source and destination, it allows for resuming interrupted data transfers without excessive data retransmissions. __rsync__ would equally well synchronize single files and entire directory trees.

For uploading and downloading files from HPC machines that allow only SSH access, __rsync__ does support encapsulation of the data stream in an SSH channel. 

An example of __rsync__ over SSH is provided below:

{{< highlight bash >}}
rsync  -aAHSv -x --delete -e "ssh -i a-private-key.key -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null " /home/$LOCAL_USER/somedir/  $REMOTE_USER@grex.hpc.umanitoba.ca:/home/$REMOTE_USER/destination/
{{< /highlight >}}

In the example above,
 * _-e_ is the option governing SSH use and behavior for __rsync__ .
 * SSH tries to use a key pair (replace a-private-key.key with the name and location of your actual private key; for Grex, the corresponding public key can be uploaded to CCDB. If the key is not provided or not found, SSH will default to password authentication.
 * /home/$LOCAL_USER/somedir/ is a path on a local machine. An actual source directory has to be supplied instead.
 * /home/$REMOTE_USER is a home directory on the Grex system, and $REMOTE_USER is the user name on Grex. The local and remote user names may or may not be the same.
 * note that the trailing slash __/__ matters for __rsync__!

There is a lot of useful documentation pages for __rsync__ ; just [one example](https://phoenixnap.com/kb/how-to-rsync-over-ssh).


## Globus Online file transfer
---

GlobusOnline is a specialized Data Transfer and Data Sharing tool for large transfers over WAN, across different organizations.
Check the [ESNet](https://fasterdata.es.net/ "ESNet") website if you are curious about Globus, and why large data transfers over WAN might need specialized networks and software setups.

We do not have a Server Endpoint of Globus on Grex as of the time of writing of the documentation page. 
However, each user can use Globus personal endpoint CLI to transfer your data between any Server endpoint and Grex, as described here ["Frontenac Data Transfers"](https://info.cac.queensu.ca/wiki/index.php/UploadingFiles:Frontenac#Using_Globus_through_a_command-line_interface).


## File transfers with OOD browser GUI
---

**NEW:** It is now possible to use [OpenOnDemand on Grex](https://zebu.hpc.umanitoba.ca) Web interface to download and upload data to and from Grex. Use the __Files__ OOD dashboard menu to select a filesystem (currently __/home/$USER__ and __/project__ filesystems are listed there), and then Upload and Download buttons.
There is a limit of about 10GB to the file transfer sizes with OOD. The OOD interface is, as of now, open for UManitoba IP addresses only (i.e., machines from campus and on UM VPN will work). 
The OOD File app allows also for transferring data to/from [MS OneDrive and NextCloud with Rclone tool](/connecting/data-transfer/one-drive)

More information is available on our [OOD pages](/ood/)

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* Last reviewed on: Apr 29, 2024.
-->
