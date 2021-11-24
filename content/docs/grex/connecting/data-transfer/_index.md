---
bookCollapseSection: true
weight: 60
title: Transferring data
---

# Transferring Data to and from Grex

## GlobusOnline file transfer

Unfortunately, the Westgrid [Globus](https://www.globus.org) endpoint on Grex had expired. 
It is not possible to use Globus on Grex as of the time of writing. You can however still use Globus to transfer data between ComputeCanada systems as described [here](https://docs.computecanada.ca/wiki/Globus). 

Check the [ESNet](https://fasterdata.es.net/) website if you are curious about Globus, and why large data transfers over WAN might need specialized networks and software setups.

## OpenSSH tools: scp, sftp

On MacOS and Linux, wheree OpenSSH client packages are always available, the following command line tools are present: _scp_, _sftp_. 
They work similar to UNIX _cp_ and _ftp_ commands, except that there is a remote target or source. 

SFTP opens a session and then drops the user to a command line, which provides commands like _ls_, _lls_, _get_, _put_, _cd_, _lcd_ to navigate
the local and remote directories, upload and download files etc.

 ```sftp  ahappyusr@grex.westgrid.ca```
 
 ```sftp> lls```
 
 ```sftp> put  myfile.fchk```

SCP behaves like _cp_. To copy a file myfile.fchk to Grex, from the current directory, into his /global/scratch/, a user would do the following command:

 ```scp ./myfile.fchk  ahappyusr@grex.westgrid.ca:/global/scratch/ahappyusr```

Note that the destination is remote (for it has the form of user@host:/path). More information about file transfer tools exist on [ComputeCanada documentation](https://docs.computecanada.ca/wiki/Transferring_data#SCP)

## LFTP tool

[LFTP](http://lftp.yar.ru/) is a multi-protocol file tansfer code for Linux, that supports some of the advanced features of Globus, enabling better bandwidth utilization
through socket tuning and using multiple streams. On Grex (and between Grex and ComputeCanada systems) only SFTP (that is, _sftp://_ URIs) is supported! So the minimal syntax for operning a transfer session
from Grex to Cedar would be (on Grex:)

  ```lftp sftp://ahappyusr@cedar.computecanada.ca```

It has a command line interface not unlike the  _ftp_ or _sftp_ command line tools, with _ls_ , _get_, and _put_ commands.

## File transfer clients with GUI

There are many file transfer clients that provide convenient graphical user interface.
Some examples of the popular file transfer clients are
 * [WinSCP](https://winscp.net/eng/index.php) for Windows
 * [CyberDuck](https://cyberduck.io/) for MacOS X
 * crossplatform [FileZilla Client](https://filezilla-project.org)

Other GUI clients will work with Grex too, as long as they provide SFTP protocol support.

To use such clients, one would need to tell them that SFTP is needed, and to provide the address, which is **grex.westgrid.ca** and you Grex/Westgrid username.
Note that we advise against saving your password in the clients: first, it is less secure, and second, it is easy to store a wrong password. FIle transfer clients
would try to autoconnect automatically, and having a wrong password stored with them will create many failed connection attempts from your client machine, which in turn
might temporarily block your IP address from accessing Grex.

## File transfers with OOD browser GUI

``NEW:`` It is now possible to use [OpenOnDemand on aurochs](https://aurochs.westgrid.ca) Web interface to download and upload data to and from Grex. Use "Files" dashboard menu to select a filesystem (currently ``/home/$USER`` and ``/global/scratch/$USER`` are available), and then Upload and Download buttons.

There is a limit of about 10GB to the file transfer sizes with OOD. The OOD interface is, as of now, open for UManitoba IP addresses only (i.e., machines from campus will work). 

More information is available on our [OOD pages](../../ood)