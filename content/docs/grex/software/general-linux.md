---
title: General Linux tools
weight: 30
---

# Linux tools on Grex

There is a number of general and distro-specific tools on Grex that are worth mentioning here. Such tools are: text editors, image viewers, file managers, etc.

## Command line Text editors

Command line text editors allow you to edit files right on Grex in any terminal session (such as SSH session or an X terminal under X2Go):

 - The (arguably) most popular editor is ```vi```, or ```vim```. It is very powerful, but requires some experience to use. To exit a vim session, you can use **ZZ** key combination (hold shift key + zz), or **ESC, :x!**. There are many vi tutorials around, for [example this one](http://heather.cs.ucdavis.edu/~matloff/UnixAndC/Editors/ViIntro.html).

 - Another lightweight text-mode editor is ```nano```. It provides self-explanatory key-combination menu at the bottom of the screen.

 - The MidnightCommander file manager provides a text-mode editor that can be invoked stand-alone as ```mc -e filename```.

## GUI Text editors

Sometimes it is useful (for example, for copy/paste operations with mouse, between client computer and a remote session) or convenient to have a text editor with a graphical user interface. Note that a most practical way to use this is from X2Go sessions that provides tolerable interaction speeds.

Vi has a GUI counterpart which is accesible as ```evim``` command. There are also the following GUI editors: ```nedit``` and ```xfe-xfw```.

## Image viewers

There are the following commands that can be used for viewing images: ```xfe-xfi``` and ```nemacs```. A simple PDF viewer for X11, ```xpdf``` and ```ghostscript``` are also available.

