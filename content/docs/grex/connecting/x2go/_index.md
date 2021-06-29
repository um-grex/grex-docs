---
bookCollapseSection: true
weight: 2
title: Connecting with X2go
---

## Graphical user interface access with X2Go

Linux (and UNIX) have a graphical user interface framework, which is called [X11, X-Window system](https://en.wikipedia.org/wiki/X_Window_System). It is possible to use remote X11 applications with the combination of SSH client with X11-tunnelling enabled and a local X11-server running. However, this way is often quite slow and painful, especially over WAN networks, where latencies of the network really impair user experience.

Luckily, there is a solution for this, which is called NX. NX software on client and server sides caches and compresses X11 traffic, leading to a great improvement of the performance of X11 applications. An free NX-based remote desktpo solution exist, and is called [X2Go](https://wiki.x2go.org/doku.php/doc:newtox2go).

On Grex, we support X2Go since 2015; that is, we run an X2Go _server_ on Grex login nodes. So if you have a valid Grex account, and an X2Go client installed on your local machine, you can connect to Grex and use a remote Linux desktop to run your favourite GUI applications.

Since X2Go runs over an encrypted SSH connection, it does not require anything else to access Grex. If you have SSH command line access working, and have X2Go client working, it should be enough to get you started.

## X2go clients and sesions

The X2Go authors provide clients for MacOS X, Linux and Windows operating systems: [download X2go](https://wiki.x2go.org/doku.php/download:start).

There are also alternative X2Go clients (PyHoca CLI and GUI, etc.) that you could try, but we will not cover them here.

After installing the X2Go client, you'd need to start it and create a "_New Session_" by clicking the corresponding icon.

For now, there is no load balancing support for connections: while connecting to the host address **grex.westgrid.ca** will work, session suspend/resume functionality might require specifying connection to a physical Grex login node explicitly, using either of **tatanka.westgrid.ca** or **bison.westgrid.ca** correspondingly in the _Host_ field. (You can also create two sessions, one for tatanka and another for bison.)

The same Westgrid username should be used as for SSH text based connections in the _Login_ field. It is also possible to provide an SSH key instead of the password.

When creating a new Session, please chose either of the supported desktop environment, **"OPENBOX"** or **"ICEWM"**, in the "Session type" menu. We support the two most lightweight Linux Desktop environments for now. It is also possible to avoid using te desktops altogether and select "Published Applications" instead following the documentation [here](https://wiki.x2go.org/doku.php/wiki:advanced:published-applications); however, most of the Grex applications are only accessible as _modules_ and therefore not present in this menu.

In the _Media_ tab, you might want to disable printing and sound support to suppress the corresponding warnings. 

After saving the new session, you should be able to connect to Grex with X2go!

## Links

Compute Canada has an X2Go documentation page [here](https://docs.computecanada.ca/wiki/X2Go), with useful screenshots. X2go installation on the [X2Go Wiki](https://wiki.x2go.org/doku.php/doc:installation:x2goclient) and [X2go FAQ](https://wiki.x2go.org/doku.php/doc:faq:start)


