---
weight: 1000
linkTitle: "Linux tools"
title: "General Linux tools"
description: "Everything you need to know about Linux tools."
categories: ["Software", "Applications"]
#tags: ["Configuration"]
---

## Linux tools on Grex
---

There are a number of general and distro-specific tools on Grex that are worth mentioning here. Such tools are: **text editors**, **image viewers**, **file managers**, ... etc.

## Command line Text editors
---

Command line text editors allow you to edit files right on Grex in any terminal session (such as SSH session or an X terminal under X2Go):

> - The (arguably) most popular editor is __vi__, or __vim__. It is very powerful, but requires some experience to use it. To exit a __vim__ session, you can use the **ZZ** key combination (hold shift key + zz), or **ESC, :x!**. There are many vi tutorials around, for [example this one](http://heather.cs.ucdavis.edu/~matloff/UnixAndC/Editors/ViIntro.html).

> - Another lightweight text-mode editor is __nano__. It provides a self-explanatory key-combination menu at the bottom of the screen. An online manual can be found [here](https://www.nano-editor.org/dist/v2.1/nano.html).

> - The Midnight Commander file manager provides a text-mode editor that can be invoked stand-alone as __mc -e filename__.

## GUI Text editors
---

Sometimes it is useful (for example, for copy/paste operations with mouse, between client computer and a remote session) or convenient to have a text editor with a graphical user interface. Note that a most practical way to use this is from X2Go sessions that provide tolerable interaction speeds.

Vi has a GUI counterpart which is accessible as __evim__ command. There are also the following GUI editors: __nedit__ and __xfe-xfw__.

## Image viewers
---

There are the following commands that can be used for viewing images: __xfe-xfi__ and __nemacs__. A simple PDF viewer for X11, __xpdf__ and __ghostscript__ are also available.

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* 
*
*
-->
