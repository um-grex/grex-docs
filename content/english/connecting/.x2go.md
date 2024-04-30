---
weight: 1400
linkTitle: "Connecting with X2Go"
title: "Connecting to Grex via X2Go"
description: "Everything you need to know about connecting to Grex via X2Go."
categories: ["How to"]
banner: true
bannerContent: "X2Go clients may not work currently on Grex because due to a lack of Duo MFA support"
#tags: ["Configuration"]
---

## Graphical user interface access with X2Go
---

Linux (and UNIX) have a graphical user interface framework, which is called [X11, X-Window system](https://en.wikipedia.org/wiki/X_Window_System "X-Window System"). It is possible to use remote X11 applications with the combination of SSH client with X11-tunneling enabled and a local X11-server running. However, this way is often quite slow and painful, especially over WAN networks, where latencies of the network really impair user experience.

Luckily, there is a solution for this, which is called NX. NX software on client and server sides caches and compresses X11 traffic, leading to a great improvement of the performance of X11 applications. A free NX-based remote desktop solution exists, and is called [X2Go](https://wiki.x2go.org/doku.php/doc:newtox2go "X2Go").

On Grex, we have supported X2Go since 2015; that is, we ran an X2Go __server__ on Grex login nodes. However, X2go lacks support of the newly enforced [Duo MFA](/connecting/mfa/). Therefore, sadly, this great tool is no longer supported on Grex.

Please refer to [OpenOnDemand](/ood/) as the alternative. Thanks!

<!--

So, if you have a valid Grex account, and an X2Go client installed on your local machine, you can connect to Grex and use a remote Linux desktop to run your favorite GUI applications.

Since X2Go runs over an encrypted SSH connection, it does not require anything else to access Grex. If you have SSH command line access working, and have X2Go client working, it should be enough to get you started.

## X2Go clients and sessions
---

The X2Go authors provide clients for Mac OS X, Linux and Windows operating systems: [download X2Go](https://wiki.x2go.org/doku.php/download:start "Download X2Go client").

There are also alternative X2Go clients (PyHoca CLI and GUI, etc.) that you could try, but we will not cover them here.

After installing the X2Go client, you'd need to start it and create a __"New Session"__ by clicking the corresponding icon.

For now, there is no load balancing support for connections: while connecting to the host address **grex.hpc.umanitoba.ca** will work, session suspend/resume functionality might require specifying connection to a physical Grex login node explicitly, using either of **tatanka.hpc.umanitoba.ca** or **bison.hpc.umanitoba.ca** correspondingly in the __Host__ field. (You can also create two sessions, one for tatanka and another for bison.)

The same username should be used as for SSH text based connections in the __Login__ field. It is also possible to provide an SSH key instead of the password.

When creating a new Session, a ["Desktop Environment"](https://en.wikipedia.org/wiki/Desktop_environment "Desktop Environment") needs to be selected in the "Session Type" menu 
Not all DE's that are listed in this X2Go menu are available on Grex. We support the following Linux Desktop environments:

> * **OPENBOX**: a lightweight DE (_Desktop Environment_)
> * **IceWM**: a lightweight DE that looks like Windows95
> * **XFCE4**: a full-fledged Linux DE

It is also possible to avoid using the desktops altogether and select "Published Applications" instead following the documentation [here](https://wiki.x2go.org/doku.php/wiki:advanced:published-applications); however, most of the Grex applications are only accessible as __modules__ and therefore not present in this menu.

In the __Media__ tab, you might want to disable printing and sound support to suppress the corresponding warnings. 

After saving the new session, you should be able to connect to Grex with X2Go.

## Problems and Limitations of X2Go
---

X2Go relies on an older version of NX library that might fail to support newer versions of OpenGL based software.

## External links
---

* The Alliance documentation page about [X2Go](https://docs.alliancecan.ca/wiki/X2Go)
* X2Go installation on the [X2Go Wiki](https://wiki.x2go.org/doku.php/doc:installation:x2goclient)

-->

## External links
---

* [X2Go FAQ](https://wiki.x2go.org/doku.php/doc:faq:start)

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* 
*
*
-->
