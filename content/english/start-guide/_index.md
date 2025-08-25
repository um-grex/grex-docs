---
weight: 3000
title: "Quick Start Guide"
description: "Getting started."
titleIcon: "fa-solid fa-bolt-lightning"
#categories: ["Functionalities"]
#tags: ["Content management"]
---

## Grex
---

Grex is an UManitoba High Performance Computing (HPC) system, first put in production in early 2011 as part of __WestGrid__ consortium. Now it is owned and operated by the University of Manitoba. Grex is accessible only for UManitoba users and their collaborators.

## A Very Quick Start guide
---

**1.** Create an account on [CCDB](https://ccdb.alliancecan.ca/security/login "CCDB"). You will need an institutional Email address. If you are a sponsored user, you'd want to ask your PI for their __CCRI__ code {Compute Canada Role Identifier}. For a detailed procedure, visit the page [Apply for an account](https://alliancecan.ca/en/services/advanced-research-computing/account-management/apply-account "Apply for an Alliance account").

**2.** If you did not set yet MFA, please enrol using the instructions from this [page](connecting/mfa).

**3.** Wait for half a day. While waiting, install an SSH client, and SFTP client for your operating system.

**4.** Connect to **grex.hpc.umanitoba.ca** (or **yak.hpc.umanitoba.ca** or **bison.hpc.umanitoba.ca**) with SSH, using your username/password from step 1.

**5.** Make a sample job script, call it, for example, __sleep-job.sh__ . The job script is a text file that has a special syntax to be recognized by SLURM. You can use the editor __nano__ , or any other right on the Grex SSH prompt (vim, emacs, pico, ... etc); you can also create the script file on your machine and upload to Grex using your SFTP client or scp.

{{< snippet
    file="scripts/jobs/templates/sleep-job.sh"
    caption="sleep-job.sh"
    codelang="bash"
/>}}

**6.** Submit the script using __sbatch__ command, to the __skylake__ partition using:

{{< highlight bash >}}
sbatch --partition=skylake sleep-job.sh
{{< /highlight >}}

**7.** Wait until the job finishes; you can monitor the queues state with the 'sq' command. When the job finishes, a file slurm-NNNN.out should be created in the same directory.

**8.** Download the output slurm-NNNN.out from yak.hpc.umanitoba.ca to your local machine using your SFTP client.

**9.** Congratulations, you have just run your first HPC-style batch job. This is the general workflow, more or less; you'd just want to substitute the __sleep__ command to something useful, like __./your-code.x your-input.dat__ .

<!--
Check out [Getting an ccount](./access), [Moving Data](./connecting/data-transfer/) and [Running jobs](./running) for general information. [Software pages](./software) might have information specific to running particular [software items](./software/specific). [OpenOndemand](./ood) pages explain how to use the new Grex's Web portal.
-->

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* Last revision: Sep 10, 2024.  
-->
