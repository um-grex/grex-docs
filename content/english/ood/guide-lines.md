---
weight: 2200
linkTitle: "Guide Lines"
title: "Guide Lines"
description: "Everything you need to know about OOD."
categories: []
tags: ["Interactive", "Visualization"]
---

## OpenOnDemand Guide
---

### How to connect to OOD?
---

* URL: https://ood.hpc.umanitoba.ca/
* It requires a Grex account and MFA.
* VPN required if used outside UManitoba network.

### What is OOD used for?
---

Via OOD interface, one can use and have access to the following:

 * __Interactive Apps:__ GUI applications, Desktops and servers (MATLAB, Gaussview, RStudion, Jupyter, OVITO, ParaView, ...).

 * __File browser:__ navigate through the directories and files under home and project directories. Many operations related to files and directories are accessible from the file browser (copy, delete, edit, move, upload, download, ...). It gives also access to GLOBUS link.

 * __Jobs:__ Status of queues, Rinning Jobs and a JobComposer interface to submit batch scripts.

 * __Clusters:__ Status of Grex system and its SLURM partitions.

### How to start applications?
---

Here is a summary on how to start any OOD GUI application:

* From the menu, __Interactive Apps__, select the application to use.

* A form will show up. This form is used to set some parameters (like accounting group, number of CPUs, ...) that are required to run the application. For some applications, there are already predefined parameters and for others you may need to set additional parameters. 

* Once all the parameters are set, use the button __Launch__ to start the application by submitting a job. This later will start when the resources are available. 

* Once the job starts, use the link __Connect to ...__ to use the corresponding application.

### What are the parameters to set in the form?
---

Here is a list of parameters that may appear on the form before launching any interactive application:

#### Accounting group:

If the user has only one accounting group, it will be picked automatically by slum. If the user has more than one accounting group, setting the accounting group is mandatiory, like when using sbatch or salloc.

#### Wall time:

Use this field to set the wall time you need to use OOD application. As of now, the maximum wall time is 6 hours.

#### E-mail notifications

Similar to sbatch, one can add E-mail notifications to receive emails from the scheduler for your OOD session. It requires to provide a valid email in the field __Email__ that will show up when you select at least one of the following options:

* I would like to receive an email when the session starts
* I would like to receive an email when the session terminates

#### Slurm partitions

We have interactive applications where the partition is predeined, like Grex Desktop Simplified, Gnuplot and Grace. However, for other application, a field with the name _SLURM partition_ will show in the form as in the following screenshot:

{{< collapsible title="Slurm Partitions" >}}
![OOD Slurm Partitions](/ood/ood-slurm-partitions.png)
{{< /collapsible >}}

You can use this field to select the partition where you want to run your OOD application:

{{< collapsible title="Select Slurm Partitions" >}}
![Select OOD Slurm Partitions](/ood/ood-select-partitions.png)
{{< /collapsible >}}

There is a summary of all the partitions and their characteristics {name of the partition, number of CPUs per node, memory per node, memory per core}.

{{< alert type="warning" >}}
__Partition type:__ please make sure to select the right partition for your application (cpu or gpu). If your application does not use or support GPU, selct the CPU partition to run it. 
{{< /alert >}}
 
#### Number of Cores

#### Memory

#### Memory multiplier

#### Modules and dependencies

<!-- Changes and update:
* Last reviewed on: Jul 04, 2025.
-->
