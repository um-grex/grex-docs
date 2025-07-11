---
weight: 1600
linkTitle: "Interactive Apps"
title: "Interactive Apps"
description: "Everything you need to know about Interactive Apps."
categories: []
---

## Introduction
---

From the menu __Interactive Apps__, it is possible to start a given application and use it for interactive work. Some applications have already predefined settings, like the partition and allow only to adjust the wall time. As an example, the _Grex Desktop Simplified _ thar uses by default the test partition.

To start an application, click on the name of the application, then fill the required parameters for slurm (accounting group, partition name, number of cpus, wall time, ...).

Most of the applications require to set up one of the following parameters:

> * Slurm accounting group: if you have access to one accounting group (def-professor), the scheduler will pick it by default. If you have more than one accounting group, you need to specify the accounting group to use.

> * Wall time: crrently, there is a limit of 6 hours for most of the applications.

### Grex Desktop Simplified

This is a very simplified instance of a Desktop. It requires only to setup the accounting group (def-professor), the wall time and if needed add the email notifications. The following snapshot shows an example of settings:

{{< collapsible title="Grex Desktop Simplified setup" >}}
![Grex Desktop Simplified setup](/ood/simplified-desktop-setup.png)
{{< /collapsible >}}

Once all the fields are filled, you can lauch the application using the _Launch_ button. This will submit a job to compute node (in this case, it will run on the test partition). First, it goes to the queue and start when the resources are available:

{{< collapsible title="Grex Desktop Simplified Queued" >}}
![Grex Desktop Simplified Queued](/ood/simplified-desktop-queued.png)
{{< /collapsible >}}

And once the resources are available, the interactive app will show up as running:

{{< collapsible title="Grex Desktop Simplified Running" >}}
![Grex Desktop Simplified Queued](/ood/simplified-desktop-running.png)
{{< /collapsible >}}

At this point, you may want to decrease the compression and image quality for not having a slow application. 

Then, click on the buttom _Launch Grex Desktop Simplified_ to start the application. After starting the Desktop, you will have access to your files and a terminal. In the following snapshot, it shows a terminal where we loaded matlab module and started matlab interface. Note that there is a dedicated application for matlab that you can use. We are loading matlab here to show how the desktop looks like. The Desktop can be used to start any other program that uses GUI.

{{< collapsible title="Grex Desktop Simplified Demonstration" >}}
![Grex Desktop Simplified Demonstration](/ood/simplified-desktop-demo.png)
{{< /collapsible >}}
 



<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* Last reviewed on: Jul 04, 2025.
-->
