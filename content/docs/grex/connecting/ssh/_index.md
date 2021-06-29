---
bookCollapseSection: true
weight: 1
title: Connecting with SSH
---

# SSH

Most of the work on shared/HPC computing systems is done via Linux command line / shell. To connect, in a secure manner, to a remote Linux system, you would like to use SSH protocol. You will need to have:

 * access to Internet that lets SSH ports open 
 * a user account on Grex (presently, it is a Westgrid Account!)
 * and an SSH client for your operating system

If you are not sure what your account on Grex is, check [Getting Access](https://www.computecanada.ca/research-portal/account-management/apply-for-an-account/). You will also need the DNS name of Grex Which is **grex.westgrid.ca**.

## SSH clients

{{< tabs "uniqueid" >}}
{{< tab "MacOS" >}}

# MacOS SSH clients

SSH clients for  **MacOS**.

MacOS X has a built-in OpenSSH command line client. It also has a full-fledged UNIX shell. Therefore, using SSH under MacOS is not different from Linux. In any terminal, **ssh** (as well as **scp** , **sftp** ) just works with one caveat: for the support of X11 tunneling, some of the MacOS X versions would require the [XQuartz](https://www.xquartz.org/) package installed. 

  ```ssh -Y username@grex.westgrid.ca```

You can manage your keys (adding key pairs, ediding known_hosts etc.) in the  _$HOME/.ssh_ directory. Compute Canada has several documentation pages on [managing SSH keys](https://docs.computecanada.ca/wiki/Using_SSH_keys_in_Linux) and [creating SSH tunnels](https://docs.computecanada.ca/wiki/SSH_tunnelling)

{{< /tab >}}

{{< tab "Linux" >}}

# Linux SSH clients

SSH clients for  **Linux** 

Linux provides the command line SSH package, OpenSSH, which is installed by default in most of the Linux distributions. If not, or you are using a very minimal Linux installation, use your package manager to install OpenSSH package. In any terminal window **ssh** (as well as **scp** , **sftp** ) commands should work. To connect to Grex, use:

  ```ssh -Y username@grex.westgrid.ca```

You can manage your keys (adding key pairs, ediding known_hosts etc.) in the  _$HOME/.ssh_ directory. Compute Canada has several documentation pages on [managing SSH keys](https://docs.computecanada.ca/wiki/Using_SSH_keys_in_Linux) and [creating SSH tunnels](https://docs.computecanada.ca/wiki/SSH_tunnelling)

{{< /tab >}}

{{< tab "Windows" >}}

# Windows SSH clients

**Windows** has a very diverse infrastructure for SSH (and Linux support in general). You would like to pick one of the options below and connect to **grex.westgrid.ca** with your Westgrid username ans password.

## Putty, WinSCP and VCXsrv

The (probably the most popular) free software combination to work under Windows is :

  * Putty SSH client : [download PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)
  * WinSCP graphical SFTP client: [download WinSCP](https://winscp.net/eng/index.php)
  * A free X11 server for Windows: [download VCXSrv](https://sourceforge.net/projects/vcxsrv/)

WinSCP interacts with PuTTY, so you can configure it to open SSH terminal windows from WinSCP client. For X11 forwarding, make sure the "X11 tunneling" is enabled in PuTTY's session settings, and VCXSrv is running (it sits in the system tray and does nothing unless you start a graphical X11 appication).

Compute Canada has a [PuTTY](https://docs.computecanada.ca/wiki/Connecting_with_PuTTY) documentation page which has some useful screenshots.

## MobaXterm

There is a quite popular package: MobaXterm. It is not open source, but has a limited free version [MobaXterm](https://mobaxterm.mobatek.net/download.html). 

Please check out Compute Canada's documentation on MobaXterm [here](https://docs.computecanada.ca/wiki/Connecting_with_MobaXTerm)

## All Windows versions, CygWin shell

There is a way to use Linux command shell tools under Windows. [Cygwin](https://www.cygwin.com/). When openssh package is installed, you can use OpenSSH's command line tools like **ssh**, **scp** and **sftp** as if you were under Linux: 

  ```ssh -Y username@grex.westgrid.ca```

## Windows 10, WSL subsystem

There is a Linux Subsystem for Windows which allows you running a containerized instance of Lunux (Ubuntu, for example) from under Windows 10. Refer to [MS documentation on enabling WSL](https://docs.microsoft.com/en-us/windows/wsl/install-win10). Then, you will have same OpenSSH under Linux. 

It is actually possible to run X11 applications from WSL as well; you would need to get VCXSrv running, on the Windows side, and DISPLAY variable set on the WSL SLinux side.

## Windows 10, native OpenSSH package

Actually, some of the Windows 10 version have OpenSSH as a standalone package. Refer to corresponsing [MS documentation on enabling OpenSSH](https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse). If it works with your version of Windows 10, you should have the OpenSSH command line tools like **ssh**, **scp** and **sftp** in Windows command line, as if you were under Linux.

## the original SSHSecureShell client

The original SSHSecureShell and SecureFTP client from www.ssh.fi is now obsolete. It is unmaintained since 2001 and may not work with newest SSH keys/encryption mechanisms and does not have any security updates for the last 20 years. We do not support it and advise users to switch to one of the others more modern clients listed above.

{{< /tab >}}
{{< /tabs >}}

## Using command line

What to do after you connect? You will be facing a Linux shell, most likely BASH. There is a plenty of online documentation on how to use it,
 [HPC Carpentries](https://hpc-carpentry.github.io/hpc-shell/), [ComputeCanadas SSH documentation page](https://docs.computecanada.ca/wiki/SSH), 
[Bash Guide for Beginners](https://www.tldp.org/LDP/Bash-Beginners-Guide/html/Bash-Beginners-Guide.html) and simple googling for the commands.

You would probably like to explore software via [Modules](/doc/docs/grex/running/), and learning how to [submit jobs](/doc/docs/grex/running/).

