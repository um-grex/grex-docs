---
weight: 4010
linkTitle: "Transferring Data"
title: "Transferring data"
description: "Everything you need to know about transferring data."
banner: true
bannerContent: "GUI clients may need to be updated to the latest versions to work with the Duo MFA on Grex"
titleIcon: "fa-solid fa-arrow-right-arrow-left"
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

More information about OpenSSH file transfer tools exist on [OpenSSH SSP manpage](https://man.openbsd.org/scp). [The Alliance](https://docs.alliancecan.ca/wiki/Transferring_data#SCP "SCP") has a detailed Wiki entry on SCP.

### SFTP
---

On Mac OS and Linux, where OpenSSH client packages are always available, the following command line tools are present: __scp__, __sftp__. They work like UNIX __cp__ and __ftp__ commands, except that there is a remote target or source. 

SFTP opens a session and then drops the user to a command line, which provides commands like __ls__, __lls__, __get__, __put__, __cd__, __lcd__ to navigate the local and remote directories, upload and download files etc.

{{< highlight bash >}}
sftp someuser@grex.hpc.umanitoba.ca
sftp> lls
sftp> put  myfile.fchk
{{< /highlight >}}

Please replace __someuser__ with your username.

### File transfer SCP/SFTP clients with GUI
---

There are many file transfer clients that provide a convenient graphical user interface (GUI) while using an implementation of SCP or SFTP under the hood.

Some examples of the popular file transfer clients are:

* [WinSCP](https://winscp.net/eng/index.php "WinSCP") for Windows.
* [CyberDuck](https://cyberduck.io/) for MacOS X and Windows, has a good MFA support.
* [MobaXterm](https://mobaxterm.mobatek.net/ "MobaXterm") for Windows has an SFTP app. 
* Cross platform [FileZilla Client](https://filezilla-project.org "FileZilla Client")


Other GUI clients will work with Grex too if they provide SFTP protocol support.

To use such clients, one would need to tell them that SFTP is needed, use the address **grex.hpc.umanitoba.ca** (or the name of a Grex login node like **yak.hpc.umanitoba.ca** or **bison.hpc.umanitoba.ca**) and your Grex/Alliance username.

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
 * /home/$LOCAL_USER/somedir/ is a path on a local machine. An actual source directory must be supplied instead.
 * /home/$REMOTE_USER is a home directory on the Grex system, and $REMOTE_USER is the user name on Grex. The local and remote user names may or may not be the same.
 * note that the trailing slash __/__ matters for __rsync__!

There is a lot of useful documentation pages for __rsync__ ; just [one example](https://phoenixnap.com/kb/how-to-rsync-over-ssh).


## Globus Online file transfer
---

GlobusOnline, or just [Globus](https://www.globus.org) is a specialized Data Transfer and Data Sharing tool for large transfers over WAN, possibly across different organizations. Globus transfers data, in an efficient and convenient way, between any two so called "Globus endpoints" or "data collections".

To use Globus, a user would need at least two endpoints, and an identity (account) for each endpoint is needed. The identities would have to be  to be "linked" using Globus Online portal. There are "server" endpoints and "personal endpoints" in Globus. 

> Grex users have a choice of using either The Alliance identity that comes with a CCDB account, or UManitoba identity using UMNetID. The preliminary step of linking identities is done by logging in to [www.globus.org](https://www.globus.org) by finding your _organization_ in the drop-down menu there. This can be Digital Alliance or University of Manitoba. Likely both identities would have to be linked to the Globus online account to be able to transfer data between the Alliance and Grex.

Please visit our [Globus Server or Globus Personal Endpoint Documentation](/data-transfer/globus) for instructions on how to use Globus on Grex.

<!--  GAS April 2025 moved to a separate page 

We do not have a Server Endpoint of Globus on Grex as of the time of writing of the documentation page. However, each user can use Globus Connect Personal to transfer data between any Server Endpoint and Grex. To do so, users need first to create their personal endpoint on Grex, under their account, as follows.

{{< highlight bash >}}
[~]$ module load globus
#
# Use an existing Globus identity to authenticate in the step below
#
[~]$ globus login --no-local-server
Please authenticate with Globus here:
------------------------------------
https://auth.globus.org/v2/oauth2/authorize?[...]
------------------------------------

Enter the resulting Authorization Code here: [...]

You have successfully logged in to the Globus CLI!

You can check your primary identity with
  globus whoami

For information on which of your identities are in session use
  globus session show

Logout of the Globus CLI with
  globus logout
[~]$ globus gcp create mapped <YOUR_NEW_ENDPOINT_NAME>
Message:     Endpoint created successfully
Endpoint ID: abcdef00-1234-0000-4321-000000fedcba
Setup Key:   12345678-aaaa-bbbb-cccc-87654321dddd
[~]$ globusconnectpersonal -setup 12345678-aaaa-bbbb-cccc-87654321dddd
[~]$ tmux new-session -d -s globus 'globusconnectpersonal -start'
### You can now start a transfer by navigating to https://globus.alliancecan.ca/
### and searching/choosing <YOUR_NEW_ENDPOINT_NAME> as the "Collection"
{{< /highlight >}}

Once the endpoint had been created and the personal Globus server started, the endpoint will be visible/searchable in the GlobusOnline Web interface. Now it can be used for data transfers. The ```module load globus``` command also provides Globus command line interface (CLI) that can also be used to move data  as described here: [Globus CLI examples](https://docs.globus.org/cli/examples/)

### Filesystems and symbolic links

Often, there is more than one filesystem on a Linux machine the personal endpoint is started on. For example, an endpoint on Grex login node would have  __$HOME__ and __/project__ available for sharing. 
However, on Linux, Globus does no share everything by default, other than users $HOME ! Even when there exist symbolic links to __/project__ or __/scratch__, they would not yet be navigable in the Globus Web UI or CLI.
Symbolic links across the filesystems do not work in Globus, unless both filesystems are shared!

To enable sharing filesystems other than $HOME, the following special file has to be edited: `~/.globusonline/lta/config-paths`
By default Globus creates this file with only one line, `~/,0,1` that corresonds to user's home directory. To add your project, or other filesystems, an extra line per filesystem must be added to the file.
The example below shows a template `~/.globusonline/lta/config-paths` file for Grex.

{{< highlight bash >}}
# modify the file as needed. Each line is of the format Path,SharingFlag,RWFlag. 
# the SharingFlag must be 0 for non-Globus+ endpoints.
cat ~/.globusonline/lta/config-paths
~/,0,1
/scratch/,0,1
/project/<YOUR_PROJECT_ID>/,0,1
{{< /highlight >}}

Note that you would replace __<YOUR_PROJECT_ID>__ above with your real path to the __/project__ filesystem. One way to get it on Grex is to examine the output of the `diskusage_report` script.
Another, more general way, is to use `realpath` command to resolve the project symlink, as in `realpath /home/${USER}/projects/def-<YOUR_PI>/` .

More information about configuring the Paths is available at [Globus Documentation on Linux Endpoints](https://docs.globus.org/globus-connect-personal/install/linux/#config-paths) .

### Managing personal endpoints

It is a good practice to not to keep unnecessary processes running on Grex login nodes. Thus, when all data transfers are finished, user should stop their Globus server process running personal endpoint as follows:
{{< highlight bash >}}
[~]$ tmux kill-session -C -t globus
{{< /highlight >}}

Once an endpoint had been created, there is (usually) no need to repeat the above steps creating a new endpoint. To restart the same existing endpoint, as needed for new data transfer sessions, it will be enough to run:
{{< highlight bash >}}
[~]$ tmux new-session -d -s globus 'globusconnectpersonal -start'
{{< /highlight >}}

A more general guide on how to use Globus personal endpoint on a Linux system, can be found on the [Frontenac "Data Transfers" page](https://info.cac.queensu.ca/en/how-to/upload-files). This guide does not require a _globus_ module installed on the system.

Check the [ESNet](https://fasterdata.es.net/ "ESNet") website if you are curious about Globus, and why large data transfers over WAN might need specialized networks and software setups.

### Using Upload button and HTTP access 

Globus v.5 adds a new feature to server endpoints that allows for [using HTTP protocol](https://docs.globus.org/globus-connect-server/v5/https-access-collections) (instead of the traditional globus-url-copy) .
This feature can be used from the Web UI (Upload button), and from CLI for accessing Globus using HTTPS URL someone had shared with you.

> Note that the Upload feature is not available for Personal Globus endpoints. It only can be used for Server endpoints.

-->

## Using MS OneDrive, NextCloud and similar cloud storage

It is possible to move data between Grex's storage and several Cloud Storage providers, including MicroSoft OneDrive, NextCloud, etc. by using the powerful [Rclone](https://rclone.org) tool. Please visit this [Rclone and OneDrive](/data-transfer/one-drive/) documentation page for instructions. 

## File transfers with OOD browser GUI
---

It is now possible to use [OpenOnDemand on Grex](https://ood.hpc.umanitoba.ca) Web interface to download and upload data to and from Grex. Use the __Files__ OOD dashboard menu to select a filesystem (currently __/home/$USER__ and __/project__ filesystems are listed there), and then Upload and Download buttons.
There is a limit of about 10GB to the file transfer sizes with OOD. The OOD interface is, as of now, open for UManitoba IP addresses only (i.e., machines from campus and on UM VPN will work). 

The OOD File app allows also for transferring data to/from [MS OneDrive and NextCloud with Rclone tool](/data-transfer/one-drive)

The OOD File app now "integrates" with Globus Server endpoint on Grex as well, providing a "globus" button that redirects to the Globus WebApp pointing to the "limited" Grex server endpoint.

More information is available on our [OOD pages](/ood/)

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* Last reviewed on: Nov 26 , 2024.
-->
