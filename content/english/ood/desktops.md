---
weight: 1600
linkTitle: "Desktops"
title: "Desktops"
description: "Everything you need to know about Interactive Apps."
categories: []
tags: ["Interactive", "Visualization"]
---

## Introduction
---

From the menu __Interactive Apps__, it is possible to start a given application and use it for interactive work. Some applications have already predefined settings, like the slurm partition and allow only to adjust the wall time. As an example, the _Grex Desktop Simplified_ that uses by default the __test__ partition. 

To start an application, click on the name of the application, then fill the required parameters for slurm (accounting group, partition name, number of cpus, wall time, email notifications, ...etc).

Most of the applications require to set up the following parameters:

* __Slurm accounting group:__ if you have access to one accounting group (def-professor), the scheduler will pick it by default. If you have more than one accounting group, you need to specify the accounting group to use.
* __Wall time:__ crrently, there is a limit of 6 hours for most of the applications.
* __E-mail notification:__ this is an optional feature to get email notfications about your job. You will need to provide a working email. 

{{< alert type="info" >}}
Other parameters will be introduced in the next sections about custom interactive applications like for MATLAB, OVITO, ... etc. 
{{< /alert >}}

Here, we will discuss the usage of the Desktops: __Grex Desktop Simplified__ and __Grex Desktop.__

### Grex Desktop Simplified

This is a very simplified instance of a Desktop. It requires only to setup the accounting group (def-professor), the wall time and if needed add the email notifications. The following snapshot shows an example of settings:

{{< collapsible title="Grex Desktop Simplified setup" >}}
![Grex Desktop Simplified setup](/ood/simplified-desktop-setup.png)
{{< /collapsible >}}

Once all the fields are filled, you can lauch the application using the _Launch_ button. This will submit a job to compute node (in this case, it will run on the test partition). First, it goes to the queue and start when the resources are available:

{{< collapsible title="Grex Desktop Simplified Queued" >}}
![Grex Desktop Simplified Queued](/ood/simplified-desktop-queued.png)
{{< /collapsible >}}

The Desktop starts as a job. Therefore, it may stay on the queue depending on the available resources. Once the resources are granted by the scheduler, the interactive app will show up as running:

{{< collapsible title="Grex Desktop Simplified Running" >}}
![Grex Desktop Simplified Queued](/ood/simplified-desktop-running.png)
{{< /collapsible >}}

At this point, you may want to decrease the compression and image quality for not having a slow application. 

Then, click on the buttom __Launch Grex Desktop Simplified__ to start the application. 

After starting the Desktop, you will have access to your files and a terminal. In the following snapshot, it shows a terminal where we loaded matlab module and started matlab interface. Note that there is a dedicated application for matlab that you can use. We are loading matlab here to show how the desktop looks like. The Desktop can be used to start any other program that uses GUI.

{{< collapsible title="Grex Desktop Simplified Demonstration" >}}
![Grex Desktop Simplified Demonstration](/ood/simplified-desktop-demo.png)
{{< /collapsible >}}

### Grex Desktop

As discussed in the previous section, __Grex Desktop Simplified__ does not require many parameters beside the wall time that can be set in the form. It only runs on one node or a predefined __test__ partition. For more flexibility, there is another Desktop called __Grex Desktop__. This later offers more choices for the parameters to set before launching the application. 

For Desktops, the following parameters can be set from the form before submitting the interactive app:

* __Linux Desktop Environmemnt:__ From the drop down menu, a user can choose one of the following Desktop Environmemnts: __IceWM__, __OpenBox__ or __FluffBox__.

* __Slurm accounting group:__ if you have access to one accounting group (def-professor), the scheduler will pick it by default. If you have more than one accounting group, you need to specify which one to use. 

* __SLURM partition:__ The __Grex Desktop Simplified__ uses only a predeined partition __test__. Using __Grex Desktop__ application, there is a possibility to choose the partition. In the same way as running jobs via salloc or sbatch, a user can specify which CPU or GPU partition to use for interactive Desktop. Below the drop down menu, there is a brief reference to the available partitions and the characteristics of the nodes on each partition. Use the menu to select the appropriate partition for your interactive session. Please make sure to pick the right partition for your application. For example, do not select GPU partition if your program is not optimized for GPU usage.  
* __Number of cores:__ The number of CPUs can be set from the form. Note that we have set a maximum limit of the number of CPUs to use with OOD to limit the waste of resources. This limit is 64 for the partitions that have more than 64 cores per node, like __genoa__ partition. For other partitions, it is limitted by the available physical core on the partition {52 for skylake partition, 40 for largemem partition}. The total memory for the job is set automatically when selecting the number of CPUs and the partition. For each partition, there is a base memory per CPU which is shown just below the field __SLURM partition__. For example, if you select __genoa_ partition and asked for _8_ cores, the total memory will be __8 x 4000M__. If needed for more memory, increase the number of CPUs.  
* __Wall time:__ crrently, there is a limit of 6 hours for most of the applications.
* __E-mail notification:__ this is an optional feature to get email notfications about your job. You will need to provide a working email.

The following screenshot shows an example of Grex Desktop Settings:

{{< collapsible title="Grex Desktop Settings" >}}
![Grex Desktop Settings](/ood/grex-desktop-setup.png)
{{< /collapsible >}}

After launching the Desktop, the job will be submitted to the queue and wait for resources and once available, the job will start. At this time you may also change the compression and image quality to something low. Otherwise, the interaction with the interface will be slower. Then click on the button with the title __Launch Grex Desktop__ to connect to the interface.

Simular to  __Grex Desktop Simplified__, you will have access to a terminal and some other tools like a text editor.

Here is an example of __Grex Desktop__ view where two terminals were opened. One is used to test the GUI by running _xeyes_ and another to load and start matlab:

{{< collapsible title="Grex Desktop View" >}}
![Grex Desktop View](/ood/grex-desktop-view.png)
{{< /collapsible >}}

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* Last reviewed on: Jul 04, 2025.
-->
