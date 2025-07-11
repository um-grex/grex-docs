---
weight: 1200
linkTitle: "Connecting with SSH"
title: "Connecting to Grex with SSH"
description: "Everything you need to know about connecting to Grex using various SSH clients."
categories: ["How to"]
banner: true
bannerContent: "SSH clients may have to be updated to their latest versions to work with the Duo MFA!"
#tags: ["Configuration"]
---

## SSH
---

Most of the work on shared HPC computing systems is done via Linux command line / Shell. To connect, in a secure manner, to a remote Linux system, you would like to use SSH protocol. You will need to have:

> * access to the Internet that lets SSH ports open.
> * a user account on Grex (presently, it is a Compute Canada (an Alliance) Account).
> * and an SSH client for your operating system.

If you are not sure what your account on Grex is, check [Getting Access](https://www.computecanada.ca/research-portal/account-management/apply-for-an-account/). You will also need the DNS name of Grex Which is **grex.hpc.umanitoba.ca**

## SSH clients
---

### Mac OS X
---

Mac OS X has a built-in OpenSSH command line client. It also has a full-fledged UNIX shell. Therefore, using SSH under Mac OS is not different from Linux. In any terminal, **ssh** (as well as **scp**, **sftp**) just works with one caveat: for the support of X11 tunneling, some of the Mac OS X versions would require the [XQuartz](https://www.xquartz.org/) package installed. 

{{< highlight bash >}}
ssh -XY username@grex.hpc.umanitoba.ca
{{< /highlight >}}

Please remember to change **username** in the above command with your Compute Canada (or Alliance) user name.

### Linux 
---

Linux provides the command line SSH package, OpenSSH, which is installed by default in most of the Linux distributions. If not, or you are using a very minimal Linux installation, use your package manager to install the OpenSSH package. In any terminal window **ssh** (as well as **scp** , **sftp** ) commands should work. To connect to Grex, use:

{{< highlight bash >}}
ssh -XY username@grex.hpc.umanitoba.ca
{{< /highlight >}}

Similarly to the above, please remember to change **username** in the above command with your Compute Canada (or Alliance) user name.

### SSH keys
---

You can manage your SSH keys (adding key pairs, editing known_hosts etc.) in the __$HOME/.ssh__ directory. The Alliance (Compute Canada) user documentation has several pages on managing [SSH keys](https://docs.alliancecan.ca/wiki/Using_SSH_keys_in_Linux) and creating [SSH tunnels](https://docs.alliancecan.ca/wiki/SSH_tunnelling). Note that if ssh keys are set on CCDB, they should work on the Alliance clusters but not on Grex. This feature is not implemented yet on Grex. Instead of CCDB, on Grex one can install ssh keys [locally](https://docs.alliancecan.ca/wiki/Using_SSH_keys_in_Linux#Installing_locally) 


### Windows
---

**Windows** has a very diverse infrastructure for SSH (and Linux support in general). You would like to pick one of the options below and connect to **grex.hpc.umanitoba.ca** with your Alliance username and password.

#### Putty, WinSCP and VCXsrv
---

The (probably the most popular) free software combination to work under Windows are:

* PuTTy SSH client: [download PuTTy](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)
* WinSCP graphical SFTP client: [download WinSCP](https://winscp.net/eng/index.php)
* A free X11 server for Windows: [download VCXSrv](https://sourceforge.net/projects/vcxsrv/)

WinSCP interacts with PuTTy, so you can configure it to open SSH terminal windows from the WinSCP client. For X11 forwarding, make sure the "X11 tunneling" is enabled in PuTTy's session settings, and VCXSrv is running (it sits in the system tray and does nothing unless you start a graphical X11 application).

The Alliance wiki has a [PuTTY](https://docs.alliancecan.ca/wiki/Connecting_with_PuTTY) documentation page with some useful screenshots.

#### MobaXterm
---

There is a quite popular package: MobaXterm. It is not open source, but has a limited free version [MobaXterm](https://mobaxterm.mobatek.net/download.html). 

Please check out the Alliance's documentation on MobaXterm [here](https://docs.alliancecan.ca/wiki/Connecting_with_MobaXTerm)

#### All Windows versions, CygWin shell
---

There is a way to use Linux command shell tools under Windows. [Cygwin](https://www.cygwin.com/). When OpenSSH package is installed, you can use OpenSSH's command line tools like **ssh**, **scp** and **sftp** as if you were under Linux: 

{{< highlight bash >}}
ssh -Y username@grex.hpc.umanitoba.ca
{{< /highlight >}}

#### Windows 10, WSL subsystem
---

There is a Linux Subsystem for Windows which allows you to run a containerized instance of Linux (Ubuntu, for example) from under Windows 10. Refer to [MS documentation on enabling WSL](https://docs.microsoft.com/en-us/windows/wsl/install-win10). Then, you will have the same OpenSSH under Linux. 

It is actually possible to run X11 applications from WSL as well; you would need to get VCXSrv running, on the Windows side, and DISPLAY variable set on the WSL Linux side.

#### Windows 10, native OpenSSH package
---

Actually, some of the Windows 10 versions have OpenSSH as a standalone package. Refer to corresponding  [MS documentation on enabling OpenSSH](https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse). If it works with your version of Windows 10, you should have the OpenSSH command line tools like **ssh**, **scp** and **sftp** in the Windows command line, as if you were under Linux.

#### The original SSH Secure Shell client
---

The original SSH Secure Shell and Secure FTP client from this website(www.ssh.fi) is now obsolete. It has been unmaintained since 2001 and may not work with the newest SSH keys/encryption mechanisms and does not have any security updates since 2001. We do not support it and advise users to switch to one of the other more modern clients listed above.

## Using command line
---

What to do after you connect? You will be facing a Linux shell, most likely BASH. There is plenty of online documentation on how to use it, [HPC Carpentries](https://hpc-carpentry.github.io/hpc-shell/), [Compute Canada's SSH documentation page](https://docs.alliancecan.ca/wiki/SSH), [Bash Guide for Beginners](https://www.tldp.org/LDP/Bash-Beginners-Guide/html/Bash-Beginners-Guide.html) and simple googling for the commands.

You would probably like to explore software via [Modules](software/using-modules), and learn how to [submit jobs](running-jobs).

## Internal links
---

* [Using modules](software/using-modules)
* [Running jobs](running-jobs)

## External links
---

* [HPC Carpentries](https://hpc-carpentry.github.io/hpc-shell/)
* The Alliance [SSH documentation page](https://docs.alliancecan.ca/wiki/SSH)
* [Bash Guide for Beginners](https://www.tldp.org/LDP/Bash-Beginners-Guide/html/Bash-Beginners-Guide.html)
* [Linux introduction](https://docs.alliancecan.ca/wiki/Linux_introduction)

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* Last reviewed on: Apr 29, 2024. 
-->
