---
weight: 1900
linkTitle: "Job Composer"
title: "Job Composer"
description: "Everything you need to know about Job Composer."
categories: []
---

## Job Composer
---

The Job Composer is an interface to create and submit jobs via OOD. It is accessible from the menu __Jobs ==> Grex JobComposer__. 

Once launched, it shows the applications that are already configured:

{{< collapsible title="Grex JobComposer" >}}
![JobComposer Fron Page](/ood/job-composer.png)
{{< /collapsible >}}

At the time of writing this page, there are two categories:

* Generic applications to create slurm scripts.

* Specific job composer for some applications like Gaussian, GROMACS, ORCA, MATLAB and R. 

More application could be configured and added to the JobComposer interface.

The following will explain the steps to use the generic template called SLURM. This template can be adapted for any application:

* First, Open the interface from the JobComposer by clicking on the icon with the title __SLURM__.

* Here is a snapshot of the intercace:

{{< collapsible title="Grex JobComposer" >}}
![JobComposer Interface](/ood/job-composer-slurm-interface.png)
{{< /collapsible >}}

This interface allows to set the parameters required for job script:

* __Script location:__ using the button _Select Path_, one can navigate through the directories {home or project} to specify the location where the job script will be saved. By default, it saves the script under home directory.

* __Script name:__ it is used to give a name for your script, for example _run-slurm-job.sh__. By default, the name is _job.sh_

* __Job name:__ this is optional but you can use it to give a name to your job. The job name will only appear in the script once the job is submitted.

* __Add modules:__ this field is used to add the modules needed to run your job, for example:

{{< highlight bash >}}
module load arch/avx512  gcc/13.2.0  openmpi/4.1.6 lammps/2024-08-29p1
{{< /highlight >}}

* __Project/AccountingGroup:__ for users who have one slurm accounting group, this field is populated automaticaly. It works exactly like sbatch or salloc where the option __--account=def-professor__ is set to the default slurm accounting group. However, if you have access to more than one accounting group, you should speficify which one to use, like __--account=def-professor1__ or --account=def-professor2__

{{< collapsible title="Grex JobComposer Parameters" >}}
![JobComposer Parameters](/ood/job-composer-parameters.png)
{{< /collapsible >}}

* __SLURM partition:__ pick the appropriate partition where to run your job. If your application does not support GPU, please select a CPU partition. The drop down menu shows all the partitions (CPU and GPU) and their caharacteristis (name of the partition, total number of nodes, number of CPUs per node, total memory per node, base memory per core). It may help to onspect first the partitions status to see where the resources are available to minimize the waiting time on the queue.

* __Nodes and CPUs:__ 

 > * Number of nodes, Minimum number of nodes, Maximum number of nodes
 > * Number of tasks per node
 > * Total Number of tasks
 > * Number of CPUs per task 

* __Memory request type:__ this field is used to set the memory for the job either total memory per node or memory per core. It set one of the options __-\-mem=Y__ or __-\-mem=per-cpu=Z__.

* __Software stack:__ it is used to choose the software stack to load, either the local __SBEnv__ or the __CCEnv__ by adding __module load SBEnv__ or __module load CCEnv__. Note that you have to add manually the rest of the modules.

* __Modules:__ use this field to add the modules required to run your application.

* __Wall time:__ set the appropriate time for your job.

* __E-mail options:__ if you need e-mail notifications, you could set what notifications to receive (All, Beginning of job execution, End of job execution, Fail of the job, When the job is requeued). It is mandatory to add a valid email. 

Once all the fields are set, you have two options:

 > * submit the job using the button __Submit__ at the buttom of the JobComposer interface.
 > * save the job using the button __Save__ at the buttom of the JobComposer interface. This can be handy for adapting the script manually where needed.

{{< alert type="warning" >}}
__Note:__ this template is more generic and one should know exactly what otions to use when filling the form, like the list of modules, ... etc.
{{< /alert >}}

In addtion to the generic template, other templates for very specific applications are available from the job composer, like for R, Gaussian, ORCA, GROMACS, ... etc. These templates have some restrictions and additional features to adapt the script for a particular program. For example, it uses by default __--cpus-per-task__ for any threaded applications and sets __--ntasks=1__. Here are some features of the specific templates:

 > * set the appropriate directives to select the resources (nodes, cores, ... etc.)
 > * Where available, modules are predefined, like for ORCA, Gaussian, ...
 > * allows to set the path to an input file, like for R
 > * Where the possible, the command line is set, like for ORCA, Gaussian, MATLAB and R. 
 > * Similar to the generic templates, they also allow to save the scrip or submit the job from the JobComposer interface.
  
<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* Last reviewed on: Jul 04, 2025.
-->
